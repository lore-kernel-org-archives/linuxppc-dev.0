Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 919042C00E0
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Sep 2013 20:48:26 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 18 Sep 2013 16:18:18 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 53DA6E0057
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Sep 2013 16:19:14 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8IAoLik41615502
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Sep 2013 16:20:22 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8IAmEnq018659
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Sep 2013 16:18:15 +0530
Message-ID: <523984BB.70208@linux.vnet.ibm.com>
Date: Wed, 18 Sep 2013 16:17:23 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/8][v4] powerpc/perf: Export Power7 memory hierarchy
 info to user space.
References: <1379119755-21025-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1379119755-21025-9-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1379119755-21025-9-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Michael Ellerman <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/14/2013 06:19 AM, Sukadev Bhattiprolu wrote:
> On Power7, the DCACHE_SRC field in MMCRA register identifies the memory
> hierarchy level (eg: L2, L3 etc) from which a data-cache miss for a
> marked instruction was satisfied.
> 
> Use the 'perf_mem_data_src' object to export this hierarchy level to user
> space. Some memory hierarchy levels in Power7 don't map into the arch-neutral
> levels. However, since newer generation of the processor (i.e. Power8) uses
> fewer levels than in Power7, we don't really need to define new hierarchy
> levels just for Power7.
> 
> We instead, map as many levels as possible and approximate the rest. See
> comments near dcache-src_map[] in the patch.
> 
> Usage:
> 
> 	perf record -d -e 'cpu/PM_MRK_GRP_CMPL/' <application>
> 	perf report -n --mem-mode --sort=mem,sym,dso,symbol_daddr,dso_daddr"
> 
> 		For samples involving load/store instructions, the memory
> 		hierarchy level is shown as "L1 hit", "Remote RAM hit" etc.
> 	# or
> 
> 	perf record --data <application>
> 	perf report -D
> 
> 		Sample records contain a 'data_src' field which encodes the
> 		memory hierarchy level: Eg: data_src 0x442 indicates
> 		MEM_OP_LOAD, MEM_LVL_HIT, MEM_LVL_L2 (i.e load hit L2).

Successfully built and boot tested this entire patchset both on a P7 and P8 system.
Running some sample tests with ebizzy micro benchmark. Till now got only 0x142 and
0x0 values for data_src object for the sample records. Will experiment around bit
more on P7 and P8 systems and post the results.

Regards
Anshuman 

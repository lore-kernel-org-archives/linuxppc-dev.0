Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FD411A038F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 09:37:03 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 6 Oct 2014 16:37:01 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id BC5D96E8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Oct 2014 18:25:42 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s96Mawq67602436
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Oct 2014 22:36:58 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s96MavSf027772
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Oct 2014 18:36:57 -0400
Date: Mon, 6 Oct 2014 15:36:40 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/vphn: fix endian issue in NUMA device node code
Message-ID: <20141006223639.GC9339@linux.vnet.ibm.com>
References: <20141003091250.28354.13766.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141003091250.28354.13766.stgit@bahia.local>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03.10.2014 [11:13:17 +0200], Greg Kurz wrote:
> The associativity domain numbers are obtained from the hypervisor through
> registers and written into memory by the guest: the packed array passed to
> vphn_unpack_associativity() is then native-endian, unlike what was assumed
> in the following commit:
> 
> commit b08a2a12e44eaec5024b2b969f4fcb98169d1ca3
> Author: Alistair Popple <alistair@popple.id.au>
> Date:   Wed Aug 7 02:01:44 2013 +1000
> 
>     powerpc: Make NUMA device node code endian safe
> 
> If a CPU home node changes, the topology gets filled with
> bogus values. This leads to severe performance breakdowns.
> 
> This patch does two things:
> - extract values from the packed array with shifts, in order to be endian
>   neutral
> - convert the resulting values to be32 as expected
> 
> Suggested-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>

Reviewed-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Tested-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

> ---
> 
> Changes in v2:
> - removed the left out __be16 *field declaration
> - removed the left out be16_to_cpup() call
> - updated the comment of the magic formula
> 
> Thanks again Nish... the two left outs probably explain why PowerVM wasn't
> happy that patch. :P

Yep, I've tested this v2 patch successfully now!

-Nish

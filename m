Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 457782C0357
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 02:15:52 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 12:15:47 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 655ACC90052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 12:15:45 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5JGFkiD253512
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 12:15:46 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5JGFj0x001265
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 13:15:45 -0300
Date: Wed, 19 Jun 2013 09:14:46 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Runzhen Wang <runzhen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf tools: Make Power7 events available for perf
Message-ID: <20130619161446.GB13326@us.ibm.com>
References: <1371633326-7696-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1371633326-7696-2-git-send-email-runzhen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371633326-7696-2-git-send-email-runzhen@linux.vnet.ibm.com>
Cc: acme@redhat.com, icycoder@gmail.com, linux-kernel@vger.kernel.org,
 xiaoguangrong@linux.vnet.ibm.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Runzhen Wang [runzhen@linux.vnet.ibm.com] wrote:
| Power7 supports over 530 different perf events but only a small
| subset of these can be specified by name, for the remaining
| events, we must specify them by their raw code:
| 
|         perf stat -e r2003c <application>
| 
| This patch makes all the POWER7 events available in sysfs.
| So we can instead specify these as:
| 
|         perf stat -e 'cpu/PM_CMPLU_STALL_DFU/' <application>
| 
| where PM_CMPLU_STALL_DFU is the r2003c in previous example.
| 
| Before this patch is applied, the size of power7-pmu.o is:
| 
| $ size arch/powerpc/perf/power7-pmu.o
|    text	   data	    bss	    dec	    hex	filename
|    3073	   2720	      0	   5793	   16a1	arch/powerpc/perf/power7-pmu.o
| 
| and after the patch is applied, it is:
| 
| $ size arch/powerpc/perf/power7-pmu.o
|    text	   data	    bss	    dec	    hex	filename
|   14451	  31112	      0	  45563	   b1fb	arch/powerpc/perf/power7-pmu.o
| 
| Signed-off-by: Runzhen Wang <runzhen@linux.vnet.ibm.com>

Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

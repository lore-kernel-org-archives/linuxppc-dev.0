Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6A889DDEC8
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Nov 2007 15:25:41 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id lAB4Pxr5021266
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Nov 2007 15:25:59 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAB4PbBY2011384
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Nov 2007 15:25:38 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAB4PLTk029629
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Nov 2007 15:25:21 +1100
Date: Sun, 11 Nov 2007 09:55:10 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] Fix CONFIG_SMP=n build error on ppc64
Message-ID: <20071111042510.GA9597@linux.vnet.ibm.com>
References: <20071110205929.GA4845@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071110205929.GA4845@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>, paulus@samba.org,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 10, 2007 at 02:59:29PM -0600, Olof Johansson wrote:
> [POWERPC] Fix CONFIG_SMP=n build error
> 
> The patch "KVM: fix !SMP build error" change the way smp_call_function()
> actually uses the passed in function names on non-SMP builds. So
> previously it was never caught that the function passed in was never
> actually defined.
> 
> This causes a build error on ppc64_defconfig + CONFIG_SMP=n:
> 
> arch/powerpc/mm/tlb_64.c: In function 'pgtable_free_now':
> arch/powerpc/mm/tlb_64.c:71: error: 'pte_free_smp_sync' undeclared (first use in this function)
> arch/powerpc/mm/tlb_64.c:71: error: (Each undeclared identifier is reported only once
> arch/powerpc/mm/tlb_64.c:71: error: for each function it appears in.)
> 
> So we need to define it even if CONFIG_SMP is off. Either that or ifdef
> out the smp_call_function() call, but that's ugly.
Hi,

Thanks, the patch fixes the build failure.

Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/mm/tlb_64.c b/arch/powerpc/mm/tlb_64.c
index eafbca5..e2d867c 100644
--- a/arch/powerpc/mm/tlb_64.c
+++ b/arch/powerpc/mm/tlb_64.c
@@ -54,12 +54,10 @@ unsigned long pte_freelist_forced_free;
      ((PAGE_SIZE - sizeof(struct pte_freelist_batch)) \ 
        / sizeof(pgtable_free_t))

-#ifdef CONFIG_SMP
 static void pte_free_smp_sync(void *arg)
 { 
      /* Do nothing, just ensure we sync with all CPUs */
 } 
-#endif

 /* This is only called when we are critically out of memory
  * (and fail to get a page in pte_free_tlb).

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.

Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 81109DDEA2
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Nov 2007 07:59:05 +1100 (EST)
Date: Sat, 10 Nov 2007 14:59:29 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix CONFIG_SMP=n build error on ppc64
Message-ID: <20071110205929.GA4845@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] Fix CONFIG_SMP=n build error

The patch "KVM: fix !SMP build error" change the way smp_call_function()
actually uses the passed in function names on non-SMP builds. So
previously it was never caught that the function passed in was never
actually defined.

This causes a build error on ppc64_defconfig + CONFIG_SMP=n:

arch/powerpc/mm/tlb_64.c: In function 'pgtable_free_now':
arch/powerpc/mm/tlb_64.c:71: error: 'pte_free_smp_sync' undeclared (first use in this function)
arch/powerpc/mm/tlb_64.c:71: error: (Each undeclared identifier is reported only once
arch/powerpc/mm/tlb_64.c:71: error: for each function it appears in.)

So we need to define it even if CONFIG_SMP is off. Either that or ifdef
out the smp_call_function() call, but that's ugly.


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

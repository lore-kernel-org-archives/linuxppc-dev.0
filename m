Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1152EDDEE9
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 20:49:13 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mBV9nAhE012675
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 02:49:10 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id mBV9n7kN021682
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 03:49:09 -0600 (CST)
From: Dave Liu <daveliu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: remove the redundant _tlbil_pid at SMP case
Date: Wed, 31 Dec 2008 17:42:55 +0800
Message-Id: <1230716575-30786-1-git-send-email-daveliu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Dave Liu <daveliu@freescale.com>
---
 arch/powerpc/mm/tlb_nohash.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 803a64c..39ac22b 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -189,8 +189,9 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
 	_tlbil_pid(0);
 	preempt_enable();
-#endif
+#else
 	_tlbil_pid(0);
+#endif
 }
 EXPORT_SYMBOL(flush_tlb_kernel_range);
 
-- 
1.5.4

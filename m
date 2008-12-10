Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26C6FDDF34
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:45:54 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mBA8jBwa018389
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 01:45:47 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mBA8jArb026359
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 02:45:11 -0600 (CST)
From: Liu Yu <yu.liu@freescale.com>
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH] fsl-booke: declare tlbcam_index and num_tlbcam_entries for
	use in c file
Date: Wed, 10 Dec 2008 16:41:13 +0800
Message-Id: <1228898473-29986-1-git-send-email-yu.liu@freescale.com>
Cc: scottwood@freescale.com, kumar.gala@freescale.com,
	Liu Yu <yu.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

KVM on E500 platform currently utilize TLB1 entries without bothering host,
that is using unused TLB1 entries.

So, KVM needs to read tlbcam_index and num_tlbcam_entries to know exactly
which TLB1 entry is unused.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
 arch/powerpc/include/asm/mmu-fsl-booke.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-fsl-booke.h b/arch/powerpc/include/asm/mmu-fsl-booke.h
index 925d93c..049ad8a 100644
--- a/arch/powerpc/include/asm/mmu-fsl-booke.h
+++ b/arch/powerpc/include/asm/mmu-fsl-booke.h
@@ -73,6 +73,9 @@
 
 #ifndef __ASSEMBLY__
 
+extern unsigned int tlbcam_index;
+extern unsigned int num_tlbcam_entries;
+
 typedef struct {
 	unsigned long id;
 	unsigned long vdso_base;
-- 
1.5.4

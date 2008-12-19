Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BC72CDDF0F
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 13:40:02 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mBJ2dmbo026602
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 19:39:59 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mBJ2dkxW024990
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 20:39:47 -0600 (CST)
From: Liu Yu <yu.liu@freescale.com>
To: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/fsl-booke: declare tlbcam_index for use in c file
Date: Fri, 19 Dec 2008 10:34:53 +0800
Message-Id: <1229654093-11398-1-git-send-email-yu.liu@freescale.com>
Cc: scottwood@freescale.com, kumar.gala@freescale.com,
	Liu Yu <yu.liu@freescale.com>, tpiepho@freescale.com, hollisb@us.ibm.com
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

So, KVM needs to read tlbcam_index to know exactly
which TLB1 entry is unused by host.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
[v2]
Remove num_tlbcam_entries declare and read from SPRN_TLB1CFG in KVM instead.

 arch/powerpc/include/asm/mmu-fsl-booke.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-fsl-booke.h b/arch/powerpc/include/asm/mmu-fsl-booke.h
index 925d93c..c86af6c 100644
--- a/arch/powerpc/include/asm/mmu-fsl-booke.h
+++ b/arch/powerpc/include/asm/mmu-fsl-booke.h
@@ -73,6 +73,8 @@
 
 #ifndef __ASSEMBLY__
 
+extern unsigned int tlbcam_index;
+
 typedef struct {
 	unsigned long id;
 	unsigned long vdso_base;
-- 
1.5.4

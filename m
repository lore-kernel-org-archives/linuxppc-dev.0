Return-Path: <roel.kluin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 56064B7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 22:35:37 +1000 (EST)
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225]) by ozlabs.org (Postfix) with ESMTP id 86508DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 22:35:34 +1000 (EST)
Received: by ewy25 with SMTP id 25so2482420ewy.9
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 05:35:32 -0700 (PDT)
Message-ID: <4A72E5CA.7070602@gmail.com>
Date: Fri, 31 Jul 2009 14:38:34 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] powerpc/fsl-booke: Read buffer overflow
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cam[tlbcam_index] is checked before tlbcam_index < ARRAY_SIZE(cam)

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index bb3d659..dc93e95 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -161,7 +161,7 @@ unsigned long __init mmu_mapin_ram(void)
 	unsigned long virt = PAGE_OFFSET;
 	phys_addr_t phys = memstart_addr;
 
-	while (cam[tlbcam_index] && tlbcam_index < ARRAY_SIZE(cam)) {
+	while (tlbcam_index < ARRAY_SIZE(cam) && cam[tlbcam_index]) {
 		settlbcam(tlbcam_index, virt, phys, cam[tlbcam_index], PAGE_KERNEL_X, 0);
 		virt += cam[tlbcam_index];
 		phys += cam[tlbcam_index];

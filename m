Return-Path: <akpm@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 48408B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 09:00:44 +1000 (EST)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A56D1DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 09:00:43 +1000 (EST)
Message-Id: <200908062300.n76N0bnS028871@imap1.linux-foundation.org>
Subject: [patch 2/3] powerpc/fsl-booke: read buffer overflow
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Thu, 06 Aug 2009 16:00:37 -0700
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, roel.kluin@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Roel Kluin <roel.kluin@gmail.com>

cam[tlbcam_index] is checked before tlbcam_index < ARRAY_SIZE(cam)

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/mm/fsl_booke_mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/powerpc/mm/fsl_booke_mmu.c~powerpc-fsl-booke-read-buffer-overflow arch/powerpc/mm/fsl_booke_mmu.c
--- a/arch/powerpc/mm/fsl_booke_mmu.c~powerpc-fsl-booke-read-buffer-overflow
+++ a/arch/powerpc/mm/fsl_booke_mmu.c
@@ -161,7 +161,7 @@ unsigned long __init mmu_mapin_ram(void)
 	unsigned long virt = PAGE_OFFSET;
 	phys_addr_t phys = memstart_addr;
 
-	while (cam[tlbcam_index] && tlbcam_index < ARRAY_SIZE(cam)) {
+	while (tlbcam_index < ARRAY_SIZE(cam) && cam[tlbcam_index]) {
 		settlbcam(tlbcam_index, virt, phys, cam[tlbcam_index], PAGE_KERNEL_X, 0);
 		virt += cam[tlbcam_index];
 		phys += cam[tlbcam_index];
_

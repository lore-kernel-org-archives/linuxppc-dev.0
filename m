Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25E07B6EF7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 05:39:57 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5TJdseB023192
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 12:39:55 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Fix address issue when using relocatable
	kernels
Date: Tue, 29 Jun 2010 14:42:07 -0500
Message-Id: <1277840527-18977-1-git-send-email-msm@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When booting a relocatable kernel it needs to jump to the correct
start address, which for BookE parts is usually unchanged
regardless of the physical memory offset.

Recent changes cause problems with how we calculate the start
address, it was always adding the RMO into the start address
which is incorrect. This patch only adds in the RMO offset
if we are in the kexec code path, as it needs the RMO to work
correctly.

Instead of adding the RMO offset in in the common code path, we
can just set r6 to the RMO offset in the kexec code path instead
of to zero, and finally perform the masking in the common code
path

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
index beb4d78..a92c79b 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -205,8 +205,7 @@ next_tlb_setup:
 	bdnz+   next_tlb_setup
 
 /* 7. Jump to our 1:1 mapping */
-	li	r6, 0
-
+	mr	r6, r25
 #else
 	#error You need to specify the mapping or not use this at all.
 #endif
@@ -217,7 +216,6 @@ next_tlb_setup:
 1:	mflr	r9
 	rlwimi	r6,r9,0,20,31
 	addi	r6,r6,(2f - 1b)
-	add	r6, r6, r25
 	mtspr	SPRN_SRR0,r6
 	mtspr	SPRN_SRR1,r7
 	rfi				/* start execution out of TLB1[0] entry */
-- 
1.6.6.1

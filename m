Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 481BFB6FFA
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:22 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p356EAXR024980
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:10 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356EL7n1720556
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356EKIR011089
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/15] powerpc: Initialize TLB and LPID register on HV mode
	Power7
Date: Tue,  5 Apr 2011 16:14:06 +1000
Message-Id: <1301984051-18413-11-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In case entry from the bootloader isn't "clean"

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/cpu_setup_power7.S |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power7.S b/arch/powerpc/kernel/cpu_setup_power7.S
index 2390f6f..4f9a93f 100644
--- a/arch/powerpc/kernel/cpu_setup_power7.S
+++ b/arch/powerpc/kernel/cpu_setup_power7.S
@@ -25,7 +25,10 @@ _GLOBAL(__setup_cpu_power7)
 	bl	__init_hvmode_206
 	mtlr	r11
 	beqlr
+	li	r0,0
+	mtspr	SPRN_LPID,r0
 	bl	__init_LPCR
+	bl	__init_TLB
 	mtlr	r11
 	blr
 
@@ -34,7 +37,10 @@ _GLOBAL(__restore_cpu_power7)
 	mfmsr	r3
 	rldicl.	r0,r3,4,63
 	beqlr
+	li	r0,0
+	mtspr	SPRN_LPID,r0
 	bl	__init_LPCR
+	bl	__init_TLB
 	mtlr	r11
 	blr
 
@@ -71,3 +77,15 @@ __init_LPCR:
 	mtspr	SPRN_LPCR,r3
 	isync
 	blr
+
+__init_TLB:
+	/* Clear the TLB */
+	li	r6,128
+	mtctr	r6
+	li	r7,0xc00	/* IS field = 0b11 */
+	ptesync
+2:	tlbiel	r7
+	addi	r7,r7,0x1000
+	bdnz	2b
+	ptesync
+1:	blr
-- 
1.7.1

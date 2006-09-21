Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 859C267B6F
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 04:10:59 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k8LINfkD000075
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 11:23:41 -0700 (MST)
Date: Thu, 21 Sep 2006 13:10:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix IPIC pending register assignments
Message-ID: <20060921181051.GA32274@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the assignment of pending registers to IRQ numbers for
the IPIC; the code previously assigned all IRQs to the high pending word
regardless of which word the interrupt belonged to.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/ipic.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 70e7077..0251b7c 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -210,7 +210,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[64] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SIFCR_L,
@@ -218,7 +218,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 0,
 	},
 	[65] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SIFCR_L,
@@ -226,7 +226,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 1,
 	},
 	[66] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SIFCR_L,
@@ -234,7 +234,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 2,
 	},
 	[67] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SIFCR_L,
@@ -242,7 +242,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 3,
 	},
 	[68] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SIFCR_L,
@@ -250,7 +250,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 0,
 	},
 	[69] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SIFCR_L,
@@ -258,7 +258,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 1,
 	},
 	[70] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SIFCR_L,
@@ -266,7 +266,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 2,
 	},
 	[71] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SIFCR_L,
@@ -274,91 +274,91 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 3,
 	},
 	[72] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 8,
 	},
 	[73] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 9,
 	},
 	[74] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 10,
 	},
 	[75] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 11,
 	},
 	[76] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 12,
 	},
 	[77] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 13,
 	},
 	[78] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 14,
 	},
 	[79] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 15,
 	},
 	[80] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 16,
 	},
 	[84] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 20,
 	},
 	[85] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 21,
 	},
 	[90] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 26,
 	},
 	[91] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
-- 
1.4.2.1

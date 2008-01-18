Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8969EDDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 11:05:45 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m0I05fX5008400
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 17:05:41 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-199.am.freescale.net
	[10.214.72.199])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0I05dK9028206
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 18:05:40 -0600 (CST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [Add mpc5121 support PATCH v3 2/8] Add mpc512x ipic support
Date: Thu, 17 Jan 2008 17:05:32 -0700
Message-Id: <1200614738-25654-3-git-send-email-jrigby@freescale.com>
In-Reply-To: <1200614738-25654-2-git-send-email-jrigby@freescale.com>
References: <1200614738-25654-1-git-send-email-jrigby@freescale.com>
	<1200614738-25654-2-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added ipic_info entries for vectors used by 512x that
were previously unused by 83xx.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/sysdev/ipic.c |   62 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 7274750..4c016da 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -48,6 +48,13 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 17,
 		.prio_mask = 1,
 	},
+	[3] = {
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_C,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 18,
+		.prio_mask = 2,
+	},
 	[4] = {
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_C,
@@ -55,6 +62,34 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 19,
 		.prio_mask = 3,
 	},
+	[5] = {
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_C,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 20,
+		.prio_mask = 4,
+	},
+	[6] = {
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_C,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 21,
+		.prio_mask = 5,
+	},
+	[7] = {
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_C,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 22,
+		.prio_mask = 6,
+	},
+	[8] = {
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_C,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 23,
+		.prio_mask = 7,
+	},
 	[9] = {
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
@@ -223,6 +258,20 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 7,
 		.prio_mask = 7,
 	},
+	[40] = {
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 8,
+		.prio_mask = 0,
+	},
+	[41] = {
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 9,
+		.prio_mask = 1,
+	},
 	[42] = {
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_B,
@@ -230,6 +279,13 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 10,
 		.prio_mask = 2,
 	},
+	[43] = {
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 11,
+		.prio_mask = 3,
+	},
 	[44] = {
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_B,
@@ -387,6 +443,12 @@ static struct ipic_info ipic_info[] = {
 		.force	= IPIC_SIFCR_L,
 		.bit	= 18,
 	},
+	[83] = {
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 19,
+	},
 	[84] = {
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
-- 
1.5.3.5.726.g41a7a

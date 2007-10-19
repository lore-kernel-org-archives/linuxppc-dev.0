Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B1003DDEBA
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 21:28:30 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l9JBSPQO015095
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:28:26 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9JBSNKW016129
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 06:28:25 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v7 1/9] add e300c4 entry to cputable
Date: Fri, 19 Oct 2007 19:38:42 +0800
Message-Id: <1192793930-26039-2-git-send-email-leoli@freescale.com>
In-Reply-To: <1192793930-26039-1-git-send-email-leoli@freescale.com>
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/kernel/cputable.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index d3fb7d0..03b973f 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -888,7 +888,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_603,
 		.platform		= "ppc603",
 	},
-	{	/* e300c3 on 83xx  */
+	{	/* e300c3 (e300c1, plus one IU, half cache size) on 83xx */
 		.pvr_mask		= 0x7fff0000,
 		.pvr_value		= 0x00850000,
 		.cpu_name		= "e300c3",
@@ -899,6 +899,17 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_603,
 		.platform		= "ppc603",
 	},
+	{	/* e300c4 (e300c1, plus one IU) */
+		.pvr_mask		= 0x7fff0000,
+		.pvr_value		= 0x00860000,
+		.cpu_name		= "e300c4",
+		.cpu_features		= CPU_FTRS_E300,
+		.cpu_user_features	= COMMON_USER,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_603,
+		.platform		= "ppc603",
+	},
 	{	/* default match, we assume split I/D cache & TB (non-601)... */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
-- 
1.5.3.2.104.g41ef

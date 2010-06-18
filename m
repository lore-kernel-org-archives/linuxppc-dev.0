Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 37FF21007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 16:33:20 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5I6XHae002780 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 23:33:17 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o5I6h9mm016659
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 01:43:12 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/4] fsl_rio: fix machine check exception for e500mc
Date: Fri, 18 Jun 2010 14:24:21 +0800
Message-Id: <1276842263-4186-2-git-send-email-leoli@freescale.com>
In-Reply-To: <1276842263-4186-1-git-send-email-leoli@freescale.com>
References: <1276842263-4186-1-git-send-email-leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The original code only covers e500 v1/v2.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_rio.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index f908ba6..954a754 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -248,7 +248,8 @@ static int fsl_rio_mcheck_exception(struct pt_regs *regs)
 	const struct exception_table_entry *entry = NULL;
 	unsigned long reason = mfspr(SPRN_MCSR);
 
-	if (reason & MCSR_BUS_RBERR) {
+	/* covers both e500v1/v2 and e500mc */
+	if (reason & (MCSR_BUS_RBERR | MCSR_LD)) {
 		reason = in_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR));
 		if (reason & (RIO_LTLEDCSR_IER | RIO_LTLEDCSR_PRT)) {
 			/* Check if we are prepared to handle this fault */
-- 
1.6.4

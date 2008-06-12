Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5368DDDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 10:30:29 +1000 (EST)
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] [85xx] powerpc: Update pin setup for 8560ads
To: galak@kernel.crashing.org
Date: Thu, 12 Jun 2008 04:30:13 +0400
Message-ID: <20080612003012.12530.91766.stgit@vitb-lp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ports B and C pins programming is changed to get SCC2 UART and FCC3 ethernet work.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
---

 arch/powerpc/platforms/85xx/mpc85xx_ads.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)


diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 3582c84..ba498d6 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -119,6 +119,8 @@ static const struct cpm_pin mpc8560_ads_pins[] = {
 	{3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
 
 	/* SCC2 */
+	{2, 12, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 13, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
 	{3, 26, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 	{3, 27, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 	{3, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
@@ -145,7 +147,6 @@ static const struct cpm_pin mpc8560_ads_pins[] = {
 	{1, 4, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 	{1, 5, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 	{1, 6, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{1, 7, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 	{1, 8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
 	{1, 9, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
 	{1, 10, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
@@ -156,8 +157,9 @@ static const struct cpm_pin mpc8560_ads_pins[] = {
 	{1, 15, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 	{1, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
 	{1, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{2, 16, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* CLK16 */
-	{2, 17, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* CLK15 */
+	{2, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* CLK16 */
+	{2, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* CLK15 */
+	{2, 27, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 };
 
 static void __init init_ioports(void)

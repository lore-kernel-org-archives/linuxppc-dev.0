Return-Path: <b08782@zro04cle141.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D720F1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 21:15:46 +1100 (EST)
Received: from mail163-ch1 (localhost [127.0.0.1])	by
 mail163-ch1-R.bigfish.com (Postfix) with ESMTP id A8E163A01B5	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 10:15:37 +0000 (UTC)
Received: from CH1EHSMHS023.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.236])	by mail163-ch1.bigfish.com (Postfix) with ESMTP id
 17A06360049	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 10:15:35
 +0000 (UTC)
Received: from zro04cle141.ea.freescale.net (udp157456uds.ea.freescale.net
 [140.101.223.141])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 q0VAFLnI011164	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 04:15:21
 -0600 (CST)
From: Claudiu Manoil <claudiu.manoil@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Add missing config option for CACHE SRAM code
Date: Tue, 31 Jan 2012 12:15:20 +0200
Message-ID: <1328004920-29727-1-git-send-email-claudiu.manoil@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fsl_85xx_l2ctlr.o and fsl_85xx_cache_sram.o are built only
if CONFIG_FSL_85XX_CACHE_SRAM is defined. The driver that
qualifies and wants to make use of the CACHE SRAM's exported
API (i.e. a freescale net driver) should (be able to) select
this config option.

Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
---
 arch/powerpc/platforms/85xx/Kconfig |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index d7946be..6e2eecd 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -13,6 +13,15 @@ if FSL_SOC_BOOKE
 
 if PPC32
 
+config FSL_85XX_CACHE_SRAM
+	bool
+	select PPC_LIB_RHEAP
+	help
+	  When selected, this option enables cache-sram support
+	  for memory allocation on P1/P2 QorIQ platforms.
+	  cache-sram-size and cache-sram-offset kernel boot
+	  parameters should be passed when this option is enabled.
+
 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
 	select DEFAULT_UIMAGE
-- 
1.6.6

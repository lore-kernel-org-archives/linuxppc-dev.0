Return-Path: <lawrence@softsystem.co.uk>
Received: from smtp21.services.sfr.fr (smtp21.services.sfr.fr [93.17.128.4])
	by ozlabs.org (Postfix) with ESMTP id ACF00B6F1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  4 Jul 2010 04:22:03 +1000 (EST)
Received: from smtp21.services.sfr.fr (msfrf2108 [10.18.25.22])
	by msfrf2115.sfr.fr (SMTP Server) with ESMTP id AC62D70025D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  3 Jul 2010 20:22:01 +0200 (CEST)
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2108.sfr.fr (SMTP Server) with ESMTP id 7FB5B7000085
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  3 Jul 2010 20:21:58 +0200 (CEST)
Received: from smtp-in.softsystem.co.uk (164.20.102-84.rev.gaoland.net
	[84.102.20.164])
	by msfrf2108.sfr.fr (SMTP Server) with SMTP id 33A71700008C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  3 Jul 2010 20:21:58 +0200 (CEST)
Received: FROM [192.168.1.62] (gagarin [192.168.1.62])
	BY smtp-in.softsystem.co.uk [84.102.20.164] (SoftMail 1.0.5,
	www.softsystem.co.uk) WITH ESMTP
	FOR <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Jul 2010 20:21:57 +0200
Subject: [PATCH] Add cmd64x IDE driver to default pmac32 config
From: lawrence rust <lawrence@softsystem.co.uk>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 03 Jul 2010 20:21:56 +0200
Message-ID: <1278181316.3232.45.camel@gagarin>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Blue/White Apple PowerMac G3 and early G4's use a cmd64x compatible
IDE disk controller.  E.g. lspci shows...

01:01.0 IDE interface: Silicon Image, Inc. PCI0646 (rev 07)

Unfortunately the default pmac32 configuration does not include this
driver and so PowerMac G3's can't load a root filesystem.  This is an
issue on a least Ubuntu since version 9.04, which uses the default
config as a starting point.

Signed-off-by: Lawrence Rust <lawrence at softsystem.co.uk>

diff -uprN a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig 
--- a/arch/powerpc/configs/pmac32_defconfig	2010-05-16 23:17:36.000000000 +0200
+++ b/arch/powerpc/configs/pmac32_defconfig	2010-07-03 20:11:10.000000000 +0200
@@ -738,7 +738,7 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
-# CONFIG_BLK_DEV_CMD64X is not set
+CONFIG_BLK_DEV_CMD64X=y
 # CONFIG_BLK_DEV_TRIFLEX is not set
 # CONFIG_BLK_DEV_CS5520 is not set
 # CONFIG_BLK_DEV_CS5530 is not set

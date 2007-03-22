Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8B42CDE0A7
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 06:49:32 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2MJnR92002191
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 12:49:28 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2MJnRpr004562
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 14:49:27 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2MJTV28004515
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 14:29:31 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 90CE8AEFC9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 14:49:26 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2MJnQkq031993
	for linuxppc-dev@ozlabs.org; Thu, 22 Mar 2007 14:49:26 -0500
Date: Thu, 22 Mar 2007 14:49:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/6] bootwrapper: Add CONFIG_DEVICE_TREE
Message-ID: <20070322194926.GD31965@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This provides a way to tell the bootwrapper makefile which
device tree to include.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e720527..2f8f05b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -967,6 +967,22 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config DEVICE_TREE
+	string "Static device tree source file"
+	help
+	  This specifies the device tree source (.dts) file to be
+	  compiled and included when building the bootwrapper.
+	  If a relative filename is given, then it will be relative
+	  to arch/powerpc/boot/dts.
+
+	  This is required when building a cuImage target for an
+	  older U-Boot, which cannot pass a device tree itself.
+	  Such a kernel will not work with a newer U-Boot that
+	  tries to pass a device tree (unless you tell it not to).
+	  If your U-Boot does not mention a device tree in
+	  "help bootm", then use the cuImage target and specify
+	  a device tree here.  Otherwise, use the uImage target.
+
 endmenu
 
 config ISA_DMA_API
-- 
1.5.0.3

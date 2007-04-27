Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15340DE084
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 06:32:24 +1000 (EST)
Date: Fri, 27 Apr 2007 15:32:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH] bootwrapper: CONFIG_ -> CONFIG_DEVICE_TREE
Message-ID: <20070427203215.GA12814@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A usage of CONFIG_DEVICE_TREE got accidentally truncated; this
fix allows out-of-tree dts files to work.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 9d7b877..3716594 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -166,7 +166,7 @@ cuboot-plat-$(CONFIG_83xx) += 83xx
 cuboot-plat-$(CONFIG_85xx) += 85xx
 cuboot-plat-y += unknown-platform
 
-dts = $(if $(shell echo $(CONFIG_) | grep '^/'),\
+dts = $(if $(shell echo $(CONFIG_DEVICE_TREE) | grep '^/'),\
        ,$(srctree)/$(src)/dts/)$(CONFIG_DEVICE_TREE)
 
 $(obj)/cuImage: vmlinux $(wrapperbits)
-- 
1.5.0.3

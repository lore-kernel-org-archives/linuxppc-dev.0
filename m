Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 16B6EB7297
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 09:38:35 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 9C310DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 09:38:34 +1000 (EST)
Date: Fri, 19 Jun 2009 03:37:52 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Make eSDHC 1-bit only transfer mode default
	for MPC8569E-MDS
Message-ID: <20090618233752.GA13279@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For yet unknown reason 4-bit mode doesn't work on MPC8569E-MDS boards,
so make 1-bit mode default. When we resolve the issue, u-boot will
remove sdhci,1-bit-only property from the device tree, while SDHCI
will still work with older u-boots.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8569mds.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index 39c2927..63e8109 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -229,6 +229,7 @@
 			/* Filled in by U-Boot */
 			clock-frequency = <0>;
 			status = "disabled";
+			sdhci,1-bit-only;
 		};
 
 		crypto@30000 {
-- 
1.6.3.1

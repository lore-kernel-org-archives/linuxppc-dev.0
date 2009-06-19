Return-Path: <gerhard_pircher@gmx.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 23678B7276
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 07:42:40 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0A399DDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 07:42:38 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 19 Jun 2009 23:42:36 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090619214236.198400@gmx.net>
MIME-Version: 1.0
Subject: [PATCH] powerpc/amigaone: Limit ISA I/O range to 4k in the device tree
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel reserves the I/O address space from 0x0 to 0xfff for legacy
ISA devices. Change the ranges property for the PCI2ISA bridge to match
the kernels behavior, even if the ranges property isn't used for now.

Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
---
 arch/powerpc/boot/dts/amigaone.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/amigaone.dts b/arch/powerpc/boot/dts/amigaone.dts
index 26549fc..49ac36b 100644
--- a/arch/powerpc/boot/dts/amigaone.dts
+++ b/arch/powerpc/boot/dts/amigaone.dts
@@ -70,8 +70,8 @@
 			devsel-speed = <0x00000001>;
 			min-grant = <0>;
 			max-latency = <0>;
-			/* First 64k for I/O at 0x0 on PCI mapped to 0x0 on ISA. */
-			ranges = <0x00000001 0 0x01000000 0 0x00000000 0x00010000>;
+			/* First 4k for I/O at 0x0 on PCI mapped to 0x0 on ISA. */
+			ranges = <0x00000001 0 0x01000000 0 0x00000000 0x00001000>;
 			interrupt-parent = <&i8259>;
 			#interrupt-cells = <2>;
 			#address-cells = <2>;
-- 
1.5.6.5

-- 
GMX FreeDSL Komplettanschluss mit DSL 6.000 Flatrate und Telefonanschluss
für nur 17,95 Euro/mtl.!* http://portal.gmx.net/de/go/dsl02

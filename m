Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 1FC41B7CF9
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 05:59:22 +1100 (EST)
Date: Wed, 17 Feb 2010 19:59:18 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [Patch v2 2/2] 5200/mpc: improve i2c bus error recovery
To: Linux PPC Development <linuxppc-dev@ozlabs.org>, Devicetree Discussions
	<devicetree-discuss@lists.ozlabs.org>, Grant Likely
	<grant.likely@secretlab.ca>, "Ben Dooks (embedded platforms)"
	<ben-linux@fluff.org>
Message-Id: <1266433158.2322.1@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make the I2C adapter timeout configurable through a Device Tree property
which gives the timeout in microseconds.

Change vs. v.1: use "fsl,timeout" as property name (Thanks, Grant)

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

---

--- linux-2.6.32-orig/Documentation/powerpc/dts-bindings/fsl/i2c.txt	2009-1=
2-03 04:51:21.000000000 +0100
+++ linux-2.6.32/Documentation/powerpc/dts-bindings/fsl/i2c.txt	2010-02-17 =
14:18:01.000000000 +0100
@@ -21,6 +21,7 @@ Recommended properties :
   - fsl,preserve-clocking : boolean; if defined, the clock settings
     from the bootloader are preserved (not touched).
   - clock-frequency : desired I2C bus clock frequency in Hz.
+ - fsl,timeout : I2C bus timeout in microseconds.

  Examples :

@@ -44,5 +45,6 @@ Examples :
  		interrupts =3D <43 2>;
  		interrupt-parent =3D <&mpic>;
  		clock-frequency =3D <400000>;
+		fsl,timeout =3D <10000>;
  	};

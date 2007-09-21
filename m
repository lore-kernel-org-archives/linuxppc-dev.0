Return-Path: <jacmet@gmail.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.227])
	by ozlabs.org (Postfix) with ESMTP id C8D87DDE3B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 17:35:15 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 24so262716hud
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 00:35:13 -0700 (PDT)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Fri, 21 Sep 2007 09:35:03 +0200
In-Reply-To: <20070920133528.GC14820@ld0162-tx32.am.freescale.net> (Scott
	Wood's message of "Thu\, 20 Sep 2007 08\:35\:28 -0500")
Message-ID: <874pholbdk.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Scott" == Scott Wood <scottwood@freescale.com> writes:

Hi,

 Scott> #size-cells is zero on i2c, so it should just be reg = <68>.

 Scott> You'll probably need to add #address-cells and #size-cells to the
 Scott> controller node, as well.

Ahh - Thanks. This should be better.
---

[PATCH] mpc8349emitx.dts: Add ds1339 RTC

Add ds1339 I2C RTC chip as child of 2nd I2C controller.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux/arch/powerpc/boot/dts/mpc8349emitx.dts
===================================================================
--- linux.orig/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ linux/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -62,12 +62,21 @@
 		};
 
 		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <f 8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
+
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1339";
+				reg = <68>;
+			};
+
 		};
 
 		spi@7000 {

-- 
Bye, Peter Korsgaard

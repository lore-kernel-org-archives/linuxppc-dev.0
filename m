Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E44FDE026
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 10:46:01 +1100 (EST)
Date: Fri, 28 Mar 2008 16:45:54 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: paulus@samba.org
Message-ID: <20080328234554.GC30214@farnsworth.org>
References: <20080328233954.GA29499@farnsworth.org>
MIME-Version: 1.0
In-Reply-To: <20080328233954.GA29499@farnsworth.org>
Subject: [PATCH 3/9] [POWERPC] prpmc2800: fix frequencies in prpmc2800.dts
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

From: Dale Farnsworth <dale@farnsworth.org>

After the conversion to dts v1 format, seeing the frequencies
in decimal made it obvious that some of them had been
incorrectly truncated.  This fixes them.  Note that the PCI
frequency comes from a different source and is documented
as 66MHz, so it was left at 66000000.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Acked-by: Mark A. Greer <mgreer@mvista.com>

Index: linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/prpmc2800.dts
+++ linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
@@ -27,7 +27,7 @@
 		PowerPC,7447 {
 			device_type = "cpu";
 			reg = <0>;
-			clock-frequency = <733000000>;	/* Default */
+			clock-frequency = <733333333>;	/* Default */
 			bus-frequency = <133333333>;
 			timebase-frequency = <33333333>;
 			i-cache-line-size = <32>;
@@ -137,7 +137,7 @@
 			compatible = "mrvl,mv64x60-brg";
 			reg = <0xb200 0x8>;
 			clock-src = <8>;
-			clock-frequency = <133000000>;
+			clock-frequency = <133333333>;
 			current-speed = <9600>;
 			bcr = <0>;
 		};
@@ -146,7 +146,7 @@
 			compatible = "mrvl,mv64x60-brg";
 			reg = <0xb208 0x8>;
 			clock-src = <8>;
-			clock-frequency = <133000000>;
+			clock-frequency = <133333333>;
 			current-speed = <9600>;
 			bcr = <0>;
 		};

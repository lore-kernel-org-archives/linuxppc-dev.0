Return-Path: <tur@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 4D2FCDDE27
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 03:27:55 +1100 (EST)
Message-ID: <475429DA.9060100@semihalf.com>
Date: Mon, 03 Dec 2007 17:07:54 +0100
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474DB27C.7020909@anagramm.de>	<20071128194321.0804b3aa@i1501.lan.towertech.it>	<474F1B25.8080508@anagramm.de>	<20071129211912.46da8f5b@i1501.lan.towertech.it>	<474FEE20.6070606@anagramm.de>	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47541D70.2040805@anagramm.de>
In-Reply-To: <47541D70.2040805@anagramm.de>
Content-Type: multipart/mixed; boundary="------------020801020106060808020404"
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020801020106060808020404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Clemens Koller wrote:
> Hi, Alessandro, Hi, Olof!
> 
> Olof Johansson wrote:
>  > ds1307 requires you to register i2c_board_info for it to probe properly.
>  > Does your platform do so?
> 
> I started to add some pr_debug()s. It seems that rtc-ds1307's ds1307_init()
> is just never called despite the module gets loaded.

Hello Clemens,

Do you have rtc node in your dts file (I'm assuming arch/powerpc
situation)? If not, you'll have to add it - for example similarly to
what's being done in the attached patch (68 is the I2C address of the
RTC chip - a DS1339 in my case).

HTH,
Bartlomiej Sieka

--------------020801020106060808020404
Content-Type: text/plain;
 name="motionpro_i2c_rtc_dts.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="motionpro_i2c_rtc_dts.diff"

diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
index 112279b..ab39d61 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -329,10 +329,17 @@
 			device_type = "i2c";
 			compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
 			cell-index = <1>;
+			#cell-size = <0>;
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1339";
+				reg = <68>;
+			};
+
 		};
 		sram@8000 {
 			device_type = "sram";

--------------020801020106060808020404--

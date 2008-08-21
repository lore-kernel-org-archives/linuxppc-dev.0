Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 55C43DF30A
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 03:06:27 +1000 (EST)
Message-ID: <48ADA090.8020100@harris.com>
Date: Thu, 21 Aug 2008 13:06:24 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: jwboyer@linux.vnet.ibm.com
Subject: Re: [RFC][PATCH] I2C driver
References: <48AD9610.8090205@harris.com>
	<1219336202.26429.55.camel@jdub.homelinux.org>
In-Reply-To: <1219336202.26429.55.camel@jdub.homelinux.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Thu, 2008-08-21 at 12:21 -0400, Steven A. Falco wrote:
>> The following patch enables building the I2C driver for 4xx chips.
>> Tested on a Sequoia board.  Comments invited.
>>
>> Signed-off-by: Steven A. Falco <sfalco@harris.com>
>> ---
>>  drivers/i2c/busses/Kconfig      |    7 +++++++
>>  drivers/i2c/busses/i2c-ibm_of.c |    5 ++---
>>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> That file doesn't even exist in the mainline kernel:
> 
> [jwboyer@yoda linux-2.6]$ find drivers/i2c/ -name *ibm*
> drivers/i2c/busses/i2c-ibm_iic.c
> drivers/i2c/busses/i2c-ibm_iic.h
> [jwboyer@yoda linux-2.6]$ 
> 
> josh
> 
> 

Interesting.  Ok - I found the problem with the driver you *did* find:

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 85dbf34..569161d 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -989,6 +989,7 @@ static int __devexit iic_remove(struct of_device *ofdev)
 static const struct of_device_id ibm_iic_match[] = {
 	{ .compatible = "ibm,iic-405ex", },
 	{ .compatible = "ibm,iic-405gp", },
+	{ .compatible = "ibm,iic-440epx", },
 	{ .compatible = "ibm,iic-440gp", },
 	{ .compatible = "ibm,iic-440gpx", },
 	{ .compatible = "ibm,iic-440grx", },

However, while the i2c-ibm_of.c driver works with the sequoia .dts,
i2c-ibm_iic.c does not, because it is looking for an "index" property,
which is not in the .dts file.  I added one:

diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index 72d6756..538aadb 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -248,6 +248,7 @@
 				reg = <ef600700 14>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <2 4>;
+				index = <0>;
 			};
 
 			IIC1: i2c@ef600800 {
@@ -255,6 +256,7 @@
 				reg = <ef600800 14>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <7 4>;
+				index = <1>;
 			};
 
 			ZMII0: emac-zmii@ef600d00 {

However, something is still not right.  Using the mystery i2c-ibm_of.c
driver, I get:

i2c /dev entries driver
IBM IIC driver v2.1
m41t80_probe called
rtc-m41t80 0-0068: chip found, driver version 0.05
rtc-m41t80 0-0068: rtc core: registered m41t80 as rtc0
ibm-iic(/plb/opb/i2c@ef600700): using standard (100 kHz) mode
ibm-iic(/plb/opb/i2c@ef600800): using standard (100 kHz) mode

But with the i2c-ibm_iic.c driver, I get:

i2c /dev entries driver
ibm-iic 1ef600700.i2c: using standard (100 kHz) mode
ibm-iic 1ef600800.i2c: using standard (100 kHz) mode

I.e. it doesn't find the rtc (which I added to my sequoia board).

	Steve

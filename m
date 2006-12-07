Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E31A467F07
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 08:37:46 +1100 (EST)
Message-ID: <45788A01.1020300@ru.mvista.com>
Date: Fri, 08 Dec 2006 00:39:13 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 2/4] powerpc: Add the ds1374 RTC to the
	mpc8349emds	devicetree.
References: <008e01c71a47$430d1700$020120ac@Jocke>
In-Reply-To: <008e01c71a47$430d1700$020120ac@Jocke>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Joakim Tjernlund wrote:

>>Signed-off-by: Scott Wood <scottwood@freescale.com>
>>---
>> arch/powerpc/boot/dts/mpc8349emds.dts |   10 ++++++++++
>> 1 files changed, 10 insertions(+), 0 deletions(-)

>>diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts 
>>b/arch/powerpc/boot/dts/mpc8349emds.dts
>>index 50f4886..889a5b8 100644
>>--- a/arch/powerpc/boot/dts/mpc8349emds.dts
>>+++ b/arch/powerpc/boot/dts/mpc8349emds.dts
>>@@ -55,12 +55,22 @@
>> 		};
>> 
>> 		i2c@3000 {
>>+			#address-cells = <1>;
>>+			#size-cells = <0>;
>> 			device_type = "i2c";
>> 			compatible = "fsl-i2c";
>> 			reg = <3000 100>;
>> 			interrupts = <e 8>;
>> 			interrupt-parent = <700>;
>> 			dfsrr;
>>+
>>+			rtc@68 {
>>+				device_type = "rtc";
>>+				compatible = "ds1374";
>>+				reg = <68>;
>>+				interrupts = <13 8>;
>>+				interrupt-parent = <700>;
>>+			};
>> 		};
>> 
>> 		i2c@3100 {
>>-- 
>>1.4.2.3

> Nice, I have a question/request though:

> I have a ds1337 I2C RTC and to make the current rtc-ds1307 do
> the right thing, I need to pass module param
> rtc-ds1307.force=0,0x68

> I would need some way to tell rtc-ds1307 that I have
> a ds1337 device from my dts spec.

    That must be achievable by specifiying the "model" property...

>  Jocke

WBR, Sergei

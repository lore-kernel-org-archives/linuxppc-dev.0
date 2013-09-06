Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 305C62C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 02:10:31 +1000 (EST)
Subject: Re: [PATCH V2] powerpc: Add I2C bus multiplexer node for B4 and
 T4240QDS
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01D4824D@039-SN1MPN1-003.039d.mgd.msft.net>
Date: Fri, 6 Sep 2013 11:10:25 -0500
Message-Id: <AC1DB807-91FA-41F6-8468-371E02F41D35@kernel.crashing.org>
References: <1378348907-3137-1-git-send-email-hongtao.jia@freescale.com>
 <7BA50BB5-9A63-4EA5-91E4-D04576892AAF@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01D4824D@039-SN1MPN1-003.039d.mgd.msft.net>
To: Jia Hongtao-B38951 <B38951@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Wei.Yang@windriver.com" <Wei.Yang@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 5, 2013, at 10:33 PM, Jia Hongtao-B38951 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Friday, September 06, 2013 2:41 AM
>> To: Jia Hongtao-B38951
>> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421;
>> Wei.Yang@windriver.com
>> Subject: Re: [PATCH V2] powerpc: Add I2C bus multiplexer node for B4 and
>> T4240QDS
>> 
>> 
>> On Sep 4, 2013, at 9:41 PM, Jia Hongtao wrote:
>> 
>>> In both B4 and T4240QDS platform PCA9547 I2C bus multiplexer is used.
>>> The sub-nodes are also reorganized according to right I2C topology.
>>> 
>>> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
>>> ---
>>> V2 change log:
>>> Reorganized the sub-nodes under I2C multiplexer to represent right
>> topology.
>>> 
>>> arch/powerpc/boot/dts/b4qds.dtsi   | 49 +++++++++++++++++-----------
>>> arch/powerpc/boot/dts/t4240qds.dts | 67 ++++++++++++++++++++++---------
>> -------
>>> 2 files changed, 69 insertions(+), 47 deletions(-)
>>> 
>>> diff --git a/arch/powerpc/boot/dts/b4qds.dtsi
>> b/arch/powerpc/boot/dts/b4qds.dtsi
>>> index e6d2f8f..de8cb38 100644
>>> --- a/arch/powerpc/boot/dts/b4qds.dtsi
>>> +++ b/arch/powerpc/boot/dts/b4qds.dtsi
>>> @@ -120,25 +120,36 @@
>>> 		};
>>> 
>>> 		i2c@118000 {
>>> -			eeprom@50 {
>>> -				compatible = "at24,24c64";
>>> -				reg = <0x50>;
>>> -			};
>>> -			eeprom@51 {
>>> -				compatible = "at24,24c256";
>>> -				reg = <0x51>;
>>> -			};
>>> -			eeprom@53 {
>>> -				compatible = "at24,24c256";
>>> -				reg = <0x53>;
>>> -			};
>>> -			eeprom@57 {
>>> -				compatible = "at24,24c256";
>>> -				reg = <0x57>;
>>> -			};
>>> -			rtc@68 {
>>> -				compatible = "dallas,ds3232";
>>> -				reg = <0x68>;
>>> +			pca9547@77 {
>>> +				compatible = "philips,pca9547";
>> 
>> We seem to be using nxp instead of philips now.

This is based on Documentation/devicetree/bindings/vendor-prefixes.txt

>> 
>>> +				reg = <0x77>;
>>> +				#address-cells = <1>;
>>> +				#size-cells = <0>;
>>> +				channel@0 {
>> 
>> channel should probably be i2c
> 
> 
> Is there any standard for the name?
> i2c is ok but I think channel is more intuitional.
> 
> Hi Scott,
> What do you think of it.

Basing my comments on Documentation/devicetree/bindings/i2c/i2c-mux.txt 


> 
> Thanks.
> -Hongtao
> 
> 
>> 
>> [same comments below]
>> 
>>> +					#address-cells = <1>;
>>> +					#size-cells = <0>;
>>> +					reg = <0>;
>>> +					eeprom@50 {
>>> +						compatible = "at24,24c64";
>>> +						reg = <0x50>;
>>> +					};
>>> +					eeprom@51 {
>>> +						compatible = "at24,24c256";
>>> +						reg = <0x51>;
>>> +					};
>>> +					eeprom@53 {
>>> +						compatible = "at24,24c256";
>>> +						reg = <0x53>;
>>> +					};
>>> +					eeprom@57 {
>>> +						compatible = "at24,24c256";
>>> +						reg = <0x57>;
>>> +					};
>>> +					rtc@68 {
>>> +						compatible = "dallas,ds3232";
>>> +						reg = <0x68>;
>>> +					};
>>> +				};
>>> 			};
>>> 		};
>>> 
>>> diff --git a/arch/powerpc/boot/dts/t4240qds.dts
>> b/arch/powerpc/boot/dts/t4240qds.dts
>>> index 0555976..ae68595 100644
>>> --- a/arch/powerpc/boot/dts/t4240qds.dts
>>> +++ b/arch/powerpc/boot/dts/t4240qds.dts
>>> @@ -118,34 +118,45 @@
>>> 		};
>>> 
>>> 		i2c@118000 {
>>> -			eeprom@51 {
>>> -				compatible = "at24,24c256";
>>> -				reg = <0x51>;
>>> -			};
>>> -			eeprom@52 {
>>> -				compatible = "at24,24c256";
>>> -				reg = <0x52>;
>>> -			};
>>> -			eeprom@53 {
>>> -				compatible = "at24,24c256";
>>> -				reg = <0x53>;
>>> -			};
>>> -			eeprom@54 {
>>> -				compatible = "at24,24c256";
>>> -				reg = <0x54>;
>>> -			};
>>> -			eeprom@55 {
>>> -				compatible = "at24,24c256";
>>> -				reg = <0x55>;
>>> -			};
>>> -			eeprom@56 {
>>> -				compatible = "at24,24c256";
>>> -				reg = <0x56>;
>>> -			};
>>> -			rtc@68 {
>>> -				compatible = "dallas,ds3232";
>>> -				reg = <0x68>;
>>> -				interrupts = <0x1 0x1 0 0>;
>>> +			pca9547@77 {
>>> +				compatible = "philips,pca9547";
>>> +				reg = <0x77>;
>>> +				#address-cells = <1>;
>>> +				#size-cells = <0>;
>>> +				channel@0 {
>>> +					#address-cells = <1>;
>>> +					#size-cells = <0>;
>>> +					reg = <0>;
>>> +					eeprom@51 {
>>> +						compatible = "at24,24c256";
>>> +						reg = <0x51>;
>>> +					};
>>> +					eeprom@52 {
>>> +						compatible = "at24,24c256";
>>> +						reg = <0x52>;
>>> +					};
>>> +					eeprom@53 {
>>> +						compatible = "at24,24c256";
>>> +						reg = <0x53>;
>>> +					};
>>> +					eeprom@54 {
>>> +						compatible = "at24,24c256";
>>> +						reg = <0x54>;
>>> +					};
>>> +					eeprom@55 {
>>> +						compatible = "at24,24c256";
>>> +						reg = <0x55>;
>>> +					};
>>> +					eeprom@56 {
>>> +						compatible = "at24,24c256";
>>> +						reg = <0x56>;
>>> +					};
>>> +					rtc@68 {
>>> +						compatible = "dallas,ds3232";
>>> +						reg = <0x68>;
>>> +						interrupts = <0x1 0x1 0 0>;
>>> +					};
>>> +				};
>>> 			};
>>> 		};
>>> 	};
>>> --
>>> 1.8.0
>>> 
>>> 
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>> 
> 

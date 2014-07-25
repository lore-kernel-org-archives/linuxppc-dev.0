Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08ABE1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jul 2014 06:09:22 +1000 (EST)
Message-ID: <53D2B777.10107@Freescale.com>
Date: Fri, 25 Jul 2014 15:00:55 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Shaohui Xie <Shaohui.Xie@Freescale.com>, Shruti Kanetkar
 <Shruti@Freescale.com>, Scott Wood <scottwood@Freescale.com>
Subject: Re: [PATCH v2 1/7] dt: Introduce the FMan 10 Gb/s MDIO binding
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
 <df68a97dc8ae427f95078082ad587543@DM2PR0301MB0864.namprd03.prod.outlook.com>
In-Reply-To: <df68a97dc8ae427f95078082ad587543@DM2PR0301MB0864.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Shao-Hui,


On 07/24/2014 10:11 PM, Shaohui Xie wrote:
> Hello, Scott, Shruti,
> 
> There are two types MDIO controllers, each MAC has a corresponding
> MDIO controller to access internal PHYs inside Serdes, another is
> dedicated MDIO controller to access external PHYs (PHYs on board or
> riser card, etc). Current MDIO driver does not distinguish the two
> controllers, if we need to distinguish the controllers, what could be
> the proper way? Perhaps a new property is needed in dts?

As per the intended binding, FMan v3 MDIO must use the
"fsl,fman-memac-mdio" compatible. Why is that not enough to
differentiate the two controllers?


Cheers,


> Please comment!
> Thanks!
> 
> Best Regards, 
> Shaohui Xie
>> -----Original Message-----
>> From: Linuxppc-dev [mailto:linuxppc-dev-
>> bounces+b21989=freescale.com@lists.ozlabs.org] On Behalf Of Shruti
>> Kanetkar
>> Sent: Thursday, July 17, 2014 4:17 AM
>> To: Wood Scott-B07421
>> Cc: Kanetkar Shruti-B44454; linuxppc-dev@lists.ozlabs.org
>> Subject: [PATCH v2 1/7] dt: Introduce the FMan 10 Gb/s MDIO binding
>>
>> This document covers FManv2 and FManv3 mEMAC MDIO
>>
>> Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
>> ---
>>  .../devicetree/bindings/net/fsl-xgmac-phy.txt      | 29
>> ++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/fsl-xgmac-
>> phy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/fsl-xgmac-phy.txt
>> b/Documentation/devicetree/bindings/net/fsl-xgmac-phy.txt
>> new file mode 100644
>> index 0000000..2f2d56d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/fsl-xgmac-phy.txt
>> @@ -0,0 +1,29 @@
>> +*MDIO IO device
>> +
>> +The MDIO is a bus to which the PHY devices are connected. For each
>> +device that exists on this bus, a child node should be created.
>> +
>> +Required properties:
>> +	- compatible: Currently supported strings/devices are:
>> +			- "fsl,fman-xmdio" (Must be used for 10 Gb/s MDIO from
>> FMan v2.
>> +			  Can be used for 1/10 Gb/s MDIO from FMan v3)
>> +			- "fsl,fman-memac-mdio" (Must be used for 1/10 Gb/s
>> MDIO from
>> +			  FMan v3)
>> +	- reg
>> +
>> +	Example for FMan v2:
>> +		mdio@f1000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			compatible = "fsl,fman-xmdio";
>> +			reg = <0xf1000 0x1000>;
>> +		};
>> +
>> +	Example for FMan v3:
>> +
>> +		mdio@f1000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
>> +			reg = <0xf1000 0x1000>;
>> +		}
>> --
>> 1.8.3.1
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev

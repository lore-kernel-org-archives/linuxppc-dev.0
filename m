Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 144D414015E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 May 2014 20:24:28 +1000 (EST)
Message-ID: <5364BEB3.6000904@Freescale.com>
Date: Sat, 3 May 2014 05:02:27 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>, Shruti Kanetkar
 <Shruti@Freescale.com>, <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 4/6] powerpc/corenet: Create the dts components for the
 DPAA FMan
References: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
 <1397823693-27977-4-git-send-email-Shruti@Freescale.com>
 <1398118262.1694.188.camel__8135.6513932862$1398128944$gmane$org@snotra.buserror.net>
In-Reply-To: <1398118262.1694.188.camel__8135.6513932862$1398128944$gmane$org@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 04/21/2014 05:11 PM, Scott Wood wrote:
> On Fri, 2014-04-18 at 07:21 -0500, Shruti Kanetkar wrote:
>> +fman@400000 {
>> +	mdio@f1000 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		compatible = "fsl,fman-xmdio";
>> +		reg = <0xf1000 0x1000>;
>> +	};
>> +};
> 
> I'd like to see a complete fman binding before we start adding pieces.

The driver for the FMan 10 Gb/s MDIO has upstreamed a couple of years
ago: '9f35a73 net/fsl: introduce Freescale 10G MDIO driver', granted
without a binding writeup. This patch series should probably include a
binding blurb. However, let's not gate this patchset on a complete
binding for the FMan

As you know we don't own the FMan work and the FMan work is... not ready
for upstreaming. In an attempt to make some sort of progress we've
decided to upstream the pieces that are less controversial and MDIO is
an obvious candidate

>> +fman@400000 {
>> +	mdio0: mdio@e1120 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		compatible = "fsl,fman-mdio";
>> +		reg = <0xe1120 0xee0>;
>> +	};
>> +};
> 
> What is the difference between "fsl,fman-mdio" and "fsl,fman-xmdio"?  I
> don't see the latter on the list of compatibles in patch 3/6.

'fsl,fman-mdio' is the 1 Gb/s MDIO (Clause 22 only). 'fsl,fman-xmdio' is
the 10 Gb/s MDIO (Clause 45 only). We can respin this patch wi

I believe 'fsl,fman-mdio' (and others on that list) was added
gratuitously as the FMan MDIO is completely compatible with the
eTSEC/gianfar MDIO driver, but we can deal with that later

> Within each category, is the exact fman version discoverable from the
> mdio registers?

No, but that's irrelevant as that's not the difference between the two
compatibles

>> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
>> new file mode 100644
>> index 0000000..ced5786
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
>> @@ -0,0 +1,52 @@
>> +/*
>> + * QorIQ FMan v3 device tree stub [ controller @ offset 0x500000 ]
>> + *
>> + * Copyright 2012 Freescale Semiconductor Inc.
>> + *
>> + * Redistribution and use in source and binary forms, with or without
>> + * modification, are permitted provided that the following conditions are met:
>> + *     * Redistributions of source code must retain the above copyright
>> + *       notice, this list of conditions and the following disclaimer.
>> + *     * Redistributions in binary form must reproduce the above copyright
>> + *       notice, this list of conditions and the following disclaimer in the
>> + *       documentation and/or other materials provided with the distribution.
>> + *     * Neither the name of Freescale Semiconductor nor the
>> + *       names of its contributors may be used to endorse or promote products
>> + *       derived from this software without specific prior written permission.
>> + *
>> + *
>> + * ALTERNATIVELY, this software may be distributed under the terms of the
>> + * GNU General Public License ("GPL") as published by the Free Software
>> + * Foundation, either version 2 of that License or (at your option) any
>> + * later version.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
>> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
>> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
>> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
>> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
>> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
>> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
>> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
>> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> +*/
>> +
>> +fman@500000 {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	compatible = "simple-bus";
> 
> Why is this simple-bus?

Because that's the translation type for the FMan sub-nodes. We need it
now to get the MDIO nodes probed and we'll needed later to probe other
nodes/devices that will have standalone drivers: MAC, MURAM. etc. I
don't think we need to add another entry into the platform probe list
(which is already quite long) as a simple synonym

>> +
>> +	/* mdio nodes for fman v3 @ 0x500000 */
>> +	mdio@fc000 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		reg = <0xfc000 0x1000>;
>> +	};
>> +
>> +	mdio@fd000 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		reg = <0xfd000 0x1000>;
>> +	};
>> +};
> 
> Where's the compatible?  Why is this file different from all the others?

The FMan v3 MDIO block (supports both Clause 22/45) is compatible with
the FMan v2 10 Gb/s MDIO (the xgmac-mdio driver). However, the driver
needs a small clean-up patch (still in internal review) that will get it
working for FMan v3 MDIO. With that patch will add the compatible to
these nodes. However, we need these nodes now for the board level MDIO
bus muxing support (included in this patchset)


Cheers,

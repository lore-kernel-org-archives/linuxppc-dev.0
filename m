Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1BB0ADDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 02:12:00 +1000 (EST)
In-Reply-To: <013b01c7de23$5baa7d70$6f00a8c0@ESIDT>
References: <1187044669.10295.4.camel@server>
	<3FE16C0A-892F-4481-999A-A699C0C70BF9@kernel.crashing.org>
	<013b01c7de23$5baa7d70$6f00a8c0@ESIDT>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1B668DF2-9909-4D43-AAFF-3A2ADFA283B2@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] [UPDATED] tsec: Allow Ten Bit Interface to be configurable
Date: Tue, 14 Aug 2007 11:04:04 -0500
To: joe.hamman@embeddedspecialties.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 13, 2007, at 22:29, Joe Hamman wrote:

>>
>>
>> On Aug 13, 2007, at 5:37 PM, Joe Hamman wrote:
>>
>>> Allow the address of the Ten Bit Interface (TBI) to be changed in  
>>> the
>>> event of a conflict with another device.
>>>
>>> Signed-off by: Joe Hamman <joe.hamman@embeddedspecialties.com>
>>> ---
>>>
>>> Please ignore the last patch - I missed a cut & paste error on the
>>> range
>>> that my testing didn't catch.
>>
>> I think we'd rather this came from the device tree.
>>
> Duh, that makes sense ;-)
>
> Has there been any discussion yet?  Maybe something like this:
>
> 		mdio@24520 {
>

...

> 			phy3: ethernet-phy@3 {
> 				interrupt-parent = <&mpic>;
> 				interrupts = <a 1>;
> 				reg = <3>;
> 				device_type = "ethernet-phy";
> 			};
> 			tbi:  ethernet-tbi@1f {
> 				reg = <1f>;
> 				device_type = "ethernet-tbi";
> 			};

It's actually a per-tsec property.  There's not one tbi, there's one  
per TSEC.  The one on TSEC 0 is special in that it can interfere with  
PHYs on the MDIO bus.

So I would suggest making it a property of the ethernet node:

ethernet@24000 {
...
tbipa = <1f>;
...
}

etc

Andy

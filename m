Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 33CFEDDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 07:27:28 +1100 (EST)
Message-ID: <476ACFD8.1000506@ru.mvista.com>
Date: Thu, 20 Dec 2007 23:26:00 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH 11/20] [POWERPC] Wire up PCI on Bamboo board
References: <20071213073845.1D311DE053@ozlabs.org>	
	<47691DE6.8050901@ru.mvista.com>
	<1198095967.18908.33.camel@pasglop>
In-Reply-To: <1198095967.18908.33.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2007-12-19 at 16:34 +0300, Valentine Barshak wrote:
> 
>>> --- linux-work.orig/arch/powerpc/boot/dts/bamboo.dts	2007-12-10 15:56:59.000000000 +1100
>>> +++ linux-work/arch/powerpc/boot/dts/bamboo.dts	2007-12-10 16:39:51.000000000 +1100
>>> @@ -239,10 +239,48 @@
>>>  				zmii-channel = <1>;
>>>  			};
>>>  		};
>>> +
>>> +		PCI0: pci@ec000000 {
>>> +			device_type = "pci";
>>> +			#interrupt-cells = <1>;
>>> +			#size-cells = <2>;
>>> +			#address-cells = <3>;
>>> +			compatible = "ibm,plb440ep-pci", "ibm,plb-pci";
>>> +			primary;
>>> +			reg = <0 eec00000 8	/* Config space access */
>>> +			       0 eed80000 4	/* IACK */
>>> +			       0 eed80000 4	/* Special cycle */
>>> +			       0 ef480000 40>;	/* Internal registers */
>> Why ef480000 here? IIRC, the docs say it should be ef400000, while 
>> ef400040 - ef4fffff are reserved and can mirror local registers.
> 
> Dunno... probably a typo, though it worked :-) I'll fix it up.

Just checked the ppc440ep user manual again.
Special cycle/IACK registers are at 0xeed00000 instead of 0xeed80000.
Looks like the same typo as in the internal registers.
It works because all these registers are mirrored at 0x80000 offset 
(though it's claimed to be a reserved region).

Thanks,
Valentine.

> 
> Ben.
> 
> 

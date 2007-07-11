Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC539DDE32
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 04:49:27 +1000 (EST)
In-Reply-To: <1184122420.22066.35.camel@localhost.localdomain>
References: <1184082783.20129.193.camel@localhost.localdomain>
	<FFEC5443-109B-45B7-80CA-0252F9365B55@kernel.crashing.org>
	<1184122420.22066.35.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9A626C3A-880F-4868-8200-6DA59171464B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 5/6] Update the 83xx/85xx/86xx boards device tree
Date: Wed, 11 Jul 2007 20:49:11 +0200
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Indentify pci, pcie host by compatible property
>>> "fsl,mpc83xx-pci","83xx"
>>> "fsl,mpc85xx-pci","85xx"
>>> "fsl,mpc86xx-pci","86xx"
>>> and
>>> "fsl, mpc85xx-pciex","85xx"
>>> "fsl, mpc86xx-pciex","86xx"
>>
>> This can't ever work --
> It works!

How can any driver match for "85xx" if two completely different
devices use it as device name?

>> if you see "compatible" = "85xx",
>> what is it?
> That's why I remove the original compatible "85xx".

All entries in "compatible" are independent of each other.  So
there still is a "85xx" in there.

>>   PCI or PCIe?  Or something else perhaps, maybe
>> a CPU or an I2C controller or who-knows-what?
> I just think the compatible field
> "fsl,mpc83xx-pci","83xx"
> has some redundant information.
> Kumar don't want to break anything using the old
> information.

Yes, you can keep the existing "compatible" for, ahem,
compatibility reasons -- but that doesn't mean you should
add "85xx" to new (incompatible!) nodes.

> We can remove it in the future:-).

I hope so :-)


Segher

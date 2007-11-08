Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 284E5DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 06:46:10 +1100 (EST)
Message-ID: <47336805.4040807@genesi-usa.com>
Date: Thu, 08 Nov 2007 19:48:21 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>	
	<4732396D.4040904@genesi-usa.com>	
	<9e4733910711071421i347a6a0bu99cbf062cc152aca@mail.gmail.com>	
	<473258B8.4060905@genesi-usa.com>	
	<9e4733910711071815x344319ebye89168320dd53c0@mail.gmail.com>	
	<47333939.6050106@freescale.com>
	<9e4733910711080904h7d0dfb90o61d15d0326aedbf9@mail.gmail.com>
In-Reply-To: <9e4733910711080904h7d0dfb90o61d15d0326aedbf9@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Jon Smirl wrote:
> On 11/8/07, Scott Wood <scottwood@freescale.com> wrote:
>
>> I think you may be placing too much faith in the vendors.
>> Is a 7400 a Freescale powerpc chip, or a quad 2-input NAND gate? :-)
> 
> There has to be more to the part number for the Freescale powerpc chip
> than just 7400. 7400 is a shorthand name, it is not an orderable part number.

The orderable part numbers add 3 or 4 characters to the front and about
8 after. There is a difference between MPC7400 and PPC7400, and the
low voltage versions, and the different clock speeds. Orderable part
number for a recent G4 might be PPC7448B1333NL - this is a ridiculous
amount of specificity in a device tree, and it also does not match the
datasheet (MPC7448 is the name of the chip).

What people usually do is use what's in the datasheet.

>> If you want to argue that the "MPC" part differentiates them, that's
>> just a less readable and more obsolete vendor prefix.
> 
> The MPC is what is printed on the chip. fsl is not printed there. MPC
> is part of the orderable part number.

Not all of them *ahem* :)

Like I said, trust the datasheet, not the number on the chip.

>> Vendor prefixes on properties are useful in that it might not mean
>> exactly the same thing as a similar property that gets standardized
>> later on.
>>
>>> That's life in the Linux world, no backwards binary compatibility.
>> There's a huge difference between compatibility of kernel interfaces and
>> compatibility of interfaces between the kernel and something else --
>> whether it be userspace or firmware.

Indeed, so.. at some point we should all sit down and hammer out the
major issues in describing something like the MPC5121E because right
now Genesi has a vested interest in that. Thanks Grant for your
discussion on it, I agree of course :)

One thing we don't want to go through again is the complaints we got
because we named the chip node "/builtin" rather than "/soc". My fixup
script is still handling that mess because you guys refused to
accept it (and some drivers were coded to map from the MBAR contained
in device_type soc's reg property rather than find a real device).

If we could all agree on how it should be mapped out, with an example
tree which shows *every damn thing available* so platform developers
can pick and choose and OF developers can use it as a reference, it
would make a much happier process.

And then we can fix up the Efika to fit some definition of the new
MPC5200 tree too.

By the way while I was poking around the tree today I noticed that
there is a PCI errata fixup handled by a Kconfig in there. Why? Surely
this is something you check the PVR/SVR for and switch on that for
a runtime solution, and not trick users with the possibility of
forgetting to enable some obscure "PCI errata fix" configuration
item? (CONFIG_PPC_MPC5200_BUGFIX)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

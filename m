Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE3DEDDEE0
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 01:47:31 +1000 (EST)
In-Reply-To: <C793D7D1-CA26-4DCB-B513-56E927BF6BA9@kernel.crashing.org>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
	<20070416102533.0f87396f.kim.phillips@freescale.com>
	<C793D7D1-CA26-4DCB-B513-56E927BF6BA9@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ba8618e3bd28389b66262e549387ac8d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Date: Mon, 16 Apr 2007 17:47:18 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Since ucc_geth is being migrated to use the phylib, the existing
>>>> (undocumented) 'interface' property is being deprecated in favour
>>>> of unconjoined variations 'max-speed' and 'interface-type'.
>>>
>>> Again, please explain why this information shouldn't
>>> be in the PHY node instead?
>>>
>>
>> Strictly speaking, it should be neither in the UCC node nor the PHY
>> node, as it describes the connection between the two, but..

Connections are never described with separate nodes in
the device tree.

>> the UCC driver utilizes the data itself; the UCC, unlike other network
>> controllers, does not provide interface data in its programming model.

I have no idea what this means?

>> the phy drivers are not of_ drivers.  Porting phylib drivers to be of_
>> drivers would break phylib for non-OF arches, e.g. x86.
>
> Nothing stops the code in the UCC driver from grabbing the phy device 
> node and pulling the information out if it.

Quite so.  This isn't "bad style" either, it is a perfectly
normal thing to do.

> I believe the question is about where the information should truly 
> live.

Yeah.

> It would seem to be more of a property of the phy than of the enet 
> controller.

Yep.  The whole reason why any property is wanted here is
to say what type the PHY is, as the enet controller can
be attached to several kinds.  And what type the PHY is
belongs in the PHY node, obviously.  In its "compatible"
property to be exact.


Segher

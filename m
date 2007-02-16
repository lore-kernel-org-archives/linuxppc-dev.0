Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3269BDDDF0
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 20:42:07 +1100 (EST)
In-Reply-To: <17877.1576.405941.835140@cargo.ozlabs.ibm.com>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
	<9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
	<1171489360.20192.184.camel@localhost.localdomain>
	<122a66d49480520cf87cd748bbfc50bb@kernel.crashing.org>
	<17875.49565.444870.924729@cargo.ozlabs.ibm.com>
	<6c90a73251f09d619498c77264a15fef@kernel.crashing.org>
	<17875.53329.662052.612956@cargo.ozlabs.ibm.com>
	<65b693652fa034ed521e132a6142b3b7@kernel.crashing.org>
	<17877.1576.405941.835140@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <698289856f5f7db0f9fdee6ecb60a459@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Fri, 16 Feb 2007 10:41:58 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> We don't require an OF device tree;
>>
>> When booting on real OF you do.
>
> No, the kernel requires a flattened tree, which is created by glue
> code from the OF device tree.

Heh.  And you really think that "glue code" will ever not
be linked into the zImage, and distributed with the kernel
code?

> Currently everything in the OF tree
> goes across into the flattened tree, but in future there may not be a
> 1-1 correspondence.

Which would be a mistake IMNSHO.  Sure you want to do some
fixups on broken things in some trees, but that's all.

Or perhaps you mean you would morph the tree into some
completely different format?  That would be fine, just
make sure it is obvious it is something different.

>> Sure.  You could have chosen a structure that is closer to the
>> internal Linux structures.
>
> What internal Linux structures?

The Linux device abstractions, for example.

> In any case it's a mistake to tie
> internal and external structures together because it creates future
> compatibility headaches.

You don't have to tell _me_ that.

>>> That it looks strangely familiar to you is just a
>>> coincidence. :)
>>
>> Heh suuuuuuuure :-)
>
> The device tree is basically a generalization of the list of tags +
> values that ppc and other architectures use.

Yeah whatever.  It is a *complete* accident that it is
virtually identical to OF.  I believe you.

> The tags are strings
> rather than numbers, because that makes sense, and you can group sets
> of tags + values that relate to a particular device together, and you
> can link devices together in a hierarchical arrangement.

Not just "you can", you *must*.  The way they are connected
has a lot of meaning.  Remove that and everything starts
falling apart.

> The last thing I want to do is to put unnecessary burdens on embedded
> platforms just to comply with OF requirements.

Then you should define a simpler format that hopefully can
handle everything that OF can.  Maybe you can do a better
job if you really think OF is overly complicated.

> We have the device
> tree because it makes sense both for embedded and for desktop/server
> machines, not because OF is some sort of holy writ.

Whatever interface definition you do create, it will be "holy
writ".  Since almost nothing is written down (complete enough
and without major errors and inconsistencies) elsewhere, there
is no other choice right now than to fall back to the OF specs.


Segher

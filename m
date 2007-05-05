Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 598D1DDED8
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 10:07:19 +1000 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302D5E891@az33exm25.fsl.freescale.net>
References: <20070425213700.GA8814@blade.az.mvista.com><20070426000852.GA2193@localhost.localdomain><20070426003748.GA30730@blade.az.mvista.com><9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org><4630D9AB.2040605@mvista.com>
	<e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5DC6F@az33exm25.fsl.freescale.net>
	<567cddf8855d809f2e0c5b4101c2c15a@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5E195@az33exm25.fsl.freescale.net>
	<1624cd331b61117d7251f70caaa86292@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5E891@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9585558cf3330e1b18e9becfa3b24864@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: RFC: new device types in the device tree (RE: [PATCH] powerpc:
	Add EDAC platform devices for 85xx)
Date: Sat, 5 May 2007 02:07:08 +0200
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> name is always optional (as defined by b-w-of.txt)
>>
>> Where does it say that?  "name" is always required!  In
>> the newer flat tree format, it's even impossible to
>> create a node without "name".
>
> I'm specifically referring to the "name" property.  Here is
> what booting-without-of.txt says:

Okay, a few separate issues here...

>    While earlier users of Open Firmware like OldWorld
>    macintoshes tended to use the actual device name for
>    the "name" property, it's nowadays considered a good
>    practice to use a name that is closer to the device
>    class (often equal to device_type)...

Yes, this is known as "generic names" -- it makes device
trees more readable and easier to use (on real OF).  See
the "generic names" recommended practice document.

> [snip]... However,
>    the kernel doesn't generally put any restriction on the
>    "name" property; it is simply considered good practice
>    to follow the standard and its evolutions as closely as
>    possible.

When the kernel looks for a driver for a device node,
it should first consider "name" and after that the
entries in "compatible", in order.

Yes I know this is not what the kernel does most of
the time.

>    Note also that the new format version 16 makes the
>    "name" property optional. If it's absent for a node, then
>    the node's unit name is then used to reconstruct the name.
>    That is, the part of the unit name before the "@" sign
>    is used (or the entire unit name if no "@" sign is present).
>
> If the name property is missing the kernel contructs it from
> the unit name.

So there _always_ is a "name" property.  Who cares how
it is encoded in the DTB.

> I guess my point is the name property implies
> nothing and the kernel doesn't seem to care what name is used.

It does, in some cases.  See the bindings for "isa" and "pci"
busses for example (for the bus nodes, not the device nodes
under those).

> It certainly doesn't imply a required set of properties.

That depends on the specific binding for the type of
device; in most cases, some binding specific properties
_are_ required.


Segher

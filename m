Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0AACDDDF39
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 10:54:51 +1000 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302D5DC6F@az33exm25.fsl.freescale.net>
References: <20070425213700.GA8814@blade.az.mvista.com><20070426000852.GA2193@localhost.localdomain><20070426003748.GA30730@blade.az.mvista.com><9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org><4630D9AB.2040605@mvista.com>
	<e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5DC6F@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <567cddf8855d809f2e0c5b4101c2c15a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: RFC: new device types in the device tree (RE: [PATCH] powerpc:
	Add EDAC platform devices for 85xx)
Date: Wed, 2 May 2007 02:34:45 +0200
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

>> "name" = "memory-controller"
>> "compatible" = "fsl,85xx-memory-controller"
>> (or a more specific 85xx model if the controller
>> isn't identical across those chips)
>> No "device_type" at all, since there is no binding
>> for this kind of device.
>
> Is "no device_type" really the approach that should be
> taken?

Yes.

> booting-without-of.txt currently reads:
>
>    Every node which actually represents an actual device
>    (that is, a node which isn't only a virtual "container"
>    for more nodes, like "/cpus" is) is also required to
>    have a "device_type" property indicating the type of
>    node

That is wrong, IMNSHO.

> The 1275 spec is 'Open Firmware centric' in that it says
> you don't need a device_type if the node is not used
> by Open Firmware.

It is "Open firmware centric" in every way; it is
the Open firmware definition after all.

"device_type" specifies what firmware interfaces a
node implements.  "name" and "compatible" are for
the client (i.e., OS, bootloader, etc.) to use for
matching drivers to device nodes.

It typically makes no sense to create a new "device_type"
value for anything else than very generic classes of
device, where you can drive the device without knowing
anything else than what is defined in the binding for
that "device_type".

> What should the approach be for new device types that
> keep popping up?   If the device type is generally useful
> I think it makes sense to create a binding and add it to
> booting-without-of.txt-- essentially documenting the
> required properties, their values, and what they mean.

And the associated methods and anything else that is
needed.  It would be a big mistake to create incompatibilities
with "real OF" where those can be avoided just as easily.

> If it is vendor specific, that vendor should create some
> vendors specific doc for their bindings--
> Documentation/powerpc/fsl-of-dev-bindings.txt.
>
> Comments?

In short: having a "device_type" in your node doesn't
help at all if all users need to know the "compatible"
property as well; and it _does_ hurt.


Segher

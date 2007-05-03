Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 76ED4DDEB9
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 10:48:44 +1000 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302D5E195@az33exm25.fsl.freescale.net>
References: <20070425213700.GA8814@blade.az.mvista.com><20070426000852.GA2193@localhost.localdomain><20070426003748.GA30730@blade.az.mvista.com><9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org><4630D9AB.2040605@mvista.com>
	<e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5DC6F@az33exm25.fsl.freescale.net>
	<567cddf8855d809f2e0c5b4101c2c15a@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5E195@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1624cd331b61117d7251f70caaa86292@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: RFC: new device types in the device tree (RE: [PATCH] powerpc:
	Add EDAC platform devices for 85xx)
Date: Thu, 3 May 2007 02:48:19 +0200
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

>>> The 1275 spec is 'Open Firmware centric' in that it says
>>> you don't need a device_type if the node is not used
>>> by Open Firmware.
>>
>> It is "Open firmware centric" in every way; it is
>> the Open firmware definition after all.
>>
>> "device_type" specifies what firmware interfaces a
>> node implements.  "name" and "compatible" are for
>> the client (i.e., OS, bootloader, etc.) to use for
>> matching drivers to device nodes.
>
> The flat device tree standard (i.e. booting-without-of.txt)
> certainly inherited stuff from IEEE-1275, but can diverge
> if need be.

It shares the kernel interface.  You cannot go diverge
on fundamental things.

> name is always optional (as defined by b-w-of.txt)

Where does it say that?  "name" is always required!  In
the newer flat tree format, it's even impossible to
create a node without "name".

> There are no interfaces or methods with the device trees
> defined in DTS files.  Given that, does the the device_type
> property have any value at all?

Not much, but still a bit, like you can find all
"serial" devices if you want to.  And of course,
many bindings require a specific "device_type",
so you should have one.

> There are a slew of device_types defined in the DTS files
> and in booting-without-of.txt.  Should all these be
> removed?

Most should yes.

>> It typically makes no sense to create a new "device_type"
>> value for anything else than very generic classes of
>> device, where you can drive the device without knowing
>> anything else than what is defined in the binding for
>> that "device_type".
>
> What types devices get a device_type and which don't?  Linux
> drives the devices based on "compatible".

No, Linux selects which driver to use based on "compatible".
That's a crucial difference.

>> And the associated methods and anything else that is
>> needed.  It would be a big mistake to create incompatibilities
>> with "real OF" where those can be avoided just as easily.
>
> But there are no methods.

Again, you should not create incompatibilities where
not needed.  Since "device_type" is primarily useful
for (talking to / using) the firmware, and hardly
useful at all for the flat device tree, the flat tree
"standard" shouldn't define new "device_type"s without
making it a real OF binding.

> Even if the kernel does not use 'device_type', the property
> still seems to have some value in that it specifies a
> required set of properties and their values for various
> classes of devices.

Sure.  "network", "block", "serial", etc.

> Take a flash device for instance--

Yes, "flash" could be made into a nice generic binding
(except that no one has succeeded so far, there are just
way too many different kinds of flash/rom/nvram, and
many ways to hook them up).

> I suppose we can delete the device_type property and the
> kernel will still be happy, but it's nice to have a standard
> set of properties that everyone uses when describing a given
> class of device.  The device_type is just a convenient
> identifer to refer to this device class and set of properties.

Unfortunately, there is no standard "device_type" for
flash yet.


Segher

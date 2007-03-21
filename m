Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1A1DDDF12
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 08:54:58 +1100 (EST)
In-Reply-To: <46018F7B.40107@freescale.com>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<1b943ac2c00b7f1f5696d006b67e9877@kernel.crashing.org>
	<46014BF5.6060509@freescale.com>
	<995355b28eecaafe955a5628ee939340@kernel.crashing.org>
	<46018315.1030703@freescale.com>
	<c4aa5f9e5e15d2e9686f77384f6cb532@kernel.crashing.org>
	<46018A00.9080703@freescale.com>
	<7a793472a33a30c35723be73e9cfce2f@kernel.crashing.org>
	<46018F7B.40107@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <2e575aae6dbe6f628356d2e8d99e1d10@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Date: Wed, 21 Mar 2007 22:54:19 +0100
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> If the property exists in the device tree, then it should be used,=20=

>>> no?  Whether or not it exists is not for the driver to decide.
>> The property doesn't describe anything about the device;
>> it merely tells you something about what the firmware did
>> during booting.
>
> Ah, I see your point.  But how else can the bootloader tell the kernel=20=

> what MAC address to use?

It should use "local-mac-address".  Quoting:

=93local-mac-address=94 S
Standard property name to specify preassigned network address.
prop-encoded-array: Array of six bytes encoded with encode-bytes.
Specifies the 48-bit IEEE 802.3-style Media Access Control (MAC)
(as specified in ISO/IEC 8802-3 : 1993 [B3]) address assigned to
the device represented by the package, of device type =93network=94,
containing this property. The absence of this property indicates
that the device does not have a permanently assigned MAC address.

>> Just everything everywhere that mentions "mac-address" should be
>> completely and utterly eradicated :-)
>
> Are you saying that Linux should not acknowledge the existence of the=20=

> mac-address property, even though it's part of the OF spec?

Oh it can acknowledge its existence, it just has no business
using its contents.

>> And sure I understand you have to change one component at a
>> time -- seems to me uboot is the first step to fix?
>
> Depends on what you mean by a fix.  Although I understand your point=20=

> that the MAC address doesn't really belong in the device tree, I don't=20=

> see any better place for it.  So for now, I'm going on the assumption=20=

> that mac-address and local-mac-address are valid properties, so it's=20=

> just a question on *how* they should be supported.

Just use "local-mac-address", ignore "mac-address" completely,
be happy, end of world hunger.  Or something like that.

> In that context, the kernel has been updated already, and some of=20
> U-Boot has also.  Well, I'm ignoring some of the more obscure IBM=20
> systems, because I don't know anything about them.  All that's left is=20=

> 85xx, 86xx, and 5xxx, and then I can clean up the DTS files, and then=20=

> as far as I'm concerned, I'm done.

I think you're on the right track and we are talking past
each other somehow.  We'll see :-)


Segher

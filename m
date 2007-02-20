Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 695A0DDE2C
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 06:54:23 +1100 (EST)
In-Reply-To: <200702201902.09051.arnd@arndb.de>
References: <20070220020837.GF17818@localhost.localdomain>
	<200702201607.33249.arnd@arndb.de>
	<814781c1228541df932f8f4c7cc6ea89@kernel.crashing.org>
	<200702201902.09051.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <df6b7857dc38d708a68c81a75b256cb5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [0/14] Ebony support, 2nd spi
Date: Tue, 20 Feb 2007 20:51:34 +0100
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Hartmut Penner <HPENNER@de.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> but is it really the right thing to call it "ibm,plb"
>
> when the identical macro is used on amcc based systems?
>
> I think that was our reasoning when we introduced the
>
> code in linux to scan for "plb5", "plb4" and "opb" buses.

Yes, the vendor-code is there only as a unique marker
so different vendors won't have clashing namespaces.
Seen from that viewpoint, if a company buys stuff from
another company, or the whole company is bought or something,
it makes sense to keep the original name.

> Changing the "device-type" now would result in the final
>
> product to not work on the 2.6.20 kernel, which was released
>
> with the code only scanning for the short names.

If it's important for you to support .20, you obviously
shouldn't change this in the device tree anymore.
Unfortunate.

> Still, it's probably a good idea to list both variants
>
> in compatible, e.g.
>
> type="plb4", compatible="ibm,plb\0ibm,plb4\0plb"

No, that's a very bad idea.

> Do you think it makes sense to do it this
>
> way, or should we rather adopt the axon style on the 440 boards?

Like I said, it is probably best to have the device_is_compatible()
function return true if it is asked for "some-vendor,some-name"
and the actual property contains just "some-name".  The device
tree isn't more specific in that case, so any matcher can easily
be hurt by a namespace clash -- too bad, nothing the kernel
can do about it, but at least it can do the right thing for
device trees that *do* comply to best practice.

> > So the "compatible" property should read ns16750, ns16550,
>
> > ns16450, i8250. The kernel really only needs the device
>
> > to be compatible to the 8250; but since lots of device trees
>
> > mention only the newer UART types, you have to match on those
>
> > too.
>
> Right, that sounds completely correct. I think I've done the
>
> right thing in of_serial already.

Yeah I think so.

> Christian, please check
>
> what the firmware does today, and make sure to change it
>
> accordingly.

Note that it doesn't matter much for Linux if you change the
"compatible" property for serial now; the kernel will have to
support ns16550, ns16750 for ever since there are device
trees in the wild that don't include the more generic devices
in their "compatible" property.  Not only Axon etc. device
trees, don't get me wrong :-)

> We probably also need a volunteer to clean up the legacy_serial
>
> code for this, it's grown pretty messy by now.

I nominate you :-)


Segher

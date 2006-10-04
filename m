Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A485567CD8
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 16:09:06 +1000 (EST)
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<20060927112201.293fef44@localhost.localdomain>
	<EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 16:08:48 +1000
Message-Id: <1159942128.13323.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Now, we have something that is way more complex than
> we initially thought was necessary, trying to describe nearly
> everything addressable in the system instead of just the
> internal memory map.  I suspect the software to attain
> (IMHO the useless) goal of a single binary for multiple
> boards will create exponentially complex software,
> something that highly reliable embedded systems
> are trying to avoid.

It's not that complex and the single binary is not necessarily the main
objective (it's a good practice as it enforce avoiding ugly #ifdef hacks
where not necessary, often not in performance critical code anyway).
There is fundamentally little difference between the OCP tables we had
before and the device-tree. In both cases, the choice was made to not
hard-code the device-infos in the drivers, not only because of the
possible booting-multiple-board stuff (which could have been acheived
with the OCP tables with simple tricks too), but also to make it easier
to have several instances of a given device (very common) etc...

The new device-tree model provides a more flexible and richer semantic
for adding all sort of driver or BSP private infos, and for dealing with
address mapping and interrupt mapping.

When done right, it does simplify the matter. An example that I've seen
internally is embedded boards with all sorts of variety of dodgy
interrupt controllers cascaded on each other. The interrupt tree
mecanism along with the new interrupt code in the powerpc architecture
makes it very easy to handle that, by completely separating the domain
number between the various controllers and using the device-tree to
express the relationship between the devices and interrupt controllers.

It simplifies the code, both on the driver and the platform side, and
keep the whole interrupt tree resresentation in one place: the
device-tree.

I agree that too complex trees are not a good idea, but so far, the
definition we provided for a minimum tree is fairly slim. You do not
-have- to put all your devices in there, but in many case, doing so
makes it simpler for your own code/driver to retreive informations such
as base addresses, interrupts (see above), and all sort of auxilliary
infos you may which to pass to a given driver (MAC address, serial
number, default clock, whatever).

There is a great flexibility of putting whatever you want in there... or
not. It's up to the embedded developper to use that tool, it can be used
in a bloated way, or in a smart way, we aren't enforcing any direction
here.

> What value does this provide to my client trying
> to create a cost effective wireless home networking
> device?  It certainly doesn't make the board port
> from hell any easier, since cramming the software
> into 4M of flash will likely cause the choice of a
> processor other than PowerPC that can configure
> a smaller kernel and use a tiny custom piece of
> boot code.  Highly configurable development/evaluation
> boards running a single binary aren't high volume
> products, and the additional resources required
> by such software could ensure real products aren't
> developed with PPCs.  We need to be sensitive
> to this.

I think you are a bit too dismissive here. The approach has always been
to provide the choice, and I've been fairly careful when designing the
flattened device tree format to keep it as compact as possible. Thus I
expect little overhead of using that mecanism to discover and
instanciate drivers and provide them with configuration informations. 

The value provided to your client, once we have fully sorted out the
matter (some things are still being ironed out and developped, for
example, I'm working on a more generic way to instanciate drivers for
devices probed from the device-tree outside of the well-known realm of
PCI) is hopefully an easier way to create the BSP in the first place, a
central and more maintainable location where what is on his board is
defined, the ability to more easily maintain multiple revisions of the
board, with very little overhead. For such a client, I wouldn't expect
him to build a heavily multi-board kernel nor use a massive bootloader,
and neither are made necessary. The -ability- to build multi-board
kernels is made mandatory for code to be merged upstream, as it enforces
a certain level of quality, but you don't have to actually do it on the
field. In fact, you client may be happy, once it's done rev 3 of the
board with a 3rd type of wifi chip or a 2nd type of ethernet HUB to have
the ability to easily build, maintain, distribute and test a single
kernel image, and just at install (or download) time slap the right
device-tree to form a zImage with embedded device-tree using paulus
latest tool.

Ben.

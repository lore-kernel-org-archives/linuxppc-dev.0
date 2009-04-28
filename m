Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B304DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 15:00:56 +1000 (EST)
Date: Tue, 28 Apr 2009 14:25:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: removing get_immrbase()??
Message-ID: <20090428042503.GE11265@yookeroo.seuss>
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
	<49F066DC.402@freescale.com>
	<20090423135005.GA18462@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090423135005.GA18462@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 23, 2009 at 05:50:05PM +0400, Anton Vorontsov wrote:
> On Thu, Apr 23, 2009 at 08:02:20AM -0500, Timur Tabi wrote:
> > David Gibson wrote:
> > 
> > > It's not so much point of view as situation.  Putting the device tree
> > > in the firmware and putting the device tree in the kernel are both
> > > valid choices, with their own distinct advantages and drawbacks. 
> > 
> > I was under the impression that the reason we put the device trees in
> > the kernel is because we didn't have a better place to put them.
> > Keeping them in the kernel repository was just convenient.
> > 
> > So I personally don't consider the *location* of the DTS files to be a
> > basis for deciding what they really mean.
> 
> I'm not sure why are we trying to make things harder for ourselves?
> x86 has a long history fighting with bogus bioses/dmi/acpi tables,
> up to the point where they completely ignore any information that
> BIOS provides, because that information is unreliable or hard to
> deal with.
> 
> With FDT (i.e. not hard-coded OF), we have a great opportunity to
> keep both device tree and Linux code legacyjunk-free.
> 
> All we have to do is to declare one simple thing: don't put
> device-tree into the read-only memory. Upgrading device tree blob
> in the rewritable NOR/NAND flashes is safe in overwhelming cases,
> just as safe as upgrading kernel image in the NOR/NAND.
> 
> And for those who didn't listen our pleases, i.e. for those
> who put device-tree blob into some kind of ROM or dangerous-
> to-upgrade memory or region of memory, we can always provide
> boot wrappers, and thus isolate the legacy stuff. I mean isolate
> it in their small legacy world, if anyone actually cares about
> these cases.

Indeed, this is a large part of the idea for the flattened device
tree.  Which is why I don't understand why when the idea of dtbs has
been floated, everyone seems to have been in a rush to put the blobs
into the firmware.  That's certainly one approach, and a good one for
certain needs (one kernel binary on many platforms, for example), but
putting the blob in the kernel is also an entirely valid approach and
avoids some drawbacks of having the blob in the firmware.

We're never going to get away from having shitty firmwares, but at
least with fdts we can isolate the handling of them from the bulk of
the kernel.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31A2B1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 14:04:32 +1100 (EST)
Subject: Re: [PATCH] Re: ZILOG serial port broken in 2.6.32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Landley <rob@landley.net>
In-Reply-To: <201001090217.25729.rob@landley.net>
References: <200912060101.22515.rob@landley.net>
	<200912080642.52103.rob@landley.net>
	<1262919644.2173.704.camel@pasglop>
	<201001090217.25729.rob@landley.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Jan 2010 14:02:16 +1100
Message-ID: <1263178936.724.91.camel@pasglop>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-01-09 at 02:17 -0600, Rob Landley wrote:
> On Thursday 07 January 2010 21:00:43 Benjamin Herrenschmidt wrote:
> > > Ok, here's the fix.  It's not the _right_ fix, but it Works For Me (tm)
> > > and I'll leave it to you guys to figure out what this _means_:
> >
> > I've failed to reproduce so far on both a Wallstreet powerbook (similar
> > generation and chipset as your beige G3) and a G5 with an added serial
> > port using current upstream...
> >
> > Can you verify it's still there ? I might be able to reproduce on a
> > Beige G3 as well next week.
> 
> It's still there on qemu 0.11.0's "g3beige" emulation when you use 
> CONFIG_SERIAL_PMACZILOG as the serial console.  (QEMU 0.10.x used a 16550 
> serial chip for its g3beige emulation instead of the actual ZILOG one.)  Still 
> dunno if it's a qemu or bug or a kernel bug, I just know that kernel patch 
> fixes it for me, and it comes back without the patch.
> 
> I tested 2.6.32.  Haven't tried the 2.6.32.3 but don't see why it would change 
> this...

Ok so I compiled qemu and things are a bit strange.

How do you get the output of both channels of the serial port with it ?

If I use -nographics, what happens is that OpenBIOS, for some reason,
tells qemu that the console on the second channel of the ESCC.

I see my kernel messages in the console if I do console=ttyPZ0 but the
debug stuff goes where udbg initializes it, which is where OpenBIOS says
the FW console is, which is channel B and I don't know how to "see" that
with qemu.

I do see it crash due to a message from the kernel but I can't get into
xmon which is a pain.

If I modify the kernel to force udbg on channel A (same channel as the
console), then the problem doesn't appear (it doesn't crash) :-)

Cheers
Ben.

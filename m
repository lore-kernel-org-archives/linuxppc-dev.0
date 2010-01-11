Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id 31ABF1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 18:22:17 +1100 (EST)
From: Rob Landley <rob@landley.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Re: ZILOG serial port broken in 2.6.32
Date: Mon, 11 Jan 2010 01:22:08 -0600
References: <200912060101.22515.rob@landley.net>
	<201001090217.25729.rob@landley.net>
	<1263178936.724.91.camel@pasglop>
In-Reply-To: <1263178936.724.91.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201001110122.10202.rob@landley.net>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 10 January 2010 21:02:16 Benjamin Herrenschmidt wrote:
> On Sat, 2010-01-09 at 02:17 -0600, Rob Landley wrote:
> > On Thursday 07 January 2010 21:00:43 Benjamin Herrenschmidt wrote:
> > > > Ok, here's the fix.  It's not the _right_ fix, but it Works For Me
> > > > (tm) and I'll leave it to you guys to figure out what this _means_:
> > >
> > > I've failed to reproduce so far on both a Wallstreet powerbook (similar
> > > generation and chipset as your beige G3) and a G5 with an added serial
> > > port using current upstream...
> > >
> > > Can you verify it's still there ? I might be able to reproduce on a
> > > Beige G3 as well next week.
> >
> > It's still there on qemu 0.11.0's "g3beige" emulation when you use
> > CONFIG_SERIAL_PMACZILOG as the serial console.  (QEMU 0.10.x used a 16550
> > serial chip for its g3beige emulation instead of the actual ZILOG one.) 
> > Still dunno if it's a qemu or bug or a kernel bug, I just know that
> > kernel patch fixes it for me, and it comes back without the patch.
> >
> > I tested 2.6.32.  Haven't tried the 2.6.32.3 but don't see why it would
> > change this...
>
> Ok so I compiled qemu and things are a bit strange.
>
> How do you get the output of both channels of the serial port with it ?
>
> If I use -nographics, what happens is that OpenBIOS, for some reason,
> tells qemu that the console on the second channel of the ESCC.

Instead of "-nographic", you could try "-serial stdio" instead?

> I see my kernel messages in the console if I do console=ttyPZ0 but the
> debug stuff goes where udbg initializes it, which is where OpenBIOS says
> the FW console is, which is channel B and I don't know how to "see" that
> with qemu.

I'm just trying to get a serial console, which is why I'm booting the sucker 
with:

qemu-system-ppc -M g3beige -nographic -no-reboot -kernel zImage-powerpc -hda 
image-powerpc.sqf -append "root=/dev/hda rw init=/usr/sbin/init.sh panic=1 
PATH=/usr/bin console=ttyS0"

I didn't even know there were more debug messages...

I have CONFIG_SERIAL_PMACZILOG_TTYS=y of course:

pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
ttyS0 at MMIO 0x80813020 (irq = 16) is a Z85c30 ESCC - Serial port
ttyS1 at MMIO 0x80813000 (irq = 17) is a Z85c30 ESCC - Serial port

CONFIG_SERIO=y
CONFIG_SERIAL_PMACZILOG=y
CONFIG_SERIAL_PMACZILOG_TTYS=y
CONFIG_SERIAL_PMACZILOG_CONSOLE=y

> I do see it crash due to a message from the kernel but I can't get into
> xmon which is a pain.

Does the -serial stdio thing help?

(I know to switch between screens in the qemu x11 window, it's ctrl-alt-number 
(so ctrl-alt-1, ctrl-alt-2, and so on.  I really don't use 'em much, though.)

> If I modify the kernel to force udbg on channel A (same channel as the
> console), then the problem doesn't appear (it doesn't crash) :-)

You can attach gdb to qemu via the "qemu -s" option and then in gdb use the 
"target remote" stuff like you would with gdbserver.  It acts a bit like you've 
connected it to a jtag through openocd, if that helps...

(I know qemu has many, many options I don't really use much.)

> Cheers
> Ben.

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds

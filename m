Date: Tue, 26 Sep 2000 21:33:30 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: daenzerm@student.ethz.ch
cc: rshapiro@bbn.com,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <39D0F7EB.C0415571@relog.ch>
Message-ID: <Pine.LNX.4.10.10009262127370.21452-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >  > Does the X server complain about PCI resource conflicts when run as X
> >  > --probeonly? Anything about PCI problems in the server log?
> >
> > "startx -- -probeonly" also crashes linux when the ati drivers are
> > selected.
> >
> > Here's the log, which ends somewhat abruptly.
>
> [...]
>
> > (--) PCI: (0:13:0) ATI Mach64 GI rev 92, Mem @ 0x84000000/24, 0x81801000/12, I/O @ 0x0400/8
> > (--) PCI: (0:15:0) ATI Mach64 GI rev 92, Mem @ 0x83000000/24, 0x81800000/12, I/O @ 0x0400/8
> > (--) PCI: (0:18:0) ATI Mach64 GT rev 154, Mem @ 0x82000000/24, I/O @ 0x0400/8
>
> [...]
>
> > (--) ATI(0): VideoRam: 1 kByte (EDO)
>
> That's quite little VRAM :)

Yep, that can't really be the 2048 bug anymore.

But that's also quite a lot of mach64 cards. Are there really two GI's in
the machine?

No PCI regions overlap so my patch doesn't apply.

> Do you have an atyfb for each head? If so, try also passing the "fbdev" option
> with the devices for the ati driver.

You will have to pass multipe atyfb= kernel parameters to make the kernel
initialize one framebuffer device for each. Right now I doubt
atyfb_of_init will do the right thing here - could you post the kernel
boot messages again? I wonder if the device you specify via the busid is
the same the kernel initialized as atyfb.

Also helpful: a dump of the OF device tree.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

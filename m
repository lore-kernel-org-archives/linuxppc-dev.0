In-Reply-To: <Pine.LNX.3.96L.991129022729.5302C-100000@unix47.andrew.cmu.edu>
Date: Mon, 29 Nov 1999 10:45:24 +0100
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>,
        linuxppc-user@lists.linuxppc.org
CC: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: BootX-1.2b2 problem?
Message-Id: <19991129104524.002317@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 29, 1999, Hollis R Blanchard <hollis+@andrew.cmu.edu> wrote:

>MHz-specific? :) I don't think so, but certainly not all bugs may not show up
>on all machines...
>
>I think this problem manifests before the kernel starts going, though I don't
>know because I haven't seen it firsthand. At any rate, this isn't the only
>problem I've heard of with 1.2b2 (want to reduce your BogoMips by a factor of
>ten?), so I'd be wary of it. (Again, "not all bugs...".)

The problem with BootX 1.2b2 is the new IDE reset code (for fixing the
MacOS 9 driver issue). Some ATAPI devices (CDROMs/DVDs) will hang the
machine during this reset. (ATAPI devices do not accept an ATA reset).

I tried asking MacOS to reset the bus but this apparently doesn't work. I
can use the IDE reset HW wires but I only know how to access them on some
machines ("heathrow" based machines). So that's really a tricky issue...
I'm trying to find a way to detect which devices are ATA and which are
ATAPI and trigger the reset only for ATA. The problem is that the ATA
device is likely not to be responding to identify command (because of the
driver problem we are trying to work around).

The BogoMIPS/Slow kernel problem is beyond my understanding for now and
until I can reproduce it on one of my machines here (basically a
wallstreet, an iBook and a 8500). I really so no reason why BootX would
cause this and I'm thinking about a possible side effect of something in
MacOS triggered by BootX, but frankly, it's weird. It's still possible
that something gets wrong with the VIA which is used for calibration, can
someone with this problem try reverting the calibration code not to use
the VIA ?
(I think It's in arch/ppc/kernel/pmac_time.c or pmac_support.c)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Mon, 8 Apr 2002 18:48:04 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
In-Reply-To: <20020408162412.GJ2716@opus.bloom.county>
Message-ID: <Pine.LNX.4.33.0204081831350.20339-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Apr 2002, Tom Rini wrote:

> It's my understanding that since they're PReP + bits, it's cleaner to
> support them seperatly than in the big prep mess.  It's also easier to
> get all of the HW bits working.  But maybe Matt Porter will speak up. :)

Well, when the bits outside of initdata/initcode can be reduced to only
a different iobase, it seems overkill. And even the other bits can be
extremely tiny and mostly pushed to the bootloader. Maybe I've forgotten
something, since I've got machines running in production for about 3 years
and hardly touched anything since then.

> > Actually, PreP residual data can be useful, if you kow how to interpret it
> > to find interrupt routing for example.
>
> Well, after talking with Hollis, IBM Residual data _has to be_ good,
> since AIX or so relies on it.  But from talking to Cort a few times, he
> never could trust it on either IBM or Motorola boxes.

Well, his code to find interrupt routing was obvisouly buggy to start
with: interrupt routing is a bridge property in residual data, not a
device property (and it is the right thing to do when you think about hot
plugging).

Some minor items are wrong in MVME2xxx residual data, but the interrupt
routing for the second Ethernet or SCSI (can't remember which right now)
on MVME3600, which are not in the kernel tables, were correctly found by
my code (from the reports I got since I don't have the hardware).

>
> > (Who should have properly submitted his PrePboot code 3 years ago)
>
> Yes.  Willing to dig it up again and try and get it going for 2.5? :)

Hmm, it booted at least until 2.4.0 (early 2001), but I am very busy on
other things right now (some software, but mostly microwave, analog
electronics up to 18 GHz is so fun!) and I was waiting for at least the
new kbuild to appear in the official trees: if it holds up to its
promises, it will make life much simpler.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

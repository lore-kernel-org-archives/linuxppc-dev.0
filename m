Date: Mon, 10 Jul 2000 14:25:19 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mmporter@home.com>
cc: Michael Lundkvist <ml@epact.se>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
In-Reply-To: <20000709222943.A19611@cx258813-a.chnd1.az.home.com>
Message-ID: <Pine.HPX.4.10.10007101412580.9548-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 9 Jul 2000, Matt Porter wrote:

> > Getting those changes into PPCBUG would be great.
>
> All you need is a big customer of MCG's to push them to do it.  Money
> is a powerful motivator.

Hopeless for me...

> > Would it be possible to make one image for 2300 cards and one for 2400
> > cards or does memory size affect the residual data?
>
> See above, you could make a lowest common denominator version of the
> data and lose some memory.  Honestly, I'd just hack the kernel...PPCBUG
> and residual data are a horrible burden.  Look through prep_* and
> mm/init.c for every place residual data is used and hardcode for your
> MCG boards.  In init.c, prep_find_end_of_memory() can detect a Raven
> bridge then use the documented board registers to identify memory size
> (see online user manual).  A 2400 puts memory size across the I2C bus
> in a EEPROM containing all sorts of useful information.  Bug MCG to get
> specs on the layout of these VPD records.

I disagree, the residual data of the device/property tree of OF are great
things. I want to boot _exactly_ the same kernel on machines with
different amounts of memory... A lot of the initizalization should be
moved to early boot or to a first stage bootloader (before uncompressing
the kernel) and then the kernel should receive important information in a
predigested form.

For the VPD records, the information in the MVME2400 programmer's guide
(mvme2400apg.pdf) looks sufficient (page 1-27 and appendix B).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

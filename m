Message-ID: <3AFABDFC.B70C0775@mvista.com>
Date: Thu, 10 May 2001 12:12:44 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Lee <kdlee@sei.co.kr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: hda: lost interrupt
References: <001901c0d8ed$43a4daa0$16b260d2@sei.co.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lee wrote:
>
>     I have the custom mpc860 board ported with linux version 2.2.13.
> My custom board looks like a Motorola MBX board because it has a ATA-type
> IDE disk drive interfaced through QSPAN PCI-Bridge and W83C553F.

There have been lots of changes to the IDE and interrupt controller
software since 2.2.13.  It barely worked correctly back then, and
is certainly broken now because the PCMCIA and compact Flash devices
are much more popular IDE peripherals than a real disk connected
through PC-style bridges.

> Currently, I am trying to upgrade our linux kernel using linux version 2.4.0.
> But I am having trouble with a problem regarding to the IDE disk drive.

...and if you get it to work it will likely break everything else.
We also rely heavily on the MBX boot rom to initialize the bridges,
so when it works there it still isn't likely to work on other boards
that may even use the same parts connected in exactly the same way.

There are some modifications in the 2.2.13 (and subsequent) kernels
for generic IDE changes that are necessary to make this work at all.
These changes were never accepted upstream, so you are going to have
a unique kernel that isn't likely to have this support in general.

All of the people I know that are actually using disk drives on MPC8xx
systems have simply created a small, inexpensive piece of logic right
on the 8xx bus or buffered directly to the PCMCIA interface.  The
QSpan plus PCI/ISA parts just to get an IDE interface is not cost
effective in real products.  In these configurations, the standard
IDE or PCMCIA software "just works."


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

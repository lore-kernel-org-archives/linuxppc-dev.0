Message-ID: <3BAEB0CA.5DF89FB0@mvista.com>
Date: Mon, 24 Sep 2001 00:04:26 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Josh Huber <huber@alum.wpi.edu>,
	Tom Rini <trini@kernel.crashing.org>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
References: <20010923180012.755801009E@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> Where can I get more information what it will look like in  2.5?

>From my understanding it will be similar to the current implementation,
but will pass pointers/info in registers rather than stuffing it
into a "well known" memory location.

There should be some discussion in the archives.

> Keep in mind that PPCBoot is in use for 50+ boards from  many  diffe-
> rent hardware manufacturers. And the number is growing every week.

That's why we keep suggesting a piggyback loader is always used rather
than trying to boot vmlinux (or compressed version of it) directly.
We currently support lots of boards that don't use PPCboot, the
kernel interface has changed a couple of times (most recently the
clock speed stuff), and it didn't affect any of the boot roms.

You could just leave the PPCboot interface as it is, write a supporting
function for it in the current embed_config.c file, and just use the
same code we use on all of the other embedded boards.

> Or is there even a discussion of this stuff where one  can  at  least
> inject  ideas  or point out thinks that might cause problems - BEFORE
> everything is cast in stone?

The discussion has pretty much died away.  We just have to find time
to implement it.  The intention is to provide a single standard interface
to the kernel, that is flexible and extensible.  The bi_recs are basically
a tag and information, you can ignore anything you don't understand in the
list and provide defaults for things you don't see in the record list.
Many of the piggyback loaders already support the first version of this,
the "well known" memory location made it a challenge for the 8xx boards,
so I was slow doing anything about it until Ben suggested the change to
use the registers to pass the record start/end information.  This will
break the existing kernel calling interface, so everyone has to change to
use the same thing.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

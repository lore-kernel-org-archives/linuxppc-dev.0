Message-ID: <3BAA093A.10E96272@mvista.com>
Date: Thu, 20 Sep 2001 11:20:26 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Stefan Roese <stefan.roese@esd-electronics.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
References: <EFEAIMDCOOOHIEPHDNFJEEMCDCAA.stefan.roese@esd-electronics.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan Roese wrote:

> Hmmm, now I am totally confused!

Me, too.  I have more to do than just track the progress of this
patch, which is changing faster than I can read e-mail.


> #ifndef __CPCI405_H
> #define __CPCI405_H
>
> #include <linux/config.h>
>
> #include <asm/ppcboot.h>
>
> #endif  /* __CPCI405_H */

This is fine, Tom said it was an empty file.........

> Tom convinced me to remove this header and so I changed ppc4xx.h this way:

This is fine, too, but certainly doesn't justify re-engineering the way
we handle all of the other embedded boards.  Your board just happens to
take advantage of all of the generic 4xx definitions, so you don't need
anything else.


> ...... but I
> have to admit that I don't have a clue what is going to replace it (please
> have mercy with my ignorance ;-))! Can somebody enlighten me (link's, etc.)?

Just take a look at all of the bootloaders for all of the other platforms.
The 4xx and 8xx should have changed to look like these long ago.  I just
didn't have time to do it, and no one else was interested.

> Dan, you are right that we (PPCBoot) people will have some homework to do,
> but right now our only way to Linux is via the bd_info struct!

No, the way to Linux is to _always_ use a zImage with an attached bootloader.
PPCboot can continue to pass whatever it wants, or the bootloader can find
the information in other ways as it does today with many boards.  Booting
a vmlinux image and trying to keep track of that private interface between
the bootloader and the kernel is difficult.  We already have more changes
planned in addition to the bi_recs interface.  Much of the code found today
in the head.S files is going to migrate to the bootloaders.

> So please, is anybody willing to check this stuff into the
> linuxppc_2_4_devel tree (Tom, Dan)?

We are working on it.  We all have real jobs to do besides trying to
manage all of these sources.  I would like to get some of _my_ stuff
checked in as well.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

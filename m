From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>,
	"Linuxppc-Commit" <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Date: Thu, 20 Sep 2001 11:20:21 +0200
Message-ID: <EFEAIMDCOOOHIEPHDNFJEEMCDCAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3BA96CA2.20EC30C8@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > ....  We
> > now define CONFIG_TREEBOOT and CONFIG_EMBEDDEDBOOT for 4xx.
>
> Why?  The Makefile can just as easily select this based upon board
> type.  That's all the configuration script does....
>
> The only thing unique about treeboot is the way the board information
> is gathered from the boot rom, which doesn't justify configuration
> variables like this.  Take a look at the 8xx for an example.  It
> configures board information based upon board type, which could be
> gathered from a variety of places.  You guys need to look at what
> is currently done, understand it, and realize it has likely been
> done before.  This is easy, don't keep complicating it by inventing
> something new all of the time.

Hmmm, now I am totally confused! It seems to me, that my first
implementation did it exactly like most of the 8xx boards! My only
difference was to implement a header without any content (included from
ppc4xx.h of course):

#ifndef __CPCI405_H
#define __CPCI405_H

#include <linux/config.h>

#include <asm/ppcboot.h>

#endif	/* __CPCI405_H */


Tom convinced me to remove this header and so I changed ppc4xx.h this way:

#if defined(CONFIG_CPCI405)
#include <asm/ppcboot.h>
#endif

> > ....  Lets add in
> > CONFIG_PPCBOOT,
>
> No, let's not.  All of this stuff is on the way out.  We should be
> making modifications so the embedded boards support bi_recs....
> All you are doing is inventing a new way to do the same thing that
> has always worked.  Yes, you are _way_ over engineering.
>
> The PPCboot folks are going to have to do some major revamping
> of the way it works.  I've warned them (and everyone) about the
> dependency of always using the compressed image and the bootloaders.
> It's time to convert all of this stuff, not promote all of these
> different boot methods and formats further into the kernel.

I already heard, that the bd_info struct will disappear someday soon, but I
have to admit that I don't have a clue what is going to replace it (please
have mercy with my ignorance ;-))! Can somebody enlighten me (link's, etc.)?

Dan, you are right that we (PPCBoot) people will have some homework to do,
but right now our only way to Linux is via the bd_info struct!

So please, is anybody willing to check this stuff into the
linuxppc_2_4_devel tree (Tom, Dan)? If not,  tell me what else I have to
change. And please, don't tell me my only way to get this checked in, is to
change to bi_recs (what ever that is?) ;-)

Thanks,
Stefan.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

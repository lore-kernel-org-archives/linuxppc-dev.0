Date: Tue, 20 Apr 1999 15:43:52 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David De Ridder <david.de.ridder@bitsmart.com>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mvme kernel patches [LONG]
In-Reply-To: <Pine.SO4.4.05.9904201448280.3400-100000@hsins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990420152154.20020F-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 20 Apr 1999, David De Ridder wrote:

>  We'll see what the result is with a 2.2.4 kernel.
>  BTW, the old patches gave a problem with ppc_defconfig or smth like that.
>  (I can't recall the exact problem, and I don't fancy unpatching the whole
>   source tree to a not-working variant).

Well, I never do a make mrproper, but occasionally a make distclean
(because it also removes the *~ files). But just after I always copy one
of the mvme2600.config to .config and type make oldconfig. Updating from
the default configs is too error prone...

> > > * The new precompiled nfsroot-2.2.4 kernel works great (as did the
> > >   2.2.1). Even better : it does not give the ``openpic.c'' error anymore.
> > 
> > I'm up to 2.2.6, it will appear soon on the server. Lots of VME tests this
> > week.
> 
>  Cool.
> 
> > > I still have some questions :
> > > 
> > > * Why is the Generic DECchip driver used instead of the DEC2x41x driver ?
> > >   Is this because of the problems with the DEC21143 ?
> > 
> > Arenn't you confused ? I think they are the sme driver under evolving
> > names. The source file is de4x5.c, tulip.c has never worked properly on
> 
>  I was unaware of that. I was under the impression that there was a
>  stable dedicated DEC Tulip driver (that I expected to work with the
>  board). I'm probably completely wrong ;-)

Anyway you won't have problems on the 2600 since it is a 21140. Only the
boards with 21143 chips have invalid SROMs. The de4x5 driver works
(CONFIG_DE4X5) and the Tulip (CONFIG_DEC_ELCP) does not. Even Dave Miller
said once that he had given up on trying to get the Tulip driver running
on a big-endian machine.

>  So, there's no use in trying to use the 21x4x driver ?

No. 

> > > * (Gabriel) Is it possible to post the .config that resulted in the
> > >   current zImage-nfsroot-2.2.4 on your FTP site ? Or by mail to this
> > >   list ?
> > 
> > Yes, I thought they were uptodate, so I must have screwed up something.
> 
>  It seems to me that you only updated mvme2600.config. Neither .initrd
>  nor .nfsroot are updated.

Ok, I've put the last ones (for 2.2.6). 

> > > I'm currently trying to compile my own 2.2.4 with the latest patches.
> > > I'll keep everyone posted.
> 
>  Well, the kernel compilation *failed*. It got stuck in ``universe.c'',
>  because it doesn't know several UNIVERSE_- constants (e.g.
>  UNIVERSE_MAJOR). Sounds like an include file is missing or not patched.
>  I did a find+grep on the patched source tree and the only header or .c
>  file with these constants seems universe.c.

grep UNIVERSE_MAJOR drivers/vme/*.[ch]
drivers/vme/universe.h:#define UNIVERSE_MAJOR 60 /* Experimental major number */

Ok, now I see. I wanted to exclude modversions.h and version.h from the
patch file and I use a *vers*.h wildcard which also removes universe.h
from the patch. Corrected now, but the patches are against 2.2.6.

>  To make sure, I've rerun ``make oldconfig'' and have compiled again
>  (NFS is slooowwwww). I notice universe.c gives several errors on
>  almost *EACH* line it contains. Weird. It also appears that there are
>  some type definitions missing.

This certainly explains lots of compile errors.

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Tue, 20 Apr 1999 16:06:16 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Gabriel Paubert <paubert@iram.es>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mvme kernel patches [LONG]
In-Reply-To: <Pine.HPP.3.96.990420152154.20020F-100000@gra-ux1.iram.es>
Message-ID: <Pine.SO4.4.05.9904201558530.3400-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Apr 1999, Gabriel Paubert wrote:

> On Tue, 20 Apr 1999, David De Ridder wrote:
> 
> >  We'll see what the result is with a 2.2.4 kernel.
> >  BTW, the old patches gave a problem with ppc_defconfig or smth like that.
> >  (I can't recall the exact problem, and I don't fancy unpatching the whole
> >   source tree to a not-working variant).
> 
> Well, I never do a make mrproper, but occasionally a make distclean
> (because it also removes the *~ files). But just after I always copy one
> of the mvme2600.config to .config and type make oldconfig. Updating from
> the default configs is too error prone...

 Yes, and doing an entire kernel configuration is not funny on a serial
 terminal (at least, not with make menuconfig). Maybe an ncurses bug...

> >  So, there's no use in trying to use the 21x4x driver ?
> 
> No. 

 Great.

> >  It seems to me that you only updated mvme2600.config. Neither .initrd
> >  nor .nfsroot are updated.
> 
> Ok, I've put the last ones (for 2.2.6). 

 You will notice that our mails just missed each other ;-)
 
> grep UNIVERSE_MAJOR drivers/vme/*.[ch]
> drivers/vme/universe.h:#define UNIVERSE_MAJOR 60 /* Experimental major number */
> 
> Ok, now I see. I wanted to exclude modversions.h and version.h from the
> patch file and I use a *vers*.h wildcard which also removes universe.h
> from the patch. Corrected now, but the patches are against 2.2.6.

 Rats !  Hmm, do you think it is safe to unpatch to a standard 2.2.4,
 then apply 2.2.5 and 2.2.6 upgrade patches, and then your new patches ?
 (Installing an entire kernel tree takes long, since I only have NFS
 access to the destination server). Or, maybe you could send me your
 universe.h...please...pretty please...

> >  To make sure, I've rerun ``make oldconfig'' and have compiled again
> >  (NFS is slooowwwww). I notice universe.c gives several errors on
> >  almost *EACH* line it contains. Weird. It also appears that there are
> >  some type definitions missing.
> 
> This certainly explains lots of compile errors.

 It sure does,

+-----------------------------------------------------------------+
   David 'Septimus' De Ridder     <david.de.ridder@bitsmart.com>

"Watching eyes wait for sadness to rise,
 true superstitions combine and thicken
 this poison that reaches my soul,
 this terror that blackens my soul."
 - Anne Clark
+-----------------------------------------------------------------+



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Tue, 20 Apr 1999 15:20:36 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Gabriel Paubert <paubert@iram.es>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mvme kernel patches [LONG]
In-Reply-To: <Pine.HPP.3.96.990420123601.20020A-100000@gra-ux1.iram.es>
Message-ID: <Pine.SO4.4.05.9904201448280.3400-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Apr 1999, Gabriel Paubert wrote:

> > * Using the mvme2600.config.nfsroot with these patches never resulted
> >   in a kernel that would boot (``Residual data located'' message, even
> >   before the Linux kernel had said anything).
> 
> That's not normal. Once you have copied the mvme2600.config.xxx to
> .config, you should always do a make oldconfig to setup things properly.

 We'll see what the result is with a 2.2.4 kernel.
 BTW, the old patches gave a problem with ppc_defconfig or smth like that.
 (I can't recall the exact problem, and I don't fancy unpatching the whole
  source tree to a not-working variant).

> > * With the new patches, ``make menuconfig'' works fine (only one error
> >   during parsing). But now, the options to save or load are *unavailable*.
> >   This is not such a problem, the old ``cp'' and ``mv'' commands can do
> >   the trick ;-)
> 
> Ok. 

 Well I'll be d*mned ! They are present again ! Maybe it has to do
 something with ``make mrproper'' (plus the fact that I have been quelled
 by make-problems due to missynchronised clocks on the NFS servers -
 that was really unpleasant).

> > * The new precompiled nfsroot-2.2.4 kernel works great (as did the
> >   2.2.1). Even better : it does not give the ``openpic.c'' error anymore.
> 
> I'm up to 2.2.6, it will appear soon on the server. Lots of VME tests this
> week.

 Cool.

> > I still have some questions :
> > 
> > * Why is the Generic DECchip driver used instead of the DEC2x41x driver ?
> >   Is this because of the problems with the DEC21143 ?
> 
> Arenn't you confused ? I think they are the sme driver under evolving
> names. The source file is de4x5.c, tulip.c has never worked properly on

 I was unaware of that. I was under the impression that there was a
 stable dedicated DEC Tulip driver (that I expected to work with the
 board). I'm probably completely wrong ;-)

> big endian machines. There are still problems with my source on 21143, but 
> Matt Porter just posted agin the necessary patches. 

 So, there's no use in trying to use the 21x4x driver ?

> > * What is the use of this ``BC336'' ?
> 
> This is an example driver that uses the services exported by universe.c
> to handle VME interrupts and access a board by only knowing that it is an 
> A16 D08(O) dumb slave. 
[snip]
> However, this is not and ad for BanComm, I had to write this because it
> happens to be what we use at the telescope so I put this as an example.

 OK, thanks for the information. It sounds like I don't need it (yet).

> BTW: I'm going to try to finish the doc of the universe driver this week
> and then announce it officially. I no more touch the code...

 I look forward to the docs !!
 
> > * (Gabriel) Is it possible to post the .config that resulted in the
> >   current zImage-nfsroot-2.2.4 on your FTP site ? Or by mail to this
> >   list ?
> 
> Yes, I thought they were uptodate, so I must have screwed up something.

 It seems to me that you only updated mvme2600.config. Neither .initrd
 nor .nfsroot are updated.

> > I'm currently trying to compile my own 2.2.4 with the latest patches.
> > I'll keep everyone posted.

 Well, the kernel compilation *failed*. It got stuck in ``universe.c'',
 because it doesn't know several UNIVERSE_- constants (e.g.
 UNIVERSE_MAJOR). Sounds like an include file is missing or not patched.
 I did a find+grep on the patched source tree and the only header or .c
 file with these constants seems universe.c.

 To make sure, I've rerun ``make oldconfig'' and have compiled again
 (NFS is slooowwwww). I notice universe.c gives several errors on
 almost *EACH* line it contains. Weird. It also appears that there are
 some type definitions missing.

 Anyway, I was trying to compile it as a module, so I'm gonna try to
 reboot the board now without these modules (zImage compiles just fine).
 We'll see what happens. 

 Kind regards,

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

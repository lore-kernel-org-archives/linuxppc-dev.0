Message-Id: <4.3.2.20000626121206.00b82690@falcon.si.com>
Date: Mon, 26 Jun 2000 12:40:43 -0400
To: Wolfgang Denk <wd@denx.de>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: omitted kernel sections 
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200006261604.SAA26982@denx.local.net>
References: <Your message of "Mon, 26 Jun 2000 08:48:36 EDT." <4.3.2.20000626080626.00b482e0@falcon.si.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Treading delicately on the brink of an all-out flamewar :-)...

At 06:04 PM 6/26/00 +0200, Wolfgang Denk wrote:
>In message <4.3.2.20000626080626.00b482e0@falcon.si.com> you wrote:
> >
> > Jon Diekema and I tried Wolfgang's "load" flag hint with the EST JTAG
> > debugger and were unsuccessful.  We were unable to use objcopy to make
>
>Well, IMHO the tools should fit the work, no vice  versa.  Maybe  you
>can talk with ETS and ask what's necessary to load a Linux image with
>their tools.

Yup.  Been there, done that, they haven't send me any updates.  Reading
between the lines, they said that it gets the job done as it stands, so
I am not holding my breath waiting for an update.

Their JTAG programming standard practice (_I_ would call it a
"workaround" :-) is to convert the elf file to an S-record file (which
converts _all_ the sections, oddly enough :-), and then program using
the S-record file.  Sigh.

For loading elf images via FTP/TFTP, their BootROM loads vxWorks just
fine and they don't understand why I would want to load anything else
:-).  For those who don't get the humor here, WindRiver of vxWorks fame
recently purchased EST.

>I don't use EST right now, so I can't help here. I'm using  the  Aba-
>tron  box,  and found that Abatron was *very* helpful many times, for
>instance by providing a Linux version of their configuration  utility
>within  a  few days after I mentioned that I need something like that
>(in fact, when I asked for _some_ documentation for the protocol thay
>use to access the box, they sent me the full  source  code  of  their
>tool). If your tool vendor is no so helpful, you know the options :-)
>
> > Dan Malek has rejected the patch in the BitKeeper tree, although Jon
> > and I disagree with him.  I didn't find Dan's reply in the archives, it
> > apparently was a direct reply.  His arguments, as I recall (and my
> > apologies, Dan, if I get them wrong), are:
> >
> > * It makes the image larger.
> >  > Not really, its just some more elf headers that get stripped on
> loading.
>
>I'm probably with you here.
>
> > * It isn't how everybody uses the load: everybody just strips the elf
> > header (pastes on a proprietary(?) header) and uses it as as a raw
> > binary image
> >  > I disagree, we ran into the problem, developers before us ran into
> > the problem, and it is coming up again.
>
>Here Dan is right, I think. Normally I just strip the ELF header  and
>use  the  file as "binary" image - all the tools I'm using can accept
>that.
>
> > * It requires an extra relink step.
> >  > Not a big deal in my book given the benefits: a valid elf file that
> > is loadable by commonly used tools.
>
>Ummm... depends on your definition of "commonly used".
>
>I never needed it myself...
>
>You might also argument that you should be using a firmware which  is
>capable of downloading a linux image :-)

That was actually our primary problem.  We are using EST 8260 boards
for our prototype/software development.  They came with an EST BootROM
that is capable of loading an elf image via FTP or TFTP, but they would
not load the gzimage or rdimage sections.  I was working on a TFTP
loader myself, but it was faster and easier to rewrite the elf headers
to change the gzimage section to .text and have the EST BootROM work
for us.

The other half of the problem is getting the firmware capable of
downloading a linux image _into_ the boot flash device, especially the
first time.  That is where the JTAG tools are essential.  It is also
extremely useful (an understatement :-) to be able to use a JTAG
debugger to step through your first cut BootROM or linux load to see
why it isn't working.

Neil Russell <caret@c-side.com> has made his limon (the Linux Monitor)
publicly available and it is an excellent BootROM.  Since the EST
BootROM is working for us at the moment, we are not actively using
limon.  It _is_ in our long term plans, however, and we are grateful
that he chose to release the source under the GPL license.  Hopefully
we will have the opportunity to add value to it.

Reference from Neil:
The source for LiMon can be downloaded from here:

         http://www.thinsys.com/limon.html



>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>panic: kernel trap (ignored)

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

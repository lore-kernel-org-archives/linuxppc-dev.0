To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Cc: Brad Midgley <brad@pht.com>, Cort Dougan <cort@persephone.cs.nmt.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: real-root-dev patch for vger
References: <Pine.LNX.4.03.9901032330100.490-100000@mercator.cs.kuleuven.ac.be>
From: Andreas Schwab <schwab@issan.informatik.uni-dortmund.de>
Date: 04 Jan 1999 11:29:26 +0100
In-Reply-To: Geert Uytterhoeven's message of "Sun, 3 Jan 1999 23:38:56 +0100 (CET)"
Message-Id: <vyzk8z3nxfd.fsf@issan.cs.uni-dortmund.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> writes:

|> On Sun, 3 Jan 1999, Brad Midgley wrote:
|> > is the patch i submitted the same as the one you refer to? is the patch
|> > safe for other architectures? i'll push for it if so.
|> 
|> AFAIK it's safe. To be sure: Andreas?

Well, it should be safe as long as kdev_t isn't changed to be some complex
type, but in this case the sysctl interface has to be changed anyway.

|> > brad
|> > 
|> > > 
|> > > On Fri, 1 Jan 1999, Brad Midgley wrote:
|> > > > a type problem has rendered /proc/sys/kernel/real-root-dev useless in the
|> > > > vger tree. this problem has been around for quite a while. also attached. 
|> > > > 
|> > > > --- init/main.c.orig	Fri Jan  1 13:35:28 1999
|> > > > +++ init/main.c	Mon Nov 30 16:01:56 1998
|> > > > @@ -349,7 +349,7 @@
|> > > >  extern int rd_size;		/* Size of the ramdisk(s) */
|> > > >  extern int rd_image_start;	/* starting block # of image */
|> > > >  #ifdef CONFIG_BLK_DEV_INITRD
|> > > > -kdev_t real_root_dev;
|> > > > +int real_root_dev;
|> 
|> In the m68k tree, we have
|> 
|>     int real_root_dev;              /* MUST be int for sysctl! */

Looks pretty identical to me, as far as the compiler is concerned. :-)

Andreas.

-- 
Andreas Schwab                                      "And now for something
schwab@issan.cs.uni-dortmund.de                      completely different"
schwab@gnu.org

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

Date: Sun, 3 Jan 1999 23:38:56 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Brad Midgley <brad@pht.com>,
        Andreas Schwab <schwab@issan.informatik.uni-dortmund.de>
cc: Cort Dougan <cort@persephone.cs.nmt.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: real-root-dev patch for vger
In-Reply-To: <Pine.LNX.3.95.990103152345.22256A-100000@pacific.pht.com>
Message-ID: <Pine.LNX.4.03.9901032330100.490-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 3 Jan 1999, Brad Midgley wrote:
> is the patch i submitted the same as the one you refer to? is the patch
> safe for other architectures? i'll push for it if so.

AFAIK it's safe. To be sure: Andreas?

> brad
> 
> > 
> > On Fri, 1 Jan 1999, Brad Midgley wrote:
> > > a type problem has rendered /proc/sys/kernel/real-root-dev useless in the
> > > vger tree. this problem has been around for quite a while. also attached. 
> > > 
> > > --- init/main.c.orig	Fri Jan  1 13:35:28 1999
> > > +++ init/main.c	Mon Nov 30 16:01:56 1998
> > > @@ -349,7 +349,7 @@
> > >  extern int rd_size;		/* Size of the ramdisk(s) */
> > >  extern int rd_image_start;	/* starting block # of image */
> > >  #ifdef CONFIG_BLK_DEV_INITRD
> > > -kdev_t real_root_dev;
> > > +int real_root_dev;

In the m68k tree, we have

    int real_root_dev;              /* MUST be int for sysctl! */

> > >  #endif
> > >  #endif
> > >  
> > > --- include/linux/fs.h.orig	Fri Jan  1 13:35:12 1999
> > > +++ include/linux/fs.h	Mon Nov 30 20:03:00 1998
> > > @@ -850,7 +850,7 @@
> > >  extern void mount_root(void);
> > >  
> > >  #ifdef CONFIG_BLK_DEV_INITRD
> > > -extern kdev_t real_root_dev;
> > > +extern int real_root_dev;
> > >  extern int change_root(kdev_t new_root_dev,const char *put_old);
> > >  #endif
> > >  
> > > 
> > > 
> > 
> > This is a known problem on big endian machines. Was fixed in the m68k tree a
> > few years ago :-) I don't know why Linus doesn't take the patch Andreas Schwab
> > sent him, also many years ago.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

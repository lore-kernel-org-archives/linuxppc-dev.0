Message-Id: <200003142105.WAA18574@denx.local.net>
To: Sebastien Articlaux <sebastien_articlaux@yahoo.com>
cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hi!
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 14 Mar 2000 06:19:13 PST."
             <20000314141913.16859.qmail@web219.mail.yahoo.com>
Date: Tue, 14 Mar 2000 22:05:58 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Sébastien,

in message <20000314141913.16859.qmail@web219.mail.yahoo.com> you wrote:
>
> Normally there is two ramdisk, the init ramdisk and an
> other,bigger wich contain the complete system.
> and this is linuxrc in the initramdisk wich mount the
> real ramdisk, right?

No. Ususally you have only one ramdisk, if any.


If you have a "normal" bootdevice (like harddisk, or the  network  in
case of a NFS-mounted root filesystem) there is little need to have a
initrd  -  except to perform actions necessary to be performed before
you can access the root device. Probing the hardware and loading  the
modules  which  necessary  to  access  the  device  on whith the root
filesystem is the typical example when you want to run one  of  these
initrd  configurations.  The  "initrc" script is the place whwere you
can put such actions.

The other case is when you don't have  a  regular  boot  device,  for
instance  in  an  embedded  system with normal FLASH memory ("normal"
means that from the system point of view it's just a ROM device  with
a  linear  layout  -  as ooposed to something simulating a disk drive
like the DiskOnChip  systems  and  others  do).  Here  you  have  two
options:  you can implement a ROMFS driver for your flash memory, and
write a boot loader that boots from the ROMFS. Or  you  can  write  a
boot  loader  that  loads just one "image" and starts it; the "image"
would contain a (compressed) Linux kernel,  and  a  (compressed)  ram
disk  image.  The  boot  loader  will  uncompress and start the Linux
kernel, and the Linux kernel will detect and uncompress the initrd  -
and mount it as it's root filesystem. You can imagine that the second
approach  is  usually  much  simpler,  especially  since many systems
already have some type of boot loader to load and start an "image".

That's why the second method is often used in embedded  systems:  you
just  p[ack  everything  you  need  in  your root filesystem into one
ramdisk image, and  mount  this  as  initrd.  You  will  never  mount
another, "real" root filesystem in this case.

> But for us,we just use the initramdisk "as ramdisk"...
> It's a minimal file system but to begin it's ok,
> right?

Minimal in the sense that it has to fit into your local FLASH memory.
But of course it will have to contain all you  application  code  and
ata  files you need for normal system operation. [Or you will have to
mount anther "data storage" device once you're up and running.]

> So now I'm trying to create a good initramdisk.
> I've put the patch for SASH in source, but I must have
> to recompile SASH (that's what I understand when I
> look into your CDK files)

If you want to use SASH you  will  need  a  binary,  right.  SASH  is
probably  a good start to get things working. Later, you might decide
to directly start your application code without any  shell  or  other
Linux tools available any more in your ramdisk image.

> Where can I found the source of SASH if I must
> recompile it?

I just took the source (sash-2.1-4.src.rpm) from one of  the  generic
LinuxPPC  releases  (LinuxPPC  1999 Q3 in my case). Just use a search
engine...

You're in France, so one of the following might be near you:
ftp://ftp.medasys-digital-systems.fr/pub0/linux/parisc/src/sash-2.1-hpux.tar.gz

ftp://ftp.lip6.fr/pub2/linux/distributions/debian/dists/slink/main/source/shells/sash_2.1.orig.tar.gz
ftp://ftp.pasteur.fr/pub/computing/linux/debian/dists/slink/main/source/shells/sash_2.1.orig.tar.gz
ftp://ftp.ath.cena.fr/debian/dists/slink/main/source/shells/sash_2.1.orig.tar.gz
ftp://ftp.fdn.fr/.pub2/debian/dists/slink/main/source/shells/sash_2.1.orig.tar.gz
ftp://ftp.u-picardie.fr/mirror/linux/debian/dists/slink/main/source/shells/sash_2.1.orig.tar.gz

> Then do I must put it in /bin/sash in my initrd and
> make a link?
> ln -s sash sh  to have /bin/sh -> sash  ?

...or you can rename SASH iinto /bin/sh, or configure the  kernel  to
start /bin/sash - whatever you like.

> And need I have to create a linuxrc if I have just the
> initrd? if yes, what must I put in it because I don't
> understand.

You don't need a linuxrc script.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Perfection is reached, not when there is no longer anything  to  add,
but when there is no longer anything to take away.
                                           - Antoine de Saint-Exupery

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

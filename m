Message-ID: <3669CABC.411EC4DE@wanadoo.fr>
Date: Sun, 06 Dec 1998 01:07:24 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: laures@hp1.esiea.fr
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: pre-R5&miscs
References: <3668FBD7.9131C8B5@mail.esiea.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"G. Laurès" wrote:
> 
> Hi guys, I just discovered the pre-R5 directory @ dev.linuxppc.org.
> 
>  It does include the latest version of Bootx, but not ramdisk.image.gz as in
> previous distributions (R4.1 for example). Note that this is also the case for R4.7.

What and where is R4.7?

> 
>   I've seen an initrd.img and a supp.img but I'm not sure if this should be
> used for installation. As I could not see installation tips anywhere, ????

This is a new installer (Redhat 5.1, I guess). The old one doesn't work
with the files they put into the base folder. It is so new that
apparently they have not yet had the time to write instructions. The
following worked for me:

1. Rename initrd.img to ramdisk.image.gz and put it where BootX can see
it.

2. Fill supp.img into a floppy using
   dd if=supp.img of=/dev/fd0 bs=1440k

3. If you want to install from a HD, put your RedHat folder on a UNIX
partition, not on a HFS one, otherwise the installer can't see it (IMHO
this is a bug, or a feature of a not quite finished product...)

4. Run BootX with "use Ramdisk" checked. After a couple of preliminary
questions, the installer will ask you to change your floppy. Put the
floppy with the supp.img into the drive. The installation continues then
normally.

> 
>  I was waiting R5 to put on my new PBG3, didn't want to mess with an R4 -> R5
> upgrade later.
> 
> BTW, should I go ahead and put it on my father's PBG3 as well, knowing that
> will be his first professional steps in linuxppc (and linux at all) so I don't
> want to mess him with a too much experimental system... would be 4 or 4.1 or
> 4.7 with recent kernel for PBG3s (2.1.130 I believe ?) better ??
> 

It is still very "beta". For me, the X server is not yet usable.
I am on a PM6400 with the built-in video (valkyrie), so I don't know
about PBG3s.

If I use XPmac, then it works in principle, but the colors are all
messed up, most of the time nothing is readable. I say 'most of the
time', because the weird colors are not always the same, they depend on
the number of the console from which X is started. Also, if you touch
the title bar of a window, the X server dies. This has been mentioned
here, and it seems that someone already has a fix.

If I use XF68_FBDev, then the colors are OK, but the keyboard and the
mouse do not work correctly: The option (alt) keys do not work, and
there is no simulation for mouse buttons 2 and 3.
This is a problem that has been mentioned to the author (Geert U.)
already some time ago, but since he doesn't have ADB devices any more,
it is not clear whether this will be fixed soon.

So for people with standard Apple keyboards and mice, there remains a
serious problem.

On the other hand, here is something positive: The compilers are working
well with the new glibc. One example: Since I am using dhcp for the
network connection (like you probably), I fetched the sources for
dhcpcd-1.3.16 (the dhcpcd-0.70-2.ppc.rpm which comes with the R5beta is
completely useless for linuxppc 2.1.1xx kernels). In linuxppc R4, the
compilation used to be somewhat tricky, due to glibc problems. Here it
works now without any problems; just one line with some CFLAGS in the
Makefile had to be adapted. And the best thing is: it works! In my R4
system, since a week or so, I always get timeouts from dhcp, so I had to
use either an old 2.1.24 kernel or a fixed IP address. Now I can even
chroot from the R4 system to the R5beta and run dhcpcd there and it
connects! I suppose this has also something to do with the more recent
networking packages, net-tools etc.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

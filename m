Subject: Re: hfs cdrom broken in 2.4.13pre
To: pochini@shiny.it (Giuliano Pochini)
Date: Tue, 23 Oct 2001 14:26:28 +0100 (BST)
Cc: schmitz@opal.biophys.uni-duesseldorf.de (Michael Schmitz),
	linuxppc-dev@lists.linuxppc.org,
	hollis-lists@austin.rr.com (Hollis Blanchard),
	alan@lxorguk.ukuu.org.uk (Alan Cox),
	trini@kernel.crashing.org (Tom Rini),
	costabel@wanadoo.fr (Martin Costabel)
In-Reply-To: <XFMail.20011023151612.pochini@shiny.it> from "Giuliano Pochini" at Oct 23, 2001 03:16:12 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <E15w1Zc-0005oZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > One would hope so. All I remember about CDROMs is they use a different
> > blocksize which causes all sorts of funny side effects in generic code
> > that assumes the only sane blocksize is 512.
>
> No. The point is that filesystems should not make assumptions about
> hardware block size (except it being power of 2 I believe). If there
> was code in block layer to provide broken FS's compatibility and that
> code has been removed, then we must fix the FS. Who's HFS maintainer ?

The hardware block size is 2048. The logical block size of the file system
is 512 bytes, Someone has to do reblocking. So the choices are

1;	We hack crap into the file systems
2:	We hack crap into the drivers
3:	We listen to Al Viro

#3 (using the loopback device) solves everything nicely - it just needs to
be implied automatically

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

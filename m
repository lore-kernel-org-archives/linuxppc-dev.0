Date: Wed, 4 Apr 2001 11:00:28 -0400 (EDT)
From: Bill Fink <billfink@capu.net>
To: "Halfmann, Klaus" <klaus.halfmann@feri.de>
Cc: linuxppc-dev@lists.linuxppc.org, billfink@capu.net
Subject: RE: Hang Mounting HFS CDROM with 2.4.3 final kernel
In-Reply-To: <B171A2EF290DD4118E510010B502900680221C@feriex.feri.de>
Message-ID: <Pine.LNX.4.21.0104041045320.934-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Wed, 4 Apr 2001, Halfmann, Klaus wrote:
>
> Hello Bill,
>
> You wrote
> > With a BenH 2.4.3 final kernel, if I do:
> >
> > 	mount -t hfs /dev/cdrom /mnt
> >
> > the system locks up solid (mouse stops moving and can't switch to
> > a virtual console) with no error messages (I also tried it from a
> > virtual console but no error messages there either).  The only
> > recourse is to hit the reset button to power cycle the machine.
> > This is using the built-in DVD ROM drive on a dual G4 (but only
> > running a UP kernel).  I can mount an HFS disk without any problem.
> >
> > This isn't actually a major issue to me personally (at least at
> > the moment), but I thought I should go ahead and report it.  I
> > discovered it because I was trying to get the MacOS ROM file from
> > my MacOS 9.0.4 CDROM for use with MOL.
>
> As far as I know nobody really cares about HFS and Linux
> (well you should crosspost this to linux-fs-devl, but I dont have
>  a correct address at hand) So I try to care a bit ...
>
> What sort of disk is it ? HFS / HFS+ / Hybrid / MultiSession / DVD ?

It's HFS.  I tried a MacOS 8 and a MacOS 9.0.4 install CD, but I
imagine any MacOS install CD would exhibit the same behavior.

> In case it is HFS+, Linux will only be able to mount the HFS-Wrapper.
> You should try my HFS+-utils to acces that CD, then.

gwiz% hpmount /dev/cdrom
(null): /dev/cdrom: Neither Wrapper nor native HFS+ volume header found (Unknown error 4294967295)

> Can you create an image from the disk (with dd) and does it show the
> same problems ? (Id like to get that image, but I fear it may be to
> large for a reasonable download/test. I only have an iBook :/ )

Thanks for the tip.  Mounting the disk image works fine.  For the
benefit of others that might encounter this problem and search the
archives, the necessary commands are:

	dd if=/dev/cdrom of=cdrom.image
	mount -t hfs cdrom.image /mnt -o loop

Another workaround is to back down to kernel 2.2.18.

> Greetings,
> 	Klaus Halfmann
> 	http://www.penguinppc.org/~hasi

						-Thanks again

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

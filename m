Message-ID: <002901c1e01a$3e8d3e60$6401a8c0@attbi.com>
Reply-To: "Greg Griffes" <ggg@ieee.org>
From: "Greg Griffes" <ggg@ieee.org>
To: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <D73A25AA6E54D511AD74009027B1110F0F3151@ORION> <001701c1e017$e74f7b60$6401a8c0@attbi.com>
Subject: Re: question concerning ram filestructure
Date: Tue, 9 Apr 2002 18:59:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven,

I must retract my previous message.  After closer scrutiny of your
log message, I realized that you are getting a crc error, I assume
during the decompression.  I did not have that problem.

I wonder if it could be a difference in gzip that is used to compress
the ram disk on the host and the gunzip version built into your kernel.
Just speculating.

Greg

>
> >
> > RAMDISK: Compressed image found at block 0
> > crc errorFreeing initrd memory: 2201k freed
> > Kernel panic: VFS: Unable to mount root fs on 01:00
> > <0>Rebooting in 180 seconds..
> >
> > I've seen this before on different ports of linux but I have not been able
> > to figure it out.  Does anyone have suggestions?
> > Steven Blakeslee
> >
>
> I just had the same symptom in my port this morning.  In my case, the
> kernel was not picking up the initrd_start or initrd_size from the boot
> loader.  It was a bug in my *_setup.c file.  I tossed out the use of r4 and r5
> and switched to using parse_bootinfo in platform_init().  That fixed it.
>
> It could also be a problem in the boot loader.
>
> Greg Griffes
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <001701c1e017$e74f7b60$6401a8c0@attbi.com>
Reply-To: "Greg Griffes" <ggg@ieee.org>
From: "Greg Griffes" <ggg@ieee.org>
To: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <D73A25AA6E54D511AD74009027B1110F0F3151@ORION>
Subject: Re: question concerning ram filestructure
Date: Tue, 9 Apr 2002 18:43:00 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> RAMDISK: Compressed image found at block 0
> crc errorFreeing initrd memory: 2201k freed
> Kernel panic: VFS: Unable to mount root fs on 01:00
> <0>Rebooting in 180 seconds..
>
> I've seen this before on different ports of linux but I have not been able
> to figure it out.  Does anyone have suggestions?
> Steven Blakeslee
>

I just had the same symptom in my port this morning.  In my case, the
kernel was not picking up the initrd_start or initrd_size from the boot
loader.  It was a bug in my *_setup.c file.  I tossed out the use of r4 and r5
and switched to using parse_bootinfo in platform_init().  That fixed it.

It could also be a problem in the boot loader.

Greg Griffes


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

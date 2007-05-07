Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 286D4DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 May 2007 02:43:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Inconsistent ramdisk generation
Date: Mon, 7 May 2007 12:45:02 -0400
Message-ID: <3C02138692C13C4BB675FE7EA240952936D267@bluefin.Soneticom.local>
In-Reply-To: <463F44CA.8080603@acmay.homeip.net>
From: "Clint Thomas" <cthomas@Soneticom.com>
To: "Andrew May" <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

My new script makes use of genext2fs instead, which does make consistent
ramdisk images, so I am grateful for that. The previous script was a
result of reading another guide to ramdisk generation, when the DULG was
really the best bet from the beginning.

I believed before that the inconsistent ramdisk were causing my
underlying problem, but even now with consistent sized images, my
problem is when using a stripped down version of our development
environment, I have a ramdisk image that works. However, whenever I add
any kind of file to the ramdisk image, it breaks userspace.

An example would be one test I ran, where all I did was add a small text
file to the root directory, and suddenly busybox would go into an
infinite loop of restarting the shell. This happens with pretty much any
addition of data to the ramdisk (another executable being added in,
etc..)

Also, a program that is set in the inittab to automatically restart,
either goes into an infinite loop of starting and restarting, or when it
starts, it starts with a "zombie" status, which I believe means that
init is no longer communicating with it. So these errors seem to
indicate a problem with init, but I have not been able to pinpoint the
exact cause. And while not a big deal, whenever a command is input
through the serial console, it is echoed again before it is executed.

I have CONFIG_BLK_DEV_RAM_SIZE =3D 32768, and the uncompressed image
definitely fits within this size.

If this is not a common error, or something that has been seen before, I
could at least use a good suggestion on how I could go about debugging
this. I'm not sure a kernel debugger would be appropriate if these
problems are occuring because of init, or something else in userspace.
Thanks

CT

-----Original Message-----
From: Andrew May [mailto:acmay@acmay.homeip.net]
Sent: Monday, May 07, 2007 11:25 AM
To: Clint Thomas
Subject: Re: Inconsistent ramdisk generation

Clint Thomas wrote:
> this behaviour. Just to be sure it was not my script, I added time
> delays between the commands, just to be sure all the IO was finished
> before any of the compression began, but that did not change anything
> either. Any suggestions?

I don't think time delays are enough. Try a full umount before doing the
compress.

But you should really try this instead.
http://genext2fs.sourceforge.net/

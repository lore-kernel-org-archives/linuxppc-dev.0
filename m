Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE450DDE98
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 13:55:26 +1100 (EST)
Date: Fri, 29 Feb 2008 21:55:51 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Sequoia build with KDBG
In-Reply-To: <20080229203015.0ada459e@zod.rchland.ibm.com>
References: <20080221213313.97814DDF55@ozlabs.org>
	<20080222164210.48628DE0A9@ozlabs.org>
	<20080222145224.7349cf36@weaponx>
	<200802292133.m1TLXqv3012273@e36.co.us.ibm.com>
	<20080229153534.684aebf9@zod.rchland.ibm.com>
	<200802292230.m1TMUk4I005462@e31.co.us.ibm.com>
	<20080229165137.64acbebf@zod.rchland.ibm.com>
	<200803010023.m210NHwr011345@e2.ny.us.ibm.com>
	<20080229203015.0ada459e@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080301025528.AE450DDE98@ozlabs.org>
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

At 09:30 PM 2/29/2008, Josh Boyer wrote:
>On Fri, 29 Feb 2008 19:23:40 -0500
>Steve Heflin <sheflin@newagemicro.com> wrote:
>
>Putting the list back on CC because I'm sure you won't be the only
>person to have this issue.
>
> > poor man's debugging works fine if a serial port is available, but my
> > Sequoia platform doesn't get that far!  I use u-boot to download and
> > boot my image, and I don't get any serial output after the boot completes:
>
>By "poking characters out the serial port" I meant I literally coded up
>assembly functions to setup MMU translations and poke hex values at hard
>coded addresses.  That's why it's "poor man's".  If you had a working
>serial port out of the box, that would be a luxury ;).
>
> > => bootm 0x500000
> > ## Booting image at 00500000 ...
> >     Image Name:   Kernel and Ramdisk
> >     Created:      2008-03-01   0:09:57 UTC
> >     Image Type:   PowerPC Linux Multi-File Image (gzip compressed)
> >     Data Size:    2430248 Bytes =  2.3 MB
> >     Load Address: 00000000
> >     Entry Point:  00000000
> >     Contents:
> >     Image 0:  1471523 Bytes =  1.4 MB
> >     Image 1:   958712 Bytes = 936.2 kB
> >     Verifying Checksum ... OK
> >     Uncompressing Multi-File Image ... OK
> >     Loading Ramdisk to 07e42000, end 07f2c0f8 ... OK
> > ------
> > console port is now dead.
> > ------
>
>What image type are you using?  If this is an older U-Boot, you'll need
>to use the cuImage.sequoia file that is produced when you compile your
>kernel with 'make zImage'.  Sequoia (and I'm assuming you mean the
>AMCC Sequoia Eval Board, not some custom hardware that's based on it)
>has been working fine for a long time.
>
>It seems you have some kind of other uImage, so try using the one
>that's built with the kernel and go from there.
>
>josh

thank you so much for your helpful reply. No, I don't have a serial 
port that works "out of the box", and your hint of setting up the MMU 
translations and poking characters at hard coded addresses, is a big help.

My hardware is NOT a Sequoia eval, it is a custom board derived from 
the Sequoia platform back at 2.6.14. In a previous message when you 
said that ECC should be handled by the NAND driver, I figured out 
that our AMCC-440EPx board was not a standard Sequoia.  Ours has DDR 
ECC and the setup code writes to several registers to enable it.  I 
still offer this code to you.

I've used the zImage, the uImage, and the vmlinux image, all with the 
same results. My last attempt was a uImage, so I'll switch to the 
zImage and try again.

thanks so much for your help,
Steve 

Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 67906DDE43
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 13:32:14 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m212WBEP015331
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Feb 2008 21:32:11 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m212WBXK300702
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Feb 2008 21:32:11 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m212WBpC018026
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Feb 2008 21:32:11 -0500
Date: Fri, 29 Feb 2008 20:30:15 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Sequoia build with KDBG
Message-ID: <20080229203015.0ada459e@zod.rchland.ibm.com>
In-Reply-To: <200803010023.m210NHwr011345@e2.ny.us.ibm.com>
References: <20080221213313.97814DDF55@ozlabs.org>
	<20080222164210.48628DE0A9@ozlabs.org>
	<20080222145224.7349cf36@weaponx>
	<200802292133.m1TLXqv3012273@e36.co.us.ibm.com>
	<20080229153534.684aebf9@zod.rchland.ibm.com>
	<200802292230.m1TMUk4I005462@e31.co.us.ibm.com>
	<20080229165137.64acbebf@zod.rchland.ibm.com>
	<200803010023.m210NHwr011345@e2.ny.us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 29 Feb 2008 19:23:40 -0500
Steve Heflin <sheflin@newagemicro.com> wrote:

Putting the list back on CC because I'm sure you won't be the only
person to have this issue.

> poor man's debugging works fine if a serial port is available, but my 
> Sequoia platform doesn't get that far!  I use u-boot to download and 
> boot my image, and I don't get any serial output after the boot completes:

By "poking characters out the serial port" I meant I literally coded up
assembly functions to setup MMU translations and poke hex values at hard
coded addresses.  That's why it's "poor man's".  If you had a working
serial port out of the box, that would be a luxury ;).

> => bootm 0x500000
> ## Booting image at 00500000 ...
>     Image Name:   Kernel and Ramdisk
>     Created:      2008-03-01   0:09:57 UTC
>     Image Type:   PowerPC Linux Multi-File Image (gzip compressed)
>     Data Size:    2430248 Bytes =  2.3 MB
>     Load Address: 00000000
>     Entry Point:  00000000
>     Contents:
>     Image 0:  1471523 Bytes =  1.4 MB
>     Image 1:   958712 Bytes = 936.2 kB
>     Verifying Checksum ... OK
>     Uncompressing Multi-File Image ... OK
>     Loading Ramdisk to 07e42000, end 07f2c0f8 ... OK
> ------
> console port is now dead.
> ------

What image type are you using?  If this is an older U-Boot, you'll need
to use the cuImage.sequoia file that is produced when you compile your
kernel with 'make zImage'.  Sequoia (and I'm assuming you mean the
AMCC Sequoia Eval Board, not some custom hardware that's based on it)
has been working fine for a long time.

It seems you have some kind of other uImage, so try using the one
that's built with the kernel and go from there.

josh

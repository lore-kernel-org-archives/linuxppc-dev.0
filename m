Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 86E1DDEF5B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 02:58:49 +1000 (EST)
Message-ID: <48AD93E7.5010304@freescale.com>
Date: Thu, 21 Aug 2008 11:12:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Jander <david.jander@protonic.nl>
Subject: Re: porting linux 2.6.27 to embedded powerpc board
References: <424724.49343.qm@web46312.mail.sp1.yahoo.com>
	<200808211143.45782.david.jander@protonic.nl>
In-Reply-To: <200808211143.45782.david.jander@protonic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Laxmikant Rashinkar <lk.atwork@yahoo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David Jander wrote:
> 4. Be sure that the device(s) necessary to produce output on your console are 
> correctly placed in the DT. Also make sure that u-boot knows about it 
> (#define OF_STDOUT_PATH... in your u-boot board config file)

OF_STDOUT_PATH is deprecated; you should enable 
CONFIG_OF_SERIAL_VIA_ALIAS, and provide aliases in the device tree for 
serial0, serial1, etc.

> 6. Remember to always specify the "rootfstype=" option on the commandline if 
> booting from anything other than NFS. This was not necessary back in the 
> 2.6.15-times AFAICR.

It still should not be necessary.

> 7. Boot with a device-tree (in u-boot: "bootm $addrofkernel - $addrofdtb", 
> don't forget the dash if you are not using an initrd). If you don't do this, 
> u-boot can't fix your DT, and the kernel probably won't find it either.

s/probably/definitely/

> 8. Be sure to use the correct version of the DTC (DT compiler) for your kernel 
> (the sources are included nowadays, somewhere in arch/powerpc/boot IIRC). The 
> command used to compile, should probably be something like this:

Or just use the most recent DTC.

-Scott

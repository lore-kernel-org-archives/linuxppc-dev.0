Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F335DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 01:25:11 +1100 (EST)
Message-ID: <47BAE6B3.7090000@freescale.com>
Date: Tue, 19 Feb 2008 08:24:51 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: maxime louvel <m.louvel@gmail.com>
Subject: Re: 2.6.24 for mpc8458amc
References: <dda529d0802190359r526dc959y8117185e1834e9f4@mail.gmail.com>
In-Reply-To: <dda529d0802190359r526dc959y8117185e1834e9f4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

maxime louvel wrote:
> Hi,
> 
> I am trying to make a 2.6.24 vanilla kernel boot (an work fine in a 
> second time) on a mpc8548amc board.
> I have add the platform specific stuff from the sources of the current 
> kernel running on the cards.
> What I have basically add is:
> - a folder mpc8548amc, in the config/platform directory, which allow to 
> select the mpc8548amc as the supported platform
> - add the following files:
>   - arch/ppc/configs/mpc8548amc_defconfig
>   - arch/ppc/configs/platforms/85xx/mpc_8548_amc.h and .c
> - I have used the dts of an another platform (mpc8548cds) which seems 
> quite the same, but I haven't got any confirmation of that yet.

Uh, let's clear up minor confusion here.  Are you using
ARCH=ppc or ARCH=powerpc?  I'm surprised to see that there
is mention of arch/ppc/... above.  Are you sure this is an
ARCH=ppc build?  You won't need a DTS file at all then.

But if you are using a DTS file, and I suspect you should,
then this is ARCH=powerpc.

> When I am booting the kernel image I get:
> 
> AMC=> dhcp 0x1000000 uImage.amc.2.6.24
> Speed: 1000, full duplex
> BOOTP broadcast 1
> DHCP client bound to address 10.255.255.2 <http://10.255.255.2/>
> Using eTSEC0 device
> TFTP from server 0.0.0.0 <http://0.0.0.0/>; our IP address is 
> 10.255.255.2 <http://10.255.255.2/>; sending through gateway 10.1.1.1 
> <http://10.1.1.1/>
> Filename 'uImage.amc.2.6.24'.
> Load address: 0x1000000
> Loading: ##############################
> ###################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         ###########################
> done
> Bytes transferred = 1802102 (1b7f76 hex)
> AMC=> bootm 0x1000000
> ## Booting image at 01000000 ...
>   Image Name:   Linux-2.6.24
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1802038 Bytes =  1.7 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
> 
> No further messages...
> 
> Does someone has an idea ?
> 
> thanks,
> Maxime
> 

Did you download a DTB file and use it on the bootm
command?  Nope.

This is really a FAQ failure mode.  Are you sure
you have the console set up properly?  Any chance
you can get to the __log_buf with a BDI-2000?

Thanks,
jdl

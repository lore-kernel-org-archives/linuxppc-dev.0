Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EEDA7DDE21
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 17:16:33 +1100 (EST)
Date: Wed, 16 Jan 2008 09:16:07 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: "Bryan O'Donoghue" <bodonoghue@codehermit.ie>
Subject: Re: [PATCH 1/3] 8xx: Analogue & Micro Adder875 board support.
Message-ID: <20080116091607.6aa76d11@kernel.crashing.org>
In-Reply-To: <1200439502.3618.26.camel@neuromancer.mindspace>
References: <20080111200705.GA696@loki.buserror.net>
	<1200234372.3990.24.camel@neuromancer.mindspace>
	<20080114152859.GA26907@ld0162-tx32.am.freescale.net>
	<1200350407.4061.19.camel@neuromancer.mindspace>
	<478BE6F2.4020207@freescale.com>
	<1200439502.3618.26.camel@neuromancer.mindspace>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 15 Jan 2008 23:25:02 +0000
Bryan O'Donoghue wrote:

> Greetings Scott.
> 
> I've tried both of the procedures you've outlined on the Adder875 with
> the patches supplied against the paulus git tree to no avail.
> 
> Pass #1 :
> 
> Doing it safe with cuImage.8xx
> 

[...]
> => bootm 0x400000
> ## Booting image at 00400000 ...
>    Image Name:   Linux-2.6.24-rc6-g4f43143f-dirty
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1032266 Bytes = 1008.1 kB
>    Load Address: 00400000
>    Entry Point:  00400554
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> 
> I haven't as yet tried to single step through the bootup process -
> but, just to say that assuming the above procedure isn't _too_ far
> wrong - the stuff posted to the list agains the tree you've
> recommended doesn't seem to work..
> 
yes the sequence seems correct, so I'd check cmdline params, contents of chosen node in dts, etc to make sure stuff is being written to the proper UART with proper settings.

> If you can point out a flaw in my usage of it - that'd help alot. I
> have some code I'd love to be able to use with the Adder875+powerpc
> layer - which is why I'm interested in this patchset...
> 
> 
> Pass #2 :
> 
> Replace step 9 with.
> 
> 9. make uImage
> 10 dtc -o ../adder875-uboot.dtb -O dtb
> arch/powerpc/boot/dts/adder875-uboot.dts 
> 
> 
> cp arch/powerpc/boot/uImage /tftpboot
> cp ../adder875-uboot.dtb /tftpboot
> 
> Finally in u-boot
> => tftpboot 0x400000 uImage
> Using FEC ETHERNET device
> TFTP from server 192.168.0.101; our IP address is 192.168.0.202
> Filename 'uImage'.
> Load address: 0x400000
> Loading:
> #################################################################
> 
> #################################################################
> 
> #################################################################
>          ###
> done
> Bytes transferred = 1009496 (f6758 hex)
> => tftpboot 0x500000 adder875-uboot.dtb
> Using FEC ETHERNET device
> TFTP from server 192.168.0.101; our IP address is 192.168.0.202
> Filename 'adder875-uboot.dtb'.
> Load address: 0x500000
> Loading: #
> done
> Bytes transferred = 3147 (c4b hex)
> => bootm 0x400000 - 0x500000
> ## Booting image at 00400000 ...
>    Image Name:   Linux-2.6.24-rc6-g4f43143f-dirty
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1009432 Bytes = 985.8 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>    Booting using the fdt at 0x500000
> 
> 
> Aside from the u-boot modification of including
> 
> #define CONFIG_OF_LIBFDT 1
> 
> The rest is a pristine version of Yuli Barchoen's original U-Boot
> Adder stuff.
> 
> The uImage + dtb seems to get a good bit further in that it seems to
> get stuck somewhere inside of some trampoline code in time.c
> 
> 
> (gdb) bt
> #0  0xc000ee30 in __div64_32 ()
> #1  0xc01d71f4 in time_init () at arch/powerpc/kernel/time.c:940
> 
> 
> I might have a go at some proper debugging tomorrow after work.
> 
> If you have any suggestions as to what's going wrong or what I've not
> done right I'd appreciate the help.
> 
following the u-boot way (which is more correct imo) you'll need to add some code that fixes up frequencies and stuff inside dtb, or you may try to hardcode those values inside dts(if you know exactly what should be  there). Just adding CONFIG_*LIBFDT is not going to work.
-- 
Sincerely, Vitaly

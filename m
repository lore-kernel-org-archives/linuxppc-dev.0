Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc2-s23.bay0.hotmail.com (bay0-omc2-s23.bay0.hotmail.com
	[65.54.246.159]) by ozlabs.org (Postfix) with ESMTP id 566D9DDEFB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Oct 2008 06:53:16 +1100 (EST)
Message-ID: <BLU119-DAV13C60547C53073676EDCA7BB3B0@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.3.1223427603.12358.linuxppc-embedded@ozlabs.org>
Subject: Re: Linuxppc-embedded Digest, Vol 50, Issue 8
Date: Wed, 8 Oct 2008 12:53:10 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Seva,

You're very grrrrrrrrrrrrrrrrrreat, You're absolutely rrrrrrrrrrrrrright, 
Selva

It's very logic, but it forgave me for quite long tong time until now.

Million Thanks and Very Best Wihses to you Selva,

Duy-Ky

----- Original Message ----- 
From: <linuxppc-embedded-request@ozlabs.org>
To: <linuxppc-embedded@ozlabs.org>
Sent: Tuesday, October 07, 2008 6:00 PM
Subject: Linuxppc-embedded Digest, Vol 50, Issue 8


> Send Linuxppc-embedded mailing list submissions to
> linuxppc-embedded@ozlabs.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> or, via email, send a message with subject or body 'help' to
> linuxppc-embedded-request@ozlabs.org
>
> You can reach the person managing the list at
> linuxppc-embedded-owner@ozlabs.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-embedded digest..."
>
>
> Today's Topics:
>
>   1. CPIO image date problem (Fisherss)
>   2. Trying to vfree() nonexistent vm area (Duy-Ky Nguyen)
>   3. German keyboard layout (Schmid Alexander)
>   4. Re: Trying to vfree() nonexistent vm area (selvamuthukumar v)
>   5. SysACE driver and Ethernet support? - mainline Linux 2.6.10
>      and Xilinx ML310 (Juliana Su)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 7 Oct 2008 13:15:17 +0800
> From: Fisherss <fisherssml@gmail.com>
> Subject: CPIO image date problem
> To: linuxppc-embedded@ozlabs.org
> Message-ID:
> <25fd1f750810062215q7f33664eo99908ab7dd26f502@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> Hi all
>
> I have a weird problem on MPC8548E with Linux Kernel 2.6.24:
>
> I use a CPIO image as my embedded system's root file system, but after
> booting, all files and directories' "date" attribute are set to "Jan
> 1, 1970".
>
> Now what I have got is:
> ====================
> U-boot and the cpio image are cleared. The roofs(cpio image) is loaded
> by Linux Kernel, not U-boot, and the image itself has successfully
> passed test, so we suppose the problem is in Linux Kernel.
>
> The Kernel loading sequence is : time_init() -> cpio image loading ->
> RTC driver loading
>
> That means, at the cpio image loading time, we don't have the RTC
> driver. In fact, Kernel uses the time_base register instead of RTC(at
> least at this time). All standard cpio images contain the "date" file
> attribute, but seems like Kernel just ignores it and uses its own
> "clock source"(and this clock source should be binded to time_base
> register).
>
> I have located the cpio image unpacking code in Kernel, but can not
> find anything about date attribute. This part of code is
> platform-independent.
>
> Anyone any idea ??
>
> Thanks
>
> -- 
> Fisherss
> fisherss@gmail.com
>
>
> ------------------------------
>
> Message: 2
> Date: Mon, 6 Oct 2008 23:14:01 -0700
> From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
> Subject: Trying to vfree() nonexistent vm area
> To: <linuxppc-embedded@ozlabs.org>
> Cc: Scott Wood <scottwood@freescale.com>
> Message-ID: <BLU119-DAV245BF96B99DC961FFF9EFBB380@phx.gbl>
> Content-Type: text/plain; format=flowed; charset="iso-8859-1";
> reply-type=original
>
> Hello,
>
> My driver uses ioremap() the IMMR_BASE @ 0xE0000000 to access registers.
> A user-space app opens and close the deive file on every access to 
> register.
>
> There's no problem with FreeScale Linuc BSP 2..6.20 for eva board
> MPC83813E-RDB.
>
> For the latest FreeScale Linuc BSP 2..6.24 , I have NO problem for the 
> very
> FIRST run.
> But after the 1st run, I have problem with the new FreeScale Linuc BSP
> 2..6.24 with the following error message
>
>        Trying to vfree() nonexistent vm area (c98a0000)
>
> where c98a0000 is the mapped address of IMMR_BASE 0xE0000000.
>
> So, it appears to me that the device file could be closed improperly as 
> it's
> closed after the 1st run.
>
> I really appreciate your time and help
>
> Best Regards,
>
> Duy-Ky
>
> ///////////////////////
> Below is outline of the driver
>
> init:
>     ppc_base = (unsigned long) ioremap_nocache(PPC_BASE, PPC_SIZE);
>
> //     ppc_base = (unsigned long) ioremap(PPC_BASE, PPC_SIZE);    // 
> failure
> with this way too
>
>
> close:
>    iounmap((void __iomem *)ppc_base);
> //    iounmap(PPC_BASE);        // failure with this way too !
>
>
>
>
>
>
> ------------------------------
>
> Message: 3
> Date: Tue, 7 Oct 2008 08:35:32 +0200
> From: "Schmid Alexander" <a.schmid@systeme-steuerungen.de>
> Subject: German keyboard layout
> To: <linuxppc-embedded@ozlabs.org>
> Cc: PHYTEC Support <support@phytec.de>
> Message-ID:
> <FCELKENEBBOLLHKPHCCBIELFCEAA.a.schmid@systeme-steuerungen.de>
> Content-Type: text/plain;   charset="iso-8859-1"
>
>
> Hello, I have linux 2.6.23.1 on a MPC5200B with a USB keyboard!
> But the default language is US. How can I have a german layout?
> I tried cross-compiling the package kbd-1.0.6, but this seems to be very
> tricky! I didn`t finish that.
>
> Then I tried it with the loadkmap from the busybox! But there is always 
> the
> error: /dev/vc0: No such file or directory!
>
> Can anyone help me please? I would only need a german keyboard layout!
>
> Thank you
>
>
>
>
>
> Alexander Schmid
> Dipl. Ing. (FH)
> -Entwicklung-
> Systeme & Steuerungen GmbH
> Josef-Buchinger-Strasse 8
> DE-94481 Grafenau
>
>
>
>
> ------------------------------
>
> Message: 4
> Date: Tue, 7 Oct 2008 20:21:13 +0530
> From: "selvamuthukumar v" <v.selvamuthukumar@gmail.com>
> Subject: Re: Trying to vfree() nonexistent vm area
> To: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
> Cc: Scott Wood <scottwood@freescale.com>, linuxppc-embedded@ozlabs.org
> Message-ID:
> <790896390810070751u71d34ad4t82921a9bb2aaa698@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
>> ///////////////////////
>> Below is outline of the driver
>>
>> init:
>>    ppc_base = (unsigned long) ioremap_nocache(PPC_BASE, PPC_SIZE);
>>
>> //     ppc_base = (unsigned long) ioremap(PPC_BASE, PPC_SIZE);    // 
>> failure
>> with this way too
>>
>>
>> close:
>>   iounmap((void __iomem *)ppc_base);
>> //    iounmap(PPC_BASE);        // failure with this way too !
>>
>>
> init and close seems to be wrong combinations. You can try,
>
> open - ioremap
> close - iounmap
>
> or
>
> init - ioremap
> exit - iounmap
>
> -- 
> Selva
>
>
> ------------------------------
>
> Message: 5
> Date: Tue, 07 Oct 2008 11:52:09 -0400
> From: Juliana Su <js084@bucknell.edu>
> Subject: SysACE driver and Ethernet support? - mainline Linux 2.6.10
> and Xilinx ML310
> To: linuxppc-embedded@ozlabs.org
> Message-ID: <48EB85A9.1000302@bucknell.edu>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Hi All,
>
> I finally got PCI support on my Xilinx ML310 with a mainline Linux
> 2.6.10 kernel and gcc-3.4.5-glibc-2.3.6 (with the help of the awesome
> people at UNCC). Now, I'm trying to get Xilinx SystemACE device driver
> support and Ethernet working. Unfortunately, I do not know much about
> adding support for a driver that does not currently exist in the kernel.
> Does anybody know if it would be possible to get SysACE driver support
> in 2.6.10? Downloading an ELF file onto a board using a JTAG cable is
> slow and inconvenient...
>
> My attempt at adding SysACE driver support involved adding in
> drivers/block/xsysace.c and linux/platform_device.h (files pulled from
> mainline Linux 2.6.24) and editing drivers/block/Kconfig and
> drivers/block/Makefile. The kernel failed to compile, however, and spit
> out these errors:
>
>
> In file included from drivers/block/xsysace.c:93:
> include/linux/platform_device.h:16: error: redefinition of `struct
> platform_device'
> include/linux/platform_device.h:39: error: conflicting types for
> 'platform_device_register_simple'
> include/linux/device.h:387: error: previous declaration of
> 'platform_device_register_simple' was here
> include/linux/platform_device.h:39: error: conflicting types for
> 'platform_device_register_simple'
> include/linux/device.h:387: error: previous declaration of
> 'platform_device_register_simple' was here
> include/linux/platform_device.h:52: error: syntax error before
> "pm_message_t"
> include/linux/platform_device.h:52: warning: function declaration isn't
> a prototype
> include/linux/platform_device.h:53: error: syntax error before
> "pm_message_t"
> include/linux/platform_device.h:53: warning: function declaration isn't
> a prototype
> drivers/block/xsysace.c: In function `ace_fsm_yieldirq':
> drivers/block/xsysace.c:461: error: `NO_IRQ' undeclared (first use in
> this function)
> drivers/block/xsysace.c:461: error: (Each undeclared identifier is
> reported only once
> drivers/block/xsysace.c:461: error: for each function it appears in.)
> drivers/block/xsysace.c: In function `ace_fsm_dostate':
> drivers/block/xsysace.c:723: error: too many arguments to function
> `end_that_request_last'
> drivers/block/xsysace.c: At top level:
> drivers/block/xsysace.c:931: error: unknown field `getgeo' specified in
> initializer
> drivers/block/xsysace.c:931: warning: initialization from incompatible
> pointer type
> drivers/block/xsysace.c: In function `ace_setup':
> drivers/block/xsysace.c:960: warning: implicit declaration of function
> `setup_timer'
> drivers/block/xsysace.c:1009: error: `NO_IRQ' undeclared (first use in
> this function)
> drivers/block/xsysace.c:1010: warning: passing arg 2 of `request_irq'
> from incompatible pointer type
> drivers/block/xsysace.c: In function `ace_teardown':
> drivers/block/xsysace.c:1061: error: `NO_IRQ' undeclared (first use in
> this function)
> drivers/block/xsysace.c: In function `ace_alloc':
> drivers/block/xsysace.c:1081: warning: implicit declaration of function
> `kzalloc'
> drivers/block/xsysace.c:1081: warning: assignment makes pointer from
> integer without a cast
> drivers/block/xsysace.c: In function `ace_probe':
> drivers/block/xsysace.c:1131: error: `NO_IRQ' undeclared (first use in
> this function)
> make[2]: *** [drivers/block/xsysace.o] Error 1
> make[1]: *** [drivers/block] Error 2
> make: *** [drivers] Error 2
>
>
> Also, is anybody familiar with the Ethernet drivers? My boot-log
> contains this error concerning Ethernet:
>
>
> eepro100.c:v1.09j-t 9/29/99 Donald Becker
> http://www.scyld.com/network/eepro100.html
> eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
> <saw@saw.sw.com.sg> and others
> eth0: Invalid EEPROM checksum 0xbf8a, check settings before activating
> this device!
> eth0: OEM i82557/i82558 10/100 Ethernet, 00:0A:35:00:7C:A0, IRQ 0.
>  Board assembly 727095-004, Physical connectors present: RJ45
>  Primary interface chip i82555 PHY #1.
> Self test failed, status ffffffff:
> Failure to initialize the i82557.
> Verify that the card is a bus-master capable slot.
>
>
> I also tried another Ethernet driver and got this error instead:
>
>
> e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
> e100: Copyright(c) 1999-2004 Intel Corporation
> e100: 0000:00:07.0: e100_eeprom_load: EEPROM corrupted
> e100: probe of 0000:00:07.0 failed with error -11
>
>
> I know that newer versions of mainline and Xilinx Linux 2.6 have SysACE
> support, but I would prefer to stick with mainline 2.6.10 because, well,
> it sort of works for me at the moment (I was able to mount an ATA hard
> drive with an ext2 file system). Any help/suggestions would be greatly
> appreciated. Let me know if you need me to provide any additional
> information. Thanks!
>
>
> -Juliana
>
>
>
>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> End of Linuxppc-embedded Digest, Vol 50, Issue 8
> ************************************************
> 

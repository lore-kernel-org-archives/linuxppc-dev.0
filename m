Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc3-s22.bay0.hotmail.com (bay0-omc3-s22.bay0.hotmail.com
	[65.54.246.222]) by ozlabs.org (Postfix) with ESMTP id 5AB45DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Oct 2008 15:21:57 +1100 (EST)
Message-ID: <BLU119-DAV1192FA6384F7385B38A752BB350@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.2972.1223596990.3127.linuxppc-embedded@ozlabs.org>
Subject: Re: Linuxppc-embedded Digest, Vol 50, Issue 15
Date: Thu, 9 Oct 2008 21:21:50 -0700
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

Hello Quan,

You're right, I2C @ 0x50 is backup I2C bootloader in case the regular
NOR/NAND corrupued.

What I'm trying to do is to take advantage of high-level access supported
from Linux where I could use read() write() after opening /dev/i2c-0 as a
file using function open("/dev/i2c-0", RDWR)

I'd install i2c-tools you recommend to see what I could get from there. In
the worst case I will write a light-weight I2C driver and access it at
low-level as I used to do.

Thanks, Quan.

Best Wishes,

Duy-Ky

----- Original Message ----- 
From: <linuxppc-embedded-request@ozlabs.org>
To: <linuxppc-embedded@ozlabs.org>
Sent: Thursday, October 09, 2008 5:03 PM
Subject: Linuxppc-embedded Digest, Vol 50, Issue 15


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
>   1. Re: MTD map drivers (FSL UPM NAND) (Scott Wood)
>   2. API access I2C (Duy-Ky Nguyen)
>   3. RE: API access I2C (Nguyen Duc Quan)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Thu, 09 Oct 2008 16:17:51 -0500
> From: Scott Wood <scottwood@freescale.com>
> Subject: Re: MTD map drivers (FSL UPM NAND)
> To: Alemao <xcarandiru@gmail.com>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <48EE74FF.9000809@freescale.com>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Alemao wrote:
>> Hi all,
>>
>> Im trying to use a physmap driver for NOR and NAND flash devices.
>
> You can't use physmap with NAND.
>
>>   ranges = <0 0 ff000000 1000000     // nor flash,  16 MB
>>                     1 0 60000000 4000000>;   // nand flash, 64 MB
>
> Is your NAND window really that large?  I'm not too familiar with UPM,
> but typically it'd only be a few KiB.
>
>> So, how can I load the UPM driver before physmap?
>
> Just stop pointing physmap at the NAND.
>
> -Scott
>
>
> ------------------------------
>
> Message: 2
> Date: Thu, 9 Oct 2008 16:11:22 -0700
> From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
> Subject: API access I2C
> To: <linuxppc-embedded@ozlabs.org>
> Message-ID: <BLU119-DAV9CCDC7C9F3F3B4125D0BDBB3A0@phx.gbl>
> Content-Type: text/plain; format=flowed; charset="iso-8859-1";
> reply-type=original
>
> Hello,
>
> I have an eva board MPC8313E-RDB with 3 I2C device at address 48, 50, 68.
> I'm able to read data from those 3 devices
>
> I follow linux/Documentation/i2c/dev-interface to create a C code to 
> access
> those 3 devices in Linux env, but all are failed !!!
>
> I really appreciate your help where to find  info or sample code running 
> in
> Linyux to access I2C devices
>
> Thanks so much,
>
> Duy-Ky
>
> ----- Original Message ----- 
> From: <linuxppc-embedded-request@ozlabs.org>
> To: <linuxppc-embedded@ozlabs.org>
> Sent: Thursday, October 09, 2008 2:05 PM
> Subject: Linuxppc-embedded Digest, Vol 50, Issue 14
>
>
>> Send Linuxppc-embedded mailing list submissions to
>> linuxppc-embedded@ozlabs.org
>>
>> To subscribe or unsubscribe via the World Wide Web, visit
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> or, via email, send a message with subject or body 'help' to
>> linuxppc-embedded-request@ozlabs.org
>>
>> You can reach the person managing the list at
>> linuxppc-embedded-owner@ozlabs.org
>>
>> When replying, please edit your Subject line so it is more specific
>> than "Re: Contents of Linuxppc-embedded digest..."
>>
>>
>> Today's Topics:
>>
>>   1. Re: performance: memcpy vs. __copy_tofrom_user (Leon Woestenberg)
>>   2. Re: performance: memcpy vs. __copy_tofrom_user (Matt Sealey)
>>   3. Toolchain for ppc-440 without FPU (Ademir Zanetti Junior)
>>   4. Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup
>>      (100005/1) (Remi Lefevre)
>>   5. MTD map drivers (FSL UPM NAND) (Alemao)
>>   6. RE: Toolchain for ppc-440 without FPU (Ayman El-Khashab)
>>
>>
>> ----------------------------------------------------------------------
>>
>> Message: 1
>> Date: Thu, 9 Oct 2008 14:04:53 +0200
>> From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
>> Subject: Re: performance: memcpy vs. __copy_tofrom_user
>> To: "Dominik Bozek" <domino@mikroswiat.pl>
>> Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
>> linuxppc-embedded@ozlabs.org
>> Message-ID:
>> <c384c5ea0810090504x570cb6aai6d136a150e74ac05@mail.gmail.com>
>> Content-Type: text/plain; charset=ISO-8859-1
>>
>> Hello all,
>>
>> On Thu, Oct 9, 2008 at 1:41 PM, Dominik Bozek <domino@mikroswiat.pl>
>> wrote:
>>> Paul Mackerras wrote:
>>>> Dominik Bozek writes:
>>>>> Actually I made couple of other tests on that mpc8313. Most of them 
>>>>> are
>>>>> to ugly to publish them, but... My problem is that I have to boost the
>>>>> gigabit interface on the mpc8313. I made simple substitution and
>>>>
>>>> Very interesting.  Can you work out where memcpy is being called on
>>>> the network data?  I wouldn't have expected that.
>>>>
>>
>> Also see this recent thread David Jander on August 25th, "Efficient
>> memcpy()/memmove() for G2/G3 cores..."
>> on linuxppc-dev@ozlabs.org.
>>
>> http://ozlabs.org/pipermail/linuxppc-dev/2008-September/062449.html
>>
>> BTW, I am interested in this work as well, I'm currently working with
>> a 8313 and 8315 design, both are e300 cores.
>>
>> My current goal is PCIe though, but I need fast GbE performance as well.
>>
>> Also, did you test Freescale's 2.6.24.3 patches that tune the gianfar
>> interfaces for higher performance?
>>
>> Regards,
>> -- 
>> Leon
>>
>>
>> ------------------------------
>>
>> Message: 2
>> Date: Thu, 09 Oct 2008 10:37:55 -0500
>> From: Matt Sealey <matt@genesi-usa.com>
>> Subject: Re: performance: memcpy vs. __copy_tofrom_user
>> To: Paul Mackerras <paulus@samba.org>
>> Cc: linuxppc-dev@ozlabs.org, Dominik Bozek <domino@mikroswiat.pl>,
>> linuxppc-embedded@ozlabs.org
>> Message-ID: <48EE2553.30903@genesi-usa.com>
>> Content-Type: text/plain; charset=UTF-8; format=flowed
>>
>> Paul Mackerras wrote:
>>> Dominik Bozek writes:
>>>
>>>> Actually I made couple of other tests on that mpc8313. Most of them are
>>>> to ugly to publish them, but... My problem is that I have to boost the
>>>> gigabit interface on the mpc8313. I made simple substitution and
>>>> __copy_tofrom_user was used instead of memcpy. I know, it's wrong, but 
>>>> I
>>>> speedup that way the network interface for about 10%.
>>>
>>> Very interesting.  Can you work out where memcpy is being called on
>>> the network data?  I wouldn't have expected that.
>>
>> It probably is somewhere.. through some weird and wonderful code path 
>> that
>> needs some serious digging to find. At least in 2.4 memcpy was used and
>> optimizing it (see Freescale's libmotovec benchmarks) did produce a
>> sizable
>> performance improvement. That, and offloading TCP checksumming to AltiVec
>> helped a lot.
>>
>> No help at all on an 8313 but, relevant anyway.
>>
>> Since then zero copy networking and other fancy things like the DMA
>> engine API (for intel ioat at least but also there is fsl dma support)
>> there's less to actually optimize now so you're less likely to see the
>> same benefits. All these got into mainline because it's essential to
>> have this kind of architecture to get reasonable speeds out of >gigabit
>> network links.
>>
>>> There is actually no strong reason not to use __copy_tofrom_user as
>>> memcpy, in fact, as long as we are sure that source and destination
>>> are both cacheable.
>>
>> I do think there is probably a good benefit in doing things like zeroing
>> pages in AltiVec and copying entire pages with AltiVec (for instance
>> when copy-on-write happens in an application) - NetBSD and QNX implement
>> at least this because it's faster than using the cache management and
>> works fine on uncacheable pages too (also since you're always aligned to
>> a page, zeroing 4kb aligned to a 4kb boundary - or whatever your page
>> size happens to be, the number of errors that can occur are absolutely
>> tiny and performance can go through the roof).
>>
>> Ahem, but nobody here wants AltiVec in the kernel do they?
>>
>> -- 
>> Matt Sealey <matt@genesi-usa.com>
>> Genesi, Manager, Developer Relations
>>
>>
>> ------------------------------
>>
>> Message: 3
>> Date: Thu, 9 Oct 2008 16:08:18 -0300
>> From: "Ademir Zanetti Junior" <ademirzanetti@gmail.com>
>> Subject: Toolchain for ppc-440 without FPU
>> To: linuxppc-embedded@ozlabs.org
>> Message-ID:
>> <2204d6480810091208u1776e81fx6597719734751edb@mail.gmail.com>
>> Content-Type: text/plain; charset="utf-8"
>>
>> Hello all,
>>
>> I am trying to create a toolchain by hand and I am facing some problems
>> when
>> I try to configure the glibc 2.7 for a powerpc. When I try to configure
>> the
>> glibc to install the headers I get the following error:
>>
>> configure --prefix=/usr --host=powerpc-440-linux-gnu
>> --with-headers=${SYSROOT}/usr/include --disable-shared --without-cvs
>> --with-binutils=/home/azanetti/ml507/powerpc/bin/
>>
>> checking build system type... i686-pc-linux-gnu
>> checking host system type... i686-pc-linux-gnu
>> configure: running configure fragment for add-on nptl
>> checking sysdep dirs... sysdeps/i386/elf
>> nptl/sysdeps/unix/sysv/linux/i386/i686 nptl/sysdeps/unix/sysv/linux/i386
>> sysdeps/unix/sysv/linux/i386 nptl/sysdeps/unix/sysv/linux
>> nptl/sysdeps/pthread sysdeps/pthread sysdeps/unix/sysv/linux sysdeps/gnu
>> sysdeps/unix/common sysdeps/unix/mman sysdeps/unix/inet
>> sysdeps/unix/sysv/i386 nptl/sysdeps/unix/sysv sysdeps/unix/sysv
>> sysdeps/unix/i386 nptl/sysdeps/unix sysdeps/unix sysdeps/posix
>> sysdeps/i386/i686/fpu nptl/sysdeps/i386/i686 sysdeps/i386/i686
>> sysdeps/i386/i486 nptl/sysdeps/i386/i486 sysdeps/i386/fpu
>> nptl/sysdeps/i386
>> sysdeps/i386 sysdeps/wordsize-32 sysdeps/ieee754/ldbl-96
>> sysdeps/ieee754/dbl-64 sysdeps/ieee754/flt-32 sysdeps/ieee754
>> sysdeps/generic/elf sysdeps/generic
>> checking for a BSD-compatible install... /usr/bin/install -c
>> checking whether ln -s works... yes
>> checking for gcc... gcc
>> checking for suffix of object files... o
>> checking whether we are using the GNU C compiler... yes
>> checking whether gcc accepts -g... yes
>> checking for gcc option to accept ISO C89... none needed
>> checking how to run the C preprocessor... gcc -E
>> checking for g++... g++
>>
>> .
>> .
>> .
>> checking for long double... yes
>> checking size of long double... 12
>> running configure fragment for sysdeps/powerpc/powerpc32/elf
>> checking for powerpc32 TLS support... no
>> running configure fragment for sysdeps/unix/sysv/linux/powerpc
>> checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2
>> -mlong-double-128 uses IBM extended format... no
>> checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2 supports
>> -mabi=ibmlongdouble... no
>> configure: error: this configuration requires -mlong-double-128 IBM
>> extended
>> format support
>>
>>
>> I already have the binutils 2.18 compiled on my PATH. I know that it is
>> easier to use a script like crosstool to compile it but I do want to
>> understand what is happening behind the scenes.
>>
>> Regards.
>>
>> Ademir
>> -------------- next part --------------
>> An HTML attachment was scrubbed...
>> URL:
>> <http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20081009/a3dd71d6/attachment-0001.htm>
>>
>> ------------------------------
>>
>> Message: 4
>> Date: Thu, 9 Oct 2008 21:46:42 +0200
>> From: "Remi Lefevre" <rlefevre@gmail.com>
>> Subject: Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup
>> (100005/1)
>> To: "Scott Wood" <scottwood@freescale.com>
>> Cc: linuxppc-embedded@ozlabs.org
>> Message-ID:
>> <4e0b9cb00810091246i2f200dbn9f8dc9877800e629@mail.gmail.com>
>> Content-Type: text/plain; charset=ISO-8859-1
>>
>> Ok, I'm sorry, I have incorrectly set the 60x pipeline depth to 0
>> instead of 1 in BCR register.
>> It works fine now. The side effect is interesting to know...
>>
>> regards,
>> r?mi
>>
>>
>> ------------------------------
>>
>> Message: 5
>> Date: Thu, 9 Oct 2008 18:04:25 -0300
>> From: Alemao <xcarandiru@gmail.com>
>> Subject: MTD map drivers (FSL UPM NAND)
>> To: linuxppc-embedded@ozlabs.org
>> Message-ID:
>> <d970ff420810091404j49492e80xcd9250d0ffdcd592@mail.gmail.com>
>> Content-Type: text/plain; charset=ISO-8859-1
>>
>> Hi all,
>>
>> Im trying to use a physmap driver for NOR and NAND flash devices.
>>
>> With NOR, everything ok. It uses CFI driver.
>>
>> The problem is with NAND, cause it is connected at Freescale
>> LocalBus UPM, and at a first look, the UPM driver is loading after the
>> physmap (lines 14-15 in kernel output)
>>
>> Here some outputs from the board:
>>
>> Bootloader (U-Boot 1.2.0):
>>
>> CPU:   e300c1, MPC8360E, Rev: 21 at 499.999 MHz, CSB:  333 MHz
>> Board: MPC8360KTX
>> I2C:   ready
>> DDR RAM: 128 MB
>> FLASH: 16 MB
>> NAND:  64 MiB
>> In:    serial
>> Out:   serial
>> Err:   serial
>>
>>
>> Kernel (linux-2.6.17):
>>
>> 1               physmap nor flash device: 1000000 at ff000000
>> 2               NOR flash: Found 1 x16 devices at 0x0 in 16-bit bank
>> 3                Amd/Fujitsu Extended Query Table at 0x0040
>> 4                number of CFI chips: 1
>> 5               Using physmap partition definition
>> 6               Creating 6 MTD partitions on "NOR flash":
>> 7               0x00000000-0x00040000 : "u-boot"
>> 8               0x00040000-0x00060000 : "env."
>> 9               0x00060000-0x00080000 : "sys"
>> 10              0x00080000-0x000c0000 : "logs"
>> 11              0x000c0000-0x00860000 : "admin"
>> 12              0x00860000-0x01000000 : "users"
>> 13
>> 14              physmap nand flash device: 4000000 at 60000000
>> 15              UPM: User-Programmable Machine NAND driver
>>
>>
>> Device Tree Source:
>>
>> localbus@e0005000 {
>>  compatible = "fsl,board-localbus";
>>  #address-cells = <2>;
>>  #size-cells = <1>;
>>  reg = <e0005000 d8>;    // BRx, ORx, etc
>>
>>  ranges = <0 0 ff000000 1000000     // nor flash,  16 MB
>>                    1 0 60000000 4000000>;   // nand flash, 64 MB
>>
>>  flash@0,0 {
>>      compatible = "atmel,29LV256", "cfi-flash";
>>      reg = <0 0 1000000>;
>>      bank-width = <2>;
>>      device-width = <1>;
>>  };
>>
>>  nand@1,0 {
>>      compatible = "stmicro,NAND512W3A", "fsl,upm-nand";
>>      reg = <1 0 4000000>;   //reg = <1 0 1>;
>>      width = <1>;
>>      upm = "A";
>>      upm-addr-offset = <16>;
>>      upm-cmd-offset = <8>;
>>      gpios = <4 18>;
>>      gpio-parent = <&qe_pio>;
>>      wait-pattern;
>>      wait-write;
>>  };
>> };
>>
>> The CFI driver is at linux/drivers/mtd/chips
>> The UPM driver is at linux/drivers/mtd/nand
>>
>> So, how can I load the UPM driver before physmap?
>>
>> Thanks in advance,
>>
>> --
>> Alemao
>>
>>
>> ------------------------------
>>
>> Message: 6
>> Date: Thu, 9 Oct 2008 16:05:47 -0500
>> From: "Ayman El-Khashab" <AymanE@tanisys.com>
>> Subject: RE: Toolchain for ppc-440 without FPU
>> To: "Ademir Zanetti Junior" <ademirzanetti@gmail.com>,
>> <linuxppc-embedded@ozlabs.org>
>> Message-ID:
>> <16691A8B34B5D9458EA3A1C37A11555A0137F80B@tanisys-ex2.Tanisys.Local>
>> Content-Type: text/plain; charset="us-ascii"
>>
>> I was compiling for the 440FP under cygwin, I believe that I had to use
>> --enable-long-long when I configured gcc in order to build glibc.
>>
>> ________________________________
>>
>> From: linuxppc-embedded-bounces+aymane=tanisys.com@ozlabs.org
>> [mailto:linuxppc-embedded-bounces+aymane=tanisys.com@ozlabs.org] On
>> Behalf Of Ademir Zanetti Junior
>> Sent: Thursday, October 09, 2008 2:08 PM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: Toolchain for ppc-440 without FPU
>>
>>
>> Hello all,
>>
>> I am trying to create a toolchain by hand and I am facing some problems
>> when I try to configure the glibc 2.7 for a powerpc. When I try to
>> configure the glibc to install the headers I get the following error:
>>
>> configure --prefix=/usr --host=powerpc-440-linux-gnu
>> --with-headers=${SYSROOT}/usr/include --disable-shared --without-cvs
>> --with-binutils=/home/azanetti/ml507/powerpc/bin/
>>
>> checking build system type... i686-pc-linux-gnu
>> checking host system type... i686-pc-linux-gnu
>> configure: running configure fragment for add-on nptl
>> checking sysdep dirs... sysdeps/i386/elf
>> nptl/sysdeps/unix/sysv/linux/i386/i686 nptl/sysdeps/unix/sysv/linux/i386
>> sysdeps/unix/sysv/linux/i386 nptl/sysdeps/unix/sysv/linux
>> nptl/sysdeps/pthread sysdeps/pthread sysdeps/unix/sysv/linux sysdeps/gnu
>> sysdeps/unix/common sysdeps/unix/mman sysdeps/unix/inet
>> sysdeps/unix/sysv/i386 nptl/sysdeps/unix/sysv sysdeps/unix/sysv
>> sysdeps/unix/i386 nptl/sysdeps/unix sysdeps/unix sysdeps/posix
>> sysdeps/i386/i686/fpu nptl/sysdeps/i386/i686 sysdeps/i386/i686
>> sysdeps/i386/i486 nptl/sysdeps/i386/i486 sysdeps/i386/fpu
>> nptl/sysdeps/i386 sysdeps/i386 sysdeps/wordsize-32
>> sysdeps/ieee754/ldbl-96 sysdeps/ieee754/dbl-64 sysdeps/ieee754/flt-32
>> sysdeps/ieee754 sysdeps/generic/elf sysdeps/generic
>> checking for a BSD-compatible install... /usr/bin/install -c
>> checking whether ln -s works... yes
>> checking for gcc... gcc
>> checking for suffix of object files... o
>> checking whether we are using the GNU C compiler... yes
>> checking whether gcc accepts -g... yes
>> checking for gcc option to accept ISO C89... none needed
>> checking how to run the C preprocessor... gcc -E
>> checking for g++... g++
>>
>> .
>> .
>> .
>> checking for long double... yes
>> checking size of long double... 12
>> running configure fragment for sysdeps/powerpc/powerpc32/elf
>> checking for powerpc32 TLS support... no
>> running configure fragment for sysdeps/unix/sysv/linux/powerpc
>> checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2
>> -mlong-double-128 uses IBM extended format... no
>> checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2 supports
>> -mabi=ibmlongdouble... no
>> configure: error: this configuration requires -mlong-double-128 IBM
>> extended format support
>>
>>
>> I already have the binutils 2.18 compiled on my PATH. I know that it is
>> easier to use a script like crosstool to compile it but I do want to
>> understand what is happening behind the scenes.
>>
>> Regards.
>>
>> Ademir
>>
>> -------------- next part --------------
>> An HTML attachment was scrubbed...
>> URL:
>> <http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20081009/c91ac7a9/attachment.htm>
>>
>> ------------------------------
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>> End of Linuxppc-embedded Digest, Vol 50, Issue 14
>> *************************************************
>>
>
>
>
> ------------------------------
>
> Message: 3
> Date: Thu, 9 Oct 2008 16:56:26 -0700 (PDT)
> From: Nguyen Duc Quan <ducquannguyen@yahoo.com>
> Subject: RE: API access I2C
> To: Duy-Ky Nguyen <duykynguyen@hotmail.com>,
> linuxppc-embedded@ozlabs.org
> Message-ID: <243068.78574.qm@web51406.mail.re2.yahoo.com>
> Content-Type: text/plain; charset="utf-8"
>
> I think I2C-tools is what you need as sample code to access I2C in Linux. 
> Here is the link
> http://dl.lm-sensors.org/i2c-tools/releases/i2c-tools-3.0.1.tar.bz2
> There are a lot of tools to access, set/get/dump register, read/write the 
> I2C eeprom...
> But please use them with care, especially when you try to read/write the 
> device at address 0x50 ( it's is bootstrap eeprom).
> You might not boot up your board after playing with this device :-)
> Quan Nguyen
>
>
>
> ----- Th? g?c ----
> T?: Duy-Ky Nguyen <duykynguyen@hotmail.com>
> ??n: linuxppc-embedded@ozlabs.org
> G?i ng?y: Th? S?u, 10 th?ng 10, 2008 6:11:22
> Ch? ??: API access I2C
>
> Hello,
>
> I have an eva board MPC8313E-RDB with 3 I2C device at address 48, 50, 68.
> I'm able to read data from those 3 devices
>
> I follow linux/Documentation/i2c/dev-interface to create a C code to 
> access
> those 3 devices in Linux env, but all are failed !!!
>
> I really appreciate your help where to find  info or sample code running 
> in
> Linyux to access I2C devices
>
> Thanks so much,
>
> Duy-Ky
>
> ----- Original Message ----- 
> From: <linuxppc-embedded-request@ozlabs.org>
> To: <linuxppc-embedded@ozlabs.org>
> Sent: Thursday, October 09, 2008 2:05 PM
> Subject: Linuxppc-embedded Digest, Vol 50, Issue 14
>
>
>> Send Linuxppc-embedded mailing list submissions to
>> linuxppc-embedded@ozlabs.org
>>
>> To subscribe or unsubscribe via the World Wide Web, visit
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> or, via email, send a message with subject or body 'help' to
>> linuxppc-embedded-request@ozlabs.org
>>
>> You can reach the person managing the list at
>> linuxppc-embedded-owner@ozlabs.org
>>
>> When replying, please edit your Subject line so it is more specific
>> than "Re: Contents of Linuxppc-embedded digest..."
>>
>>
>> Today's Topics:
>>
>>   1. Re: performance: memcpy vs. __copy_tofrom_user (Leon Woestenberg)
>>   2. Re: performance: memcpy vs. __copy_tofrom_user (Matt Sealey)
>>   3. Toolchain for ppc-440 without FPU (Ademir Zanetti Junior)
>>   4. Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup
>>      (100005/1) (Remi Lefevre)
>>   5. MTD map drivers (FSL UPM NAND) (Alemao)
>>   6. RE: Toolchain for ppc-440 without FPU (Ayman El-Khashab)
>>
>>
>> ----------------------------------------------------------------------
>>
>> Message: 1
>> Date: Thu, 9 Oct 2008 14:04:53 +0200
>> From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
>> Subject: Re: performance: memcpy vs. __copy_tofrom_user
>> To: "Dominik Bozek" <domino@mikroswiat.pl>
>> Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
>> linuxppc-embedded@ozlabs.org
>> Message-ID:
>> <c384c5ea0810090504x570cb6aai6d136a150e74ac05@mail.gmail.com>
>> Content-Type: text/plain; charset=ISO-8859-1
>>
>> Hello all,
>>
>> On Thu, Oct 9, 2008 at 1:41 PM, Dominik Bozek <domino@mikroswiat.pl>
>> wrote:
>>> Paul Mackerras wrote:
>>>> Dominik Bozek writes:
>>>>> Actually I made couple of other tests on that mpc8313. Most of them 
>>>>> are
>>>>> to ugly to publish them, but... My problem is that I have to boost the
>>>>> gigabit interface on the mpc8313. I made simple substitution and
>>>>
>>>> Very interesting.  Can you work out where memcpy is being called on
>>>> the network data?  I wouldn't have expected that.
>>>>
>>
>> Also see this recent thread David Jander on August 25th, "Efficient
>> memcpy()/memmove() for G2/G3 cores..."
>> on linuxppc-dev@ozlabs.org.
>>
>> http://ozlabs.org/pipermail/linuxppc-dev/2008-September/062449.html
>>
>> BTW, I am interested in this work as well, I'm currently working with
>> a 8313 and 8315 design, both are e300 cores.
>>
>> My current goal is PCIe though, but I need fast GbE performance as well.
>>
>> Also, did you test Freescale's 2.6.24.3 patches that tune the gianfar
>> interfaces for higher performance?
>>
>> Regards,
>> -- 
>> Leon
>>
>>
>> ------------------------------
>>
>> Message: 2
>> Date: Thu, 09 Oct 2008 10:37:55 -0500
>> From: Matt Sealey <matt@genesi-usa.com>
>> Subject: Re: performance: memcpy vs. __copy_tofrom_user
>> To: Paul Mackerras <paulus@samba.org>
>> Cc: linuxppc-dev@ozlabs.org, Dominik Bozek <domino@mikroswiat.pl>,
>> linuxppc-embedded@ozlabs.org
>> Message-ID: <48EE2553.30903@genesi-usa.com>
>> Content-Type: text/plain; charset=UTF-8; format=flowed
>>
>> Paul Mackerras wrote:
>>> Dominik Bozek writes:
>>>
>>>> Actually I made couple of other tests on that mpc8313. Most of them are
>>>> to ugly to publish them, but... My problem is that I have to boost the
>>>> gigabit interface on the mpc8313. I made simple substitution and
>>>> __copy_tofrom_user was used instead of memcpy. I know, it's wrong, but 
>>>> I
>>>> speedup that way the network interface for about 10%.
>>>
>>> Very interesting.  Can you work out where memcpy is being called on
>>> the network data?  I wouldn't have expected that.
>>
>> It probably is somewhere.. through some weird and wonderful code path 
>> that
>> needs some serious digging to find. At least in 2.4 memcpy was used and
>> optimizing it (see Freescale's libmotovec benchmarks) did produce a
>> sizable
>> performance improvement. That, and offloading TCP checksumming to AltiVec
>> helped a lot.
>>
>> No help at all on an 8313 but, relevant anyway.
>>
>> Since then zero copy networking and other fancy things like the DMA
>> engine API (for intel ioat at least but also there is fsl dma support)
>> there's less to actually optimize now so you're less likely to see the
>> same benefits. All these got into mainline because it's essential to
>> have this kind of architecture to get reasonable speeds out of >gigabit
>> network links.
>>
>>> There is actually no strong reason not to use __copy_tofrom_user as
>>> memcpy, in fact, as long as we are sure that source and destination
>>> are both cacheable.
>>
>> I do think there is probably a good benefit in doing things like zeroing
>> pages in AltiVec and copying entire pages with AltiVec (for instance
>> when copy-on-write happens in an application) - NetBSD and QNX implement
>> at least this because it's faster than using the cache management and
>> works fine on uncacheable pages too (also since you're always aligned to
>> a page, zeroing 4kb aligned to a 4kb boundary - or whatever your page
>> size happens to be, the number of errors that can occur are absolutely
>> tiny and performance can go through the roof).
>>
>> Ahem, but nobody here wants AltiVec in the kernel do they?
>>
>> -- 
>> Matt Sealey <matt@genesi-usa.com>
>> Genesi, Manager, Developer Relations
>>
>>
>> ------------------------------
>>
>> Message: 3
>> Date: Thu, 9 Oct 2008 16:08:18 -0300
>> From: "Ademir Zanetti Junior" <ademirzanetti@gmail.com>
>> Subject: Toolchain for ppc-440 without FPU
>> To: linuxppc-embedded@ozlabs.org
>> Message-ID:
>> <2204d6480810091208u1776e81fx6597719734751edb@mail.gmail.com>
>> Content-Type: text/plain; charset="utf-8"
>>
>> Hello all,
>>
>> I am trying to create a toolchain by hand and I am facing some problems
>> when
>> I try to configure the glibc 2.7 for a powerpc. When I try to configure
>> the
>> glibc to install the headers I get the following error:
>>
>> configure --prefix=/usr --host=powerpc-440-linux-gnu
>> --with-headers=${SYSROOT}/usr/include --disable-shared --without-cvs
>> --with-binutils=/home/azanetti/ml507/powerpc/bin/
>>
>> checking build system type... i686-pc-linux-gnu
>> checking host system type... i686-pc-linux-gnu
>> configure: running configure fragment for add-on nptl
>> checking sysdep dirs... sysdeps/i386/elf
>> nptl/sysdeps/unix/sysv/linux/i386/i686 nptl/sysdeps/unix/sysv/linux/i386
>> sysdeps/unix/sysv/linux/i386 nptl/sysdeps/unix/sysv/linux
>> nptl/sysdeps/pthread sysdeps/pthread sysdeps/unix/sysv/linux sysdeps/gnu
>> sysdeps/unix/common sysdeps/unix/mman sysdeps/unix/inet
>> sysdeps/unix/sysv/i386 nptl/sysdeps/unix/sysv sysdeps/unix/sysv
>> sysdeps/unix/i386 nptl/sysdeps/unix sysdeps/unix sysdeps/posix
>> sysdeps/i386/i686/fpu nptl/sysdeps/i386/i686 sysdeps/i386/i686
>> sysdeps/i386/i486 nptl/sysdeps/i386/i486 sysdeps/i386/fpu
>> nptl/sysdeps/i386
>> sysdeps/i386 sysdeps/wordsize-32 sysdeps/ieee754/ldbl-96
>> sysdeps/ieee754/dbl-64 sysdeps/ieee754/flt-32 sysdeps/ieee754
>> sysdeps/generic/elf sysdeps/generic
>> checking for a BSD-compatible install... /usr/bin/install -c
>> checking whether ln -s works... yes
>> checking for gcc... gcc
>> checking for suffix of object files... o
>> checking whether we are using the GNU C compiler... yes
>> checking whether gcc accepts -g... yes
>> checking for gcc option to accept ISO C89... none needed
>> checking how to run the C preprocessor... gcc -E
>> checking for g++... g++
>>
>> .
>> .
>> .
>> checking for long double... yes
>> checking size of long double... 12
>> running configure fragment for sysdeps/powerpc/powerpc32/elf
>> checking for powerpc32 TLS support... no
>> running configure fragment for sysdeps/unix/sysv/linux/powerpc
>> checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2
>> -mlong-double-128 uses IBM extended format... no
>> checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2 supports
>> -mabi=ibmlongdouble... no
>> configure: error: this configuration requires -mlong-double-128 IBM
>> extended
>> format support
>>
>>
>> I already have the binutils 2.18 compiled on my PATH. I know that it is
>> easier to use a script like crosstool to compile it but I do want to
>> understand what is happening behind the scenes.
>>
>> Regards.
>>
>> Ademir
>> -------------- next part --------------
>> An HTML attachment was scrubbed...
>> URL:
>> <http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20081009/a3dd71d6/attachment-0001.htm>
>>
>> ------------------------------
>>
>> Message: 4
>> Date: Thu, 9 Oct 2008 21:46:42 +0200
>> From: "Remi Lefevre" <rlefevre@gmail.com>
>> Subject: Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup
>> (100005/1)
>> To: "Scott Wood" <scottwood@freescale.com>
>> Cc: linuxppc-embedded@ozlabs.org
>> Message-ID:
>> <4e0b9cb00810091246i2f200dbn9f8dc9877800e629@mail.gmail.com>
>> Content-Type: text/plain; charset=ISO-8859-1
>>
>> Ok, I'm sorry, I have incorrectly set the 60x pipeline depth to 0
>> instead of 1 in BCR register.
>> It works fine now. The side effect is interesting to know...
>>
>> regards,
>> r?mi
>>
>>
>> ------------------------------
>>
>> Message: 5
>> Date: Thu, 9 Oct 2008 18:04:25 -0300
>> From: Alemao <xcarandiru@gmail.com>
>> Subject: MTD map drivers (FSL UPM NAND)
>> To: linuxppc-embedded@ozlabs.org
>> Message-ID:
>> <d970ff420810091404j49492e80xcd9250d0ffdcd592@mail.gmail.com>
>> Content-Type: text/plain; charset=ISO-8859-1
>>
>> Hi all,
>>
>> Im trying to use a physmap driver for NOR and NAND flash devices.
>>
>> With NOR, everything ok. It uses CFI driver.
>>
>> The problem is with NAND, cause it is connected at Freescale
>> LocalBus UPM, and at a first look, the UPM driver is loading after the
>> physmap (lines 14-15 in kernel output)
>>
>> Here some outputs from the board:
>>
>> Bootloader (U-Boot 1.2.0):
>>
>> CPU:   e300c1, MPC8360E, Rev: 21 at 499.999 MHz, CSB:  333 MHz
>> Board: MPC8360KTX
>> I2C:   ready
>> DDR RAM: 128 MB
>> FLASH: 16 MB
>> NAND:  64 MiB
>> In:    serial
>> Out:   serial
>> Err:   serial
>>
>>
>> Kernel (linux-2.6.17):
>>
>> 1               physmap nor flash device: 1000000 at ff000000
>> 2               NOR flash: Found 1 x16 devices at 0x0 in 16-bit bank
>> 3                Amd/Fujitsu Extended Query Table at 0x0040
>> 4                number of CFI chips: 1
>> 5               Using physmap partition definition
>> 6               Creating 6 MTD partitions on "NOR flash":
>> 7               0x00000000-0x00040000 : "u-boot"
>> 8               0x00040000-0x00060000 : "env."
>> 9               0x00060000-0x00080000 : "sys"
>> 10              0x00080000-0x000c0000 : "logs"
>> 11              0x000c0000-0x00860000 : "admin"
>> 12              0x00860000-0x01000000 : "users"
>> 13
>> 14              physmap nand flash device: 4000000 at 60000000
>> 15              UPM: User-Programmable Machine NAND driver
>>
>>
>> Device Tree Source:
>>
>> localbus@e0005000 {
>>  compatible = "fsl,board-localbus";
>>  #address-cells = <2>;
>>  #size-cells = <1>;
>>  reg = <e0005000 d8>;    // BRx, ORx, etc
>>
>>  ranges = <0 0 ff000000 1000000     // nor flash,  16 MB
>>                    1 0 60000000 4000000>;   // nand flash, 64 MB
>>
>>  flash@0,0 {
>>      compatible = "atmel,29LV256", "cfi-flash";
>>      reg = <0 0 1000000>;
>>      bank-width = <2>;
>>      device-width = <1>;
>>  };
>>
>>  nand@1,0 {
>>      compatible = "stmicro,NAND512W3A", "fsl,upm-nand";
>>      reg = <1 0 4000000>;   //reg = <1 0 1>;
>>      width = <1>;
>>      upm = "A";
>>      upm-addr-offset = <16>;
>>      upm-cmd-offset = <8>;
>>      gpios = <4 18>;
>>      gpio-parent = <&qe_pio>;
>>      wait-pattern;
>>      wait-write;
>>  };
>> };
>>
>> The CFI driver is at linux/drivers/mtd/chips
>> The UPM driver is at linux/drivers/mtd/nand
>>
>> So, how can I load the UPM driver before physmap?
>>
>> Thanks in advance,
>>
>> --
>> Alemao
>>
>>
>> ------------------------------
>>
>> Message: 6
>> Date: Thu, 9 Oct 2008 16:05:47 -0500
>> From: "Ayman El-Khashab" <AymanE@tanisys.com>
>> Subject: RE: Toolchain for ppc-440 without FPU
>> To: "Ademir Zanetti Junior" <ademirzanetti@gmail.com>,
>> <linuxppc-embedded@ozlabs.org>
>> Message-ID:
>> <16691A8B34B5D9458EA3A1C37A11555A0137F80B@tanisys-ex2.Tanisys.Local>
>> Content-Type: text/plain; charset="us-ascii"
>>
>> I was compiling for the 440FP under cygwin, I believe that I had to use
>> --enable-long-long when I configured gcc in order to build glibc.
>>
>> ________________________________
>>
>> From: linuxppc-embedded-bounces+aymane=tanisys.com@ozlabs.org
>> [mailto:linuxppc-embedded-bounces+aymane=tanisys.com@ozlabs.org] On
>> Behalf Of Ademir Zanetti Junior
>> Sent: Thursday, October 09, 2008 2:08 PM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: Toolchain for ppc-440 without FPU
>>
>>
>> Hello all,
>>
>> I am trying to create a toolchain by hand and I am facing some problems
>> when I try to configure the glibc 2.7 for a powerpc. When I try to
>> configure the glibc to install the headers I get the following error:
>>
>> configure --prefix=/usr --host=powerpc-440-linux-gnu
>> --with-headers=${SYSROOT}/usr/include --disable-shared --without-cvs
>> --with-binutils=/home/azanetti/ml507/powerpc/bin/
>>
>> checking build system type... i686-pc-linux-gnu
>> checking host system type... i686-pc-linux-gnu
>> configure: running configure fragment for add-on nptl
>> checking sysdep dirs... sysdeps/i386/elf
>> nptl/sysdeps/unix/sysv/linux/i386/i686 nptl/sysdeps/unix/sysv/linux/i386
>> sysdeps/unix/sysv/linux/i386 nptl/sysdeps/unix/sysv/linux
>> nptl/sysdeps/pthread sysdeps/pthread sysdeps/unix/sysv/linux sysdeps/gnu
>> sysdeps/unix/common sysdeps/unix/mman sysdeps/unix/inet
>> sysdeps/unix/sysv/i386 nptl/sysdeps/unix/sysv sysdeps/unix/sysv
>> sysdeps/unix/i386 nptl/sysdeps/unix sysdeps/unix sysdeps/posix
>> sysdeps/i386/i686/fpu nptl/sysdeps/i386/i686 sysdeps/i386/i686
>> sysdeps/i386/i486 nptl/sysdeps/i386/i486 sysdeps/i386/fpu
>> nptl/sysdeps/i386 sysdeps/i386 sysdeps/wordsize-32
>> sysdeps/ieee754/ldbl-96 sysdeps/ieee754/dbl-64 sysdeps/ieee754/flt-32
>> sysdeps/ieee754 sysdeps/generic/elf sysdeps/generic
>> checking for a BSD-compatible install... /usr/bin/install -c
>> checking whether ln -s works... yes
>> checking for gcc... gcc
>> checking for suffix of object files... o
>> checking whether we are using the GNU C compiler... yes
>> checking whether gcc accepts -g... yes
>> checking for gcc option to accept ISO C89... none needed
>> checking how to run the C preprocessor... gcc -E
>> checking for g++... g++
>>
>> .
>> .
>> .
>> checking for long double... yes
>> checking size of long double... 12
>> running configure fragment for sysdeps/powerpc/powerpc32/elf
>> checking for powerpc32 TLS support... no
>> running configure fragment for sysdeps/unix/sysv/linux/powerpc
>> checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2
>> -mlong-double-128 uses IBM extended format... no
>> checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2 supports
>> -mabi=ibmlongdouble... no
>> configure: error: this configuration requires -mlong-double-128 IBM
>> extended format support
>>
>>
>> I already have the binutils 2.18 compiled on my PATH. I know that it is
>> easier to use a script like crosstool to compile it but I do want to
>> understand what is happening behind the scenes.
>>
>> Regards.
>>
>> Ademir
>>
>> -------------- next part --------------
>> An HTML attachment was scrubbed...
>> URL:
>> <http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20081009/c91ac7a9/attachment.htm>
>>
>> ------------------------------
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>> End of Linuxppc-embedded Digest, Vol 50, Issue 14
>> *************************************************
>>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>
>      B?n c? ? ki?n v? M? T?m?
> H?y c?ng chia s? v?i m?i ng??i t?i Yahoo! Vi?t Nam Music
> http://vn.music.yahoo.com/artist/100000056?
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: 
> <http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20081009/0c4f9884/attachment.htm>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> End of Linuxppc-embedded Digest, Vol 50, Issue 15
> *************************************************
> 

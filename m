Return-Path: <pczanik@fang.fa.gau.hu>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 9B828DDEDB
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 19:51:55 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	3A5F3370346
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 11:42:51 +0200 (CEST)
Received: from [192.168.2.179] ([62.77.251.67])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0K2600MFIWB5LGY0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Mon, 09 Jun 2008 11:42:42 +0200 (CEST)
Date: Mon, 09 Jun 2008 11:42:41 +0200
From: Peter Czanik <pczanik@fang.fa.gau.hu>
Subject: Re: Default flats for running dtc from kernel build
In-reply-to: <A005B9E2-9A1D-4190-AB00-A7C880E4DBDB@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Message-id: <484CFB11.1080400@fang.fa.gau.hu>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <20080606143347.B35CC247FE@gemini.denx.de>
	<A005B9E2-9A1D-4190-AB00-A7C880E4DBDB@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Kumar Gala írta:
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index c40fb82..52db85a 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -29,6 +29,8 @@ ifdef CONFIG_DEBUG_INFO
>  BOOTCFLAGS     += -g
>  endif
>
> +DTS_FLAGS      ?= -R4 -S 0x3000
> +
>  ifeq ($(call cc-option-yn, -fstack-protector),y)
>  BOOTCFLAGS     += -fno-stack-protector
>  endif
I have a 8610 standing next to my desk with U-Boot 1.3.0 (Mar 13 2008 - 
10:14:26). It came with 2.6.23. I wanted to compile a kernel from the 
latest available kernel sources ( 2.6.26-RC5-git2 ). I compiled it using 
mpc8610_hpcd_defconfig. I also did a make mpc8610_hpcd.dtb to have a 
matching dtb file for the kernel. This is how far it gets:

=> boot

11032 bytes read

1708346 bytes read
## Booting image at 01000000 ...
  Image Name:   Linux-2.6.26-rc5-git2-czp7
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
  Data Size:    1708282 Bytes =  1.6 MB
  Load Address: 00000000
  Entry Point:  00000000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK
  Booting using the fdt at 0xc00000
  Loading Device Tree to 007fb000, end 007fdb17 ... OK

When I use the 2.6.26 kernel, but the original dtb file from the BSP, 
then I get two more lines on the serial console:

pci@8000 first_busno=0 last_busno=0
pcie@9000 first_busno=0 last_busno=0

So I suspected, that this might be something with the dtb file. This is 
when I ran into this thread. I tried all the different options for 
DTS_FLAGS to generate a working dtb file, but I got the same result, 
"Loading Device Tree to 007fb000, end 007fdb17 ... OK" was the last line 
on screen. Any additional ideas, how to create a working dtb file for 
the 8610 board for later kernels?

Bye,
CzP

Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rM1NP0ZTWzDq7s
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jun 2016 10:01:57 +1000 (AEST)
Message-ID: <1464998513.22191.38.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Giuseppe Lippolis <giu.lippolis@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 03 Jun 2016 19:01:53 -0500
In-Reply-To: <004201d1b85c$75353ba0$5f9fb2e0$@gmail.com>
References: <004201d1b85c$75353ba0$5f9fb2e0$@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: problem with cuImage.mpc834x_mds image
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-05-27 at 23:12 +0200, Giuseppe Lippolis wrote:
> Dear All,
> I'm trying with buildroot to build the linux-4.4.3 for an iomega 150d
> machine mounting the mpc8347E sys.
> Due the old U-Boot version is not possible to use the standard uImage, but
> it is needed to set the cuImage target (the one embedding the device tree).
> 
> I start using the default configuration
> arch/powerpc/configs/mpc83xx_defconfig,
> and the default device tree mpc834x_mds.
> 
> In order to enable the console  output during the first linux boot stage I
> added the following line at the end of the device tree file:
> 
>         chosen {
>                 linux,stdout-path = "/soc8349/serial at 4500";
>         };
> 
> The kernel is compiled and I get the cuImage.mpc834x_mds image.
> 
> Then I load it on the machine and execute:
> 
> tftp 0x10000000 cuImage.mpc834x_mds
> Speed: 1000, full duplex
> Using Freescale TSEC0 device
> TFTP from server 192.168.178.36; our IP address is 192.168.178.10
> Filename 'cuImage.mpc834x_mds'.
> Load address: 0x10000000
> Loading: #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          ################################
> done
> Bytes transferred = 2157489 (20ebb1 hex)
> IOMEGA=> bootm 0x10000000
> ## Booting image at 10000000 ...
>    Image Name:   Linux-4.4.3
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    2157425 Bytes =  2.1 MB
>    Load Address: 00500000
>    Entry Point:  005001f8
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Memory <- <0x0 0x20000000> (512MB)
> ethernet0: local-mac-address <- 00:d0:b8:01:d1:9f
> ethernet1: local-mac-address <- 9b:e3:00:01:72:6f
> CPU clock-frequency <- 0x179a7b00 (396MHz)
> CPU timebase-frequency <- 0x3ef1480 (66MHz)
> CPU bus-frequency <- 0xfbc5200 (264MHz)
> 
> zImage starting: loaded at 0x00500000 (sp: 0x1ffb2ce8)
> Allocating 0x439a88 bytes for kernel ...
> gunzipping (0x00000000 <- 0x0050e000:0x00940fe8)...done 0x422920 bytes
> 
> Linux/PowerPC load: root=/dev/mtdblock1 ro rootfstype=cramfs devfs=mount
> console=ttyS0,115200 init=/linuxrc
> Finalizing device tree... flat tree at 0x94d120
> 
> 
> But at this point the process crash and the system is reset.
> It should be something near the handover between the first kenel boot stage
> and the vmlinux start, but I do not have a jtag to proceed the
> investigation.
>
> In any case it seems that the execution never entry the vmlinux start
> (head_32.S).
> 
> I try to add this macro at the begin of the file:
> 
>         .equ cnsladdr, 0xe0004500 (console address txreg)
> 
> .macro dbg_prnt nid
>         lis     r24, cnsladdr at ha
>         addi    r24, r24, cnsladdr at l
>         li      r25, 'd'
>         stb     r25, 0(r24)
>         li      r25, 'b'
>         stb     r25, 0(r24)
>         li      r25, 'g'
>         stb     r25, 0(r24)
>         li      r25, '0'
>         addi    r25, r25, \nid
>         stb     r25, 0(r24)
>         li      r25, '\n'
>         stb     r25, 0(r24)
> .endm
> 
> 
> But I do not see anything in the console.

Have you tried inserting a loop to wait until the transmitter is empty before
sending a character?

> The problem seems releted to the vmlinux call in arc/powerpc/boot/main.c
> 
> kentry = (kernel_entry_t) vmlinux.addr;
> 
> 
> Any suggestion?

Check (with serial output) that flow control reaches the very end of the
bootwrapper before it jumps to Linux.  Use the same code that you use in
head.S (with loop added in both cases).  Print the entry address, and some
bytes loaded from that address to confirm the image is there.  Check that the
BATs are set up correctly, etc.

-Scott

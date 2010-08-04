Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 9C1DCB70B4
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 16:00:36 +1000 (EST)
Received: by iwn33 with SMTP id 33so1884102iwn.15
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Aug 2010 23:00:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimWYeRtN+Bcw-vG2G1j-D3FFmaUW7cnpvL+e=yN@mail.gmail.com>
References: <AANLkTinKb8E_McVAv5epg+4acb8H1+8HNsKHJYDr9B10@mail.gmail.com>
	<20100730120424.6db4139f@schlenkerla.am.freescale.net>
	<AANLkTim0pD9LWEgWjX4QvqUkZkYO3YOeELz_XjNJPDft@mail.gmail.com>
	<AANLkTi=mq_vnUkrdmTeKjtfO3DQLKRESxzEBiK3jeTpV@mail.gmail.com>
	<AANLkTimWYeRtN+Bcw-vG2G1j-D3FFmaUW7cnpvL+e=yN@mail.gmail.com>
Date: Tue, 3 Aug 2010 23:00:34 -0700
Message-ID: <AANLkTinhxPfhLheg25JhDsVYYk9j0OgTbCN-3KPT61P-@mail.gmail.com>
Subject: Re: ramdisk size is larger than 4MB
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I did more debugging and something is really weird though. When the
> link address is changed to 0x800000, when stepping through the kernel,
> I actually got the kernel boot successfully. However I let the kernel
> run through it would just crash. After crash the BDI2000 shows it
> stopped at __delay().

Well, actually it's nothing to do with gdb.

When the link address is changed to 0x800000, if the PPC_EARLY_DEBUG
and PPC_EARLY_DEBUG_CPM are on, the built kernel can boot
successfully. But without these EARLY_DEBUG, the kernel fails to boot.

=> bootm 5000000
## Booting image at 05000000 ...
   Image Name:   Linux-2.6.33.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1757354 Bytes =  1.7 MB
   Load Address: 00800000
   Entry Point:  00800554
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x8000000> (128MB)
ENET0: local-mac-address <- 00:09:9b:01:58:64
CPU clock-frequency <- 0x7270e00 (120MHz)
CPU timebase-frequency <- 0x7270e0 (8MHz)
CPU bus-frequency <- 0x3938700 (60MHz)

zImage starting: loaded at 0x00800000 (sp: 0x07d1cbd0)
Allocating 0x3a15a4 bytes for kernel ...
gunzipping (0x00000000 <- 0x0080c000:0x00bd702c)...done 0x3886ec bytes

Linux/PowerPC load: root=/dev/ram
Finalizing device tree... flat tree at 0xbe4300
^^^^^^^^^^^^^^^^^^The kernel stopped here.

=> bootm 5000000
## Booting image at 05000000 ...
   Image Name:   Linux-2.6.33.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1757742 Bytes =  1.7 MB
   Load Address: 00800000
   Entry Point:  00800554
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x8000000> (128MB)
ENET0: local-mac-address <- 00:09:9b:01:58:64
CPU clock-frequency <- 0x7270e00 (120MHz)
CPU timebase-frequency <- 0x7270e0 (8MHz)
CPU bus-frequency <- 0x3938700 (60MHz)

zImage starting: loaded at 0x00800000 (sp: 0x07d1cbd0)
Allocating 0x3a15a4 bytes for kernel ...
gunzipping (0x00000000 <- 0x0080c000:0x00bd702c)...done 0x3886ec bytes

Linux/PowerPC load: root=/dev/ram
Finalizing device tree... flat tree at 0xbe4300
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
Using My MPC870 machine description
Linux version 2.6.33.5 (shanw@ubuntu) (gcc version 4.2.2) #5 Tue Aug 3
21:24:40 PDT 2010
bootconsole [udbg0] enabled
^^^^^^^^^The kernel continued booting.

With the EARLY_DEBUG turned on, the link address is changed to
0x1000000, the built kernel can also boot successfully.

However if the link address is changed to 0x2000000 or 0x4000000, the
built kernel fails to boot.

I think the kernel failure may be caused by some memory corruption.
But will the bootwrapper relocation corrupt the kernel code?

Thanks,
-Shawn.

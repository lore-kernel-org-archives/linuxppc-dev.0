Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3D7ACB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 01:48:31 +1000 (EST)
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 855C8DDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 01:48:29 +1000 (EST)
Date: Fri, 7 Aug 2009 17:48:26 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: sequoia: The final kernel image would overwrite the device
 tree
In-Reply-To: <alpine.LRH.2.00.0907281524510.29006@vixen.sonytel.be>
Message-ID: <alpine.LRH.2.00.0908071740410.22357@vixen.sonytel.be>
References: <alpine.LRH.2.00.0907281524510.29006@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Jul 2009, Geert Uytterhoeven wrote:
> Current kernel (2.6.31-rc4) fails to boot on sequoia:
> 
> | ## Booting image at 00100000 ...
> |    Image Name:   Linux-2.6.31-rc4-00003-g52c6890-
> |    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> |    Data Size:    1680490 Bytes =  1.6 MB
> |    Load Address: 00400000
> |    Entry Point:  00400458
> |    Verifying Checksum ... OK
> |    Uncompressing Kernel Image ... OK
> | CPU clock-frequency <- 0x27bc86a4 (667MHz)
> | CPU timebase-frequency <- 0x27bc86a4 (667MHz)
> | /plb: clock-frequency <- 9ef21a9 (167MHz)
> | /plb/opb: clock-frequency <- 4f790d4 (83MHz)
> | /plb/opb/ebc: clock-frequency <- 34fb5e3 (56MHz)
> | /plb/opb/serial@ef600300: clock-frequency <- a8c000 (11MHz)
> | /plb/opb/serial@ef600400: clock-frequency <- a8c000 (11MHz)
> | /plb/opb/serial@ef600500: clock-frequency <- 42ecac (4MHz)
> | /plb/opb/serial@ef600600: clock-frequency <- 42ecac (4MHz)
> | Memory <- <0x0 0x0 0xffff000> (255MB)
> | ethernet0: local-mac-address <- 00:10:ec:00:f1:df
> | ethernet1: local-mac-address <- 00:10:ec:80:f1:df
> | 
> | zImage starting: loaded at 0x00400000 (sp: 0x0ff2ba18)
> | Allocating 0x85e77c bytes for kernel ...
> | The final kernel image would overwrite the device tree?
> 
> Git bisect told me the bad guy is:
> 
> | commit 5d38902c483881645ba16058cffaa478b81e5cfa
> | Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> | Date:   Wed Jun 17 17:43:59 2009 +0000
> | 
> |     powerpc: Add irqtrace support for 32-bit powerpc
> 
> However, disabling CONFIG_PROVE_LOCKING also fixes the problem.

I did some more investigations.

If CONFIG_PROVE_LOCKING is not set:

| zImage starting: loaded at 0x00400000 (sp: 0x0ff2b670)
| Allocating 0x74a764 bytes for kernel ...
| platform_ops.vmlinux_alloc = 0x00000000
| _end = 0x78e000
| gunzipping (0x00000000 <- 0x0040e000:0x00781b34)...done 0x360460 bytes

and the rest of the kernel boots (note: it hangs later on with "BUG: spinlock
lockup on CPU#0, swapper/1, cf8b6908" with today's kernel, will look into
that later).

However, nm says _end = c074b000?


If CONFIG_PROVE_LOCKING=y:

| zImage starting: loaded at 0x00400000 (sp: 0x0ff2ba18)
| Allocating 0x85e784 bytes for kernel ...
| platform_ops.vmlinux_alloc = 0x00000000
| _end = 0x792000
| The final kernel image would overwrite the device tree?

and it reboots.

However, nm says _end = c085f000.

So in both cases _end is not correct in arch/powerpc/boot/main.c:prep_kernel()?
But depending on CONFIG_PROVE_LOCKING, the test for
((unsigned long)_end < ei.memsize) gives different results, and the kernel
boots or doesn't boot?

  
With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010

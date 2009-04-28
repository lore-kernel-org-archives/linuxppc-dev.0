Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26C06DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 15:00:56 +1000 (EST)
Date: Tue, 28 Apr 2009 14:10:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: John Williams <john.williams@petalogix.com>
Subject: Re: microblaze: Statically linking device tree blobs into the kernel
Message-ID: <20090428041028.GB11265@yookeroo.seuss>
References: <1d3f23370904262124l444bc30dmf4178930f4a2b82f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1d3f23370904262124l444bc30dmf4178930f4a2b82f@mail.gmail.com>
Cc: Michal Simek <michal.simek@petalogix.com>,
	microblaze-uclinux@itee.uq.edu.au,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2009 at 02:24:42PM +1000, John Williams wrote:
> To MicroBlazers and other interested parties:
> 
> Currently the MicroBlaze kernel boot-time ABI requires r7 to point to
> a valid DTB, whereupon in early kernel setup the DTB is copied to a
> statically allocated 16k memory region inside the kernel. From there
> it is later queried by the platform startup code.
> 
> For simple boot scenarios the ability to statically bind a DTB into
> the kernel image would clearly be useful.  In PPC land, this is
> achieved through the simpleboot bootloader that lives in
> arch/powerpc/boot.  The DTB becomes part of the simpleboot payload,
> and is passed to the kernel through the normal means.
> 
> I'm not convinced duplicating this for MicroBlaze is a good idea, I
> think it would be overkill.  However, the make syntax that PPC uses to
> achieve DTB binding is quite nice:
> 
> $ make simpleImage.<board>
> 
> which binds arch/powerpc/boot/dts/<board>.dts into the boot payload.
> 
> My feeling is that we should make use of the fact that the DTB region
> is statically allocated in the MicroBlaze kernel anyway.  From
> arch/microblaze/kernel/vmlinux.lds.S:
> 
>         . = ALIGN (4) ;
>        _fdt_start = . ; /* place for fdt blob */
>        . = . + 0x4000;
>        _fdt_end = . ;
> 
> and in head.S, the DTB at r7 is copied into place at _fdt_start
> 
> /* save fdt to kernel location */
> /* r7 stores pointer to fdt blob */
>         beqi    r7, no_fdt_arg
>         or      r11, r0, r0 /* incremment */
>         ori     r4, r0, TOPHYS(_fdt_start) /* save bram context */
>         ori     r3, r0, (0x4000 - 4)
> _copy_fdt:
>        <simple copy loop>
> no_fdt_arg:
> 
> Since this memory is already allocated in the kernel image but is
> normally just zeros, to bind a DTB to the kernel we could just store
> it in-situ.  This way, if a non-zero r7 is passed in at boot time,
> head.S will naturally overwrite (and thus override) the "default" DTB
> that was inside the kernel image.
> 
> What I'm not so sure about is how best to achieve this in the kbuild
> sequence.  I see two options:
> 
>  (a) use .incbin in a .S file, similar to how the initramfs gets
> linked in in /usr/Makefile etc, or

Or you could build the .dts directly into a .S file (which dtc
supports) and #include or link that in.  It's possible the dtc asm
output mode would need some work, but that's easily enough done.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

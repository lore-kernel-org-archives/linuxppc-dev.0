Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id F2A29DDDA9
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 23:47:41 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1158851ywt.39
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 06:47:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1d3f23370904262124l444bc30dmf4178930f4a2b82f@mail.gmail.com>
References: <1d3f23370904262124l444bc30dmf4178930f4a2b82f@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 27 Apr 2009 07:47:25 -0600
Message-ID: <fa686aa40904270647j1ac083d0t6328e9d5de3b84c9@mail.gmail.com>
Subject: Re: microblaze: Statically linking device tree blobs into the kernel
To: John Williams <john.williams@petalogix.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Sun, Apr 26, 2009 at 10:24 PM, John Williams
<john.williams@petalogix.com> wrote:
> To MicroBlazers and other interested parties:
>
> Currently the MicroBlaze kernel boot-time ABI requires r7 to point to
> a valid DTB, whereupon in early kernel setup the DTB is copied to a
> statically allocated 16k memory region inside the kernel. From there
> it is later queried by the platform startup code.
>
> For simple boot scenarios the ability to statically bind a DTB into
> the kernel image would clearly be useful. =A0In PPC land, this is
> achieved through the simpleboot bootloader that lives in
> arch/powerpc/boot. =A0The DTB becomes part of the simpleboot payload,
> and is passed to the kernel through the normal means.
>
> I'm not convinced duplicating this for MicroBlaze is a good idea, I
> think it would be overkill. =A0However, the make syntax that PPC uses to
> achieve DTB binding is quite nice:
>
> $ make simpleImage.<board>
>
> which binds arch/powerpc/boot/dts/<board>.dts into the boot payload.
>
> My feeling is that we should make use of the fact that the DTB region
> is statically allocated in the MicroBlaze kernel anyway. =A0From
> arch/microblaze/kernel/vmlinux.lds.S:
>
> =A0 =A0 =A0 =A0. =3D ALIGN (4) ;
> =A0 =A0 =A0 _fdt_start =3D . ; /* place for fdt blob */
> =A0 =A0 =A0 . =3D . + 0x4000;
> =A0 =A0 =A0 _fdt_end =3D . ;
>
> and in head.S, the DTB at r7 is copied into place at _fdt_start
>
> /* save fdt to kernel location */
> /* r7 stores pointer to fdt blob */
> =A0 =A0 =A0 =A0beqi =A0 =A0r7, no_fdt_arg
> =A0 =A0 =A0 =A0or =A0 =A0 =A0r11, r0, r0 /* incremment */
> =A0 =A0 =A0 =A0ori =A0 =A0 r4, r0, TOPHYS(_fdt_start) /* save bram contex=
t */
> =A0 =A0 =A0 =A0ori =A0 =A0 r3, r0, (0x4000 - 4)
> _copy_fdt:
> =A0 =A0 =A0 <simple copy loop>
> no_fdt_arg:
>
> Since this memory is already allocated in the kernel image but is
> normally just zeros, to bind a DTB to the kernel we could just store
> it in-situ. =A0This way, if a non-zero r7 is passed in at boot time,
> head.S will naturally overwrite (and thus override) the "default" DTB
> that was inside the kernel image.
>
> What I'm not so sure about is how best to achieve this in the kbuild
> sequence. =A0I see two options:
>
> =A0(a) use .incbin in a .S file, similar to how the initramfs gets
> linked in in /usr/Makefile etc, or
> =A0(b) use objcopy to manipulate vmlinux after final link, by directly
> inserting the DTB into the appropriate ELF section.
>
> (a) seems nice because it means that our standard make targets, such
> as linux.bin etc, would still work unchanged. =A0(b) seems to go a bit
> against the grain of kbuild, but maybe I'm wrong there.
>
> I've hacked around with (a) a bit, part of the problem is that it
> seems arch/microblaze/Makefile would need something like

I'm partial to (a)too , but I don't know how to achieve it in Kbuild.
Using the linker means that even large .dtb files will get handled
gracefully.

> core-y +=3D arch/microblaze/boot
>
> because the DTB "object file" must be ready before final vmlinux link.

Which works fine with the .dtb list is in the list of default targets,
but is harder for miscellaneous 'make simpleimage.<board>' usage.  You
could I suppose duplicate the vmlinux target as simpleimage.% (or
whatever name makes sense) and have the kernel be relinked for each
target provided.  In fact, this might be the only way to do (a).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

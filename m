Return-Path: <hkallweit1@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stB3m6NkqzDskZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 07:07:00 +1100 (AEDT)
Received: by mail-lf0-x244.google.com with SMTP id p80so33284lfp.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 13:07:00 -0700 (PDT)
Subject: Re: Commit 1b7898ee276b "powerpc/boot: Use the pre-boot decompression
 API" breaks boot
To: Michael Ellerman <mpe@ellerman.id.au>, Oliver O'Halloran <oohall@gmail.com>
References: <8db8ecac-4022-7df9-4e81-3d490c50821d@gmail.com>
 <CAOSf1CFVX8j+kyp3SRhRz_gyPiQ3R9x=_nJyq9fr31NyGi3hhg@mail.gmail.com>
 <c19153b9-7554-0280-6d97-750c9e62b3be@gmail.com>
 <80c9c42c-45d3-9f24-b3e1-5a5042686b1b@gmail.com>
 <877f9g7r4l.fsf@concordia.ellerman.id.au>
 <62241a1e-51c0-c1cd-1ecd-fa54a3842da0@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <0a0d0909-cee3-f375-4cf4-75f0beb5b8b7@gmail.com>
Date: Mon, 10 Oct 2016 22:06:48 +0200
MIME-Version: 1.0
In-Reply-To: <62241a1e-51c0-c1cd-1ecd-fa54a3842da0@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 10.10.2016 um 08:10 schrieb Heiner Kallweit:
> Am 10.10.2016 um 06:41 schrieb Michael Ellerman:
>> Heiner Kallweit <hkallweit1@gmail.com> writes:
>>
>>> Am 07.10.2016 um 21:26 schrieb Heiner Kallweit:
>>>> Am 07.10.2016 um 07:51 schrieb Oliver O'Halloran:
>>>>> Hi, Heiner
>>>>>
>>>>> Could you send me a copy of the kernel .config (or which defconfig)
>>>>> that you're using, the name of the HW platform that you're using and
>>>>> if possible the kernel image itself?
>>>>>
>>>>> Thanks,
>>>>> Oliver
>>>>>
>>>> Thanks for the quick reply. Attached are .config and cuImage.
>>>> HW is a TP-Link TL-WDR4900 WiFi router (P1014-based) running OpenWRT.
>>>>
>>> After further checking I think I found the issue. The old gunzip code
>>> handled uncompressed data transparently whilst the new one bails out
>>> if it doesn't find a proper gzip header.
>>> And in my case the actual kernel image is uncompressed.
>>> With the following patch the system boots fine again (at least for me).
>>
>> Thanks for testing and tracking it down.
>>
>> I wonder why the actual image is uncompressed? Or alternately why do we
>> tell uboot the image is compressed when it's not?
>>
> Uboot is provided with a compressed image, but what gets compressed is
> not the pure kernel image but the resulting image incl. boot wrapper code,
> see this part of the wrapper script:
> 
> cuboot*)
>     gzip -n -f -9 "$ofile"
>     ${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
>             $uboot_version -d "$ofile".gz "$ofile"
> 
> And this resulting image is decompressed by uboot already during boot.
> Therefore the boot wrapper code sees an uncompressed kernel image.
> 
> IMHO in case of using cuboot no CONFIG_KERNEL_<COMPR TYPE> config option
> should be set and Makefile + code in arch/powerpc/boot should be able
> to deal with this situation:
> - don't copy and build the decompression stuff
> - use an alternative version of prep_kernel() in main.c which doesn't
>   attempt to decompress the kernel image
> 
> This should be a cleaner solution than probing the kernel image whether
> it's compressed or not.
> 

This would be the patch implementing the idea. Advantage is that all
the unnecessary decompression code isn't built. Works fine for me.

---
 arch/powerpc/boot/Makefile |  7 ++++++-
 arch/powerpc/boot/main.c   | 15 ++++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index eae2dc8..1f18847 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -19,6 +19,7 @@
 
 all: $(obj)/zImage
 
+compress-y                     := CONFIG_KERNEL_UNCOMPRESSED
 compress-$(CONFIG_KERNEL_GZIP) := CONFIG_KERNEL_GZIP
 compress-$(CONFIG_KERNEL_XZ)   := CONFIG_KERNEL_XZ
 
@@ -95,12 +96,15 @@ libfdtheader := fdt.h libfdt.h libfdt_internal.h
 $(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o): \
 	$(addprefix $(obj)/,$(libfdtheader))
 
-src-wlib-y := string.S crt0.S crtsavres.S stdio.c decompress.c main.c \
+src-wlib-y := string.S crt0.S crtsavres.S stdio.c main.c \
 		$(libfdt) libfdt-wrapper.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		elf_util.c $(zlib-y) devtree.c stdlib.c \
 		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
 		uartlite.c mpc52xx-psc.c opal.c opal-calls.S
+ifneq ($(compress-y),CONFIG_KERNEL_UNCOMPRESSED)
+src-wlib-y += decompress.c
+endif
 src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
 src-wlib-$(CONFIG_44x) += 4xx.c ebony.c bamboo.c
 src-wlib-$(CONFIG_8xx) += mpc8xx.c planetcore.c fsl-soc.c
@@ -226,6 +230,7 @@ CROSSWRAP := -C "$(CROSS_COMPILE)"
 endif
 endif
 
+compressor-y                     := none
 compressor-$(CONFIG_KERNEL_GZIP) := gz
 compressor-$(CONFIG_KERNEL_XZ)   := xz
 
diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index f7a184b..5a28c18 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -28,14 +28,19 @@ static struct addr_range prep_kernel(void)
 {
 	char elfheader[256];
 	unsigned char *vmlinuz_addr = (unsigned char *)_vmlinux_start;
-	unsigned long vmlinuz_size = _vmlinux_end - _vmlinux_start;
 	void *addr = 0;
 	struct elf_info ei;
+#ifndef CONFIG_KERNEL_UNCOMPRESSED
+	unsigned long vmlinuz_size = _vmlinux_end - _vmlinux_start;
 	long len;
+#endif
 
+#ifdef CONFIG_KERNEL_UNCOMPRESSED
+	memcpy(elfheader, vmlinuz_addr, sizeof(elfheader));
+#else
 	partial_decompress(vmlinuz_addr, vmlinuz_size,
 		elfheader, sizeof(elfheader), 0);
-
+#endif
 	if (!parse_elf64(elfheader, &ei) && !parse_elf32(elfheader, &ei))
 		fatal("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
 
@@ -67,6 +72,10 @@ static struct addr_range prep_kernel(void)
 					"device tree\n\r");
 	}
 
+#ifdef CONFIG_KERNEL_UNCOMPRESSED
+	memcpy(addr, vmlinuz_addr + ei.elfoffset, ei.loadsize);
+	printf("%ld bytes of uncompressed data copied\n\r", ei.loadsize);
+#else
 	/* Finally, decompress the kernel */
 	printf("Decompressing (0x%p <- 0x%p:0x%p)...\n\r", addr,
 	       vmlinuz_addr, vmlinuz_addr+vmlinuz_size);
@@ -82,7 +91,7 @@ static struct addr_range prep_kernel(void)
 			 len, ei.loadsize);
 
 	printf("Done! Decompressed 0x%lx bytes\n\r", len);
-
+#endif
 	flush_cache(addr, ei.loadsize);
 
 	return (struct addr_range){addr, ei.memsize};
-- 
2.10.0

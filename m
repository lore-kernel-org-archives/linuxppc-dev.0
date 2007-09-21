Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by ozlabs.org (Postfix) with ESMTP id 144C5DDEA2
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 03:31:20 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so731998nzh
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 10:31:17 -0700 (PDT)
Message-ID: <fa686aa40709211031t687310fdk9ca703ea8cf759e7@mail.gmail.com>
Date: Fri, 21 Sep 2007 11:31:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 08/10] bootwrapper: Add a firmware-independent "raw"
	target.
In-Reply-To: <20070905192116.GH32113@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
	<20070905192116.GH32113@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/5/07, Scott Wood <scottwood@freescale.com> wrote:
> This target produces a flat binary rather than an ELF file,
> fixes the entry point at the beginning of the image, and takes
> a complete device tree with no fixups needed.
>
> The device tree must have labels on /#address-cells, the timebase
> frequency, and the memory size.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 02f0fe0..2a6a4c6 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -48,7 +48,8 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
>                 cpm-serial.c stdlib.c planetcore.c
>  src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
>                 cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
> -               ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c cuboot-pq2.c
> +               ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c \
> +               cuboot-8xx.c cuboot-pq2.c fixed-head.S raw-platform.c
>  src-boot := $(src-wlib) $(src-plat) empty.c
>
>  src-boot := $(addprefix $(obj)/, $(src-boot))
> @@ -146,6 +147,7 @@ image-$(CONFIG_PPC_83xx)            += cuImage.83xx
>  image-$(CONFIG_PPC_85xx)               += cuImage.85xx
>  image-$(CONFIG_EBONY)                  += treeImage.ebony cuImage.ebony
>  image-$(CONFIG_BAMBOO)                 += treeImage.bamboo
> +image-$(CONFIG_BUILD_RAW_IMAGE)                += zImage.raw
>  endif
>
>  # For 32-bit powermacs, build the COFF and miboot images

Are these makefile changes complete?  When I attempt to compile with
this patch I get the following error:

grant@trillian:~/hacking/linux-2.6$ ppc4xx make
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
make[1]: *** No rule to make target `arch/powerpc/boot/zImage.raw',
needed by `arch/powerpc/boot/zImage'.  Stop.
make: *** [zImage] Error 2
grant@trillian:~/hacking/linux-2.6$

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

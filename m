Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0115.outbound.protection.outlook.com [157.56.111.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E0061A0851
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 07:42:45 +1100 (AEDT)
Message-ID: <1449520948.15946.89.camel@freescale.com>
Subject: Re: [PATCH v2 3/3] ppc64: Add a flag to tell the kernel it's
 booting from kexec
From: Scott Wood <scottwood@freescale.com>
To: Simon Horman <horms@verge.net.au>
CC: <kexec@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>
Date: Mon, 7 Dec 2015 14:42:28 -0600
In-Reply-To: <1444172150-29493-3-git-send-email-scottwood@freescale.com>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
 <1444172150-29493-3-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-06 at 17:55 -0500, Scott Wood wrote:
> It needs to know this because the SMP release mechanism for Freescale
> book3e is different from when booting with normal hardware.  In theory
> we could simulate the normal spin table mechanism, but not (easily) at
> the addresses U-Boot put in the device tree -- so there'd need to be
> even more communication between the kernel and kexec to set that up.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v2: Use a device tree property rather than setting a flag in the kernel
> image, as requested by Michael Ellerman.

ping?

Michael, can you review this?  Simon is waiting for another PPC person to
review it.

-Scott

> ---
>  kexec/arch/ppc64/Makefile           |  6 +++
>  kexec/arch/ppc64/fdt.c              | 78
> +++++++++++++++++++++++++++++++++++++
>  kexec/arch/ppc64/include/arch/fdt.h |  9 +++++
>  kexec/arch/ppc64/kexec-elf-ppc64.c  |  7 ++++
>  4 files changed, 100 insertions(+)
>  create mode 100644 kexec/arch/ppc64/fdt.c
>  create mode 100644 kexec/arch/ppc64/include/arch/fdt.h
> 
> diff --git a/kexec/arch/ppc64/Makefile b/kexec/arch/ppc64/Makefile
> index 9a6e475..37cd233 100644
> --- a/kexec/arch/ppc64/Makefile
> +++ b/kexec/arch/ppc64/Makefile
> @@ -1,11 +1,15 @@
>  #
>  # kexec ppc64 (linux booting linux)
>  #
> +include $(srcdir)/kexec/libfdt/Makefile.libfdt
> +
>  ppc64_KEXEC_SRCS =  kexec/arch/ppc64/kexec-elf-rel-ppc64.c
>  ppc64_KEXEC_SRCS += kexec/arch/ppc64/kexec-zImage-ppc64.c
>  ppc64_KEXEC_SRCS += kexec/arch/ppc64/kexec-elf-ppc64.c
>  ppc64_KEXEC_SRCS += kexec/arch/ppc64/kexec-ppc64.c
>  ppc64_KEXEC_SRCS += kexec/arch/ppc64/crashdump-ppc64.c
> +ppc64_KEXEC_SRCS += kexec/arch/ppc64/fdt.c
> +ppc64_KEXEC_SRCS += $(LIBFDT_SRCS:%=kexec/libfdt/%)
>  
>  ppc64_ARCH_REUSE_INITRD =
>  
> @@ -13,6 +17,8 @@ ppc64_FS2DT	    = kexec/fs2dt.c
>  ppc64_FS2DT_INCLUDE = -include $(srcdir)/kexec/arch/ppc64/crashdump-ppc64.h
> \
>                        -include $(srcdir)/kexec/arch/ppc64/kexec-ppc64.h
>  
> +ppc64_CPPFLAGS = -I$(srcdir)/kexec/libfdt
> +
>  dist += kexec/arch/ppc64/Makefile $(ppc64_KEXEC_SRCS)			
> \
>  	kexec/arch/ppc64/kexec-ppc64.h kexec/arch/ppc64/crashdump-ppc64.h \
>  	kexec/arch/ppc64/include/arch/options.h
> diff --git a/kexec/arch/ppc64/fdt.c b/kexec/arch/ppc64/fdt.c
> new file mode 100644
> index 0000000..8bc6d2d
> --- /dev/null
> +++ b/kexec/arch/ppc64/fdt.c
> @@ -0,0 +1,78 @@
> +/*
> + * ppc64 fdt fixups
> + *
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation (version 2 of the License).
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <arch/fdt.h>
> +#include <libfdt.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +/*
> + * Let the kernel know it booted from kexec, as some things (e.g.
> + * secondary CPU release) may work differently.
> + */
> +static int fixup_kexec_prop(void *fdt)
> +{
> +	int err, nodeoffset;
> +
> +	nodeoffset = fdt_subnode_offset(fdt, 0, "chosen");
> +	if (nodeoffset < 0)
> +		nodeoffset = fdt_add_subnode(fdt, 0, "chosen");
> +	if (nodeoffset < 0) {
> +		printf("%s: add /chosen %s\n", __func__,
> +		       fdt_strerror(nodeoffset));
> +		return -1;
> +	}
> +
> +	err = fdt_setprop(fdt, nodeoffset, "linux,booted-from-kexec",
> +			  NULL, 0);
> +	if (err < 0) {
> +		printf("%s: couldn't write linux,booted-from-kexec: %s\n",
> +		       __func__, fdt_strerror(err));
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +/*
> + * For now, assume that the added content fits in the file.
> + * This should be the case when flattening from /proc/device-tree,
> + * and when passing in a dtb, dtc can be told to add padding.
> + */
> +int fixup_dt(char **fdt, off_t *size)
> +{
> +	int ret;
> +
> +	*size += 4096;
> +	*fdt = realloc(*fdt, *size);
> +	if (!*fdt) {
> +		fprintf(stderr, "%s: out of memory\n", __func__);
> +		return -1;
> +	}
> +
> +	ret = fdt_open_into(*fdt, *fdt, *size);
> +	if (ret < 0) {
> +		fprintf(stderr, "%s: fdt_open_into: %s\n", __func__,
> +			fdt_strerror(ret));
> +		return -1;
> +	}
> +
> +	ret = fixup_kexec_prop(*fdt);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> diff --git a/kexec/arch/ppc64/include/arch/fdt.h
> b/kexec/arch/ppc64/include/arch/fdt.h
> new file mode 100644
> index 0000000..14f8be2
> --- /dev/null
> +++ b/kexec/arch/ppc64/include/arch/fdt.h
> @@ -0,0 +1,9 @@
> +#ifndef KEXEC_ARCH_PPC64_FDT
> +#define KEXEC_ARCH_PPC64_FDT
> +
> +#include <sys/types.h>
> +
> +int fixup_dt(char **fdt, off_t *size);
> +
> +#endif
> +
> diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf
> -ppc64.c
> index adcee4c..ddd3de8 100644
> --- a/kexec/arch/ppc64/kexec-elf-ppc64.c
> +++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
> @@ -37,6 +37,8 @@
>  #include "kexec-ppc64.h"
>  #include "../../fs2dt.h"
>  #include "crashdump-ppc64.h"
> +#include <libfdt.h>
> +#include <arch/fdt.h>
>  #include <arch/options.h>
>  
>  uint64_t initrd_base, initrd_size;
> @@ -242,6 +244,11 @@ int elf_ppc64_load(int argc, char **argv, const char
> *buf, off_t len,
>  		/* create from fs2dt */
>  		create_flatten_tree(&seg_buf, &seg_size, cmdline);
>  	}
> +
> +	result = fixup_dt(&seg_buf, &seg_size);
> +	if (result < 0)
> +		return result;
> +
>  	my_dt_offset = add_buffer(info, seg_buf, seg_size, seg_size,
>  				0, 0, max_addr, -1);
>  

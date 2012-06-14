Return-Path: <jwboyer@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1336362768-31326-1-git-send-email-vhtnguyen@apm.com>
References: <1336362768-31326-1-git-send-email-vhtnguyen@apm.com>
Date: Thu, 14 Jun 2012 13:47:26 -0400
Message-ID: <CA+5PVA7vnLvqwsDAboR4s-QCLWSDm34N2tE+sFiBMsE2f=qYEg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/44x: Support OCM(On Chip Memory) for APM821xx SoC
 and Bluestone board
From: Josh Boyer <jwboyer@gmail.com>
To: Vinh Nguyen Huu Tuong <vhtnguyen@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Anatolij Gustschin <agust@denx.de>, devicetree-discuss@lists.ozlabs.org,
 Duc Dang <dhdang@apm.com>, Rob Herring <rob.herring@calxeda.com>,
 linux-kernel@vger.kernel.org, Liu Gang <Gang.Liu@freescale.com>,
 Paul Mackerras <paulus@samba.org>, Ashish Kalra <ashish.kalra@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 6, 2012 at 11:52 PM, Vinh Nguyen Huu Tuong
<vhtnguyen@apm.com> wrote:
> This patch consists of:
> - Add driver for OCM component
> - Export OCM Information at /sys/class/ocm/ocminfo

Again, apologies for the delay.  Aside from the incorrect sysfs usage
I pointed out in my other reply, I have just a few comments/questions
below.

> diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/=
bluestone.dts
> index 7bda373..2687c11 100644
> --- a/arch/powerpc/boot/dts/bluestone.dts
> +++ b/arch/powerpc/boot/dts/bluestone.dts
> @@ -107,6 +107,14 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&UIC0>;
> =A0 =A0 =A0 =A0};
>
> + =A0 =A0 =A0 OCM1: ocm@400040000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ibm,ocm";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D "ok";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configured in U-Boot */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <4 0x00040000 0x8000>; /* 32K */
> + =A0 =A0 =A0 };
> +
> =A0 =A0 =A0 =A0SDR0: sdr {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "ibm,sdr-apm821xx";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dcr-reg =3D <0x00e 0x002>;
> diff --git a/arch/powerpc/include/asm/ppc4xx_ocm.h b/arch/powerpc/include=
/asm/ppc4xx_ocm.h
> new file mode 100644
> index 0000000..ff7f386
> --- /dev/null
> +++ b/arch/powerpc/include/asm/ppc4xx_ocm.h
> @@ -0,0 +1,47 @@
> +/*
> + * PowerPC 4xx OCM memory allocation support
> + *
> + * (C) Copyright 2009, Applied Micro Circuits Corporation
> + * Victor Gallardo (vgallardo@amcc.com)
> + *
> + * See file CREDITS for list of people who contributed to this
> + * project.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA
> + */
> +
> +#ifndef __ASM_POWERPC_PPC4xx_OCM_H__
> +#define __ASM_POWERPC_PPC4xx_OCM_H__
> +
> +#include <linux/types.h>
> +
> +#define OCM_NON_CACHED 0
> +#define OCM_CACHED =A0 =A0 1
> +
> +#if defined(CONFIG_PPC4xx_OCM)
> +
> +void *ocm_alloc(phys_addr_t *phys, int size, int align,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int flags, const char *owner);
> +void ocm_free(const void *virt);
> +
> +#else
> +
> +#define ocm_alloc(phys, size, align, flags, owner) =A0 =A0 NULL
> +#define ocm_free(addr) ((void)0)
> +
> +#endif /* CONFIG_PPC4xx_OCM */
> +
> +#endif =A0/* __ASM_POWERPC_PPC4xx_OCM_H__ */

I don't see any users of this header included in the patch.  I'm going
to guess that follow-on drivers/users are queued once this is in the
tree?  Also, you might want to name these 'ppc4xx_ocm_alloc' or
similar.  The concept of OCM isn't limited to ppc4xx or even SoCs, so
just using 'ocm' in the global kernel namespace might not be great.

> diff --git a/arch/powerpc/sysdev/ppc4xx_ocm.c b/arch/powerpc/sysdev/ppc4x=
x_ocm.c
> new file mode 100644
> index 0000000..ba3e450
> --- /dev/null
> +++ b/arch/powerpc/sysdev/ppc4xx_ocm.c
> @@ -0,0 +1,420 @@
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/proc_fs.h>

Why do you need proc_fs.h?

> +#include <linux/seq_file.h>
> +#include <linux/spinlock.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/list.h>
> +#include <asm/uaccess.h>
> +#include <asm/prom.h>
> +#include <asm/dcr.h>
> +#include <asm/rheap.h>
> +#include <asm/mmu.h>
> +#include <asm/ppc4xx_ocm.h>
> +#include <linux/export.h>
> +
> +#define OCM_DISABLED =A0 0
> +#define OCM_ENABLED =A0 =A0 =A0 =A0 =A0 =A01
> +
> +struct ocm_block {
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0list;
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*addr;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 size;
> + =A0 =A0 =A0 const char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*owne=
r;
> +};
> +
> +/* non-cached or cached region */
> +struct ocm_region {
> + =A0 =A0 =A0 phys_addr_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys;
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*virt;
> +
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 memtotal;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 memfree;
> +
> + =A0 =A0 =A0 rh_info_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rh;
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0list;
> +};

There's some interesting whitespace usage in these struct definitions.

josh

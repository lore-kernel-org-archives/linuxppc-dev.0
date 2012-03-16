Return-Path: <jwboyer@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA427B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 23:41:10 +1100 (EST)
Received: by yenl1 with SMTP id l1so4244261yen.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 05:41:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1331539663-29641-1-git-send-email-mla@apm.com>
References: <1331539663-29641-1-git-send-email-mla@apm.com>
Date: Fri, 16 Mar 2012 08:41:07 -0400
Message-ID: <CA+5PVA7K66kKwKHUsNRjw9GLjvKBWgovmKPR4uOMMNFtiWfrzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] [v3] powerpc/44x: Fix PCI MSI support for Maui
 APM821xx SoC and Bluestone board
From: Josh Boyer <jwboyer@gmail.com>
To: Mai La <mla@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>, open-source-review@apm.com,
 Tirumala R Marri <tmarri@apm.com>, linux-kernel@vger.kernel.org,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2012 at 4:07 AM, Mai La <mla@apm.com> wrote:
> diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4x=
x_msi.c
> index 1c2d7af..63989d0 100644
> --- a/arch/powerpc/sysdev/ppc4xx_msi.c
> +++ b/arch/powerpc/sysdev/ppc4xx_msi.c
> @@ -28,10 +28,11 @@
> =A0#include <linux/of_platform.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/export.h>
> +#include <linux/kernel.h>
> =A0#include <asm/prom.h>
> =A0#include <asm/hw_irq.h>
> =A0#include <asm/ppc-pci.h>
> -#include <boot/dcr.h>
> +#include <asm/dcr.h>
> =A0#include <asm/dcr-regs.h>
> =A0#include <asm/msi_bitmap.h>
>
> @@ -43,13 +44,14 @@
> =A0#define PEIH_FLUSH0 =A0 =A00x30
> =A0#define PEIH_FLUSH1 =A0 =A00x38
> =A0#define PEIH_CNTRST =A0 =A00x48
> -#define NR_MSI_IRQS =A0 =A04
> +
> +int msi_irqs;

This should be static.

> =A0struct ppc4xx_msi {
> =A0 =A0 =A0 =A0u32 msi_addr_lo;
> =A0 =A0 =A0 =A0u32 msi_addr_hi;
> =A0 =A0 =A0 =A0void __iomem *msi_regs;
> - =A0 =A0 =A0 int msi_virqs[NR_MSI_IRQS];
> + =A0 =A0 =A0 int *msi_virqs;
> =A0 =A0 =A0 =A0struct msi_bitmap bitmap;
> =A0 =A0 =A0 =A0struct device_node *msi_dev;
> =A0};
> @@ -61,7 +63,7 @@ static int ppc4xx_msi_init_allocator(struct platform_de=
vice *dev,
> =A0{
> =A0 =A0 =A0 =A0int err;
>
> - =A0 =A0 =A0 err =3D msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS,
> + =A0 =A0 =A0 err =3D msi_bitmap_alloc(&msi_data->bitmap, msi_irqs,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->dev.of_no=
de);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> @@ -83,6 +85,9 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, i=
nt nvec, int type)
> =A0 =A0 =A0 =A0struct msi_desc *entry;
> =A0 =A0 =A0 =A0struct ppc4xx_msi *msi_data =3D &ppc4xx_msi;
>
> + =A0 =A0 =A0 msi_data->msi_virqs =3D kmalloc((msi_irqs) * sizeof(int),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 GFP_KERNEL);
> +

What happens if this allocation fails?  Unlikely perhaps, but we should sti=
ll
probably try and handle the error.

> =A0 =A0 =A0 =A0list_for_each_entry(entry, &dev->msi_list, list) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int_no =3D msi_bitmap_alloc_hwirqs(&msi_da=
ta->bitmap, 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (int_no >=3D 0)

<snip>

> @@ -234,6 +241,10 @@ static int __devinit ppc4xx_msi_probe(struct platfor=
m_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto error_out;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 msi_irqs =3D of_irq_count(dev->dev.of_node);
> + =A0 =A0 =A0 if (!msi_irqs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +

Maybe return -ENODEV here instead of -1?  It probably doesn't matter at the
moment, but if anything actually checked why the probe function failed, tha=
t
would be more descriptive.

josh

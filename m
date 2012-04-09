Return-Path: <mla@apm.com>
Received: from exprod5og106.obsmtp.com (exprod5og106.obsmtp.com [64.18.0.182])
 by ozlabs.org (Postfix) with SMTP id 41696B7021
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2012 14:24:21 +1000 (EST)
Received: by vbbfc26 with SMTP id fc26so2626200vbb.26
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2012 21:24:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1332129548-20379-1-git-send-email-mla@apm.com>
References: <1332129548-20379-1-git-send-email-mla@apm.com>
From: Mai La <mla@apm.com>
Date: Mon, 9 Apr 2012 11:23:58 +0700
Message-ID: <CAJ0-vuh4bRz13E35CymiWy5v_jMQ+zJS==U6bH=aJ43acEfhdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] [v4] powerpc/44x: Fix PCI MSI support for Maui
 APM821xx SoC and Bluestone board
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Tirumala R Marri <tmarri@apm.com>, Grant Likely <grant.likely@secretlab.ca>,
 Michael Neuling <mikey@neuling.org>, Kumar Gala <galak@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=00235445ba883383d404bd376136
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00235445ba883383d404bd376136
Content-Type: text/plain; charset=ISO-8859-1

Do you have any further comment for this patch?

On Mon, Mar 19, 2012 at 10:59 AM, Mai La <mla@apm.com> wrote:

> This patch consists of:
> - Enable PCI MSI as default for Bluestone board
> - Change definition of number of MSI interrupts as it depends on SoC
> - Fix returning ENODEV as finding MSI node
> - Fix MSI physical high and low address
> - Keep MSI data logically
>
> Signed-off-by: Mai La <mla@apm.com>
>
> ---
> v4:
> Per Josh Boyer's comment:
> * Declare msi_irqs as static
> * Handle error if allocation of MSI vitual interrupts fails
> * Return ENODEV if counting MSI interrupts fails
> v3:
> * Use upper_32_bits() / lower_32_bits() consistently as Wolfgang Denk
> recomments
> v2:
> * Change definition of number of MSI interrupt from config to count
> interrupts in device tree
>
> ---
>  arch/powerpc/platforms/44x/Kconfig |    2 +
>  arch/powerpc/sysdev/ppc4xx_msi.c   |   42
> ++++++++++++++++++++++++------------
>  2 files changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/platforms/44x/Kconfig
> b/arch/powerpc/platforms/44x/Kconfig
> index fcf6bf2..9f04ce3 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -23,6 +23,8 @@ config BLUESTONE
>        default n
>        select PPC44x_SIMPLE
>        select APM821xx
> +       select PCI_MSI
> +       select PPC4xx_MSI
>        select IBM_EMAC_RGMII
>        help
>          This option enables support for the APM APM821xx Evaluation board.
> diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c
> b/arch/powerpc/sysdev/ppc4xx_msi.c
> index 1c2d7af..cc17f59 100644
> --- a/arch/powerpc/sysdev/ppc4xx_msi.c
> +++ b/arch/powerpc/sysdev/ppc4xx_msi.c
> @@ -28,10 +28,11 @@
>  #include <linux/of_platform.h>
>  #include <linux/interrupt.h>
>  #include <linux/export.h>
> +#include <linux/kernel.h>
>  #include <asm/prom.h>
>  #include <asm/hw_irq.h>
>  #include <asm/ppc-pci.h>
> -#include <boot/dcr.h>
> +#include <asm/dcr.h>
>  #include <asm/dcr-regs.h>
>  #include <asm/msi_bitmap.h>
>
> @@ -43,13 +44,14 @@
>  #define PEIH_FLUSH0    0x30
>  #define PEIH_FLUSH1    0x38
>  #define PEIH_CNTRST    0x48
> -#define NR_MSI_IRQS    4
> +
> +static int msi_irqs;
>
>  struct ppc4xx_msi {
>        u32 msi_addr_lo;
>        u32 msi_addr_hi;
>        void __iomem *msi_regs;
> -       int msi_virqs[NR_MSI_IRQS];
> +       int *msi_virqs;
>        struct msi_bitmap bitmap;
>        struct device_node *msi_dev;
>  };
> @@ -61,7 +63,7 @@ static int ppc4xx_msi_init_allocator(struct
> platform_device *dev,
>  {
>        int err;
>
> -       err = msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS,
> +       err = msi_bitmap_alloc(&msi_data->bitmap, msi_irqs,
>                              dev->dev.of_node);
>        if (err)
>                return err;
> @@ -83,6 +85,11 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev,
> int nvec, int type)
>        struct msi_desc *entry;
>        struct ppc4xx_msi *msi_data = &ppc4xx_msi;
>
> +       msi_data->msi_virqs = kmalloc((msi_irqs) * sizeof(int),
> +                                           GFP_KERNEL);
> +       if (!msi_data->msi_virqs)
> +               return -ENOMEM;
> +
>        list_for_each_entry(entry, &dev->msi_list, list) {
>                int_no = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
>                if (int_no >= 0)
> @@ -150,12 +157,11 @@ static int ppc4xx_setup_pcieh_hw(struct
> platform_device *dev,
>        if (!sdr_addr)
>                return -1;
>
> -       SDR0_WRITE(sdr_addr, (u64)res.start >> 32);      /*HIGH addr */
> -       SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
> -
> +       mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));      /*HIGH
> addr */
> +       mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));  /* Low
> addr */
>
>        msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
> -       if (msi->msi_dev)
> +       if (!msi->msi_dev)
>                return -ENODEV;
>
>        msi->msi_regs = of_iomap(msi->msi_dev, 0);
> @@ -167,9 +173,12 @@ static int ppc4xx_setup_pcieh_hw(struct
> platform_device *dev,
>                (u32) (msi->msi_regs + PEIH_TERMADH), (u32)
> (msi->msi_regs));
>
>        msi_virt = dma_alloc_coherent(&dev->dev, 64, &msi_phys, GFP_KERNEL);
> -       msi->msi_addr_hi = 0x0;
> -       msi->msi_addr_lo = (u32) msi_phys;
> -       dev_dbg(&dev->dev, "PCIE-MSI: msi address 0x%x\n",
> msi->msi_addr_lo);
> +       if (!msi_virt)
> +               return -ENOMEM;
> +       msi->msi_addr_hi = (u32)(msi_phys >> 32);
> +       msi->msi_addr_lo = (u32)(msi_phys & 0xffffffff);
> +       dev_dbg(&dev->dev, "PCIE-MSI: msi address high 0x%x, low 0x%x\n",
> +               msi->msi_addr_hi, msi->msi_addr_lo);
>
>        /* Progam the Interrupt handler Termination addr registers */
>        out_be32(msi->msi_regs + PEIH_TERMADH, msi->msi_addr_hi);
> @@ -185,6 +194,8 @@ static int ppc4xx_setup_pcieh_hw(struct
> platform_device *dev,
>        out_be32(msi->msi_regs + PEIH_MSIED, *msi_data);
>        out_be32(msi->msi_regs + PEIH_MSIMK, *msi_mask);
>
> +       dma_free_coherent(&dev->dev, 64, msi_virt, msi_phys);
> +
>        return 0;
>  }
>
> @@ -194,7 +205,7 @@ static int ppc4xx_of_msi_remove(struct platform_device
> *dev)
>        int i;
>        int virq;
>
> -       for (i = 0; i < NR_MSI_IRQS; i++) {
> +       for (i = 0; i < msi_irqs; i++) {
>                virq = msi->msi_virqs[i];
>                if (virq != NO_IRQ)
>                        irq_dispose_mapping(virq);
> @@ -215,8 +226,6 @@ static int __devinit ppc4xx_msi_probe(struct
> platform_device *dev)
>        struct resource res;
>        int err = 0;
>
> -       msi = &ppc4xx_msi;/*keep the msi data for further use*/
> -
>        dev_dbg(&dev->dev, "PCIE-MSI: Setting up MSI support...\n");
>
>        msi = kzalloc(sizeof(struct ppc4xx_msi), GFP_KERNEL);
> @@ -234,6 +243,10 @@ static int __devinit ppc4xx_msi_probe(struct
> platform_device *dev)
>                goto error_out;
>        }
>
> +       msi_irqs = of_irq_count(dev->dev.of_node);
> +       if (!msi_irqs)
> +               return -ENODEV;
> +
>        if (ppc4xx_setup_pcieh_hw(dev, res, msi))
>                goto error_out;
>
> @@ -242,6 +255,7 @@ static int __devinit ppc4xx_msi_probe(struct
> platform_device *dev)
>                dev_err(&dev->dev, "Error allocating MSI bitmap\n");
>                goto error_out;
>        }
> +       ppc4xx_msi = *msi;
>
>        ppc_md.setup_msi_irqs = ppc4xx_setup_msi_irqs;
>        ppc_md.teardown_msi_irqs = ppc4xx_teardown_msi_irqs;
> --
> 1.7.3.4
>
>

--00235445ba883383d404bd376136
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Do you have any further comment for this patch?<br><br><div class=3D"gmail_=
quote">On Mon, Mar 19, 2012 at 10:59 AM, Mai La <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:mla@apm.com">mla@apm.com</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">

This patch consists of:<br>
- Enable PCI MSI as default for Bluestone board<br>
- Change definition of number of MSI interrupts as it depends on SoC<br>
- Fix returning ENODEV as finding MSI node<br>
- Fix MSI physical high and low address<br>
- Keep MSI data logically<br>
<br>
Signed-off-by: Mai La &lt;<a href=3D"mailto:mla@apm.com">mla@apm.com</a>&gt=
;<br>
<br>
---<br>
v4:<br>
Per Josh Boyer&#39;s comment:<br>
* Declare msi_irqs as static<br>
* Handle error if allocation of MSI vitual interrupts fails<br>
* Return ENODEV if counting MSI interrupts fails<br>
v3:<br>
* Use upper_32_bits() / lower_32_bits() consistently as Wolfgang Denk recom=
ments<br>
v2:<br>
* Change definition of number of MSI interrupt from config to count interru=
pts in device tree<br>
<br>
---<br>
=A0arch/powerpc/platforms/44x/Kconfig | =A0 =A02 +<br>
=A0arch/powerpc/sysdev/ppc4xx_msi.c =A0 | =A0 42 ++++++++++++++++++++++++--=
----------<br>
=A02 files changed, 30 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44=
x/Kconfig<br>
index fcf6bf2..9f04ce3 100644<br>
--- a/arch/powerpc/platforms/44x/Kconfig<br>
+++ b/arch/powerpc/platforms/44x/Kconfig<br>
@@ -23,6 +23,8 @@ config BLUESTONE<br>
 =A0 =A0 =A0 =A0default n<br>
 =A0 =A0 =A0 =A0select PPC44x_SIMPLE<br>
 =A0 =A0 =A0 =A0select APM821xx<br>
+ =A0 =A0 =A0 select PCI_MSI<br>
+ =A0 =A0 =A0 select PPC4xx_MSI<br>
 =A0 =A0 =A0 =A0select IBM_EMAC_RGMII<br>
 =A0 =A0 =A0 =A0help<br>
 =A0 =A0 =A0 =A0 =A0This option enables support for the APM APM821xx Evalua=
tion board.<br>
diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_=
msi.c<br>
index 1c2d7af..cc17f59 100644<br>
--- a/arch/powerpc/sysdev/ppc4xx_msi.c<br>
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c<br>
@@ -28,10 +28,11 @@<br>
=A0#include &lt;linux/of_platform.h&gt;<br>
=A0#include &lt;linux/interrupt.h&gt;<br>
=A0#include &lt;linux/export.h&gt;<br>
+#include &lt;linux/kernel.h&gt;<br>
=A0#include &lt;asm/prom.h&gt;<br>
=A0#include &lt;asm/hw_irq.h&gt;<br>
=A0#include &lt;asm/ppc-pci.h&gt;<br>
-#include &lt;boot/dcr.h&gt;<br>
+#include &lt;asm/dcr.h&gt;<br>
=A0#include &lt;asm/dcr-regs.h&gt;<br>
=A0#include &lt;asm/msi_bitmap.h&gt;<br>
<br>
@@ -43,13 +44,14 @@<br>
=A0#define PEIH_FLUSH0 =A0 =A00x30<br>
=A0#define PEIH_FLUSH1 =A0 =A00x38<br>
=A0#define PEIH_CNTRST =A0 =A00x48<br>
-#define NR_MSI_IRQS =A0 =A04<br>
+<br>
+static int msi_irqs;<br>
<br>
=A0struct ppc4xx_msi {<br>
 =A0 =A0 =A0 =A0u32 msi_addr_lo;<br>
 =A0 =A0 =A0 =A0u32 msi_addr_hi;<br>
 =A0 =A0 =A0 =A0void __iomem *msi_regs;<br>
- =A0 =A0 =A0 int msi_virqs[NR_MSI_IRQS];<br>
+ =A0 =A0 =A0 int *msi_virqs;<br>
 =A0 =A0 =A0 =A0struct msi_bitmap bitmap;<br>
 =A0 =A0 =A0 =A0struct device_node *msi_dev;<br>
=A0};<br>
@@ -61,7 +63,7 @@ static int ppc4xx_msi_init_allocator(struct platform_devi=
ce *dev,<br>
=A0{<br>
 =A0 =A0 =A0 =A0int err;<br>
<br>
- =A0 =A0 =A0 err =3D msi_bitmap_alloc(&amp;msi_data-&gt;bitmap, NR_MSI_IRQ=
S,<br>
+ =A0 =A0 =A0 err =3D msi_bitmap_alloc(&amp;msi_data-&gt;bitmap, msi_irqs,<=
br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev-&gt;dev.of_=
node);<br>
 =A0 =A0 =A0 =A0if (err)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;<br>
@@ -83,6 +85,11 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, in=
t nvec, int type)<br>
 =A0 =A0 =A0 =A0struct msi_desc *entry;<br>
 =A0 =A0 =A0 =A0struct ppc4xx_msi *msi_data =3D &amp;ppc4xx_msi;<br>
<br>
+ =A0 =A0 =A0 msi_data-&gt;msi_virqs =3D kmalloc((msi_irqs) * sizeof(int),<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 GFP_KERNEL);<br>
+ =A0 =A0 =A0 if (!msi_data-&gt;msi_virqs)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+<br>
 =A0 =A0 =A0 =A0list_for_each_entry(entry, &amp;dev-&gt;msi_list, list) {<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int_no =3D msi_bitmap_alloc_hwirqs(&amp;msi=
_data-&gt;bitmap, 1);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (int_no &gt;=3D 0)<br>
@@ -150,12 +157,11 @@ static int ppc4xx_setup_pcieh_hw(struct platform_devi=
ce *dev,<br>
 =A0 =A0 =A0 =A0if (!sdr_addr)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;<br>
<br>
- =A0 =A0 =A0 SDR0_WRITE(sdr_addr, (u64)res.start &gt;&gt; 32); =A0 =A0 =A0=
/*HIGH addr */<br>
- =A0 =A0 =A0 SDR0_WRITE(sdr_addr + 1, res.start &amp; 0xFFFFFFFF); /* Low =
addr */<br>
-<br>
+ =A0 =A0 =A0 mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start)); =A0 =A0 =
=A0/*HIGH addr */<br>
+ =A0 =A0 =A0 mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start)); =A0/* =
Low addr */<br>
<br>
 =A0 =A0 =A0 =A0msi-&gt;msi_dev =3D of_find_node_by_name(NULL, &quot;ppc4xx=
-msi&quot;);<br>
- =A0 =A0 =A0 if (msi-&gt;msi_dev)<br>
+ =A0 =A0 =A0 if (!msi-&gt;msi_dev)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;<br>
<br>
 =A0 =A0 =A0 =A0msi-&gt;msi_regs =3D of_iomap(msi-&gt;msi_dev, 0);<br>
@@ -167,9 +173,12 @@ static int ppc4xx_setup_pcieh_hw(struct platform_devic=
e *dev,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(u32) (msi-&gt;msi_regs + PEIH_TERMADH), (u=
32) (msi-&gt;msi_regs));<br>
<br>
 =A0 =A0 =A0 =A0msi_virt =3D dma_alloc_coherent(&amp;dev-&gt;dev, 64, &amp;=
msi_phys, GFP_KERNEL);<br>
- =A0 =A0 =A0 msi-&gt;msi_addr_hi =3D 0x0;<br>
- =A0 =A0 =A0 msi-&gt;msi_addr_lo =3D (u32) msi_phys;<br>
- =A0 =A0 =A0 dev_dbg(&amp;dev-&gt;dev, &quot;PCIE-MSI: msi address 0x%x\n&=
quot;, msi-&gt;msi_addr_lo);<br>
+ =A0 =A0 =A0 if (!msi_virt)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+ =A0 =A0 =A0 msi-&gt;msi_addr_hi =3D (u32)(msi_phys &gt;&gt; 32);<br>
+ =A0 =A0 =A0 msi-&gt;msi_addr_lo =3D (u32)(msi_phys &amp; 0xffffffff);<br>
+ =A0 =A0 =A0 dev_dbg(&amp;dev-&gt;dev, &quot;PCIE-MSI: msi address high 0x=
%x, low 0x%x\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 msi-&gt;msi_addr_hi, msi-&gt;msi_addr_lo);<br=
>
<br>
 =A0 =A0 =A0 =A0/* Progam the Interrupt handler Termination addr registers =
*/<br>
 =A0 =A0 =A0 =A0out_be32(msi-&gt;msi_regs + PEIH_TERMADH, msi-&gt;msi_addr_=
hi);<br>
@@ -185,6 +194,8 @@ static int ppc4xx_setup_pcieh_hw(struct platform_device=
 *dev,<br>
 =A0 =A0 =A0 =A0out_be32(msi-&gt;msi_regs + PEIH_MSIED, *msi_data);<br>
 =A0 =A0 =A0 =A0out_be32(msi-&gt;msi_regs + PEIH_MSIMK, *msi_mask);<br>
<br>
+ =A0 =A0 =A0 dma_free_coherent(&amp;dev-&gt;dev, 64, msi_virt, msi_phys);<=
br>
+<br>
 =A0 =A0 =A0 =A0return 0;<br>
=A0}<br>
<br>
@@ -194,7 +205,7 @@ static int ppc4xx_of_msi_remove(struct platform_device =
*dev)<br>
 =A0 =A0 =A0 =A0int i;<br>
 =A0 =A0 =A0 =A0int virq;<br>
<br>
- =A0 =A0 =A0 for (i =3D 0; i &lt; NR_MSI_IRQS; i++) {<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; msi_irqs; i++) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0virq =3D msi-&gt;msi_virqs[i];<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (virq !=3D NO_IRQ)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_dispose_mapping(virq);<=
br>
@@ -215,8 +226,6 @@ static int __devinit ppc4xx_msi_probe(struct platform_d=
evice *dev)<br>
 =A0 =A0 =A0 =A0struct resource res;<br>
 =A0 =A0 =A0 =A0int err =3D 0;<br>
<br>
- =A0 =A0 =A0 msi =3D &amp;ppc4xx_msi;/*keep the msi data for further use*/=
<br>
-<br>
 =A0 =A0 =A0 =A0dev_dbg(&amp;dev-&gt;dev, &quot;PCIE-MSI: Setting up MSI su=
pport...\n&quot;);<br>
<br>
 =A0 =A0 =A0 =A0msi =3D kzalloc(sizeof(struct ppc4xx_msi), GFP_KERNEL);<br>
@@ -234,6 +243,10 @@ static int __devinit ppc4xx_msi_probe(struct platform_=
device *dev)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto error_out;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
+ =A0 =A0 =A0 msi_irqs =3D of_irq_count(dev-&gt;dev.of_node);<br>
+ =A0 =A0 =A0 if (!msi_irqs)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
+<br>
 =A0 =A0 =A0 =A0if (ppc4xx_setup_pcieh_hw(dev, res, msi))<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto error_out;<br>
<br>
@@ -242,6 +255,7 @@ static int __devinit ppc4xx_msi_probe(struct platform_d=
evice *dev)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;dev-&gt;dev, &quot;Error alloc=
ating MSI bitmap\n&quot;);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto error_out;<br>
 =A0 =A0 =A0 =A0}<br>
+ =A0 =A0 =A0 ppc4xx_msi =3D *msi;<br>
<br>
 =A0 =A0 =A0 =A0ppc_md.setup_msi_irqs =3D ppc4xx_setup_msi_irqs;<br>
 =A0 =A0 =A0 =A0ppc_md.teardown_msi_irqs =3D ppc4xx_teardown_msi_irqs;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.3.4<br>
<br>
</font></span></blockquote></div><br>

--00235445ba883383d404bd376136--

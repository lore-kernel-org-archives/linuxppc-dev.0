Return-Path: <B04825@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: Re: [PATCH] powerpc/fsl_msi: Handle msi-available-ranges better
Date: Wed, 7 Sep 2011 16:20:19 +0000
Message-ID: <CAOZdJXVm1YL-T8i26O0BiB-uTkXUDnYQdacU8k52aG-K0pZ1Lg@mail.gmail.com>
References: <20110117202528.GB561@udp111988uds.am.freescale.net>
In-Reply-To: <20110117202528.GB561@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 17, 2011 at 2:25 PM, Scott Wood <scottwood@freescale.com> wrote=
:

> + =A0 =A0 =A0 for (irq_index =3D 0, i =3D 0; i < len / (2 * sizeof(u32));=
 i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p[i * 2] % IRQS_PER_MSI_REG ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p[i * 2 + 1] % IRQS_PER_MSI_REG) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: %s=
: msi available range of %u at %u is not IRQ-aligned\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, de=
v->dev.of_node->full_name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p[i * 2 + 1]=
, p[i * 2]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D p[i * 2] / IRQS_PER_MSI_REG;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D p[i * 2 + 1] / IRQS_PER_MSI_REG;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < count; j++, irq_index++) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D fsl_msi_setup_hwirq=
(msi, dev, offset, irq_index);

Scott,

I know it's been eight months since you posted this patch, but I'm not
sure this part is correct.   fsl_msi_setup_hwirq() does this:

cascade_data->index =3D offset + irq_index;

"cascade_data->index" is supposed to be the index of the MSIIR
register, so it's a number between 0 and 7.  irq_index is incremented
on every pass of loop 'j'.  My understanding is that the following two
definitions of msi-available-ranges are equivalent:

static const u32 all_avail[] =3D { 0, NR_MSI_IRQS };

static const u32 all_avail[] =3D { 0, 64, 64, 32, 96, 32, 128, 32, 160, 96}=
;

When I use the first definition, I get this on each call to
fsl_msi_setup_hwirq():

fsl_msi_setup_hwirq:299 offset=3D0 irq_index=3D0 cascade_data->index=3D0
fsl_msi_setup_hwirq:299 offset=3D0 irq_index=3D1 cascade_data->index=3D1
fsl_msi_setup_hwirq:299 offset=3D0 irq_index=3D2 cascade_data->index=3D2
fsl_msi_setup_hwirq:299 offset=3D0 irq_index=3D3 cascade_data->index=3D3
fsl_msi_setup_hwirq:299 offset=3D0 irq_index=3D4 cascade_data->index=3D4
fsl_msi_setup_hwirq:299 offset=3D0 irq_index=3D5 cascade_data->index=3D5
fsl_msi_setup_hwirq:299 offset=3D0 irq_index=3D6 cascade_data->index=3D6
fsl_msi_setup_hwirq:299 offset=3D0 irq_index=3D7 cascade_data->index=3D7

But when I use the second definition of all_avail[], I get this instead:

fsl_msi_setup_hwirq:299 offset=3D0 irq_index=3D0 cascade_data->index=3D0
fsl_msi_setup_hwirq:299 offset=3D0 irq_index=3D1 cascade_data->index=3D1
fsl_msi_setup_hwirq:299 offset=3D2 irq_index=3D2 cascade_data->index=3D4
fsl_msi_setup_hwirq:299 offset=3D3 irq_index=3D3 cascade_data->index=3D6
fsl_msi_setup_hwirq:299 offset=3D4 irq_index=3D4 cascade_data->index=3D8
fsl_msi_setup_hwirq:299 offset=3D5 irq_index=3D5 cascade_data->index=3D10
fsl_msi_setup_hwirq:299 offset=3D5 irq_index=3D6 cascade_data->index=3D11
fsl_msi_setup_hwirq:299 offset=3D5 irq_index=3D7 cascade_data->index=3D12

The problem is that both offset and irq_index are being incremented in
the loop, and cascade_data->index is set to the sum of the two.

Perhaps you meant this:

		err =3D fsl_msi_setup_hwirq(msi, dev, offset, j);

--=20
Timur Tabi
Linux kernel developer at Freescale=

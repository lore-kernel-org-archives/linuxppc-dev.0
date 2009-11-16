Return-Path: <grundler@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0F06B6F29
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 04:48:14 +1100 (EST)
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id nAGHbdOS021443
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 17:37:40 GMT
Received: from gv-out-0910.google.com (gveo2.prod.google.com [10.16.166.2])
	by zps78.corp.google.com with ESMTP id nAGHbYCx003518
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 09:37:35 -0800
Received: by gv-out-0910.google.com with SMTP id o2so697965gve.31
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 09:37:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com>
References: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com>
Date: Mon, 16 Nov 2009 09:37:34 -0800
Message-ID: <da824cf30911160937l38651a44sc25a3315efd24aea@mail.gmail.com>
Subject: Re: [PATCH 1/1] ata/sata_sil24: MSI support, disabled by default
From: Grant Grundler <grundler@google.com>
To: Vivek Mahajan <vivek.mahajan@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 15, 2009 at 10:19 PM, Vivek Mahajan
<vivek.mahajan@freescale.com> wrote:
> The following patch adds MSI support. Some platforms
> may have broken MSI, so those are defaulted to use
> legacy PCI interrupts.
>
> Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
> ---
> =C2=A0drivers/ata/sata_sil24.c | =C2=A0 =C2=A09 +++++++++
> =C2=A01 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index e6946fc..1370df6 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -417,6 +417,10 @@ static struct ata_port_operations sil24_ops =3D {
> =C2=A0#endif
> =C2=A0};
>
> +static int sata_sil24_msi; =C2=A0 =C2=A0/* Disable MSI */
> +module_param_named(msi, sata_sil24_msi, bool, S_IRUGO);
> +MODULE_PARM_DESC(msi, "Enable MSI (Default: false)");

Vivek,
Do we even still need the parameter? I'm thinking either MSI works
with a chipset
or it doesn't. The kernel has globals to "know" which state is true.

If the parameter is needed, when this driver is compiled into the kernel, h=
ow
is "msi" parameter specified?
I think the parameter needs to be documented and fit in with other
"msi" parameters.
See "nomsi" in Documentation/kernel-parameters.txt.

If you want to keep this module parameter, can I suggest calling the
exported parameter "sata_sil24_msi"?

I'm not able to test this since the chipset I have sata_sil24 devices
plugged into don't support MSI (older AMD/Nvidia chipset). :(


> +
> =C2=A0/*
> =C2=A0* Use bits 30-31 of port_flags to encode available port numbers.
> =C2=A0* Current maxium is 4.
> @@ -1340,6 +1344,11 @@ static int sil24_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sil24_init_controller(host);
>
> + =C2=A0 =C2=A0 =C2=A0 if (sata_sil24_msi && !!pci_msi_enable(pdev)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_printk(KERN_INFO, =
&pdev->dev, "Using MSI\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_intx(pdev, 0);

pci_intx() isn't documented in MSI-HOWTO.txt  - because it's already called=
:
    pci_msi_enable() -> pci_msi_enable_block() -> msi_capability_init()
       -> pci_intx_for_msi(dev, 0) -> pci_intx(pdev, 0);

(thanks to willy (Mathew Wilcox) for pointing me at
msi_capability_init() - I overlooked it)

Please add "Reviewed-by: Grant Grundler <grundler@google.com>" once the
variable name is changed and the pci_intx() call is removed.

cheers,
grant

> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_set_master(pdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ata_host_activate(host, pdev->irq, sil2=
4_interrupt, IRQF_SHARED,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &sil24_sht);
> --
> 1.5.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>

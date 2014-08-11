Return-Path: <Bharat.Bhushan@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E4371A06EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 00:48:44 +1000 (EST)
From: "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>
To: Alexander Gordeev <agordeev@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>
Subject: RE: [PATCH v2 2/2] PCI/MSI: Remove arch_msi_check_device()
Date: Mon, 11 Aug 2014 14:33:25 +0000
Message-ID: <0a23568bd6eb4dfbb5f4acc96bba3706@BLUPR03MB566.namprd03.prod.outlook.com>
References: <cover.1405160163.git.agordeev@redhat.com>
 <1005232855c3af2c0c669818ee63be445389b6ad.1405160163.git.agordeev@redhat.com>
 <20140716222024.GE14366@google.com>
 <20140811114536.GA3427@dhcp-27-160.brq.redhat.com>
In-Reply-To: <20140811114536.GA3427@dhcp-27-160.brq.redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel=
.org]
> On Behalf Of Alexander Gordeev
> Sent: Monday, August 11, 2014 5:16 PM
> To: Bjorn Helgaas
> Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> pci@vger.kernel.org
> Subject: [PATCH v2 2/2] PCI/MSI: Remove arch_msi_check_device()
>=20
> There are no archs that override arch_msi_check_device() hook. Remove it =
as it
> is completely redundant.

Is not we are still overriding this in powerpc (not sure I missed some patc=
h , if so please point to that).

$ grep -r  arch_msi_check_device arch/powerpc/
Binary file arch/powerpc/kernel/msi.o matches
arch/powerpc/kernel/msi.c:int arch_msi_check_device(struct pci_dev* dev, in=
t nvec, int type)
Binary file arch/powerpc/kernel/built-in.o matches

Thanks
-Bharat

>=20
> If an arch would need to check MSI/MSI-X possibility for a device it shou=
ld make
> it within arch_setup_msi_irqs() hook.
>=20
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  drivers/pci/msi.c   | 49 +++++++++++++----------------------------------=
--
>  include/linux/msi.h |  3 ---
>  2 files changed, 13 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c index 5a40516..6c2cc41=
 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -56,16 +56,6 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
>  	chip->teardown_irq(chip, irq);
>  }
>=20
> -int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type=
) -{
> -	struct msi_chip *chip =3D dev->bus->msi;
> -
> -	if (!chip || !chip->check_device)
> -		return 0;
> -
> -	return chip->check_device(chip, dev, nvec, type);
> -}
> -
>  int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type) =
 {
>  	struct msi_desc *entry;
> @@ -806,22 +796,23 @@ out_free:
>  }
>=20
>  /**
> - * pci_msi_check_device - check whether MSI may be enabled on a device
> + * pci_msi_supported - check whether MSI may be enabled on a device
>   * @dev: pointer to the pci_dev data structure of MSI device function
>   * @nvec: how many MSIs have been requested ?
> - * @type: are we checking for MSI or MSI-X ?
>   *
>   * Look at global flags, the device itself, and its parent buses
>   * to determine if MSI/-X are supported for the device. If MSI/-X is
>   * supported return 0, else return an error code.
>   **/
> -static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
> +static int pci_msi_supported(struct pci_dev *dev, int nvec)
>  {
>  	struct pci_bus *bus;
> -	int ret;
>=20
>  	/* MSI must be globally enabled and supported by the device */
> -	if (!pci_msi_enable || !dev || dev->no_msi)
> +	if (!pci_msi_enable)
> +		return -EINVAL;
> +
> +	if (!dev || dev->no_msi || dev->current_state !=3D PCI_D0)
>  		return -EINVAL;
>=20
>  	/*
> @@ -843,10 +834,6 @@ static int pci_msi_check_device(struct pci_dev *dev,=
 int
> nvec, int type)
>  		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
>  			return -EINVAL;
>=20
> -	ret =3D arch_msi_check_device(dev, nvec, type);
> -	if (ret)
> -		return ret;
> -
>  	return 0;
>  }
>=20
> @@ -949,13 +936,13 @@ int pci_enable_msix(struct pci_dev *dev, struct msi=
x_entry
> *entries, int nvec)
>  	int status, nr_entries;
>  	int i, j;
>=20
> -	if (!entries || !dev->msix_cap || dev->current_state !=3D PCI_D0)
> -		return -EINVAL;
> -
> -	status =3D pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSIX);
> +	status =3D pci_msi_supported(dev, nvec);
>  	if (status)
>  		return status;
>=20
> +	if (!entries)
> +		return -EINVAL;
> +
>  	nr_entries =3D pci_msix_vec_count(dev);
>  	if (nr_entries < 0)
>  		return nr_entries;
> @@ -1062,8 +1049,9 @@ int pci_enable_msi_range(struct pci_dev *dev, int m=
invec,
> int maxvec)
>  	int nvec;
>  	int rc;
>=20
> -	if (dev->current_state !=3D PCI_D0)
> -		return -EINVAL;
> +	rc =3D pci_msi_supported(dev, minvec);
> +	if (rc)
> +		return rc;
>=20
>  	WARN_ON(!!dev->msi_enabled);
>=20
> @@ -1086,17 +1074,6 @@ int pci_enable_msi_range(struct pci_dev *dev, int =
minvec,
> int maxvec)
>  		nvec =3D maxvec;
>=20
>  	do {
> -		rc =3D pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSI);
> -		if (rc < 0) {
> -			return rc;
> -		} else if (rc > 0) {
> -			if (rc < minvec)
> -				return -ENOSPC;
> -			nvec =3D rc;
> -		}
> -	} while (rc);
> -
> -	do {
>  		rc =3D msi_capability_init(dev, nvec);
>  		if (rc < 0) {
>  			return rc;
> diff --git a/include/linux/msi.h b/include/linux/msi.h index 8103f32..dbf=
7cc9
> 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -60,7 +60,6 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_=
desc
> *desc);  void arch_teardown_msi_irq(unsigned int irq);  int
> arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);  void
> arch_teardown_msi_irqs(struct pci_dev *dev); -int arch_msi_check_device(s=
truct
> pci_dev* dev, int nvec, int type);  void arch_restore_msi_irqs(struct pci=
_dev
> *dev);
>=20
>  void default_teardown_msi_irqs(struct pci_dev *dev); @@ -77,8 +76,6 @@ s=
truct
> msi_chip {
>  	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
>  			 struct msi_desc *desc);
>  	void (*teardown_irq)(struct msi_chip *chip, unsigned int irq);
> -	int (*check_device)(struct msi_chip *chip, struct pci_dev *dev,
> -			    int nvec, int type);
>  };
>=20
>  #endif /* LINUX_MSI_H */
> --
> 1.9.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in t=
he body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

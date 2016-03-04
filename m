Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E8301A0615
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 03:32:29 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 09:32:26 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 22A4519D8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 09:20:19 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24GWMgI45809688
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 09:32:23 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24GWMm1004923
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 09:32:22 -0700
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v6 19/20] cxlflash: Use new cxl_pci_read_adapter_vpd() API
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1457090804-9719-20-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Fri, 4 Mar 2016 10:32:20 -0600
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-scsi <linux-scsi@vger.kernel.org>
Message-Id: <E46D4E73-A65C-49F8-A74E-DF4837F9B4E6@linux.vnet.ibm.com>
References: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1457090804-9719-20-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch should have also been sent to the SCSI list (included now).

Changes look fine.

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

> On Mar 4, 2016, at 5:26 AM, Frederic Barrat =
<fbarrat@linux.vnet.ibm.com> wrote:
>=20
> To read the adapter VPD, drivers can't rely on pci config APIs, as it
> wouldn't work on powerVM. cxl introduced a new kernel API especially
> for this, so start using it.
>=20
> Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---
> drivers/scsi/cxlflash/common.h |  1 -
> drivers/scsi/cxlflash/main.c   | 18 ++----------------
> 2 files changed, 2 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/scsi/cxlflash/common.h =
b/drivers/scsi/cxlflash/common.h
> index 5ada926..580f370 100644
> --- a/drivers/scsi/cxlflash/common.h
> +++ b/drivers/scsi/cxlflash/common.h
> @@ -106,7 +106,6 @@ struct cxlflash_cfg {
> 	atomic_t scan_host_needed;
>=20
> 	struct cxl_afu *cxl_afu;
> -	struct pci_dev *parent_dev;
>=20
> 	atomic_t recovery_threads;
> 	struct mutex ctx_recovery_mutex;
> diff --git a/drivers/scsi/cxlflash/main.c =
b/drivers/scsi/cxlflash/main.c
> index f6d90ce..e04aae7 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -1407,7 +1407,7 @@ static int start_context(struct cxlflash_cfg =
*cfg)
>  */
> static int read_vpd(struct cxlflash_cfg *cfg, u64 wwpn[])
> {
> -	struct pci_dev *dev =3D cfg->parent_dev;
> +	struct pci_dev *dev =3D cfg->dev;
> 	int rc =3D 0;
> 	int ro_start, ro_size, i, j, k;
> 	ssize_t vpd_size;
> @@ -1416,7 +1416,7 @@ static int read_vpd(struct cxlflash_cfg *cfg, =
u64 wwpn[])
> 	char *wwpn_vpd_tags[NUM_FC_PORTS] =3D { "V5", "V6" };
>=20
> 	/* Get the VPD data from the device */
> -	vpd_size =3D pci_read_vpd(dev, 0, sizeof(vpd_data), vpd_data);
> +	vpd_size =3D cxl_read_adapter_vpd(dev, vpd_data, =
sizeof(vpd_data));
> 	if (unlikely(vpd_size <=3D 0)) {
> 		dev_err(&dev->dev, "%s: Unable to read VPD (size =3D =
%ld)\n",
> 		       __func__, vpd_size);
> @@ -2392,7 +2392,6 @@ static int cxlflash_probe(struct pci_dev *pdev,
> {
> 	struct Scsi_Host *host;
> 	struct cxlflash_cfg *cfg =3D NULL;
> -	struct device *phys_dev;
> 	struct dev_dependent_vals *ddv;
> 	int rc =3D 0;
>=20
> @@ -2458,19 +2457,6 @@ static int cxlflash_probe(struct pci_dev *pdev,
>=20
> 	pci_set_drvdata(pdev, cfg);
>=20
> -	/*
> -	 * Use the special service provided to look up the physical
> -	 * PCI device, since we are called on the probe of the virtual
> -	 * PCI host bus (vphb)
> -	 */
> -	phys_dev =3D cxl_get_phys_dev(pdev);
> -	if (!dev_is_pci(phys_dev)) {
> -		dev_err(&pdev->dev, "%s: not a pci dev\n", __func__);
> -		rc =3D -ENODEV;
> -		goto out_remove;
> -	}
> -	cfg->parent_dev =3D to_pci_dev(phys_dev);
> -
> 	cfg->cxl_afu =3D cxl_pci_to_afu(pdev);
>=20
> 	rc =3D init_pci(cfg);
> --=20
> 1.9.1
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

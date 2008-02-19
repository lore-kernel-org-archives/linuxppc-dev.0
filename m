Return-Path: <bzolnier@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id EF43BDDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 11:50:58 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1307324fgg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 16:50:55 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH] next-20080218 build failure at pmac_ide_macio_attach ()
Date: Tue, 19 Feb 2008 01:04:46 +0100
References: <20080218140159.GA31310@linux.vnet.ibm.com>
In-Reply-To: <20080218140159.GA31310@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802190104.47058.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, sfr@canb.auug.org.au,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 18 February 2008, Kamalesh Babulal wrote:
> Hi,
>=20
> The next-20080218 kernel build fails on the powerpc(s)
>=20
> drivers/ide/ppc/pmac.c: In function =E2=80=98pmac_ide_macio_attach=E2=80=
=99:
> drivers/ide/ppc/pmac.c:1094: error: conversion to non-scalar type request=
ed
> drivers/ide/ppc/pmac.c: In function =E2=80=98pmac_ide_pci_attach=E2=80=99:
> drivers/ide/ppc/pmac.c:1232: error: conversion to non-scalar type request=
ed
> make[3]: *** [drivers/ide/ppc/pmac.o] Error 1
> make[2]: *** [drivers/ide/ppc] Error 2
> make[1]: *** [drivers/ide] Error 2
> make: *** [drivers] Error 2
>=20
> I Have tested this patch for build failure only.
>=20
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> ---
> --- linux-2.6.25-rc1/drivers/ide/ppc/pmac.c	2008-02-18 18:41:48.000000000=
 +0530
> +++ linux-2.6.25-rc1/drivers/ide/ppc/~pmac.c	2008-02-18 19:20:37.00000000=
0 +0530
> @@ -1091,7 +1091,7 @@ pmac_ide_macio_attach(struct macio_dev *
>  	int irq, rc;
>  	hw_regs_t hw;
> =20
> -	pmif =3D (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
> +	pmif =3D (struct pmac_ide_hwif*)kzalloc(sizeof(*pmif), GFP_KERNEL);
>  	if (pmif =3D=3D NULL)
>  		return -ENOMEM;
> =20
> @@ -1229,7 +1229,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev
>  		return -ENODEV;
>  	}
> =20
> -	pmif =3D (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
> +	pmif =3D (struct pmac_ide_hwif*)kzalloc(sizeof(*pmif), GFP_KERNEL);
>  	if (pmif =3D=3D NULL)
>  		return -ENOMEM;
> =20

Thanks, I integrated it with the "guilty" patch to preserve bisectability.

=46rom: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-pmac: dynamically allocate struct pmac_ide_hwif instan=
ces (take 2)

* Dynamically allocate struct pmac_ide_hwif instances in pmac_ide_macio_att=
ach()
  and pmac_ide_pci_attach(), then remove no longer needed pmac_ide[].

v2:
* Build fix from Kamalesh Babulal.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
=2D--
 drivers/ide/ppc/pmac.c |   49 +++++++++++++++++++++++++++++++++-----------=
=2D----
 1 file changed, 33 insertions(+), 16 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -79,8 +79,6 @@ typedef struct pmac_ide_hwif {
 =09
 } pmac_ide_hwif_t;
=20
=2Dstatic pmac_ide_hwif_t pmac_ide[MAX_HWIFS];
=2D
 enum {
 	controller_ohare,	/* OHare based */
 	controller_heathrow,	/* Heathrow/Paddington */
@@ -1094,29 +1092,34 @@ pmac_ide_macio_attach(struct macio_dev *
 	int i, rc;
 	hw_regs_t hw;
=20
+	pmif =3D kzalloc(sizeof(*pmif), GFP_KERNEL);
+	if (pmif =3D=3D NULL)
+		return -ENOMEM;
+
 	i =3D 0;
=2D	while (i < MAX_HWIFS && (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] !=3D 0
=2D	    || pmac_ide[i].node !=3D NULL))
+	while (i < MAX_HWIFS && (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] !=3D 0))
 		++i;
 	if (i >=3D MAX_HWIFS) {
 		printk(KERN_ERR "ide-pmac: MacIO interface attach with no slot\n");
 		printk(KERN_ERR "          %s\n", mdev->ofdev.node->full_name);
=2D		return -ENODEV;
+		rc =3D -ENODEV;
+		goto out_free_pmif;
 	}
=20
=2D	pmif =3D &pmac_ide[i];
 	hwif =3D &ide_hwifs[i];
=20
 	if (macio_resource_count(mdev) =3D=3D 0) {
 		printk(KERN_WARNING "ide%d: no address for %s\n",
 		       i, mdev->ofdev.node->full_name);
=2D		return -ENXIO;
+		rc =3D -ENXIO;
+		goto out_free_pmif;
 	}
=20
 	/* Request memory resource for IO ports */
 	if (macio_request_resource(mdev, 0, "ide-pmac (ports)")) {
 		printk(KERN_ERR "ide%d: can't request mmio resource !\n", i);
=2D		return -EBUSY;
+		rc =3D -EBUSY;
+		goto out_free_pmif;
 	}
 		=09
 	/* XXX This is bogus. Should be fixed in the registry by checking
@@ -1166,11 +1169,15 @@ pmac_ide_macio_attach(struct macio_dev *
 			iounmap(pmif->dma_regs);
 			macio_release_resource(mdev, 1);
 		}
=2D		memset(pmif, 0, sizeof(*pmif));
 		macio_release_resource(mdev, 0);
+		kfree(pmif);
 	}
=20
 	return rc;
+
+out_free_pmif:
+	kfree(pmif);
+	return rc;
 }
=20
 static int
@@ -1223,30 +1230,36 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 		printk(KERN_ERR "ide-pmac: cannot find MacIO node for Kauai ATA interfac=
e\n");
 		return -ENODEV;
 	}
+
+	pmif =3D kzalloc(sizeof(*pmif), GFP_KERNEL);
+	if (pmif =3D=3D NULL)
+		return -ENOMEM;
+
 	i =3D 0;
=2D	while (i < MAX_HWIFS && (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] !=3D 0
=2D	    || pmac_ide[i].node !=3D NULL))
+	while (i < MAX_HWIFS && (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] !=3D 0))
 		++i;
 	if (i >=3D MAX_HWIFS) {
 		printk(KERN_ERR "ide-pmac: PCI interface attach with no slot\n");
 		printk(KERN_ERR "          %s\n", np->full_name);
=2D		return -ENODEV;
+		rc =3D -ENODEV;
+		goto out_free_pmif;
 	}
=20
=2D	pmif =3D &pmac_ide[i];
 	hwif =3D &ide_hwifs[i];
=20
 	if (pci_enable_device(pdev)) {
 		printk(KERN_WARNING "ide%i: Can't enable PCI device for %s\n",
 			i, np->full_name);
=2D		return -ENXIO;
+		rc =3D -ENXIO;
+		goto out_free_pmif;
 	}
 	pci_set_master(pdev);
 		=09
 	if (pci_request_regions(pdev, "Kauai ATA")) {
 		printk(KERN_ERR "ide%d: Cannot obtain PCI resources for %s\n",
 			i, np->full_name);
=2D		return -ENXIO;
+		rc =3D -ENXIO;
+		goto out_free_pmif;
 	}
=20
 	hwif->dev =3D &pdev->dev;
@@ -1276,11 +1289,15 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 		/* The inteface is released to the common IDE layer */
 		pci_set_drvdata(pdev, NULL);
 		iounmap(base);
=2D		memset(pmif, 0, sizeof(*pmif));
 		pci_release_regions(pdev);
+		kfree(pmif);
 	}
=20
 	return rc;
+
+out_free_pmif:
+	kfree(pmif);
+	return rc;
 }
=20
 static int

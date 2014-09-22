Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30EDA1A0704
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Sep 2014 15:01:35 +1000 (EST)
Message-ID: <1411362094.984.15.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH 07/15] powerpc/powerpc: Add new PCIe functions for
 allocating cxl interrupts
From: Michael Neuling <mikey@neuling.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Mon, 22 Sep 2014 15:01:34 +1000
In-Reply-To: <20140919070939.GB27190@shangw>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-8-git-send-email-mikey@neuling.org>
 <20140919070939.GB27190@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, imunsie@au1.ibm.com,
 anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<snip>
> >+struct device_node *pnv_pci_to_phb_node(struct pci_dev *dev)
> >+{
> >+	struct device_node *np;
> >+	struct property *prop =3D NULL;
> >+
> >+	np =3D of_node_get(pci_device_to_OF_node(dev));
> >+
> >+	/* Scan up the tree looking for the PHB node */
> >+	while (np) {
> >+		if ((prop =3D of_find_property(np, "ibm,opal-phbid", NULL)))
> >+			break;
> >+		np =3D of_get_next_parent(np);
> >+	}
> >+
> >+	if (!prop) {
> >+		of_node_put(np);
> >+		return NULL;
> >+	}
> >+
> >+	return np;
> >+}
> >+EXPORT_SYMBOL(pnv_pci_to_phb_node);
>=20
> Nitpick: I'm not sure it's better way. "struct pci_controller::dn" should
> always have valid "ibm,opal-phbid", so I guess the code could be like thi=
s
> way:
>=20
> 	struct pci_controller *hose =3D pci_bus_to_host(dev->bus);
>=20
> 	return hose->dn;

Nice.. that makes it much simpler.  I'll update.

<snip>
> >+
> >+#ifdef CONFIG_CXL_BASE
> >+int pnv_phb_to_cxl(struct pci_dev *dev)
> >+{
> >+	struct device_node *np;
> >+	struct pnv_ioda_pe *pe;
> >+	const u64 *prop64;
> >+	u64 phb_id;
> >+	int rc;
> >+
> >+	dev_info(&dev->dev, "switch PHB to CXL\n");
> >+
> >+	if (!(np =3D pnv_pci_to_phb_node(dev)))
> >+		return -ENODEV;
> >+
> >+	prop64 =3D of_get_property(np, "ibm,opal-phbid", NULL);
> >+
> >+	phb_id =3D be64_to_cpup(prop64);
> >+	dev_info(&dev->dev, "PHB-ID  : 0x%016llx\n", phb_id);
> >+
>=20
> The PHB ID would have been there: struct pnv_phb::opal_id. So
> I guess we needn't grab it from device-tree again :)

Nice, I'll update.

> >+	if (!(pe =3D pnv_ioda_get_pe(dev))) {
> >+		rc =3D -ENODEV;
> >+		goto out;
> >+	}
> >+	dev_info(&dev->dev, "     pe : %i\n", pe->pe_number);
>=20
> Perhaps you can reuse pe_info() here.

Yep, will do.

<snip>
> >+#ifdef CONFIG_CXL_BASE
> >+int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
> >+			   unsigned int virq)
> >+{
> >+	struct pci_controller *hose =3D pci_bus_to_host(dev->bus);
> >+	struct pnv_phb *phb =3D hose->private_data;
> >+	unsigned int xive_num =3D hwirq - phb->msi_base;
> >+	struct pnv_ioda_pe *pe;
> >+	int rc;
> >+
> >+	if (!(pe =3D pnv_ioda_get_pe(dev)))
> >+		return -ENODEV;
> >+
> >+	/* Assign XIVE to PE */
> >+	rc =3D opal_pci_set_xive_pe(phb->opal_id, pe->pe_number, xive_num);
> >+	if (rc) {
> >+		pr_warn("%s: OPAL error %d setting msi_base 0x%x hwirq 0x%x XIVE 0x%x=
 PE\n",
> >+			pci_name(dev), rc, phb->msi_base, hwirq, xive_num);
> >+		return -EIO;
> >+	}
>=20
> It seems current firmware doesn't support the OPAL API for PHB3.

The current public version of skiboot seems to be doing something here
in hw/phb3.c in phb3_set_ive_pe():

https://github.com/open-power/skiboot/blob/c34c4ef8c660e3e439365c8f5c06143f=
f00bc6bc/hw/phb3.c#L1096

I think we still need this.

Thanks again!
Mikey

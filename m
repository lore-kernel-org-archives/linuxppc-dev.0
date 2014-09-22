Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53FF91A070A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Sep 2014 14:31:51 +1000 (EST)
Message-ID: <1411360310.984.7.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH 05/15] powerpc/powernv: Split out set MSI IRQ chip code
From: Michael Neuling <mikey@neuling.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Mon, 22 Sep 2014 14:31:50 +1000
In-Reply-To: <20140919065412.GA27190@shangw>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-6-git-send-email-mikey@neuling.org>
 <20140919065412.GA27190@shangw>
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

> >+static void set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
> >+{
> >+	struct irq_data *idata;
> >+	struct irq_chip *ichip;
> >+
> >+	/*
> >+	 * Change the IRQ chip for the MSI interrupts on PHB3.
> >+	 * The corresponding IRQ chip should be populated for
> >+	 * the first time.
> >+	 */
> >+	if (phb->type =3D=3D PNV_PHB_IODA2) {
> >+		if (!phb->ioda.irq_chip_init) {
> >+			idata =3D irq_get_irq_data(virq);
> >+			ichip =3D irq_data_get_irq_chip(idata);
> >+			phb->ioda.irq_chip_init =3D 1;
> >+			phb->ioda.irq_chip =3D *ichip;
> >+			phb->ioda.irq_chip.irq_eoi =3D pnv_ioda2_msi_eoi;
> >+		}
> >+
> >+		irq_set_chip(virq, &phb->ioda.irq_chip);
> >+	}
> >+}
> >+
>=20
> Nitpick: to check PHB type and bail early could avoid nested code :)
>=20
> 	if (phb->type !=3D PNV_PHB_IODA2)
> 		return;

OK, will do in repost.

Thanks,
Mikey

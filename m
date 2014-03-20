Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C12B32C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 13:25:48 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [2/2] fsl/pci: The new pci suspend/resume implementation
Date: Thu, 20 Mar 2014 02:25:38 +0000
Message-ID: <2b84971a86a34d4696afa8144fa99620@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389081848-26506-2-git-send-email-dongsheng.wang@freescale.com>
 <20140319210041.GA14019@home.buserror.net>
In-Reply-To: <20140319210041.GA14019@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "roy.zang@freescale.com" <roy.zang@freescale.com>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

I will send v2 patch to fix your comment. Thanks for your review. :)

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, March 20, 2014 5:01 AM
> To: Wang Dongsheng-B40534
> Cc: bhelgaas@google.com; rjw@rjwysocki.net; roy.zang@freescale.com;
> galak@codeaurora.org; linux-pci@vger.kernel.org; linuxppc-dev@lists.ozlab=
s.org
> Subject: Re: [2/2] fsl/pci: The new pci suspend/resume implementation
>=20
> On Tue, Jan 07, 2014 at 04:04:08PM +0800, Dongsheng Wang wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > The new suspend/resume implementation, send pme turnoff message in
> > suspend, and send pme exit message in resume.
> >
> > Add a PME handler, to response PME & message interrupt.
> >
> > Change platform_driver->suspend/resume to syscore->suspend/resume.
> > pci-driver will call back EP device, to save EP state in
> > pci_pm_suspend_noirq, so we need to keep the link, until
> > pci_pm_suspend_noirq finish.
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> Is this patch OK to go in without patch 1/2?  It's not clear whether that=
 was
> deemed incorrect (as in new patch coming) or unnecessary.
>=20

Yes, I will abandon 1/2. And send this as a independent patch.

> It would also be good if you submit with the explanation from
> http://www.spinics.net/lists/linux-pci/msg27844.html in the commit messag=
e.
>=20

Thanks.

> > -static int fsl_pci_probe(struct platform_device *pdev)
> > +#ifdef CONFIG_PM
> > +static irqreturn_t fsl_pci_pme_handle(int irq, void *dev_id)
> >  {
> > -	int ret;
> > -	struct device_node *node;
> > +	struct pci_controller *hose =3D dev_id;
> > +	struct ccsr_pci __iomem *pci =3D hose->private_data;
> > +	u32 dr;
> >
> > -	node =3D pdev->dev.of_node;
> > -	ret =3D fsl_add_bridge(pdev, fsl_pci_primary =3D=3D node);
> > +	dr =3D in_be32(&pci->pex_pme_mes_dr);
> > +	if (dr)
> > +		out_be32(&pci->pex_pme_mes_dr, dr);
> > +	else
> > +		return IRQ_NONE;
> >
> > -	mpc85xx_pci_err_probe(pdev);
> > +	return IRQ_HANDLED;
> > +}
>=20
> Why do you put some of the HANDLED path in the if statement, and some out=
side?
>=20
> Just do:
>=20
> if (!dr)
> 	return IRQ_NONE;
>=20
> out_be32(...);
> return IRQ_HANDLED;
>=20

Right. :)

> > +static int fsl_pci_pme_probe(struct pci_controller *hose) {
> > +	struct ccsr_pci __iomem *pci;
> > +	struct pci_dev *dev =3D hose->bus->self;
> > +	u16 pms;
> > +	int pme_irq;
> > +	int res;
> > +
> > +	/* PME Disable */
> > +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pms);
> > +	pms &=3D ~PCI_PM_CTRL_PME_ENABLE;
> > +	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pms);
> > +
> > +	pme_irq =3D irq_of_parse_and_map(hose->dn, 0);
> > +	if (!pme_irq) {
> > +		pr_warn("Failed to map PME interrupt.\n");
>=20
> dev_err()
>=20
> > +
> > +		return -ENXIO;
> > +	}
> > +
> > +	res =3D devm_request_irq(hose->parent, pme_irq,
> > +			fsl_pci_pme_handle,
> > +			IRQF_DISABLED | IRQF_SHARED,
> > +			"[PCI] PME", hose);
>=20
> IRQF_DISABLED is a deprecated no-op.
>=20
> > +	if (res < 0) {
> > +		pr_warn("Unable to requiest irq %d for PME\n", pme_irq);
>=20
> dev_err() etc.
>=20

Ok, I will use it.

Regards,
-Dongsheng

> -Scott

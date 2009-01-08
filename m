Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0A12DE3FB
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 18:27:33 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n087RDXW006921
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 00:27:24 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n087RBFT013680
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 01:27:12 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2] powerpc/fsl_pci: Add MPC83xx PCI-E controller RC
	modesupport
Date: Thu, 8 Jan 2009 15:27:10 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB12089056CC6@zch01exm21.fsl.freescale.net>
In-Reply-To: <20090108013110.GA11165@oksana.dev.rtsoft.ru>
References: <20090108013006.GA31653@oksana.dev.rtsoft.ru>
	<20090108013110.GA11165@oksana.dev.rtsoft.ru>
From: "Liu Dave" <DaveLiu@freescale.com>
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: Huang Changming-R66093 <Chang-Ming.Huang@freescale.com>,
	Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static void __iomem *mpc83xx_pcie_remap_cfg(struct pci_bus *bus,
> +					    unsigned int devfn,=20

[snip]

> +	if (pcie->dev_base =3D=3D dev_base)
> +		goto mapped;
> +
> +	out_le32(hose->cfg_data + PEX_OUTWIN0_TAL, dev_base);
> +
> +	pcie->dev_base =3D dev_base;

Do we need local_irq_save/local_irq_restore between them?
out_le32(PEX_OUTWIN0_TAL,...) and pcie->dev_base =3D dev_base;

> +mapped:
> +	return pcie->cfg_map + offset;
> +}

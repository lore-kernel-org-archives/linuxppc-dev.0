Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 01FDCDDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 08:54:53 +1000 (EST)
Message-ID: <4713EFBB.3070203@freescale.com>
Date: Mon, 15 Oct 2007 17:54:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] pasemi: process i2c device tree entries at boot
References: <20071015015232.GA4641@lixom.net>
	<20071015224932.GA23875@lixom.net>
In-Reply-To: <20071015224932.GA23875@lixom.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> Setup i2c_board_info based on device tree contents. This has to be
> a device_initcall since we need PCI to be probed by the time we
> run it, but before the actual driver is initialized.

Can we factor at least some of this stuff out into common code?

We certainly shouldn't need more than one translation table, and this loop:

> +static int __init pasemi_register_i2c_devices(void)
> +{
> +	struct pci_dev *pdev;
> +	struct device_node *adap_node;
> +	struct device_node *node;
> +
> +	pdev = NULL;
> +	while ((pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa003, pdev))) {
> +		adap_node = pci_device_to_OF_node(pdev);

Should be in the pasemi code, and pass a bus number and device node to 
generic code that does this:

> +		node = NULL;
> +		while ((node = of_get_next_child(adap_node, node))) {

-Scott

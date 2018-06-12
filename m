Return-Path: <BATV+b157325a3ff6b4a866cc+5406+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414hN92C7LzF39x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 17:29:29 +1000 (AEST)
Date: Mon, 11 Jun 2018 23:57:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] pci/shpchp: no claim on pcie port device
Message-ID: <20180612065727.GA5195@infradead.org>
References: <1528785733-19442-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528785733-19442-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 12, 2018 at 02:42:13PM +0800, Pingfan Liu wrote:
> The Linux Device Driver Model allows a physical device to be handled
> by only a single driver. But at present, both shpchp and portdrv_pci
> claim PCI_CLASS_BRIDGE_PCI, and touch devices_kset. This causes a
> few problems, one is the wrong shutdown seq of devices, owing to the
> broken devices_kset.

How can they both touch devices_kset?  Once one driver has claimed the
device it should not be available to others.

> +	/* do not claim pcie port device */
> +	if (pci_is_pcie(dev) &&
> +	    ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	     (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) ||
> +	     (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)))
> +		return -ENODEV;

No need for the inner braces.

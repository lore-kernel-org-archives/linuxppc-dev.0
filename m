Return-Path: <BATV+aedd8ced9e3963eed800+4902+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7Ccr2VmBzDqLv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 03:02:36 +1100 (AEDT)
Date: Tue, 24 Jan 2017 17:02:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH 31/37] misc: Add host side pci driver for pci test
 function device
Message-ID: <20170124160224.GA23528@infradead.org>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-32-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484216786-17292-32-git-send-email-kishon@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2017 at 03:56:20PM +0530, Kishon Vijay Abraham I wrote:
> Add PCI endpoint test driver that can verify base address
> register, legacy interrupt/MSI interrupt and read/write/copy
> buffers between host and device. The corresponding pci-epf-test
> function driver should be used on the EP side.

Just curious:  what would you think of a text based (e.g. debugfs)
interface to avoid the need for a userspace tool here?

> +static const struct pci_device_id pci_endpoint_test_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_ANY_ID) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);

Also this looks really odd, and dangerous.  Probing for any
TI device will bind to all kinds of legit devices.  It would
be good if you could squeeze out a single id for this device
out of the TI group responsible for allocating it.  Otherwise
we might try some other venues, e.g. Red Hat through Qumranet
has PCI IDs available for virtio, which might have some left
for other Linux uses.

In general I fear the PCI ID allocation will become a worse
and worse issue once your framework goes in and we'll grow
more PCI device models in the kernel.

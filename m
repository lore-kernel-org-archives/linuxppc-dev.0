Date: Sun, 18 Jan 2004 13:49:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <greg@kroah.com>, sensors@stimpy.netroedge.com,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH 2.6] Hydra i2c
Message-ID: <20040118124957.GA7585@lst.de>
References: <Pine.LNX.4.58.0401181323130.653@callisto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0401181323130.653@callisto>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 18, 2004 at 01:28:22PM +0100, Geert Uytterhoeven wrote:
> +static int __devinit hydra_probe(struct pci_dev *dev,
> +				 const struct pci_device_id *id)
> +{
> +	unsigned int base_addr;
> +
> +	base_addr = dev->resource[0].start;

I think you should use pci_resource_start here.

> +	hydra_bit_data.data = ioremap(base_addr, 0x100);

And pci_resource len instead of hardcoding it?  Also you need to
check the ioremap return value.

You should also add a safety exit for the case the probe callback is
called more than once.  Or dynamic allocate a per-device struct instead
of using hydra_bit_data.

> +static void __exit i2c_hydra_exit(void)
> +{
> +	pci_unregister_driver(&hydra_driver);
> +	iounmap(hydra_bit_data.data);

The ioremap should move into the hydra_remove.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [patch 3/5] cell: updated driver for DDR2 memory on
	AXON
Date: Wed, 20 Jun 2007 01:03:24 +0200
References: <20070618224247.972139855@arndb.de>
	<20070618224923.364578320@arndb.de>
	<20070619154812.GA20347@ps3linux.grid.fixstars.com>
In-Reply-To: <20070619154812.GA20347@ps3linux.grid.fixstars.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706200103.24799.arnd@arndb.de>
Cc: Akinobu Mita <mita@fixstars.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 June 2007, Akinobu Mita wrote:
> > +	if (of_address_to_resource(device->node, 0, &resource) != 0) {
> > +		dev_err(&device->dev, "Cannot access device tree\n");
> > +		rc = -EFAULT;
> > +		goto failed;
> > +	}
> 
> of_address_to_resource() returns error code on failure:
> 
> 	rc = of_address_to_resource(device->node, 0, &resource);
> 	if (rc) {
> 		dev_err(&device->dev, "Cannot access device tree\n");
> 		goto failed;
> 	}
> 
> is better.

Right.

> > +	bank->ph_addr = resource.start;
> > +	bank->io_addr = (unsigned long) ioremap_flags(
> > +			bank->ph_addr, bank->size, _PAGE_NO_CACHE);
> > +	if (bank->io_addr == 0) {
> > +		dev_err(&device->dev, "ioremap() failed\n");
> > +		rc = -EFAULT;
> > +		goto failed;
> > +	}
> > +
> > +	bank->disk = alloc_disk(AXON_RAM_MINORS_PER_DISK);
> > +	if (bank->disk == NULL) {
> > +		dev_err(&device->dev, "Cannot register disk\n");
> > +		rc = -EFAULT;
> > +		goto failed;
> > +	}
> 
> -ENOMEM is better than -EFAULT. Because alloc_disk() failure happens
> only when it runs out of memory.

yes. EFAULT should only be used when an access to user memory has failed,
so it's wrong practically everywhere in here, your other comments are
obviously correct as well. 

	Arnd <><

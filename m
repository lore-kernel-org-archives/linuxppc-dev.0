Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 1/3] powerpc: fix pci_setup_phb_io_dynamic for pci_iomap
Date: Tue, 5 Jun 2007 00:27:06 +0200
References: <20070604181438.569356702@arndb.de>
	<20070604181739.375615838@arndb.de>
	<1180995548.31677.68.camel@localhost.localdomain>
In-Reply-To: <1180995548.31677.68.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706050027.06670.arnd@arndb.de>
Cc: paulus@samba.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 05 June 2007, Benjamin Herrenschmidt wrote:
> 
> On Mon, 2007-06-04 at 20:14 +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> > We had a problem on a system with only dynamically allocated
> > PCI buses (using of_pci_phb_driver) in combination with libata.
> > This setup ended up having no "primary" phb, which means
> > that pci_io_base never got initialized and all IO port
> > numbers are 64 bit numbers, which is larger than the
> > PIO_MASK limit.
> 
> That's for 2.6.22 ? I wonder if a better fix is to initialize
> pci_io_base statically and clear it in iSeries code... didn't I post a
> patch for that a while ago ?

We talked about this, but I can't find a patch from you that did this.
Either way should be fine, mine may be slightly less invasive, while
statically initializing pci_io_base is what you also do in your
rewrite of that code for 2.6.23.

	Arnd <><

Date: Thu, 8 Mar 2001 07:54:35 -0700
From: Matt Porter <mporter@mvista.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI confusion
Message-ID: <20010308075435.A19376@cx258813-a.chnd1.az.home.com>
References: <20010308155428.6682.qmail@dag.newtech.fi> <20010308060128.A18986@cx258813-a.chnd1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010308060128.A18986@cx258813-a.chnd1.az.home.com>; from mporter@mvista.com on Thu, Mar 08, 2001 at 06:01:29AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 08, 2001 at 06:01:29AM -0700, Matt Porter wrote:
> > 3. the driver I am using for testing (for the Tundra Universe) uses
> >   the following construction:
> >   baseaddr = ioremap(pci_resource_start(uni_pci_dev,0),
> > 		pci_resource_len (uni_pci_dev, 0));
> >   Then request_mem_region() for the same resources.
> >    Then pci_enable_device()
> >    Then pci_set_master()
> >    After this a access: temp = readl(baseaddr) will generate
> >    an Oops with illegal access....
> >   What am I doing wrong ?
>
> Also be sure that pci_mem_offset is 0x80000000 in the case of your
> memory map.  Otherwise, virt_to_bus() and the pci DMA API will not
> generate appropriate PCI mem master addresses for your devices to
> use.

Arg...that should be pci_dram_offset, of course.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

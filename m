From: acurtis@directvinternet.com
Reply-To: <acurtis@directvinternet.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Ppc Developers" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: PCI architecture enlightenment
Date: Tue, 6 Aug 2002 08:55:47 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFGEGNDKAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020806151731.30754@192.168.4.1>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> So the actual setup should look like
>
>  hose->io_base_phys           = 0x40000000;
>  hose->io_base_virt           = ioremap(0x40000000, 0x01000000);
>  hose->io_resource.start      = 0;
>  hose->io_resource.end        = 0x01000000;
>  hose->io_resource.flags      = IORESOURCE_IO;
>  isa_io_base                  = hose->io_base_virt;
>
>  hose->mem_resources[0].start = 0x48000000;
>  hose->mem_resources[0].end   = 0x4fffffff;
>  hose->mem_resources[0].flags = IORESOURCE_MEM;
>  hose->pci_mem_offset         = 0x48000000;
>  isa_mem_base                 = 0x48000000;
>  pci_dram_offset              = 0x40000000;
>

I think this is the configuration I have but will double check. Thanks for
the explanation. It is so much easier to work on something when you do not
think you are just putting things in variables without any idea why.

> Beware that if your host bridge appears as a PCI device on the BUS and
> his BAR may for some reasons be incorrectly considered as a device BAR
> while it's actually used to configure the bridge ranges (typically what
> happens with a 405gp or a CPC710), then you need to "hide" this BAR, using
> a PCI quirk (see the fixups in arch/ppc/kernel/pci.c)

There are 2 BAR's for the host controller that appear but they do not get
assigned resources since they fall outside of the defined resources ranges.
So, this should matter right? (see PCI/SCSI help message for output)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Thu, 8 Mar 2001 06:01:29 -0700
From: Matt Porter <mporter@mvista.com>
To: Dag Nygren <dag@newtech.fi>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI confusion
Message-ID: <20010308060128.A18986@cx258813-a.chnd1.az.home.com>
References: <20010308155428.6682.qmail@dag.newtech.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010308155428.6682.qmail@dag.newtech.fi>; from dag@newtech.fi on Thu, Mar 08, 2001 at 05:54:28PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 08, 2001 at 05:54:28PM +0200, Dag Nygren wrote:
>
> Hi,
>
> just spent some hours going through all
> postings in the mailing list about PCI-setup,
> but now i am even more confused....

We can fix that...

> The setup is:
>
> Nonsupported (sofar) VME board with
> a PreP address map and MPC107.
>
> I have the board booting but the PCI-drivers
> are all working through the I/O space and cannot see
> the memoryspace of the PCI devices.
>
> The questions I have are:
>
> 1. The I/O BAT:s are setup as follows:
> BAT 0: 0x10000000@0x80000000 to virtual 0x80000000
> BAT 1: 0x10000000@0xc0000000 to virtual 0xe0000000
> ioremap_base = 0xe0000000
> Are these OK ?

That's fine.  Hopefully, your PCI allocator locates PCI memory base
addresses at 0x00000000-0x10000000 so the BAT translation is used.
If you really want the low latency BAT translation, you'd better
be sure of placement or an ioremap is going to generate PTEs.

> 2. What is the right value for hose->pci_mem_offset ?
>     The physical 0xc0000000 or the address the processor sees
>     0xe0000000.

In this case it's 0xc0000000.  It is used to "fixup" the PCI mem
resources since those are defined to be an ioremmapable "token".  As
you know in PReP (MPC10x map A) CPU and PCI memory space addresses
are not 1:1.

> 3. the driver I am using for testing (for the Tundra Universe) uses
>   the following construction:
>   baseaddr = ioremap(pci_resource_start(uni_pci_dev,0),
> 		pci_resource_len (uni_pci_dev, 0));
>   Then request_mem_region() for the same resources.
>    Then pci_enable_device()
>    Then pci_set_master()
>    After this a access: temp = readl(baseaddr) will generate
>    an Oops with illegal access....
>   What am I doing wrong ?

Also be sure that pci_mem_offset is 0x80000000 in the case of your
memory map.  Otherwise, virt_to_bus() and the pci DMA API will not
generate appropriate PCI mem master addresses for your devices to
use.

> My kernel is a stock 2.4.2 from ftp.kernel.org.

Ports to board like these are much easier off of the linuxppc_2_5 tree
http://www.fsmlabs.com/linuxppcbk.html (port 5005).  There are many
examples of similar boards (there's really nothing new out there
anyway).

--
Matt Porter
MontaVista Software, Inc.
mporter@home.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

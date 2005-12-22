Return-Path: <Phil.Nitschke@avalon.com.au>
From: Phil Nitschke <Phil.Nitschke@avalon.com.au>
To: linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
References: <kw3bkovcup.fsf@lamorak.int.avalon.com.au>
	<20051220010136.GA31165@mag.az.mvista.com>
Date: Thu, 22 Dec 2005 11:24:13 +1030
Message-ID: <kwlkyeq7d6.fsf@lamorak.int.avalon.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: linux DMA capabilities in MV64460
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "MAG" == Mark A Greer <mgreer@mvista.com> writes:

  MAG> Hi Phil,
  MAG> [Note: I'm cc'ing linuxppc-embedded for others to reference and to
  MAG> add their thoughts.]

OK, I've just subscribed...

  MAG> On Tue, Dec 20, 2005 at 10:49:58AM +1030, Phil Nitschke wrote:
  >> Hi Mark,
  >>
  >> I'm developing a device driver to run in the 2.6.10 kernel.  I want to

  MAG> That's a pretty old kernel.  Do you have the option of using a more
  MAG> recent one like 2.6.14?

That might be possible if I reverse-engineer a patch file by comparing
the Artesyn reference kernel (2.6.10) with the kernel.org version, then
trying to apply that patch to the latest kernel.  I'll try this later...

  >> get large amounts of data from a custom peripheral on the PCI bus.  The
  >> software is running on an Artesyn PmPPC7448, which includes a Discovery
  >> III bridge.

  MAG> Can you share exact platform you're using?

I'm using a PMC processor on a custom carrier card (not made by Avalon).
Here are the respective links:

  Carrier:   http://www.tenix.com.au/Main.asp?ID=938
  Processor: http://www.artesyncp.com/products/PmPPC7448.html

  MAG> The bridge supports bursting on the PCI bus as long as the bridge
  MAG> is configured correctly and the PCI device is making an
  MAG> appropriate request.  Note, however, that there are many errata
  MAG> for the Marvell parts including some with cache coherency.  If
  MAG> your system is running with coherency on, you may have to limit
  MAG> your bursts to 32 bytes (i.e., the size of one cache line).

  MAG> You can see how the bursting is set up on the bridge by looking
  MAG> at the platform file for your board (e.g.,
  MAG> <file:arch/ppc/platforms/katana.c> in the latest linux
  MAG> kernel)--search for 'BURST'.

As far as I can tell, there is no platform file for this board in the
mainstream kernel.

In the reference kernel provided by Artesyn, there is a file named
arch/ppc/configs/pmppc7447_defconfig, where CONFIG_NOT_COHERENT_CACHE=y

Therefore in arch/ppc/platforms/pmppc7447.c, there is some code which
does this:

#if defined(CONFIG_NOT_COHERENT_CACHE)
        mv64x60_write(&bh, MV64360_SRAM_CONFIG, 0x00160000);
#else
        mv64x60_write(&bh, MV64360_SRAM_CONFIG, 0x001600b2);
#endif

... and later ...

        for (i = 0; i < MV64x60_CPU2MEM_WINDOWS; i++) {
#if defined(CONFIG_NOT_COHERENT_CACHE)
                si.cpu_prot_options[i] = 0;
                si.enet_options[i] = MV64360_ENET2MEM_SNOOP_NONE;
                si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE;
                si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE;
                si.pci_0.acc_cntl_options[i] =
                    MV64360_PCI_ACC_CNTL_SNOOP_NONE |
                    MV64360_PCI_ACC_CNTL_SWAP_NONE |
                    MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
                    MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
#else
                si.cpu_prot_options[i] = 0;
                si.enet_options[i] = MV64360_ENET2MEM_SNOOP_NONE;       /* errata */
                si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE;       /* errata */
                si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE;       /* errata */
                si.pci_0.acc_cntl_options[i] =
                    MV64360_PCI_ACC_CNTL_SNOOP_WB |
                    MV64360_PCI_ACC_CNTL_SWAP_NONE |
                    MV64360_PCI_ACC_CNTL_MBURST_32_BYTES |
                    MV64360_PCI_ACC_CNTL_RDSIZE_32_BYTES;
#endif
        }

But I'm yet to learn what all this means...

  >> Is there a summary of what is possible and/or not possible with the 4
  >> IDMA channels on the mv64460?

  MAG> The only real documentation is the bridge's user manual from Marvell.
  MAG> Unfortunately, you must sign an NDA to get access to it so I can't share
  MAG> mine with you.  You will need access to that info to get very far so I
  MAG> recommend you contact the people in your company that can make that
  MAG> happen, ASAP.

I talked with a person from Marvell's only Australian distributor, who
told me that they'd not be too keen to give us an NDA, since we're not
developing a project specifically for the Marvell, rather we're using a
Marvell which has already been integrated in the Artesyn card.
Therefore, he argued, Marvell would tell me to go to Artesyn for the
info, as they already have the NDA.  So for now, assume no NDA, no errata.

  >> For example, if the device that I'm trying to get data from supported a
  >> DMA engine capable of initiating bursts on the PCI bus (it currently
  >> can't do this), does the current kernel code support that?

  MAG> That's a hardware feature so its not really an issue of kernel support
  MAG> other than ensuring that the firmware and/or kernel configures the bridge
  MAG> correctly.  IOW, it can be supported by software but its an issue of
  MAG> whether your hardware supports it (and it actually works).

I'm not sure here whether you're talking about the hardware in the
CPU/bridge, or the hardware in the device.  Since the device interfaces
to the PCI bus using firmware inside an FPGA, this is configurable (to a
certain extent).

Currently there is a 2M aperture on the device, but it is not being seen
as "prefetchable", so when I try to get data from the device using
repetitive reads, they are very slow.  Hence my efforts to get DMA
happening.

Presumably the CPU/bridge discovers PCI device memory regions during bus
enumeration.  What characteristic of a device determines whether the
memory region is going to be marked as "prefetchable"?

Does this attribute also affect whether DMA will work?

  >> Or if I wanted to suck the data into main memory using the mv64460 IDMA
  >> controller (assuming the device couldn't initiate its own burst writes),
  >> is there a standard kernel interface to allow me to do this?

  MAG> Yes.  You would make a "dma ctlr driver" for the dma ctlr(s).  I
  MAG> don't know what the best example would be but hopefully someone
  MAG> else has a suggestion.

OK, I'll look into this.  I've been using the O'Reilly book "Linux
Device Drivers, Third Edition" by Jonathan Corbet, Alessandro Rubini,
and Greg Kroah-Hartman.  They say "The kernel developers recommend the
use of streaming mappings over coherent mappings whenever possible."

I'm not sure how the H/W vs S/W coherency discussion has anything to do
with their assertion.  I had previously thought that allocating a huge
buffer (for example at boot time) would be the way to go, but perhaps
getting the CPU to collect the data in smaller amounts into cache
coherent memory will give me the best performance?

  MAG> You may want to pick up "PCI System Architecture" from Mindshare,
  MAG> Inc.  There are ones for PCI-X and PCI-Express too, I think.
  MAG> Well worth the money.

Sounds like a good idea.  I'd hoped not to have to become a PCI expert,
but it seems that there is a lot for me to learn just to determine how
best to design my driver.

Thanks for your input.

--
Phil

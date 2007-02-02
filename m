Return-Path: <rmcguire@videopresence.com>
Received: from smtpout10-04.prod.mesa1.secureserver.net
	(smtpout10-04.prod.mesa1.secureserver.net [64.202.165.238])
	by ozlabs.org (Postfix) with SMTP id 3E1B8DDF81
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Feb 2007 03:01:14 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
References: <000c01c746db$6451e7e0$6405a8c0@absolut>
	<06A02CF1-7D0C-4D59-9628-A2EB0FF3CCF4@kernel.crashing.org>
Subject: RE: MPC8360 : PCI resource allocate error
Date: Fri, 2 Feb 2007 08:01:10 -0800
Message-ID: <001101c746e3$5b8dab00$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <06A02CF1-7D0C-4D59-9628-A2EB0FF3CCF4@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here is the current .dts mapping, though I am beginning to suspect the
hardware or a possible U-boot bug on this.

U-boot can't see the PCI USB card in SLOT 3, but it can see the all of the
other various PCI cards I have <ATI video card, sound card, ATA card,
network card>

All the cards that are seen by U-boot have the IO resource problem. Only
when in Slot 3.

I probably need to direct this at the U-boot crowd, but what about these
defines in U-boot? Would they have any bearing? I forgot to publish these
when I originally had asked the question bout PCI IO space, but they are the
only ALL zero's in the mapping.
-------------STUFF I FORGET TO PUBLISH -------
#define CFG_PCI_SLV_MEM_LOCAL	CFG_SDRAM_BASE  //= 0x0000_0000
#define CFG_PCI_SLV_MEM_BUS	0x00000000	    
#define CFG_PCI_SLV_MEM_SIZE	0x80000000      //Should this be 2GB????
----------------------------------------------
-------------------- OTHER U-BOOT DEFINES --------
#define CFG_PCI_MEM_BASE		0x80000000
#define CFG_PCI_MEM_PHYS		CFG_PCI_MEM_BASE
#define CFG_PCI_MEM_SIZE		0x10000000 /* 256M */
#define CFG_PCI_MMIO_BASE	0x90000000
#define CFG_PCI_MMIO_PHYS	CFG_PCI_MMIO_BASE
#define CFG_PCI_MMIO_SIZE	0x10000000 /* 256M */
#define CFG_PCI_IO_BASE		0xF0300000
#define CFG_PCI_IO_PHYS		0xF0300000
#define CFG_PCI_IO_SIZE		0x00100000 /* 1M */
--------------------------------------------------

Here is the dts section
---------------------

	pci@8500 {
		linux,phandle = <8500>;
		interrupt-map-mask = <3f800 0 0 7>;
		interrupt-map = <
			/* IDSEL 0x19 AD25 */
			 c800 0 0 1 700 14 8
			 c800 0 0 2 700 15 8
			 c800 0 0 3 700 16 8
			 c800 0 0 4 700 17 8
			/* IDSEL 0x1B AD27 */
			 15800 0 0 1 700 14 8
			 15800 0 0 2 700 15 8
			 15800 0 0 3 700 16 8
			 15800 0 0 4 700 17 8
			/* IDSEL 0x1E AD30*/
			 17000 0 0 1 700 14 8
			 17000 0 0 2 700 15 8
			 17000 0 0 3 700 16 8
			 17000 0 0 4 700 17 8
			/* IDSEL 0x1B AD27 */
			 25800 0 0 1 700 14 8
			 25800 0 0 2 700 15 8
			 25800 0 0 3 700 16 8
			 25800 0 0 4 700 17 8 
			>;
			interrupt-parent = <700>;
		interrupts = <42 8>;
		bus-range = <0 0>;
		ranges = <42000000 0 80000000 80000000 0 10000000
			  02000000 0 90000000 90000000 0 10000000
			  01000000 0 f0300000 f0300000 0 00100000>;
		clock-frequency = <3f940aa>;
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <8500 100>;
		compatible = "83xx";
		device_type = "pci";
	};
-------------- END DTS --------------


-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org] 
Sent: Friday, February 02, 2007 7:28 AM
To: rmcguire@videopresence.com
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8360 : PCI resource allocate error


On Feb 2, 2007, at 9:04 AM, Russell McGuire wrote:

> While trying out various of my PCI slots, I ran into this  
> interesting error.
>
>
>
> If I try to put a sounc card, Audigy SE, into SLOT 1 and 2 this  
> error doesn't occur.
>
> But when I place it in the 3rd. I get this:  <Note the 02:0b is  
> SLOT 3>
>
>
>
> <Linux 2.6.20-rc6 compiled for PowerPC / MPC83xx>
>
>
>
> --------------------------------------
>
> PCI: Probing PCI hardware
>
> Try to map irq for 0000:00:19.0...
>
> pci_busdev_to_OF_node(0,0xc8)
>
>  parent is /soc8360@f0000000/pci@8500
>
>  result is <NULL>
>
> Try to map irq for 0000:00:19.1...
>
> pci_busdev_to_OF_node(0,0xc9)
>
>  parent is /soc8360@f0000000/pci@8500
>
>  result is <NULL>
>
> Try to map irq for 0000:02:0b.0...
>
> pci_busdev_to_OF_node(2,0x58)
>
> pci_busdev_to_OF_node(0,0xc9)
>
>  parent is /soc8360@f0000000/pci@8500
>
>  result is <NULL>
>
>  -> got one, spec 2 cells (0x00000017...) on /soc8360@f0000000/pic@700
>
> PCI: bridge rsrc 0..ffffffff (100), parent c038d184
>
> PCI: bridge rsrc 80000000..8fffffff (1200), parent c038d168
>
> PCI: bridge rsrc 90000000..9fffffff (200), parent c038d168
>
> PCI: bridge rsrc f0302000..f0302fff (101), parent c03da03c
>
> PCI:0000:02:0b.0: Resource 0: 0000000000302000-000000000030201f  
> (f=101)
>
> PCI: Cannot allocate resource region 0 of device 0000:02:0b.0
>
> PCI: Error while updating region 0000:02:0b.0/0 (f0302001 != 00302001)
>
> ------------------------------
>
>
>
> What can cause this to not work?

The problem is with the IO resource, for some reason the code things  
your PCI IO space is at f03... instead of 000...

Is Slot 3 behind the P2P bridge or directly connected to the 83xx?

Also, what's your .dts look like now.

- k

Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 016B3DE0CE
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 03:16:27 +1000 (EST)
Date: Wed, 3 Sep 2008 12:15:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: Janaka Subhawickrama <JanakaS@optiscan.com>
Subject: Re: Kernel crash while initialising PCI
Message-ID: <20080903171519.GC10979@loki.buserror.net>
References: <DE0CCFFBFF707949BEABD4537A14ACBA073580F459@mailsvr.optiscan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DE0CCFFBFF707949BEABD4537A14ACBA073580F459@mailsvr.optiscan.com>
Cc: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 03, 2008 at 05:50:10PM +1000, Janaka Subhawickrama wrote:
> My DTS file entries for PCI are as follows:
> 
> pci@8500 {
>                         interrupt-map-mask = <  // Mask the child UnitIrqSpec
>                                                 //ff00 0 0 7
>                                                 ffff ff ff f
>                                                 >;
>                         interrupt-map = <
>                                         // Child UnitIrqSpec, Parent PIC handle, Parent UnitIrqSpec
>                                         // PCI unit address (0000 0 0), Interrupt specifier IDSEL 0x0D (CRX board hard wired to IDSEL 13),
>                                         //      parent Phandle, IRQ7=0x17 (jumper based) level sensitive(8)
>                                         //0d00 0 0 1 &ipic 17 8
>                                         00006800 0 0 1 &ipic 17 8
>                                         >;
>                         interrupt-parent = < &ipic >;
>                         interrupts = <42 8>;            //PCI1 interrupt, level sensitive
>                         bus-range = <0 0>;              //Bus number and largest bus under this
>                         /*
>                                 struct ranges_pci {
>                                         unsigned int pci_space; //Prefechable/relocatable .... IEEE1275
>                                         u64 pci_addr;
>                                         phys_addr_t phys_addr;
>                                         u64 size;
>                                 };
>                         */
>                         ranges = < 02000000 0 A0000000 A0000000 0 20000000
>                                    01000000 0 D8000000 D8000000 0 01000000 >;
>                         clock-frequency = <1FCA055>;    //33333333Hz
>                         #interrupt-cells = <1>;         //PCI aparently uses 1
>                         #size-cells = <2>;              //Max of 2 ints
>                         #address-cells = <3>;           //int size
>                         reg = <8500 100>; //??
>                         compatible = "fsl,mpc8349-pci";
>                         device_type = "pci";
>                 };
> 
> 
> What am I doing wrong ?

The PCI node needs to go under the root node, rather than under the soc
node.  Otherwise, the kernel will try to translate ranges through the IMMR
window.  In older kernels, there was a bug in the PCI code that let you get
away with this.

See current in-kernel device trees for examples.

-Scott

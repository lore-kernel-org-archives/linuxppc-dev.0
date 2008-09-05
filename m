Return-Path: <JanakaS@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id 40487DDF7C
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 10:31:57 +1000 (EST)
From: Janaka Subhawickrama <JanakaS@optiscan.com>
To: 'Scott Wood' <scottwood@freescale.com>
Date: Fri, 5 Sep 2008 10:31:55 +1000
Subject: RE: Kernel crash while initialising PCI
Message-ID: <DE0CCFFBFF707949BEABD4537A14ACBA07A5FBD38D@mailsvr.optiscan.com>
References: <DE0CCFFBFF707949BEABD4537A14ACBA073580F459@mailsvr.optiscan.com>
	<20080903171519.GC10979@loki.buserror.net>
In-Reply-To: <20080903171519.GC10979@loki.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Scott Wood [mailto:scottwood@freescale.com]
> Sent: Thursday, 4 September 2008 3:15 AM
> To: Janaka Subhawickrama
> Cc: 'linuxppc-dev@ozlabs.org'
> Subject: Re: Kernel crash while initialising PCI
>
> On Wed, Sep 03, 2008 at 05:50:10PM +1000, Janaka Subhawickrama wrote:
> > My DTS file entries for PCI are as follows:
> >
> > pci@8500 {
> >                         interrupt-map-mask =3D <  // Mask the child
> UnitIrqSpec
> >                                                 //ff00 0 0 7
> >                                                 ffff ff ff f
> >                                                 >;
> >                         interrupt-map =3D <
> >                                         // Child UnitIrqSpec, Parent
> PIC handle, Parent UnitIrqSpec
> >                                         // PCI unit address (0000 0
> 0), Interrupt specifier IDSEL 0x0D (CRX board hard wired to IDSEL 13),
> >                                         //      parent Phandle,
> IRQ7=3D0x17 (jumper based) level sensitive(8)
> >                                         //0d00 0 0 1 &ipic 17 8
> >                                         00006800 0 0 1 &ipic 17 8
> >                                         >;
> >                         interrupt-parent =3D < &ipic >;
> >                         interrupts =3D <42 8>;            //PCI1
> interrupt, level sensitive
> >                         bus-range =3D <0 0>;              //Bus number
> and largest bus under this
> >                         /*
> >                                 struct ranges_pci {
> >                                         unsigned int pci_space;
> //Prefechable/relocatable .... IEEE1275
> >                                         u64 pci_addr;
> >                                         phys_addr_t phys_addr;
> >                                         u64 size;
> >                                 };
> >                         */
> >                         ranges =3D < 02000000 0 A0000000 A0000000 0
> 20000000
> >                                    01000000 0 D8000000 D8000000 0
> 01000000 >;
> >                         clock-frequency =3D <1FCA055>;    //33333333Hz
> >                         #interrupt-cells =3D <1>;         //PCI
> aparently uses 1
> >                         #size-cells =3D <2>;              //Max of 2
> ints
> >                         #address-cells =3D <3>;           //int size
> >                         reg =3D <8500 100>; //??
> >                         compatible =3D "fsl,mpc8349-pci";
> >                         device_type =3D "pci";
> >                 };
> >
> >
> > What am I doing wrong ?
>
> The PCI node needs to go under the root node, rather than under the soc
> node.  Otherwise, the kernel will try to translate ranges through the
> IMMR
> window.  In older kernels, there was a bug in the PCI code that let you
> get
> away with this.
>
> See current in-kernel device trees for examples.
>
> -Scott

Yep.  That fixed my immediate problem. Thank you very much.
Kernel boots now and I can do lspci and see the basic information of the gr=
aphics card.
Now I have to trace through why I get "PCI: Calling quirk c01a9db8 for 0000=
:00:0d.0".  Any pointers are greatly appreciated.
Cheers
   Janaka

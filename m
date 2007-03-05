Return-Path: <laurent.pinchart@technotrade.biz>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4D64DDF18
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Mar 2007 19:27:38 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l258RDQb002903
	for <linuxppc-embedded@ozlabs.org>; Mon, 5 Mar 2007 09:27:14 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Getting the LED light up... (A&M Rattler 8250PCI linux 2.6.13-AM)
Date: Mon, 5 Mar 2007 09:27:05 +0100
References: <45EAB26F.1060001@tihlde.org>
In-Reply-To: <45EAB26F.1060001@tihlde.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703050927.05201.laurent.pinchart@technotrade.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Robert,

> Got an Analogue & Micro Rattler 8250PCI board running Linux 2.6.13-AM
>
> I'm trying to get the debug LEDs work (LED0-2 connected to PA0-2) but
> havent had any success yet (How #=A4@"$! hard can it be to get a LED light
> up...? :)
>
> Port D bit 24 is accessible on the boards expansion connector, and I
> successfully tested my code to use it as gen purpose I/O (both input and
> output).
>
>
> But when I try to write (change) port A (bit 0-2), nothing changes in
> the register (nor do the LED light up). And my Ethernet FCC1 freezes
> up!! (fs mounted by NFS so I notice)
>
> FCC1 is using a big part of port A, but I'm quite sure I don't touch any
> of those bits (see code below)
>
> I'm a Linux newbie, but I'm starting to wonder if theres any 'lock' or
> something by the kernel on port A?
>
> Any ideas/tips/anything welcome!
>
> br
> Robert
>
> PS, I have a hard time find an immap for the 8250, but since the kernel
> and fs compile fine on my toolchain i assume it there somewhere?
>
>
> ---
> snips of relevant parts of my code:
>
> (it's written and compiled as a module)
>
> typedef struct io_port {
> 	ulong	iop_padir;
> 	ulong	iop_papar;
> 	ulong	iop_pasor;
> 	ulong	iop_paodr;
> 	ulong	iop_padat;
> 	char	res1[12];
> 	ulong	iop_pbdir;
> 	ulong	iop_pbpar;
> 	ulong	iop_pbsor;
> 	ulong	iop_pbodr;
> 	ulong	iop_pbdat;
> 	char	res2[12];
> 	ulong	iop_pcdir;
> 	ulong	iop_pcpar;
> 	ulong	iop_pcsor;
> 	ulong	iop_pcodr;
> 	ulong	iop_pcdat;
> 	char	res3[12];
> 	ulong	iop_pddir;
> 	ulong	iop_pdpar;
> 	ulong	iop_pdsor;
> 	ulong	iop_pdodr;
> 	ulong	iop_pddat;
> 	//char	res4[12];
> } iop8250_t;
> #define IOPORT_BASE_ADDR 0x10D00 // Address to first reg in iop8250
>
> volatile iop8250_t *iommap;
>
> #define P0		0x8000 // P0 bit in registers
> #define P1		0x4000 // P1 bit in registers
> #define P2		0x2000 // P2 bit in registers

Shouldn't that be

#define P0		0x80000000 // P0 bit in registers
#define P1		0x40000000 // P1 bit in registers
#define P2		0x20000000 // P2 bit in registers

?

> #define LED0 P2
> #define LED1 P1
> #define LED2 P0
>
> iommap =3D (iop8250_t *)(CPM_MAP_ADDR+IOPORT_BASE_ADDR);
>
> printk("PDIRA (0x%08X) =3D 0x%08X\n", &(iommap->iop_padir),
> iommap->iop_padir);
> printk("PPARA (0x%08X) =3D 0x%08X\n", &(iommap->iop_papar),
> iommap->iop_papar);
> printk("PSORA (0x%08X) =3D 0x%08X\n", &(iommap->iop_pasor),
> iommap->iop_pasor);
> printk("PDATA (0x%08X) =3D 0x%08X\n", &(iommap->iop_padat),
> iommap->iop_padat);
>
> iommap->iop_papar &=3D ~LED0; // set PA2 to general I/O
> iommap->iop_padir |=3D  LED0; // set PA2 as output
> iommap->iop_padat &=3D ~LED0; // Clear PA2 / LED0 on
>
> printk("PDATA (0x%08X) =3D 0x%08X\n", &(iommap->iop_padat),
> iommap->iop_padat);

Cheers,

Laurent Pinchart

Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id D3EDADDF0B
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 20:37:20 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] [POWERPC] Describe memory-mapped RAM&ROM chips of
	bindings
Date: Thu, 27 Mar 2008 10:37:17 +0100
References: <200803261344.26555.laurentp@cse-semaphore.com>
	<d195a61e876d685ea04b29474da187cc@kernel.crashing.org>
In-Reply-To: <d195a61e876d685ea04b29474da187cc@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803271037.17654.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 March 2008 15:52, Segher Boessenkool wrote:
> > +    Dedicated RAM and ROM chips are often used as storage for=20
> > temporary or
> > +    permanent data in embedded devices. Possible usage include=20
> > non-volatile
> > +    storage in battery-backed SRAM, semi-permanent storage in=20
> > dedicated SRAM
> > +    to preserve data accross reboots and firmware storage in=20
> > dedicated ROM.
> > +
> > +     - compatible : should contain the specific model of RAM/ROM=20
> > chip(s)
> > +       used, if known, followed by either "physmap-ram" or=20
> > "physmap-rom"
> > +     - reg : Address range of the RAM/ROM chip
> > +     - bank-width : Width (in bytes) of the RAM/ROM bank. Equal to the
> > +       device width times the number of interleaved chips.
> > +     - device-width : (optional) Width of a single RAM/ROM chip. If
> > +       omitted, assumed to be equal to 'bank-width'.
>=20
> Maybe I'm rehashing some old discussion here, if so, sorry; but why
> do you have bank-width and device-width here?  What useful information
> does it provide?  If this is about saying what the preferred (or only
> possible) access width is, better names are in order.

device-width isn't used so we can get rid of it. bank-width is used by the=
=20
map_ram driver for erase operations (mapram_erase in=20
drivers/mtd/chips/map_ram.c). To be honest I'm not sure why it uses such an=
=20
inefficient approach instead of memsetting the whole area.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

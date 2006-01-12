Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id E8171689AD
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 06:15:29 +1100 (EST)
Date: Thu, 12 Jan 2006 20:15:27 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1137041067.7774.25.camel@localhost.localdomain>
Message-ID: <19694.1137093327@www37.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> --- Ursprüngliche Nachricht ---
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_stamer@gmx.net>
> Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: AGPGART driver for ArticiaS - ioremap() problem
> Datum: Thu, 12 Jan 2006 15:44:27 +1100
> 
> On Wed, 2006-01-11 at 22:00 +0100, Gerhard Pircher wrote:
> > Hi,
> > 
> > David Bentam and I are trying to get a AGPGART driver working for the  >
> AmigaOne and the Pegasos1. The driver detects the aperture size of the
> > ArticiaS AGP bridge, but fails at the ioremap() function in the generic
> > GATT table create function. Does the PowerPC platform behaves
> > differently for the mapping of address location for AGP operation than >
> the x86 platform? Is it possible to use a mask to relocate the AGP
> > address space to a specific location?
> 
> Well, what value are you passing to ioremap ?
> 
> Ben.

I added some debug code to the agp_generic_create_gatt_table() function.
This is the debug output of it (function renamed to
articias_create_gatt_table()):

 agpgart: [ARTICIAS] articias_fetch_size()
agpgart: [ARTICIAS] * non masked temp = 0x1
agpgart: [ARTICIAS] * aperature size loop index #0
agpgart: [ARTICIAS] * values[0].size_value = 1
agpgart: [ARTICIAS] * masked temp = 0x1
agpgart: [ARTICIAS] * values[0].size = 4
agpgart: [ARTICIAS] * current_size->size = 4
agpgart: [ARTICIAS] * current_size->page_order = 1
agpgart: [ARTICIAS] * current_size->num_entries = 1024
agpgart: [ARTICIAS] * current_size->size_value = 1
agpgart: [ARTICIAS] articias_create_gatt_table()
agpgart: [ARTICIAS] * table address = 0xdfad2000
agpgart: [ARTICIAS] * table end address = 0xdfad3fff
agpgart: [ARTICIAS] * page = 0xc08f9a80
agpgart: [ARTICIAS] * gatt_table_real = 0xdfad2000
agpgart: [ARTICIAS] * agp_gatt_table = 0xdfad2000
agpgart: [ARTICIAS] * virt_to_gart(table) = 0x1fad2000
__ioremap(): phys addr 1fad2000 is RAM lr c000ec3c
agpgart: [ARTICIAS] * gatt_table_real = 0x0
agpgart: unable to get memory for graphics translation table.
agpgart: agp_backend_initialize() failed.
agpgart-articias: probe of 0000:00:00.0 failed with error -12

As far as I can see, the physical address of the table is in the PCI memory
range, right?

Any ideas?

Thanks!

Regards,

Gerhard

-- 
Lust, ein paar Euro nebenbei zu verdienen? Ohne Kosten, ohne Risiko!
Satte Provisionen für GMX Partner: http://www.gmx.net/de/go/partner

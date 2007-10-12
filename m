Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A186DDE29
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 21:52:06 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9CBpvFk023221
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 07:51:57 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9CBpve0119378
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 07:51:57 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9CBplsd003913
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 07:51:47 -0400
Subject: Re: [PATCH] PowerPC: Fix find_legacy_serial_ports on OPB.
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20071012023149.GA21056@localhost.localdomain>
References: <20071011152609.GA10320@ru.mvista.com>
	<200710111750.41852.arnd@arndb.de>
	<1192118028.5534.123.camel@localhost.localdomain>
	<470E5CBC.9040604@ru.mvista.com>
	<1192127513.5534.127.camel@localhost.localdomain>
	<20071012023149.GA21056@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 06:49:59 -0500
Message-Id: <1192189799.3061.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-10-12 at 12:31 +1000, David Gibson wrote:
> On Thu, Oct 11, 2007 at 01:31:53PM -0500, Josh Boyer wrote:
> > On Thu, 2007-10-11 at 21:26 +0400, Valentine Barshak wrote:
> > > Josh Boyer wrote:
> > > > On Thu, 2007-10-11 at 17:50 +0200, Arnd Bergmann wrote:
> > > >> On Thursday 11 October 2007, Valentine Barshak wrote:
> > > >>> Currently find_legacy_serial_ports() can find no serial ports on the OPB.
> > > >>> Thus no legacy boot console can be initialized. Just the early udbg console
> > > >>> works, which is initialized with udbg_init_44x_as1() on the UART's physical
> > > >>> address specified in kernel config. This happens because we look for ns16750
> > > >>> and higher serial devices only and expect opb node to have a device type
> > > >>> property. This patch makes it look for ns16550 compatible devices and use
> > > >>> of_device_is_compatible() for opb instead of checking device type.
> > > >>> Lack of legacy serial ports found causes problems for KGDB over serial.
> > > >>>
> > > >>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> > > >> The patch would make sense if we were only dealing with flattened device
> > > >> tree systems at this point. Unfortunately, IBM is shipping hardware that
> > > >> encodes the serial port in exactly the way that find_legacy_serial_ports
> > > >> is looking for (parent->type == "opb", compatible = "ns16750" "ns16550"
> > > >> "ns16450" i8250").
> > > >>
> > > >> Changing the search for ns16750 to ns16550 should be fine, but unnecessary
> > > >> because AFAIK, all OPB serial imlpementations are actually ns16750 and
> > > >> should have that in the device tree as well.
> > > >>
> > > >> For the device type of the bus, please check for both compatible and
> > > >> type, so that it still works on machines that are missing the compatible
> > > >> property.
> > > > 
> > > > Wait, no.  We already had this discussion months ago when David was
> > > > working on the original Ebony port.  It was declared that legacy_serial
> > > > is not how serial should be done on 4xx and the serial_of driver was
> > > > supposed to be used instead.
> > > > 
> > > > Have we changed our stance on that?  If not, then perhaps KGDB should be
> > > > fixed to work with serial_of.
> > > 
> > > Actually I don't see any reason not to use legacy_serial stuff for early 
> > > console. We could split the kernel configured very early debug output, 
> > > which uses  PPC_EARLY_DEBUG_44x_PHYSLOW/PHYSHIGH (since it's really 
> > > dangerous) and early console things by using legacy serial. We could use 
> > >   early boot console without PPC_EARLY_DEBUG_44x.
> > 
> > That was exactly my thinking when this first came up.  I'd like to hear
> > David's opinion on it.
> 
> Yeah, I think I misinterpreted BenH way back when.  This looks ok, and
> means serial will be initialized earlier than of_serial, which would
> be nice.

Great.  It seems Paul pulled it into his tree already as well, which
suits me just fine.

josh

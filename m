Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0FBF2DE089
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 01:56:47 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9BFuarf012533
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 11:56:36 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9BFuZ5F476788
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 09:56:36 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9BFuZ1f030828
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 09:56:35 -0600
Subject: Re: [PATCH] PowerPC: Fix find_legacy_serial_ports on OPB.
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>, david@gibson.dropbear.id.au
In-Reply-To: <200710111750.41852.arnd@arndb.de>
References: <20071011152609.GA10320@ru.mvista.com>
	<200710111750.41852.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 10:53:48 -0500
Message-Id: <1192118028.5534.123.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-10-11 at 17:50 +0200, Arnd Bergmann wrote:
> On Thursday 11 October 2007, Valentine Barshak wrote:
> > Currently find_legacy_serial_ports() can find no serial ports on the OPB.
> > Thus no legacy boot console can be initialized. Just the early udbg console
> > works, which is initialized with udbg_init_44x_as1() on the UART's physical
> > address specified in kernel config. This happens because we look for ns16750
> > and higher serial devices only and expect opb node to have a device type
> > property. This patch makes it look for ns16550 compatible devices and use
> > of_device_is_compatible() for opb instead of checking device type.
> > Lack of legacy serial ports found causes problems for KGDB over serial.
> > 
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> 
> The patch would make sense if we were only dealing with flattened device
> tree systems at this point. Unfortunately, IBM is shipping hardware that
> encodes the serial port in exactly the way that find_legacy_serial_ports
> is looking for (parent->type == "opb", compatible = "ns16750" "ns16550"
> "ns16450" i8250").
> 
> Changing the search for ns16750 to ns16550 should be fine, but unnecessary
> because AFAIK, all OPB serial imlpementations are actually ns16750 and
> should have that in the device tree as well.
> 
> For the device type of the bus, please check for both compatible and
> type, so that it still works on machines that are missing the compatible
> property.

Wait, no.  We already had this discussion months ago when David was
working on the original Ebony port.  It was declared that legacy_serial
is not how serial should be done on 4xx and the serial_of driver was
supposed to be used instead.

Have we changed our stance on that?  If not, then perhaps KGDB should be
fixed to work with serial_of.

josh

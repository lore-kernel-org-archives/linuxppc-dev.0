Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by ozlabs.org (Postfix) with ESMTP id 826721007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 00:01:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Bug in drivers/serial/of_serial.c?
Date: Thu, 19 Nov 2009 14:01:37 +0100
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<200911160909.08433.arnd@arndb.de>
	<8B957E110B62714A84290A01A597805F05D2AE31@Exchange.discretix.com>
In-Reply-To: <8B957E110B62714A84290A01A597805F05D2AE31@Exchange.discretix.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911191401.37531.arnd@arndb.de>
Cc: Alon Ziv <alonz@discretix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 19 November 2009, Alon Ziv wrote:
> On Monday, November 16, 2009, Arnd wrote:
> > > -       { .type = "serial", .compatible = "ns16550",  .data = (void
> *)PORT_16550, },
> > > +       { .type = "serial", .compatible = "ns16550",  .data = (void
> *)PORT_16550A, },
> > 
> > Does not seem logical. If the device claims compatibility with
> ns16550, we should
> > not automatically assume it's an ns16550a. Why not add another line
> for 
> > 
> 
> Unfortunately, there is no way to change what the device claims--it's
> encoded into the OpenFirmware tree by the EDK tools.
> And, in any case, the device is actually not lying: it is compatible
> with NS16550--just with a non-buggy one.  Unfortunately the kernel
> driver for 8250-class UARTs makes the conservative choice to assume any
> 16550 is one of the (early, buggy) revisions where the FIFO was
> non-functional; any 16550 with working UART is classed as a 16550A.

In that case, add another entry for the device encoded in the firmware
itself. The ns16550 entry should be the second one after a more specific
one telling which device it is exactly.

	Arnd <><

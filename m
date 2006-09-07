Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 36B7967BA1
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 22:48:30 +1000 (EST)
Date: Thu, 7 Sep 2006 07:47:29 -0500
From: Olof Johansson <olof@lixom.net>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [4/5] powerpc: PA Semi PWRficient platform support
Message-ID: <20060907074729.6d1765be@localhost.localdomain>
In-Reply-To: <86FCADAC-25CF-42B1-8FFB-06889AF6C90E@kernel.crashing.org>
References: <20060904175742.5472a6fa@localhost.localdomain>
	<20060905122956.2cebd36d@localhost.localdomain>
	<0C880511-D99D-4160-9EB1-A66B22B2D82F@kernel.crashing.org>
	<20060906101034.404014f7@localhost.localdomain>
	<1157590706.22705.272.camel@localhost.localdomain>
	<86FCADAC-25CF-42B1-8FFB-06889AF6C90E@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, anton@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 7 Sep 2006 13:28:25 +0200 Segher Boessenkool <segher@kernel.crashing.org> wrote:

> >> How about I keep it this way until Maple is fixed then? It's  
> >> better to keep it
> >> fairly common anyway. Functionally there's no difference.
> >
> > Well, the platform-open-pic thingy comes from the CHRP spec.
> 
> I can't find it there.  I'm looking at version 1.0; maybe it's
> in a newer version that I don't have?  It's not in the PAPR
> either (the "open" version, anyway).

1.5 from http://openbios.org/docs/index.html has it (section 5.1.1):

prop-name indicates the system Open Firmware Interrupt Controller physical address.

prop-encoded-array: List of system phys-addr values

This property is a list of system physical addresses corresponding to "reg" property
of the system Open Firmware Interrupt Controller


reg for the openpic is (section 5.5.1):

Standard prop-name, defines the base physical address(s) and size(s)
of this Open PIC's addressable register space.

prop-encoded-array: List of (phys-addr, size) specifications

Phys-addr is encoded as with encode-phys, and size is encoded as with encode-int.

The first entry in this list shall be the physical address and size
decoded by the base Open PIC Interrupt Delivery Unit (IDU). Successive
entries in this list shall be the physical addresses and sizes decoded
by any additional Open PIC Interrupt Source Units (ISU).

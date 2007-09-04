Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0ABE5DDDF5
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 21:49:47 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 04 Sep 2007 13:49:45 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
Message-ID: <20070904114945.303440@gmx.net>
MIME-Version: 1.0
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Tue, 4 Sep 2007 00:32:57 +0200
> Von: Segher Boessenkool <segher@kernel.crashing.org>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
> Betreff: Re: [RFC] AmigaOne device tree source v2

> PCI memory space sits on the PCI bus, not on the PCI host bridge,
> so is not part of "reg" but is part of "ranges" here, since it is
> direct mapped into the host's address space.
That's right, but what about this example here (from a Pegasos II):

/proc/device-tree/pci@80000000:
name             "pci"
linux,phandle    0fc59260 (264606304)
bus-range        00000000 00000000
pci-bridge-number 00000000
reg              80000000 40000000
8259-interrupt-acknowledge f1000cb4
ranges           01000000 00000000 00000000 fe000000 00000000 00010000
		 02000000 00000000 80000000 80000000 00000000 40000000
clock-frequency  01fca055 (33333333)
#size-cells      00000002
#address-cells   00000003
device_type      "pci"

AFAIU the reg property overlaps the ranges property for the PCI memory
space from 0x80000000 to 0xC0000000 or the CPU address space at the
same location!? Would be good to know, why it was defined like this.

> PCI legacy I/O is not direct mapped: there is no legacy I/O on a
> PowerPC system bus.  So, it can not be mentioned in the "ranges"
> property, but the PHB registers used to access it should be shown
> in the "reg" property.  It could be a simple linear window (it
> sounds like it is here?), but it could for example also be implemented
> via an address/data register pair.
Yes, it is a simple linear address window. I'll remove its address range
from the reg property.

> The order of the "reg" entries depends on the exact model of PCI
> bridge, so a device binding for it has to be written.
Only the Pegasos I and the AmigaOne use this PCI bridge. I guess it should
be enough to check for the board type, but a compatible property doesn't
hurt.

Thanks,

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger

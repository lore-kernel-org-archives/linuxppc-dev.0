MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16493.61242.908659.82167@cargo.ozlabs.ibm.com>
Date: Sat, 3 Apr 2004 08:54:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with dma_alloc_coherent()
In-Reply-To: <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>
	<20040401100546.A27472@home.com>
	<4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com>
	<20040401181926.GA3630@gate.ebshome.net>
	<406C658E.10500@embeddededge.com>
	<20040401185956.GB3786@gate.ebshome.net>
	<2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com>
	<20040401191715.GC3786@gate.ebshome.net>
	<406C8104.9050609@acm.org>
	<20040401220018.GA4130@gate.ebshome.net>
	<D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Whitney writes:

> As an exemplification of the problem I am having with the current
> DMA/PCI API:
>
> I am developing a Generic DMA driver.  DMA providers register
> themselves with it.  Clients ask the DMA core driver to please have a
> registered driver transfer the data from one location to another, and
> call them back when it is complete.

It sounds like you have the model of a DMA controller that is separate
from any I/O device that needs to transfer data to/from memory, and
you want to use it to transfer data from one memory location to
another.  Just like in the bad old days of the PC/XT. :)

That is not the model that PCI/DMA API is designed for.  The model it
is designed for is one where you have a bridge, often with an IOMMU
that remaps bus addresses to memory addresses on a page granularity,
and behind that you have a bus-master capable device.  Thus the
PCI/DMA API takes care of setting up an appropriate translation in the
IOMMU (if any) and returning the bus address that the driver should
use.  The way that the driver gives the bus address to the device is
very device-dependent and isn't handled by the API.

If you want to write code to handle a separate DMA controller, go
ahead.  You will need to design your own separate API for it.  I
wouldn't try to make it too general, though, since there are very few
systems these days that have DMA controllers (as distinct from
bus-master capable I/O devices).

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

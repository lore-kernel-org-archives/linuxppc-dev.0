Message-ID: <406DB5DC.6060508@acm.org>
Date: Fri, 02 Apr 2004 13:50:04 -0500
From: "Michael R. Zucca" <mrz5149@acm.org>
MIME-Version: 1.0
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with dma_alloc_coherent()
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net> <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com> <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org> <20040401220018.GA4130@gate.ebshome.net> <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com>
In-Reply-To: <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Whitney wrote:
>
> As an exemplification of the problem I am having with the current
> DMA/PCI API:
>
> I am developing a Generic DMA driver.  DMA providers register
> themselves with it.  Clients ask the DMA core driver to please have a
> registered driver transfer the data from one location to another, and
> call them back when it is complete.

If CPU memory is assumed to be a source/target and the other
source/target is the device, then you should take a DMA direction, a
virtual address, a device or bus, and a bus-local address. If CPU memory
isn't the only target or the DMA engine is between a bunch of bridges,
you might need to take a source bus and bus-local address, and a
destination bus and bus-local address.

If you have the bus and the bus-local address you should be able to
deduce what bridges you have to program/translate-through to do the
transfer with the DMA engine. Once you know that you should be able to
translate a bus-local address to whatever address is appropriate for the
DMA engine and program any intervening bridges appropriately.

Does Linux currently have the smarts to do this? Beats me, but it should
if it's ever going to hope to deal with the crazy array of busses and
bridges coming out of the minds of hardware engineers these days. :-)

--
----------------------------------------------
  Michael Zucca - mrz5149@acm.org
----------------------------------------------
  "I'm too old to use Emacs." -- Rod MacDonald
----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

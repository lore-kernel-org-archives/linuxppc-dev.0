In-Reply-To: <406DB5DC.6060508@acm.org>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net> <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com> <20040401191715.GC3786@gate.ebshome.net> <406C8104.9050609@acm.org> <20040401220018.GA4130@gate.ebshome.net> <D7F4C570-84C5-11D8-9FF0-000A95A07384@sands-edge.com> <406DB5DC.6060508@acm.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C9A11702-84DB-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Re: Problems with dma_alloc_coherent()
Date: Fri, 2 Apr 2004 14:27:32 -0500
To: "Michael R. Zucca" <mrz5149@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Apr 2, 2004, at 1:50 PM, Michael R. Zucca wrote:

> John Whitney wrote:
>> As an exemplification of the problem I am having with the current
>> DMA/PCI API:
>> I am developing a Generic DMA driver.  DMA providers register
>> themselves with it.  Clients ask the DMA core driver to please have a
>> registered driver transfer the data from one location to another, and
>> call them back when it is complete.
>
> If CPU memory is assumed to be a source/target and the other
> source/target is the device, then you should take a DMA direction, a
> virtual address, a device or bus, and a bus-local address. If CPU
> memory isn't the only target or the DMA engine is between a bunch of
> bridges, you might need to take a source bus and bus-local address,
> and a destination bus and bus-local address.
>

The "device" will always be the DMA controller (since it is moving data
from one place to another), and all physical addresses should be from
the controller's perspective.  However, the client does not know what
DMA controller might be used (or even which ones exists), as it has
been abstracted.  Direction is not needed to be specified.  The source
will ALWAYS be "to device" the destination will always be "from
device".  The DMA controller device just needs source and destination
physical addresses (adjusted for its memory space).

I'm not trying to handle wierd bus scenarios... I'm just trying to
figure out how to go from a virtual address to a DMA-controller
specific one, with the constraints I have been told about with the
LinuxPPC kernel, in an abstracted interface.  As I outlined in the
previous message, I can't see a way to do this.


Heck, let's make it simple.  Let's say I have a high-speed serial port,
and I want to DMA data to it with a known DMA controller (not
abstracted) with a standard "device" structure associated with it.  The
serial driver has the physical address of the 1-byte transmit register
of the serial port that it wants to DMA to.  How does he make this into
a physical address the known DMA controller device can use?  There is
no phys_to_bus() macro, and it would be deprecated if it existed.
There is no DMA/PCI API for taking a physical address and converting it
to a dma_addr_t for a specific device (the DMA controller).  I can't
ioremap() the device, and pass that virtual address to the DMA API, as
it will produce a bad physical address and I have been told this is the
desired way for the API to work.

What's generic method is left, that doesn't require platform-specific
code?

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

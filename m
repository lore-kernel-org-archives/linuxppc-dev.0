Date: Thu, 12 Apr 2001 00:36:33 +0100
Message-Id: <200104112336.AAA08972@mail.bigwig.net>
To: jtm@smoothsmoothie.com
Subject: Re: Ethernet Bridging on 8260
From: Jim Chapman <hea23587@bigwig.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Reply-To: jim.chapman@bigwig.net
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ah, there's someone else out there trying to break linux with a
SmartBits tester!! :)

I ran into similar problems; and they get even worse when you blast 64
byte packets rather than 1500 byte packets at the box! The problem is
caused by the kernel being starved of the CPU by spending too much
time in interrupt handlers.

On a typical PC, the CPU interrupt rate from a NIC can be throttled by
the PCI bus / PCI bridge chip. Also, while data is being copied across
PCI to/from the NIC from/to the host memory, the host CPU is often
able to do other work between PCI burst cycles. For the 8260,
interrupts will occur as fast as new packets arrive in the FCC's bd
ring, assuming FCC interrupts are enabled. For 100M ethernet, that can
be real fast...

With the 8260, when packets are received, the FCC interrupt handler
allocates skbs and queues them on the kernel's network input queue via
netif_rx(). The interrupt handler keeps taking buffers from the rx bd
ring until no more rx bds are available. Assuming the ISR eventually
gives up the CPU, when a packet reaches the bridge code, the bridge
determines the output device(s) and queues the packet for transmission
via dev_queue_xmit(). (I assume your SmartBit test frames are "real"
unicast frames - broadcast / multicast frames incur much more
processing overhead.) Since you're getting so many interrupts, the
kernel isn't getting enough of the CPU to process its input / output
queues so the skbs just build up on backlog queues until a limit is
reached or you run out of memory.

Unlike BSD, linux does not have network buffer pools; the network
drivers and network kernel code allocate buffers (skbs) from system
memory. However, there is a configurable limit to the size of the
receive backlog queue. Try changing the
/proc/sys/net/core/netdev_max_backlog value and make it much
smaller. Perhaps its value (default 300) is too big for your available
memory (300 1500 byte packets is ~450k). If the length of this queue
exceeds the configured value, netif_rx() just drops packets.

Packets can build up in the transmit queues(s) too and there is no
limit to the size to which they can grow. You say that if you blast
packets in on both ports, the kernel doesn't die. This might be
because the CPU is stuck permanently in CPU receive processing, where
netif_rx() just keeps discarding the skbs because the receive backlog
limit has been reached. If the bridge code (or other protocol stacks)
are unable to generate transmit data because they never run, skbs
won't build up on the transmit queues.

I've made extensive modifications to the FCC driver and related code
which make the system much better behaved under load. I'm still
working on fixing the last few bugs. Here's a brief summary, fyi:

 * Add a cpm tasklet for doing all cpm "interrupt" processing. The ISR
   now simply disables further interrupts from the device, acks the
   interrupt and flags that the cpm tasklet has work to do. The kernel
   schedules the tasklet as soon as it can, typically at the next call
   to schedule(). The interrupt is used only to kick off task level
   kernel processing.

 * Change the rx/tx bd ring processing routines (which used to be in
   the ISR) to loop only for a fixed quota before returning control
   back to the kernel (tasklet). The tasklet calls these routines
   again and again (perhaps between servicing other devices) until the
   device driver says that it has no more work to do. This allows all
   CPM device drivers to get a fair slice of the CPU cake. The
   device's interrupt is enabled again only when the tx/rx bd rings
   have no more events to process. In this way, FCC interrupts are
   effectively disabled when the system is under load while the
   tasklet invokes active drivers.

 * Improve the efficiency of bd ring and register access.

 * Modify net/core/skbuff.c to allow skbs to be preallocated with
   specific memory buffers and assigned to pools. Modify the FCC
   driver to use the preallocated skbs so that no data copy is needed
   in the driver's receive path (the bd ring's data buffer ptr points
   into the pre-prepared skb data buffers). Also, dev_alloc_skb()
   effectively becomes a skb_dequeue() from the skb pool list which is
   much more efficient. I use the ability to assign specific data
   buffers to skb->data because my board has local memory (on the
   CPU's Local Bus) which I use specifically for data buffers.

Changing the driver interrupt strategy as described above
significantly improves performance and behavior under load. It also
allows the kernel to decide which events should be processed when, not
the CPU's interrupt prioritization logic. With these changes, I can
still type commands at the console shell prompt when running my
SmartBits tests...

Hope I've helped!

Jim

jtm@smoothsmoothie.com wrote:

> We're trying to enable ethernet bridging between FCC2 and FCC3 on an
> 8260 (EST's SBC8260 eval board), and running into problems.
>
> Our test is to send it continuous 1500 byte ethernet packets from
> a SmartBits traffic generator. Transmitting on one port, everything
> is fine until we send more than about 7500 packets back to back.
>
> Below that value, all of the values reported by ifconfig are correct,
> and memory use (reported by free) is constant. Above that value,
> the 'TX packets' value reported from ifconfig does not match what
> the SmartBits says it received, and according to free, we start using
> more memory that never gets released. If we send 3-5 bursts of 8000
> packets, we start getting output like:
>         Out of Memory: Killed process 16 (sh)
>         Out of Memory: Killed process 18 (inetd)
>         __alloc_pages: 0 - order allocation failed.
>         eth2: Memory squeeze, dropping packet
>
> And so on.
>
> Another test that we have tried is sending traffic on both ports. As
> long as we send on both ports, we can generate traffic all the way
> up to 100 Mbps without killing the kernel. (It can't keep up, but it
> doesn't die). Above 95 Mbps, if we stop transmitting on one of the
> ports, the system dies with error messages like those above.
>
> We are using kernel 2.4.3, with a modified driver from bitkeeper's 2.5
> kernel. The differences are:
>         mii_discover_phy_poll() is commented out, and
>                 cep->phy_speed is set to 100,
>                 cep->phy_duplex is set to 1
>         fcc->fcc_fgmr has the TCI bit cleared
>
> We are running the 8260 core at 133 MHz and the CPM at 133 MHz
>
> --
> Jay Monkman         The truth knocks on the door and you say "Go away, I'm
> monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
>                      - from _Zen_and_the_Art_of_Motorcycle_Maintenance_
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

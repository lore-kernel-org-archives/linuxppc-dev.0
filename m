Date: Fri, 14 Jan 2000 16:12:55 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: Niklaus Giger <n.giger@netstal.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Help Sought: 8390-Ethernet Troubles on PowerPC 4xx Port
In-Reply-To: <s87fa3ee.073@netstal.com>
Message-ID: <Pine.SGI.4.10.10001141601470.264375-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 14 Jan 2000, Niklaus Giger wrote:
> Are you sure that the ethernet interrupt are correclty handled? It
> seems to me that the oak board never answers.

I definitely receive and handle the interrupt. The call chain is as
follows when I chase it with single-step from 0x500.

                  
  0x500 -> do_IRQ -> oak_get_irq -> ppc4xx_pic_get_irq -> IRQ = 27
              |
              `----> ppc_irq_dispatch_handler
                              |
                              `---> ppc4xx_pic_mask_and_ack
                              `---> ei_interrupt
                              `---> ppc4xx_pic_unmask

> Have you ever serviced correctly a interrupt on the PPC403? If you
> have HW-debug possiblity through the JTAG, try to break on external
> interrupt at address 0x500 and step through the interrupt code to
> verify that it works correctly.

Yes, it appears to be working correctly. I haven't dove into the actual
logic of ei_interrupt, however. I'm presuming (perhaps incorrectly) that
the 8390.c code is pretty architecture neutral.

> Other idea: Do you need a byte swapping to set the controller
> TCP/IP-address/ethernet adresses?

That's a possibility. The Ethernet address is OK and can be verified by
looking at the ARP trace I sent (the MAC addresses from the PROM-generated
and Linux-generated ARPs are the same). I don't think* the IP address
should come into play until the Oak controller has grabbed the ARP reply
from the server, right?

Thanks again for the input!

Regards,

Grant


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <393D2ECF.98A29632@lucent.com>
Date: Tue, 06 Jun 2000 12:03:11 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: net driver receive problems
References: <21966.960193171@msa.cmst.csiro.au> <393C0FA3.9208BAE1@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does anybody know how to write a net driver for a 2.2 kernel?

Rubini's book _Linux_Device_Drivers_ only covers the 2.1 kernel,
and significant changes have been made since then.

I have essentially identical drivers on board and host, but
they behave differently -- the PowerPC version works but the i386
does not.

In particular, I have looked through the kernel code and made the
driver no longer crash the kernel. But I cannot get the host's
network stack to accept packets received by my driver; the powerpc
Linux stack accepts them just fine.

My configuration is that I boot a PowerPC board (with Linux
2.2.15-2.9.0) from an i386 host running RedHat Linux 2.2.14-5.0.
I have a SIO driver on both host and board which becomes the console
of the board's Linux, and on the host the boot program becomes a
cheap terminal emulator so I can issue commands to the board's Linux
and see its printk's and responses. The on-board linux comes up
fine and my init script configures and starts the network device.

ifconfig of my device on the host shows packets received, but
netstat -s shows IP did not get them. When I dump the skb the data
it contains looks at least superficially like a valid IP datagram
(the 3rd word is the IP address of the board, and the 4th word is
the IP address of the host [count words from 0]).

The weird thing is that when I ping my PowerPC board from the
i386 host, the packets are received on the PowerPC Linux just fine,
and they are returned just fine, but the host does not see them
after the driver calls netif_rx(). On the PowerPC "netstat -s"
shows all packets received and sent by both IP and ICMP; on the
host neither IP nor ICMP sees any packets. On both PowerPC and
host, "ifconfig lspsnet" shows the right number of packets sent
and received. And debugging printk-s of the skb just before the
call to netif_rx() are quite similar on the PowerPC and host --
the IP addresses are interchanged as expected.


What I think are the relevant details: this is not an ethernet;
my do_rcvpkt() is called every tick using a timer; it checks for
a packet arrival (in a memory buffer), and when one arrives:
	// data = pointer to the packet data
	// len = length of the packet data (# bytes)
	/* allocate and fill a skb */
        len4 = (len+3) & ~3;
        skb = dev_alloc_skb(len4);
        if(!skb) return (npkt ? 0 : -ENOMEM);
	memcpy(skb_put(skb,len),data,len);
        skb->dev = dev;
        skb->protocol = ETH_P_IP;
        skb->pkt_type = PACKET_HOST;
        skb->ip_summed = CHECKSUM_UNNECESSARY;
        /* all packets received are for us -- fake mac addr */
        skb->mac.raw = skb_push(skb,dev->addr_len);
        memcpy(skb->mac.raw,dev->dev_addr,dev->addr_len);
        skb_pull(skb,dev->addr_len);
	// deliver skb to higher layers
        netif_rx(skb);
	// update counter and statistics
	++npkt;
	dev->last_rx = jiffies;
        ++Enet_stats.rx_packets;
        Enet_stats.rx_bytes += len;

Note the attempt to fake out the mac address (mac.raw must point
between skb->head and skb->data). My dev->addr_len is 1, but
changing it to 6 did not help. Printing the skb contents shows that
the drivers do indeed transfer the data unchanged, and I think
I set all the required skb fields above.... WHAT AM I MISSING???


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

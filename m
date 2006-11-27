Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 216D167C3F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Nov 2006 09:44:32 +1100 (EST)
Date: Mon, 27 Nov 2006 14:44:30 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Jeff Mock <jeff@mock.com>
Subject: Re: PPC440GX ethernet oddities
Message-ID: <20061127224430.GA20171@gate.ebshome.net>
References: <456A641D.7070904@mock.com>
	<20061127042554.GB26806@gate.ebshome.net>
	<456B21C3.6040203@mock.com>
	<20061127201859.GA14806@gate.ebshome.net>
	<456B6475.4010109@mock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <456B6475.4010109@mock.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 27, 2006 at 02:19:33PM -0800, Jeff Mock wrote:
> 
> 
> Eugene Surovegin wrote:
> > On Mon, Nov 27, 2006 at 09:34:59AM -0800, Jeff Mock wrote:
> >> # ./ethtool -S eth0
> >> NIC statistics:
> >>      rx_packets: 683430611
> >>      rx_bytes: 45405076316
> >>      tx_packets: 1331225622
> >>      tx_bytes: 2005276384145
> >>      rx_packets_csum: 683428670
> >>      tx_packets_csum: 1331224150
> >>      tx_undo: 0
> >>      rx_dropped_stack: 80
> >>      rx_dropped_oom: 0
> >>      rx_dropped_error: 0
> >>      [lots more 0's...]
> >>
> >> The number of checksum errors seems okay and doesn't really change when
> >> I plug in the second network connection, but the ring buffer usage still
> >> increases dramatically.
> > 
> > Stats look OK.  BTW, tx/rx_packets_csum is not a number of checksum 
> > errors, that's a number of packets where driver used hw checksum 
> > acceleration :).
> > 
> 
> Ah, silly me.  Can you tell me where I can find the number of received
> packets with bad ethernet checksums?  I'm still thinking that I might
> have a little hardware problem that is increasing the bit error rate
> when I use both ports, ultimately increasing my buffer utilization.

Packets with bad ethernet checksums are dropped by the MAC before 
being handed off to MAL. You can disable this behavior by setting 
RFP bit in EMACx_RMR register. In this case I think IP stack will drop 
these packets because IP and/or TCP checksum will fail. Use netstat -s 
to check network stack statistics.

Here is untested patch which enables RFP bit. It's against recent-ish 
kernel.org git tree:

diff --git a/drivers/net/ibm_emac/ibm_emac_core.c b/drivers/net/ibm_emac/ibm_emac_core.c
index ffeafb2..56ad988 100644
--- a/drivers/net/ibm_emac/ibm_emac_core.c
+++ b/drivers/net/ibm_emac/ibm_emac_core.c
@@ -372,7 +372,7 @@ static void emac_hash_mc(struct ocp_enet
 static inline u32 emac_iff2rmr(struct net_device *ndev)
 {
        u32 r = EMAC_RMR_SP | EMAC_RMR_SFCS | EMAC_RMR_IAE | EMAC_RMR_BAE |
-           EMAC_RMR_BASE;
+           EMAC_RMR_BASE | EMAC_RMR_RFP;

        if (ndev->flags & IFF_PROMISC)
                r |= EMAC_RMR_PME;



-- 
Eugene

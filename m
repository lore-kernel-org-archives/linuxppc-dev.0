Return-Path: <gjb@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id C7710DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 08:26:59 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 58EBC142CC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 00:01:05 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31905-09 for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 00:01:04 +0200 (CEST)
Message-ID: <46560B34.2070800@semihalf.com>
Date: Fri, 25 May 2007 00:01:24 +0200
From: Grzegorz Bernacki <gjb@semihalf.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] mpc52xx: Correct calculation of FEC RX errors.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

'ifconfig eth0' command for mpc5200B-based cards shows error for RX.
However none of RX MIB counters is set to value greater than zero.
Number of errors is equal to number of multicast packet. In linux 2.4
calculation of RX errors is slightly different and takes into account
number of multicast packet. This change is a port of calculation method
of RX errors for FEC controller from linux 2.4 to 2.6.

Signed-off-by: Grzegorz Bernacki <gjb@semihalf.com>
---

 drivers/net/fec_mpc52xx/fec.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fec_mpc52xx/fec.c b/drivers/net/fec_mpc52xx/fec.c
index f0ce87e..d2087f6 100644
--- a/drivers/net/fec_mpc52xx/fec.c
+++ b/drivers/net/fec_mpc52xx/fec.c
@@ -395,7 +395,9 @@ static struct net_device_stats *fec_get_stats(struct
net_device *dev)

        stats->rx_bytes = in_be32(&fec->rmon_r_octets);
        stats->rx_packets = in_be32(&fec->rmon_r_packets);
-       stats->rx_errors = stats->rx_packets -
in_be32(&fec->ieee_r_frame_ok);
+       stats->rx_errors = stats->rx_packets - (
+                       in_be32(&fec->ieee_r_frame_ok) +
+                       in_be32(&fec->rmon_r_mc_pkt));
        stats->tx_bytes = in_be32(&fec->rmon_t_octets);
        stats->tx_packets = in_be32(&fec->rmon_t_packets);
        stats->tx_errors = stats->tx_packets - (

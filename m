Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 531B2DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 06:06:00 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IGKAI-00086p-5j
	for linuxppc-dev@ozlabs.org; Wed, 01 Aug 2007 12:47:26 -0700
Message-ID: <11952546.post@talk.nabble.com>
Date: Wed, 1 Aug 2007 12:47:26 -0700 (PDT)
From: Mit Matelske <mit@sweeet.net>
To: linuxppc-dev@ozlabs.org
Subject: FEC driver not working after upgrade
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I upgraded from an old 2.4.25 kernel to the latest Denx snapshot and cannot
get the ethernet to work.  I was previously running the FEC driver that used
the sdma interface.  I get a couple of interrupts and that is it.

Output when initializing:

mpc5xxx_fec_init
fec_priv c3f83160
MPC5200 I2S driver (16 BDs x 16 bytes).
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
mpc5xxx_fec_open
mpc5xxx_fec_restart
eth0: duplex set to 1
mii_queue: 600a0000 c0130bb0 00000000
mpc5xxx_fec_interrupt:
mpc5xxx_fec_mii 60080141 c0130bb0 00000000
mii_discover_phy
mii_queue: 600e0000 c0130abc 00000000
mpc5xxx_fec_interrupt:
mpc5xxx_fec_mii 600e0c87 c0130abc 00000000
eth0: Phy @ 0x0, type 88E6060 (0x01410c87)

Whenever I try to transmit anything I get:

mpc5xxx_fec_hard_start_xmit:
dev c3f83000, priv c3f83160, skb c3bcc860

The phy code works in the old fec driver fine, but I have tried the generic
phy driver also and it acts exactly the same.  

The major change was done by this patch back on Sept 4, 2005:

Modifications to the MPC5200 ATA and FEC drivers based on the
linuxppc_2_4_devel-fec+ata.patch and linux.habanero.fifo_cntrl.patch
patches from Freescale.

I am running a 5200B.  Thanks for any help.

Mit
-- 
View this message in context: http://www.nabble.com/FEC-driver-not-working-after-upgrade-tf4202285.html#a11952546
Sent from the linuxppc-dev mailing list archive at Nabble.com.

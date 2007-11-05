Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF937DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 05:15:41 +1100 (EST)
Date: Mon, 5 Nov 2007 12:15:30 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Li Yang <leoli@freescale.com>, Kumar Gala <galak@kernel.crashing.org>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5] fixups for mpc8360 rev. 2.1 erratum #2 (RGMII Timing)
Message-Id: <20071105121530.5c38fbb7.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

the following patches fix RGMII timing for rev. 2.1 of the mpc8360,
according to erratum #2 (erratum text included below).  Basically the
most intrusive part is the addition of two new RGMII Internal Delay
modes; one for TX delay only, and the other for RX delay only (i.e, not
both at the same time).

Please review, and since this affects both netdev and powerpc trees,
one maintainer should ack them for the other to push upstream (i.e,
Kumar acks them, and Leo picks them up to go through netdev or the
other way around; either way is fine with me).  I'm hoping they're
trivial enough to go in 2.6.24.

Depending on how the review goes, a follow-on patch to u-boot will be
sent out that fixes up the phy-connection-type in the device tree (from
"rgmii-id" to "rgmii-rxid" iff on mpc8360rev2.1).

Thanks,

Kim

mpc8360 rev 2.1 erratum #2:
-----------
Recommended AC timings for chip 8360Rev2.1 UCC ETH RGMII  when working
with Rev Pilot MDS for proper RGMII operation:

IMMR_BASE + 0x14A8[4:5] = 11 (clk delay for UCC 2)
IMMR_BASE + 0x14A8[18:19] = 11 (clk delay for UCC 1)
IMMR_BASE + 0x14AC[20:27] = 10101010 (data delay for both UCC's)

The Phy (Marvell 88e1111) should be configured NOT to work with RGMII
delay for TxD.

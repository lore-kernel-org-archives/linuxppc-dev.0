Return-Path: <lagrange@fr.oleane.com>
Received: from smtp1.clb.oleane.net (smtp1.clb.oleane.net [213.56.31.17])
	by ozlabs.org (Postfix) with ESMTP id 76BCF67B74
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jul 2006 01:36:25 +1000 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <pantelis@embeddedalley.com>
Subject: Linux 2.6.x  :  cpm_dpalloc alignment bug perhaps not fully resolved
Date: Tue, 4 Jul 2006 17:37:29 +0200
Message-ID: <000001c69f7f$c9227760$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200601251814.17331.pantelis@embeddedalley.com>
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


Hello Pantelis,

Few months ago (25 January 2006), I sent a mail about an alignment bug in
cpm_dpalloc.
I applied and verified the provided patch. I was very satisfied with the
result.

Today I port a driver from Linux 2.4 to Linux 2.6 and I have strange
results.

The driver allocates rx and tx bds (8 bytes aligned) in the module_init for
4 SCC ports.
That is always right. Then one port is opened by an application and a user
configuration
is set via an ioctl (set_conf).

This ioctl first frees the old bds :
	cpm_dpfree(chan->rx_bd_offset);
	cpm_dpfree(chan->tx_bd_offset);
then allocates the new ones :
	chan->rx_bd_offset = cpm_dpalloc(sizeof(cbd_t) * chan->conf.rx_bufnbr, 8);
	chan->tx_bd_offset = cpm_dpalloc(sizeof(cbd_t) * chan->conf.tx_bufnbr, 8);
with rx_bufnbr == 8 and tx_bufnbr == 2

module_init
SCC1 rx_bd_offset=160
SCC1 tx_bd_offset=1a8
SCC2 rx_bd_offset=1c0
SCC2 tx_bd_offset=208
SCC3 rx_bd_offset=220
SCC3 tx_bd_offset=260
SCC4 rx_bd_offset=278
SCC4 tx_bd_offset=2c0
set_conf
SCC1 rx_bd_offset=160
SCC1 tx_bd_offset=1a4	-> ???

module_init
SCC1 rx_bd_offset=160
SCC1 tx_bd_offset=1a8
SCC2 rx_bd_offset=1c0
SCC2 tx_bd_offset=208
SCC3 rx_bd_offset=220
SCC3 tx_bd_offset=260
SCC4 rx_bd_offset=278
SCC4 tx_bd_offset=2c0
set_conf
SCC2 rx_bd_offset=1c0
SCC2 tx_bd_offset=202	-> ???

module_init
SCC1 rx_bd_offset=160
SCC1 tx_bd_offset=1a8
SCC2 rx_bd_offset=1c0
SCC2 tx_bd_offset=208
SCC3 rx_bd_offset=220
SCC3 tx_bd_offset=260
SCC4 rx_bd_offset=278
SCC4 tx_bd_offset=2c0
set_conf
SCC3 rx_bd_offset=220
SCC3 tx_bd_offset=260	-> ok

module_init
SCC1 rx_bd_offset=160
SCC1 tx_bd_offset=1a8
SCC2 rx_bd_offset=1c0
SCC2 tx_bd_offset=208
SCC3 rx_bd_offset=220
SCC3 tx_bd_offset=260
SCC4 rx_bd_offset=278
SCC4 tx_bd_offset=2c0
set_conf
SCC4 rx_bd_offset=278
SCC4 tx_bd_offset=2c0	-> ok

WARNING : if I only uses the SCC1 port without allocating bds for the other
ports,
I can free and reallocate the bds for the SCC1 port as many times I want.

module_init
SCC1 rx_bd_offset=160
SCC1 tx_bd_offset=1a8
set_conf
SCC1 rx_bd_offset=160
SCC1 tx_bd_offset=1a8	-> ok

Really, I don't understand how this can arise.
Any idea ?

Thanks
Laurent

Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A98BDDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 03:08:01 +1000 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1Iawq8-0004EO-4S
	for linuxppc-embedded@ozlabs.org; Thu, 27 Sep 2007 19:07:56 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 27 Sep 2007 19:07:50 +0200
References: <20070810095153.GC13994@moe.telargo.com>
In-Reply-To: <20070810095153.GC13994@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709271907.50479.jbe@pengutronix.de>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 10 August 2007 11:51, Domen Puncer wrote:
> Not for merge (yet)! But please do review.
>
> fec_mpc52xx driver (not in-tree, but floating around) isn't in very
> good shape, so I tried to change that.
> Diff against original is quite big (fec_phy.c is completely rewritten)
> and confuzing, so I'm including whole drivers/net/fec_mpc52xx/ .
>
> I still have 'make CONFIG_FEC_MPC52xx_MDIO=3Dn compile and work' on my
> TODO, maybe even ethtool support.

Currently I'm trying with your fec driver and Sylvain Munaut's bestcomm dri=
ver=20
*and* rt-preemt 2.6.23-rc8-rt1 and now I'm getting this error while stress=
=20
test the network:

BUG: scheduling while atomic: softirq-timer/0/0x00000002/5, CPU#0
Call Trace:
[c0309e00] [c0007ddc] show_stack+0x3c/0x194 (unreliable)
[c0309e30] [c0017934] __schedule_bug+0x38/0x48
[c0309e40] [c01c8f24] __schedule+0x3e8/0x428
[c0309e70] [c01c96d4] schedule+0x54/0xf0
[c0309e80] [c01c9e8c] schedule_timeout+0x68/0xe4
[c0309ec0] [c00282dc] msleep+0x1c/0x34
[c0309ed0] [c0125fb8] fec_stop+0xbc/0x1a8
[c0309ef0] [c0126530] fec_reset+0x20/0xb0
[c0309f10] [c0127840] fec_tx_timeout+0x3c/0xa4
[c0309f30] [c016b5dc] dev_watchdog+0x13c/0x14c
[c0309f50] [c0027c90] run_timer_softirq+0x2e4/0x444
[c0309f90] [c00239a4] ksoftirqd+0x134/0x214
[c0309fd0] [c0034d94] kthread+0x48/0x84
[c0309ff0] [c000f828] kernel_thread+0x44/0x60

Do you have an idea what happens?

Juergen
=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9

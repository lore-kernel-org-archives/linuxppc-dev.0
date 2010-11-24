Return-Path: <r58472@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1688B7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Nov 2010 22:04:33 +1100 (EST)
Received: from mail65-va3 (localhost.localdomain [127.0.0.1])	by
	mail65-va3-R.bigfish.com (Postfix) with ESMTP id 3C686198284	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 24 Nov 2010 11:04:27 +0000 (UTC)
Received: from VA3EHSMHS002.bigfish.com (unknown [10.7.14.248])	by
	mail65-va3.bigfish.com (Postfix) with ESMTP id E28E263804F	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 24 Nov 2010 11:04:26 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oAOB4DW6018770	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 24 Nov 2010 04:04:13 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oAOBLu4b001164	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Nov 2010 05:21:56 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Subject: RE: ucc_geth: transmit queue timeout at half-duplex mode
Date: Wed, 24 Nov 2010 04:05:06 -0700
Message-ID: <3F607A5180246847A760FD34122A1E0502AF23@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <1863FF2A13D0E048900A981ACDE485000281810792@ExchN1.riedel.net>
References: <1863FF2A13D0E048900A981ACDE485000281810792@ExchN1.riedel.net>
From: Li Yang-R58472 <r58472@freescale.com>
To: "Schmitz, Andreas" <Andreas.Schmitz@riedel.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Subject: ucc_geth: transmit queue timeout at half-duplex mode
>
>Hi all,
>on my MPC8321E with linux-2.6.36 I get this netdev watchdog warning
>"NETDEV WATCHDOG: eth0 (of:ucc_geth): transmit queue 0 timed out" if =
the
>link mode is half-duplex.
>The warning is caused, because all Tx BDs are full and packet =
transmission
>is stopped with netif_stop_queue() in ucc_geth_start_xmit().
>
>You can reproduce the bug in the following way:
>- Connect to a switch, that supports only 10baseT, or set the mode
>manually with "mii-diag -F 10baseT".
>- Open a telnet session to the target. Generate higher traffic with
>executing maybe "cat /proc/interrupts" many times.
>- After some tries the ethernet connection will be down, then again =
after
>approx. 30s seconds the netdev watchdog will dump the warning.
>
>It is unclear to me why the TxBDs get full. Due to missing "Tx buffer
>sent" interrupts, it seems that the QE stops the transmission.
>
>I found some issue in the errata: "QE_ENET20: UEC may stop transmitting
>after late collision". But UCCE[TXE] is never set in this case.
>
>Thank you for your help in advance and best regards,

I believe your problem is related to an errata for 8321:
High Tx Virtual FIFO threshold size can cause UCC to halt.

Reducing the UTFTT might fix the problem.

If you are interested, I can sent you the detailed errata off the =
thread.

- Leo

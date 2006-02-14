Return-Path: <lagrange@fr.oleane.com>
Received: from smtp3.clb.oleane.net (smtp3.clb.oleane.net [213.56.31.19])
	by ozlabs.org (Postfix) with ESMTP id A9AFA67A58
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 02:21:22 +1100 (EST)
Received: from GEG2400 ([194.3.133.184]) (authenticated)
	by smtp3.clb.oleane.net with ESMTP id k1EFLFev027110
	for <linuxppc-embedded@ozlabs.org>; Tue, 14 Feb 2006 16:21:20 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Gianfar is slower  than fcc_enet on MPC8541 ???
Date: Tue, 14 Feb 2006 16:26:48 +0100
Message-ID: <000001c6317b$148162c0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

I work on a cutom MPC8541 board with Linux 2.6.9.
The kernel activates the L1 cache (instructions and data)
and the L2 cache (entirely used as cache and not as sram).

I configure 
1 FCC (FCC1),
2 TSECs with or without NAPI (no effect) but without stashing in L2 sram.
All PHYs are automatically configured in 100MB full duplex.

	eth0: Gianfar Ethernet Controller Version 1.1, 00:10:cd:48:48:e0
	eth0: Running with NAPI disabled
	eth0: 64/64 RX/TX BD ring size
	eth1: Gianfar Ethernet Controller Version 1.1, 00:10:cd:48:48:e1
	eth1: Running with NAPI disabled
	eth1: 64/64 RX/TX BD ring size
	eth2: FCC ENET Version custom, 00:10:cd:48:48:e2

Then I launch 3 simple TCP servers, one on each ports.

>From remote machines I runs 3 TCP clients.
The client sends messages of 1000 bytes, 
The server receives and echoes the message
The client receives the echoed message, check the content
and sends a new message again.

The result is that the 2 TSECs are 2 times slower than the FCC.

If I run a "top" application on the board, I use less than 10% of the CPU
Each port consumes about 1/3 of the CPU.

Any idea on how to configure the gianfar driver ?

Thanks
Laurent
 

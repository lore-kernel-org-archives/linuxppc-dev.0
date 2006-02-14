Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id DBD2567B4A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 04:37:05 +1100 (EST)
In-Reply-To: <000001c6317b$148162c0$5201a8c0@GEG2400>
References: <000001c6317b$148162c0$5201a8c0@GEG2400>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <83375DC1-33DA-401B-9E6A-D0C1A9A273D7@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Gianfar is slower  than fcc_enet on MPC8541 ???
Date: Tue, 14 Feb 2006 11:36:54 -0600
To: Laurent Lagrange <lagrange@fr.oleane.com>
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

My guess is that you are measuring latency.  By default, interrupt  
coalescing is on, and used to be set to very poor default values.  In  
drivers/net/gianfar.h, change the defaults to look like this:

#define DEFAULT_TX_COALESCE 1
#define DEFAULT_TXCOUNT 16
#define DEFAULT_TXTIME  4

#define DEFAULT_RX_COALESCE 1
#define DEFAULT_RXCOUNT 16
#define DEFAULT_RXTIME  4

The problem was that the timeout was quite long, so a small number of  
packets would have to wait a whole millisecond (or more!) to get  
processed.  While it wouldn't affect bandwidth tests, which send many  
packets, it would affect a simple test like ping.

If you don't feel like recompiling the kernel, you can use ethtool to  
change the timeout values.


On Feb 14, 2006, at 09:26, Laurent Lagrange wrote:

>
> Hello,
>
> I work on a cutom MPC8541 board with Linux 2.6.9.
> The kernel activates the L1 cache (instructions and data)
> and the L2 cache (entirely used as cache and not as sram).
>
> I configure
> 1 FCC (FCC1),
> 2 TSECs with or without NAPI (no effect) but without stashing in L2  
> sram.
> All PHYs are automatically configured in 100MB full duplex.
>
> 	eth0: Gianfar Ethernet Controller Version 1.1, 00:10:cd:48:48:e0
> 	eth0: Running with NAPI disabled
> 	eth0: 64/64 RX/TX BD ring size
> 	eth1: Gianfar Ethernet Controller Version 1.1, 00:10:cd:48:48:e1
> 	eth1: Running with NAPI disabled
> 	eth1: 64/64 RX/TX BD ring size
> 	eth2: FCC ENET Version custom, 00:10:cd:48:48:e2
>
> Then I launch 3 simple TCP servers, one on each ports.
>
>> From remote machines I runs 3 TCP clients.
> The client sends messages of 1000 bytes,
> The server receives and echoes the message
> The client receives the echoed message, check the content
> and sends a new message again.
>
> The result is that the 2 TSECs are 2 times slower than the FCC.
>
> If I run a "top" application on the board, I use less than 10% of  
> the CPU
> Each port consumes about 1/3 of the CPU.
>
> Any idea on how to configure the gianfar driver ?
>
> Thanks
> Laurent
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

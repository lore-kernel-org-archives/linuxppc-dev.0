Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3454067B8B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Nov 2006 16:56:50 +1100 (EST)
Message-ID: <454987B8.4030602@dlasys.net>
Date: Thu, 02 Nov 2006 00:52:56 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: robert corley <rdcorle@yahoo.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: plb_temac w/linux 2.6.18.1 driver init error
References: <20061101203314.2385.qmail@web56315.mail.re3.yahoo.com>
In-Reply-To: <20061101203314.2385.qmail@web56315.mail.re3.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    I am not sure of the problem,
     but  I think you are using a different variation of the TEMAC than 
I am.
    My  TEMAC is configured with a DMA_TYPE of 1 and a DRE TYPE of 0
   
    I also thought the  XPacketFifo code was for DMA TYPE 1 which I 
beleive is the FIFO incarnation of the TEMAC.
    This driver is supposed to work with your TEMAC - I think.

robert corley wrote:
> Anyone?;
>
> The offending instruction is:
>
> out_be32((volatile unsigned *) InstancePtr->RegBaseAddress+XPF_V200A_RESET_REG_OFFSET, XPF_V200A_RESET_FIFO_MASK);
>
> called vai a #define in "drivers/xilinx_edk/xpacket_fifo_v2_00_a.c"
>
> Would anyone care to speculate if the error is in the out_be32 definition or is this a function of a memory access to an incorrect value?
>
> Here is the latest dump:
>
> [    2.702189] xtenet_probe: xtemac 0: IO resources obtained.  IRQ = 0, MEM = 0x60000000
> [    2.710095] xtenet_probe: xtemac 0: private data initialized
> [    2.715872]     remap info => start = 0x60000000, end=0x60003fff, total=16384, virtual dest.=0xc5050000
> [    2.725007] xtenet_probe: TEMAC config lookup succeeded.  Details = 
> [    2.731369]         Base address    = 0x60000000
> [    2.735471]         Unique ID       = 0x0000
> [    2.739230]         RCV FIFO depth  = 0x131072
> [    2.743161]         XMIT FIFO depth = 0x131072
> [    2.747091]         MAC FIFO depth  = 0x64
> [    2.750677]         IPIF/DMA config = 0x03
> [    2.754260]         DCR Host        = 0x0
> [    2.757759]         DRE Engine?     = 0x1
> [    2.761260] Initialize : Handlers set up.  Configuring FIFO access...
> [    2.767709] XPacketFifoV200a_Initialize : setting FIFO REG base address to 0xC5052010
> [    2.775548] XPacketFifoV200a_Initialize : setting FIFO DATA base address to 0xC5052200
> [    2.783474] XPacketFifoV200a_Initialize : setting IsReady to 286331153
> [    2.790011] XPacketFifoV200a_Initialize : resetting FIFO by writing 0x000A to 0xC5052010
> [    2.798103] Data machine check in kernel mode.
> [    2.802544] Oops: machine check, sig: 7 [#1]
>
> -cy
>
>
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

Return-Path: <ALEBAS@televes.com>
Received: from televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with SMTP id 65C952BF07
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jan 2005 00:31:14 +1100 (EST)
Message-ID: <51DB8827D393D411BB69003048003F46FDCF94@tvesntr>
From: Bastos Fernandez Alexandre <ALEBAS@televes.com>
To: 'linuxppc' <linuxppc-embedded@ozlabs.org>
Date: Tue, 4 Jan 2005 14:31:03 +0100 
MIME-Version: 1.0
Content-Type: text/plain
Subject: Asymmetric throughput in pq2ads. Help needed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi to all,

I have been doing some throughput test in the 8272ads board
using it as a router.

Several tests have been done with uboot-1.1.2 (using FCC1 ETHERNET)
and linux kernel 2.6.10-rc3

To support both FCC interfaces on this board, I have enabled
FCC2 in BCSR3:

In platforms/pq2ads.h

#define BCSR3_FETHIEN2          ((uint)0x10000000)
#define BCSR3_FETH2_RST         ((uint)0x80000000)

In 8260_io/fcc_enet.c

*(volatile uint *)(BCSR_ADDR + 12) &= ~BCSR3_FETHIEN2;
*(volatile uint *)(BCSR_ADDR + 12) |=  BCSR3_FETH2_RST;

No other related changes have been done to linuxppc-2.5 top
bitkeeper version of kernel.

In this context I have set this trivial net:


   PC1 -----X-cable------ 8272ADS ------X-cable------ PC2

The ADS is connected to PC1 through FCC1 and to PC2 through FCC2.

Then, throughput from PC1 to PC2 (measured using ttcp) is not the
same than throughput from PC2 to PC1.

 UDP ...  PC1 --> PC2  90 Mbps aprox
              PC2 --> PC1  60 Mbps aprox   !!!!!!!!

  TCP ... PC1 --> PC2   60 Mbps aprox
             PC2 --> PC1   1 Mbps aprox  !!!!!!!!!!!!

It seems as if the ADS were loosing packets arriving at FCC2.

At this point I am a bit lost. I don't know what I should try to change or
where I should set any breakpoint with my BDI to find what is going wrong.
Any idea from guys in the list?

Thanks,

Alex Bastos

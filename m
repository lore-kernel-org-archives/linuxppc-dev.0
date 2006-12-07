Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc1-s37.bay0.hotmail.com (bay0-omc1-s37.bay0.hotmail.com
	[65.54.246.109]) by ozlabs.org (Postfix) with ESMTP id 1C66E67C5C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Dec 2006 01:10:44 +1100 (EST)
Message-ID: <BAY7-F1D1F74BDCA80CD1342CBCBEDC0@phx.gbl>
From: "Ilse Reyneke" <reynekejunk@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Linux 4xx DMA interface broken?
Date: Thu, 07 Dec 2006 14:10:39 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gents/ladies,

Has anyone successfully used the 4xx DMA interface? I think I'm missing 
something very obvious, or it's broken.

We are using a Linux 2.6.14 kernel on a 440EPx. Basically, it looks like the 
code is written to work with the PLB4 controller but addressed to the PLB3 
controller.

The problem I have is the following: ppc4xx_dma.h has the following code 
section(s):

#ifdef CONFIG_44x
#define	PPC4xx_DMA_64BIT
#define DMA_CR_OFFSET 1
#else
#define DMA_CR_OFFSET 0
#endif

#define SET_DMA_PW(x)     (((x)&0x3)<<(26-DMA_CR_OFFSET))	/* Peripheral 
Width */


And ibm44x.h has the following:


#define DCRN_DMA0_BASE	0x100
#define DCRN_DMA2P40_BASE  0x300
#define DCRN_DMACR0	(DCRN_DMA0_BASE + 0x0)	/* DMA Channel Control 0 */

A typical DMA interface function as defined in ppc4xx_dma.c, looks like this

void ppc4xx_enable_dma(unsigned int dmanr)
{
	...
	mtdcr(DCRN_DMACR0 + (dmanr * 0x8), control);
	...
}


Because of the processor type, DMA_CR_OFFSET is set to 1. Which means that 
the control register is structured on the PLB4, not the PL3 as the 
DCRN_DMASR address implies.

How (or can you) do you specify which DMA controller you want to use? Any 
ideas/comments?

Cheers
   Jan Reyneke

_________________________________________________________________
Be the first to hear what's new at MSN - sign up to our free newsletters! 
http://www.msn.co.uk/newsletters

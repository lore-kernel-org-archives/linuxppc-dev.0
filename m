Return-Path: <CWernham@Airspan.com>
Received: from mail.airspan.com (mail.airspan.com [62.189.116.4])
	by ozlabs.org (Postfix) with ESMTP id 13DE52BEA0
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Dec 2004 21:25:51 +1100 (EST)
Message-ID: <41B8255A.3040101@airspan.com>
Date: Thu, 09 Dec 2004 10:13:46 +0000
From: Colin Wernham <cwernham@airspan.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: PPC4XX DMA polarity bug in linuxppc-2.6.9
Reply-To: cwernham@airspan.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I believe that there is a PPC4xx DMA driver bug in the following kernel, 
file and function:
   linuxppc-2.6.9,
    /arch/ppc/syslib/ppc4xx_dma.c,
    ppc4xx_init_dma_channel()

Symptoms are:
DMA does not work as the polarity bits (DMA Req, Ack, EOT) are not set 
correctly in the DMA controller using the ppc4xx_init_dma_channel() 
function call, but when this is called twice in succession, then it does 
work.

Cause is (I believe):
/arch/ppc/syslib/ppc4xx_dma.c:
On line 469 the old polarity bits in p_dma_ch are ORed in when it should 
be ORing in the new polarity bits from p_init. p_init is then saved into 
p_dma_ch. This means that it only gets correctly programmed when the 
function is called twice:

    467  /* clear all polarity signals and then "or" in new signal levels */
    468  polarity &= ~GET_DMA_POLARITY(dmanr);
    469  polarity |= p_dma_ch->polarity;

Fix could be:
    469  polarity |= p_init->polarity;

Is there anyone else using the PPC4XX DMA?

Colin Wernham

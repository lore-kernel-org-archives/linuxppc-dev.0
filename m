Return-Path: <CWernham@Airspan.com>
Received: from mail.airspan.com (mail.airspan.com [62.189.116.4])
	by ozlabs.org (Postfix) with ESMTP id 7F2072BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Dec 2004 20:16:46 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 10 Dec 2004 09:09:39 -0000
Message-ID: <3506EDCDEC47904CBE6FD2E1DEEA89840205BCAA@fs5.airspan.com>
From: "Colin Wernham" <CWernham@Airspan.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: PPC4XX DMA polarity bug in linuxppc-2.6.9
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[a copy of this has also been posted on linuxppc-dev]

I believe that there is a PPC4xx DMA driver bug in the following kernel, =

file and function:
   linuxppc-2.6.9,
    /arch/ppc/syslib/ppc4xx_dma.c,
    ppc4xx_init_dma_channel()

Symptoms are:
DMA does not work as the polarity bits (DMA Req, Ack, EOT) are not set=20
correctly in the DMA controller using the ppc4xx_init_dma_channel()=20
function call, but when this is called twice in succession, then it does =

work.

Cause is (I believe):
/arch/ppc/syslib/ppc4xx_dma.c:
On line 469 the old polarity bits in p_dma_ch are ORed in when it should =

be ORing in the new polarity bits from p_init. p_init is then saved into =

p_dma_ch. This means that it only gets correctly programmed when the=20
function is called twice:

    467  /* clear all polarity signals and then "or" in new signal =
levels */
    468  polarity &=3D ~GET_DMA_POLARITY(dmanr);
    469  polarity |=3D p_dma_ch->polarity;

Fix should be:
    469  polarity |=3D p_init->polarity;

Is there anyone else using the PPC4XX DMA?

Colin Wernham

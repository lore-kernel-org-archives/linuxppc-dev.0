Return-Path: <niklaus.giger@member.fsf.org>
Received: from smtp.hispeed.ch (mxout.hispeed.ch [62.2.95.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E3D5DDEE0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 09:23:25 +1100 (EST)
Received: from ng (84-73-191-27.dclient.hispeed.ch [84.73.191.27])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.11.20060308/8.12.11/taifun-1.0) with ESMTP id
	l0IMGapC004183
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Thu, 18 Jan 2007 23:16:37 +0100
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-embedded@ozlabs.org
Subject: Howto use PPC4xx memory to memory DMA
Date: Thu, 18 Jan 2007 23:16:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701182316.36296.niklaus.giger@member.fsf.org>
Reply-To: niklaus.giger@member.fsf.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I ported successfully the Linux 2.6.19 kernel to our PPC405GPr based board and 
mostly everything just works as it should.

As an example I tried to make a small example program to use memory to memory 
DMA and failed miserably. I used the ppc4xx_*dma function, which are not 
referenced anywhere in a stock 2.6.19.1 kernel in the following function:

void dma_mem_to_mem(void *src, void *dst, unsigned int length,
			unsigned int use_interrupt)
{
	int res = 0;
	memset((char *)&p_init, sizeof(p_init), 0);
	p_init.polarity = 0;
	p_init.pwidth   = PW_8;
 	res = ppc4xx_init_dma_channel(DMA_NR, &p_init);
	if (res) {
		printk("%32s: nit_dma_channel return %d %d bytes dest %p\n",
			__FUNCTION__, res, length, dst);
	}
	res = ppc4xx_clr_dma_status(DMA_NR);
	if (res) { 
		printk("%32s: ppc4xx_clr_dma_status %d\n", __FUNCTION__, res);
	}

	ppc4xx_set_dma_mode(DMA_NR, DMA_MODE_MM);
	ppc4xx_set_src_addr(DMA_NR, src);
	ppc4xx_set_dst_addr(DMA_NR, dst);
	ppc4xx_set_dma_count(DMA_NR, length);
	ppc4xx_enable_dma(DMA_NR);
	if (use_interrupt) {
		res = ppc4xx_enable_dma_interrupt(DMA_NR);
	} else {
		res = ppc4xx_disable_dma_interrupt(DMA_NR);
	}
	if (res) { 
		printk("%32s: en/disable_dma_interrupt %d return %d per %d\n",
		__FUNCTION__, use_interrupt, res, 
		ppc4xx_get_peripheral_width(DMA_NR));
	}
}

However the destination memory never changed, even when calling repeatedly 
ppc4xx_get_dma_residu function correctly return first something between 
length and 0 and finally 0.

Any hints would be appreciated. As googleing around didn't allow me to find an 
answer.

Also I am a little confused as I cannot see how something dma_alloc_coherent 
should work on a PPC4xx board.

Best regards

-- 
Niklaus Giger

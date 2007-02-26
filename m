Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A47E4DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Feb 2007 18:41:26 +1100 (EST)
Date: Mon, 26 Feb 2007 10:41:23 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
Subject: Re: SPI controller hangs in 2.6 and not in 2.4 (on MPC875)
Message-ID: <20070226104123.46e18917@localhost.localdomain>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E264927@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8E264927@aquib01a>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 25 Feb 2007 20:51:12 +0100
DI BACCO ANTONIO - technolabs wrote:

> Hi Melinda,
> 
> the problem in my case was caused by the following instructions to
> allocate the buffers for SPI controller tx and rx:
> 
>         rxbuffer = (u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE);  
>         txbuffer = (u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE); 
>         // Set the bd's rx and tx buffer address pointers
>         rbdf->cbd_bufaddr = virt_to_bus((void
> *)rxbuffer); tbdf->cbd_bufaddr = virt_to_bus((void *)txbuffer);   
> 
> I don't know why (I'm asking an opinion to Vitaly Bordug), I replaced
> the allocation of rx and tx buffers with:
> 
> ...->cbd_bufaddr = __pa(__get_free_page(GFP_KERNEL | GFP_DMA))
> 
Well this is just evil... even if it works :)


> but it will better to use dma_alloc_coherent.
> In my case the use of m8xx_cpm_hostalloc led to an immediate kernel
> hang after giving the start command to the spi controller.
> 
Heh, this case you'lll have to use dpram for the buffers I guess iiuc.

dma_* stuff might work too but I'm not sure. Moreover, it didn't work  for 
me in case of powerpc, where m8xx_cpm_hostalloc made as a placeholder for 
dma_alloc_coherent...

Return-Path: <kevinko@arlut.utexas.edu>
Received: from ns4.arlut.utexas.edu (ns4.arlut.utexas.edu [207.200.28.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06F5E679E0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Mar 2006 09:07:54 +1100 (EST)
Received: from ns2.arlut.utexas.edu (ns2.arlut.utexas.edu [146.6.211.1])
	by ns4.arlut.utexas.edu (8.13.4/8.13.4) with ESMTP id k2AM7oVh026145
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 16:07:50 -0600 (CST)
Received: from ns5.arlut.utexas.edu (ns5.arlut.utexas.edu [10.4.1.6])
	by ns2.arlut.utexas.edu (8.13.4/8.13.4) with ESMTP id k2AM7jjx080293
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 16:07:46 -0600 (CST)
Received: from mohave.arlut.utexas.edu (mohave.arlut.utexas.edu [10.8.16.38])
	by ns5.arlut.utexas.edu (8.13.4/8.13.4) with ESMTP id k2AM7jaL096439
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 16:07:45 -0600 (CST)
Date: Fri, 10 Mar 2006 16:07:45 -0600 (CST)
From: Kevin Kleinosowski <kevinko@arlut.utexas.edu>
To: linuxppc-embedded@ozlabs.org
Subject: Re: 440gx dma transfer with no data change at dest
In-Reply-To: <Pine.LNX.4.64.0603071505110.21479@mohave.arlut.utexas.edu>
Message-ID: <Pine.LNX.4.64.0603101535210.23667@mohave.arlut.utexas.edu>
References: <Pine.LNX.4.64.0603071505110.21479@mohave.arlut.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Maybe this is too much.  Has anyone successfully done a memory-to-memory 
DMA transfer with the 2.4.27 kernel routines in 
arch/ppc/kernel/ppc4xx_dma.c on any ppc embedded platform?  If you have, 
are you willing to share a bit of code example, or look at one?

   #define MEM_BUF_SIZE_ORDER 4
   #define MEM_BUF_SIZE_BYTES 65536UL
   #define EBC0_DMA_CHANNEL 1
   #define DMA_SR_CS_SET 0x80000000
   unsigned long interruptFlags;
   ppc_dma_ch_t channelSetup;
   int dmaStatus;
   u32 src, dst;

   src = __get_dma_pages (GFP_KERNEL, MEM_BUF_SIZE_ORDER);
   memset ((char *)src, 0xFF, MEM_BUF_SIZE_BYTES);
   dst = __get_dma_pages (GFP_KERNEL, MEM_BUF_SIZE_ORDER);
   memset ((char *)dst, 0x00, MEM_BUF_SIZE_BYTES);
   memset (&channelSetup, 0, sizeof (ppc_dma_ch_t));
   interruptFlags = claim_dma_lock ();
   ppc4xx_get_channel_config (EBC0_DMA_CHANNEL, &channelSetup);
   channelSetup.buffer_enable = 1;
   channelSetup.tce_enable = 1;
   channelSetup.etd_output = 1;
   channelSetup.pce = 0;
   channelSetup.pl = 1;
   channelSetup.pwidth = PW_32;
   channelSetup.sai = 1;
   channelSetup.dai = 1;
   channelSetup.psc = 0;
   channelSetup.pwc = 0;
   channelSetup.phc = 0;
   channelSetup.cp = PRIORITY_LOW;
   channelSetup.pf = PREFETCH_1;
   channelSetup.int_enable = 1;
   channelSetup.mode = DMA_MODE_MM;
   ppc4xx_init_dma_channel (EBC0_DMA_CHANNEL, &channelSetup);
   ppc4xx_enable_dma_interrupt (EBC0_DMA_CHANNEL);
   ppc4xx_disable_dma (EBC0_DMA_CHANNEL);
   ppc4xx_set_src_addr (EBC0_DMA_CHANNEL, virt_to_bus((u32 *)src));
   ppc4xx_set_dst_addr (EBC0_DMA_CHANNEL, virt_to_bus((u32 *)dst));
   ppc4xx_set_dma_count (EBC0_DMA_CHANNEL, MEM_BUF_SIZE_BYTES);
   ppc4xx_enable_dma (EBC0_DMA_CHANNEL);
   release_dma_lock (interruptFlags);

   dmaStatus = ppc4xx_get_dma_status ();
   while ((dmaStatus & (DMA_SR_CS_SET >> EBC0_DMA_CHANNEL)) != 
(DMA_SR_CS_SET >> EBC0_DMA_CHANNEL)) {
     printk ("DMA STATUS: 0x%8.8x\n", dmaStatus);
     set_current_state (TASK_INTERRUPTIBLE);
     schedule_timeout (HZ/4);
     dmaStatus = ppc4xx_get_dma_status ();
   }


The result dst was initialed to 0x00 but the transfer should have put 
it all to 0xff.  However most locations are 0xff, and some locations are 
0x00.  There seems to be no pattern to it.  Sometimes all locations of dst 
have 0xff.

Anyone see anything wrong?

Kevin


On Tue, 7 Mar 2006, Kevin Kleinosowski wrote:

>
> I am running a simple test with a software initiated DMA transfer from one 
> bigphysarea allocated buffer to another bigphysarea allocated buffer. The 
> destination buffer shows no data changes once the transfer is done.
>
> However, I perform the same simple test using __get_dma_pages() rather then 
> the bigphysarea_alloc_pages() and the destination does get the data transfer.
>
> Is there a reason this should fail for bigphysarea?  I understand the low 
> memory addresses needed for the DMA controller on some platforms, but I didnt 
> think that limitation existed on the PPC.  Besides that, the bigphysarea 
> returns low memory address anyway.  Anyone have an idea why? An old archive 
> email had someone with a similar problem, but there were no follow-ups to the 
> message.
>
> I have linux 2.4.27-pre3 patched, ppc-linux-gcc (GCC) 3.3.3 (DENX ELDK 3.1.1 
> 3.3.3-9), U-Boot 1.1.2, and GMS 440gx board.
>
> thanks,
> Kevin
>
>

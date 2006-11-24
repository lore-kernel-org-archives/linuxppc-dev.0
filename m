Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc1-s11.bay0.hotmail.com (bay0-omc1-s11.bay0.hotmail.com
	[65.54.246.83]) by ozlabs.org (Postfix) with ESMTP id 5EE6367B5F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Nov 2006 02:38:02 +1100 (EST)
Message-ID: <BAY7-F19173F0CA7C1079F313395BEE10@phx.gbl>
From: "Ilse Reyneke" <reynekejunk@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: virt_to_bus and DMA
Date: Fri, 24 Nov 2006 15:37:58 +0000
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

Hi there,

Question from a relative newby.

Can someone please tell me how to get the bus/physical address from a 
virtual address? To familiarise myself with the PPC4xx DMA API I'm trying to 
get a simple mem-mem DMA working (any good samples out there??). The 
following code snippet seems to be the way of allocating memory buffers for 
the transfer:

  int size = 2*1024;
  uint32_t* sourceaddr = (uint32_t *)__get_free_pages(GFP_KERNEL 
|GFP_DMA,get_order(size));
  uint32_t* destaddr = (uint32_t *)__get_free_pages(GFP_KERNEL |GFP_DMA,
get_order(size));

  phys_addr_t physdest = virt_to_bus((u32 *)destaddr);
  phys_addr_t physsource = virt_to_bus((u32 *)sourceaddr);


The problem is that virt_to_bus seems to be returning 0. I understand that 
it is generally undesirable to use the deprecated virt_to_bus, but what are 
the alternatives?

Am I also correct in saying the "standard DMA API" (request_dma, 
set_dma_addr etc) is NOT available on the 4xx?

We're making use of the 440EPx, Linux 2.6.14 kernel.

Cheers
   Jan Reyneke

_________________________________________________________________
Windows Live™ Messenger has arrived. Click here to download it for free! 
http://imagine-msn.com/messenger/launch80/?locale=en-gb

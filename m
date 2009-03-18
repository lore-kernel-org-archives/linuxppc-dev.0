Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id C0C71DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 03:26:39 +1100 (EST)
Received: from [192.168.0.200] (oz3 [192.168.0.200])
	by oz.embeddedARM.com (8.12.11.20060614/8.11.6) with ESMTP id
	n2IGQaI9011085
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 09:26:36 -0700 (MST)
Message-ID: <49C12159.4060100@embeddedarm.com>
Date: Wed, 18 Mar 2009 09:29:13 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [RFC]PPC driver lock for DMA registers
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I'm working on SD card and Nand drivers that I would like to eventually submit 
for inclusion in the mainline kernel. This being my first kernel port being 
submitted upstream I was hoping for comments on my proposed design to ensure it 
would be excepted in the mainline kernel(from a design standpoint). We have an 
FPGA on our product that has an interface for transferring data via DMA. The SD 
card driver and Nand flash driver will both be accessing these registers. As a 
result I was planning on writing a dma driver(drivers/dma/ts81xx.c) that 
implements a function dma_op() that gets passed a physical address, virtual 
address, length, and read/write op and returns an int. I'd use a semaphore to 
protect the registers. I'd also implement a function dma_bus_init() for 
allocating a cache coherent buffer, initializing the semaphore, and ioremapping 
the FPGA regs.

I'd really appreciate any feedback or suggestions.

-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive 	     | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com

Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id BF73EDDDF0
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 03:50:42 +1100 (EST)
Message-ID: <49C126FA.90401@embeddedarm.com>
Date: Wed, 18 Mar 2009 09:53:14 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC]PPC driver lock for DMA registers
References: <49C12159.4060100@embeddedarm.com>
	<fa686aa40903180940m782bcd65nb78b2c87353f10a@mail.gmail.com>
In-Reply-To: <fa686aa40903180940m782bcd65nb78b2c87353f10a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

>> I'm working on SD card and Nand drivers that I would like to eventually
>> submit for inclusion in the mainline kernel. This being my first kernel port
>> being submitted upstream I was hoping for comments on my proposed design to
>> ensure it would be excepted in the mainline kernel(from a design
>> standpoint). We have an FPGA on our product that has an interface for
>> transferring data via DMA. The SD card driver and Nand flash driver will
>> both be accessing these registers. As a result I was planning on writing a
>> dma driver(drivers/dma/ts81xx.c) that implements a function dma_op() that
>> gets passed a physical address, virtual address, length, and read/write op
>> and returns an int. I'd use a semaphore to protect the registers. I'd also
>> implement a function dma_bus_init() for allocating a cache coherent buffer,
>> initializing the semaphore, and ioremapping the FPGA regs.
> 
> Nothing that you describe here sounds off base, but the proof is in
> the pudding so they say.  Best advice I can offer is to follow the
> example of existing powerpc device drivers.  You'll need to describe
> your FPGA interface in the .dts file and write an of_platform driver
> that binds against it.  Make sure you post your proposed dts
> description of the FPGA to the devicetree-discuss@ozlabs.org mailing
> list before committing to it.  In you're device drivers .probe() hook
> you would create and register the NAND and SD devices with the kernel
> with the needed hooks to access the FPGA.
> 
> Here are some good examples of of_platform drivers to look at:
> 
> drivers/block/xsysace.c
> drivers/spi/xilinx_spi.c
> drivers/i2c/busses/i2c-ibm_iic.c

Thanks for the suggestions, and the pointer to some reference drivers ;)


-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive 	     | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com

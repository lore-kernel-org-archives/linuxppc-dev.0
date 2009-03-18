Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 5345FDDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 03:40:50 +1100 (EST)
Received: by gxk1 with SMTP id 1so1734196gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 09:40:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49C12159.4060100@embeddedarm.com>
References: <49C12159.4060100@embeddedarm.com>
Date: Wed, 18 Mar 2009 10:40:48 -0600
Message-ID: <fa686aa40903180940m782bcd65nb78b2c87353f10a@mail.gmail.com>
Subject: Re: [RFC]PPC driver lock for DMA registers
From: Grant Likely <grant.likely@secretlab.ca>
To: Eddie Dawydiuk <eddie@embeddedarm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 18, 2009 at 10:29 AM, Eddie Dawydiuk <eddie@embeddedarm.com> wrote:
> Hello,
>
> I'm working on SD card and Nand drivers that I would like to eventually
> submit for inclusion in the mainline kernel. This being my first kernel port
> being submitted upstream I was hoping for comments on my proposed design to
> ensure it would be excepted in the mainline kernel(from a design
> standpoint). We have an FPGA on our product that has an interface for
> transferring data via DMA. The SD card driver and Nand flash driver will
> both be accessing these registers. As a result I was planning on writing a
> dma driver(drivers/dma/ts81xx.c) that implements a function dma_op() that
> gets passed a physical address, virtual address, length, and read/write op
> and returns an int. I'd use a semaphore to protect the registers. I'd also
> implement a function dma_bus_init() for allocating a cache coherent buffer,
> initializing the semaphore, and ioremapping the FPGA regs.

Nothing that you describe here sounds off base, but the proof is in
the pudding so they say.  Best advice I can offer is to follow the
example of existing powerpc device drivers.  You'll need to describe
your FPGA interface in the .dts file and write an of_platform driver
that binds against it.  Make sure you post your proposed dts
description of the FPGA to the devicetree-discuss@ozlabs.org mailing
list before committing to it.  In you're device drivers .probe() hook
you would create and register the NAND and SD devices with the kernel
with the needed hooks to access the FPGA.

Here are some good examples of of_platform drivers to look at:

drivers/block/xsysace.c
drivers/spi/xilinx_spi.c
drivers/i2c/busses/i2c-ibm_iic.c

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

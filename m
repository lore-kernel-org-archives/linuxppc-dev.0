Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 107C0DE755
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 22:32:36 +1000 (EST)
Message-ID: <48AD5FD1.1090809@ru.mvista.com>
Date: Thu, 21 Aug 2008 16:30:09 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Strange behavior with I2C on Sequoia board
References: <48AC84D9.8050809@harris.com>	<1219279463.26429.35.camel@jdub.homelinux.org>	<20080820231828.3c22da08@lappy.seanm.ca>
	<200808211151.40499.sr@denx.de>
In-Reply-To: <200808211151.40499.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Thursday 21 August 2008, Sean MacLennan wrote:
>>> That's all output from the wrapper, not the kernel.  And the kernel
>>> config doesn't make a difference at all to the wrapper.  I wonder if
>>> there is some weird size issue going on there or if whatever U-Boot
>>> version you are using is doing odd things...
>> Any chance something in the DTS could affect it? Maybe try commenting
>> out the second IIC controller?
> 
> Yes, I2C is generally working and should make a difference in Linux kernel 
> booting.
> 
> It seems that your bootwrapper is somehow not copying the correct MAC address 
> to the device-tree. Not sure what's going wrong here. We usually don't use 
> the bootwrapper but boot the uImage directly from U-Boot on all 4xx systems.
> 
> You might want to debug the bootwrapper code, if possible drop the bootwrapper 
> and use the uImage with a newer, device-tree enabled U-Boot version.
> 

U-boot thinks that all memory above the first 8MB is out of reach for 
the kernel and puts kernel bootargs and boardinfo structure below 8MB as 
close as possible to this limit. Including the i2c driver into the 
kernel increases the kernel image size. So when u-boot unpacks the 
kernel to 0x400000 (Load Address: 00400000) it overwrites the kernel 
parameters. So when the kernel actually starts, it reads zeros instead 
of boardinfo (and mac addresses)

The 8MB limit is set for all AMCC boards in include/configs/amcc-common.h:
#define CFG_BOOTMAPSZ		(8 << 20) /* Initial Memory map for Linux */

I think this limit is obsolete and can be moved to at least 64MB.
But you'll need to rebuild u-boot.

Stefan, what do you think? Can we increase the default initial memory 
map for AMCC boards in the next u-boot release, since u-boot has all 
memory identity-mapped on ppc 44x?

Thanks,
Valentine.

> Best regards,
> Stefan
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

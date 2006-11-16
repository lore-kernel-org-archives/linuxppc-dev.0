Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx9.toshiba.co.jp (imx9.toshiba.co.jp [202.33.96.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77B3F67B77
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 21:02:58 +1100 (EST)
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5 [202.33.96.24])
	by imx9.toshiba.co.jp  with ESMTP id kAG9e1gV025744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 18:40:01 +0900 (JST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id kAG9dr7l029257
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 18:39:53 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id kAG9dsw4029524
	for linuxppc-dev@ozlabs.org; Thu, 16 Nov 2006 18:39:54 +0900 (JST)
Received: from mx11.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id kAG9dqTB009321
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 18:39:53 +0900 (JST)
Message-Id: <200611160939.kAG9dq09024617@toshiba.co.jp>
MIME-Version: 1.0
Date: Thu, 16 Nov 2006 18:42:33 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: benh@kernel.crashing.org, hch@lst.de
Subject: Re: [PATCH 11/16] PATA driver
	for Celleb
In-Reply-To: <1163634900.5940.290.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Christoph-san, Ben-san.

I'm Akira Iguchi, one of Toshiba Linux member.
We thank you very much for commenting.

>On Wed, 2006-11-15 at 19:44 +0100, Christoph Hellwig wrote:
>> On Wed, Nov 15, 2006 at 06:49:15PM +0900, Ishizaki Kou wrote:
>> > This patch adds PATA driver for Celleb platform.
>> 
>> This needs to go to linux-ide for review.  But IIRC new PATA drivers
>> should use libata these days, not the old ide layer.
>
>While I agree, there are still issues with libata vs. devices that needs
>special IOps. libata allows you to override writing/reading taskfiles,
>but there are cases, specifically in the EH/bus reset code, where it
>still assumes the standard taskfile byte access format for a few things
>and while it's possible to "override" these, that means re-implementing
>a lot of logic in the driver.
>
>I need to sort that out with Jeff one of these days as there is a
>similar problem with the mpc52xx IDE driver.
>
>In the meantime, I reckon it's ok to have a drivers/ide driver for
>2.6.20

We use a drivers/ide driver because its design is more suitable for
SCC IDE controller than libata driver. But we will try to implement
the libata driver as needed. This work needs to override many 
callbacks of ata_port_operations by modifying generic helpers.


>I have another question for Toshiba though. From my experience, the
>Spider chip is very lousy vs. ordering of requests (it has several
>severe violations of the PCI spec on the PCI and PCIe busses, requiring
>the workarounds I've implemented in my recent serie of patches, the
>worst one being that reads don't flush pending writes in the other
>direction).
>
>What is the kind of ordering guarantees provided by the IDE interface in
>that case ? The main issue with IDE DMA is that you need to make sure
>that by the time your ide_dma_end callback returns, all outstanding DMAs
>done by the chip have completed. If the chip was writing to memory (due
>to an IDE DMA READ operation), you must guarantee that all the data are
>visible to the BE by the time you return from ide_dma_end().
>
>This is typically not working with standard IDE controllers on spider as
>they rely on an IO read from the device status register to perform that
>flush of pending DMAs, according to the PCI spec, but on spider, no
>flush occurs unless the "dummy read" function is used. That's the reason
>why I implement a dummy read access after every MMIO read access in my
>workarounds.
>
>Thus there are two potential issues you need to clarify here:
>
> - Does your IDE controller guarantee some sort of ordering or not at
>all ? I see that you have your own dma_end callback which does a read
>from the "intsts_port" register. Will that guarantee a flush of
>outstanding DMAs to the BE ?

We use the PRD transfer end read function on SCC IDE controller
to handle this issue.
This function guarantees that issue of DMA End interrupt and
setting the interrupt bit of status register are done after 
the outstanding write data to memory was pushed. Pushing is 
implemented by the dummy read of IDE controller, which reads 
the same path as the path of the write data. 
Therefore this function is same as the flush of outstanding DMAs.
To use this function, we specify the PRD table address(dmatable_dma) 
in PRD Transfer End Read Base Address Register(dma_base + 0x018) as
the path. Of course it also requires to set a strong order in 
the IOIF space.


> - Regarding PCI and PCIe on SCC, I didn't see any code in your PCI
>support code for handling that issue. Is it fixed ? If not, then I
>suppose you'll have problem with most PCI device/drivers on the field as
>they do rely on such ordering to be provided. There was also an issue
>with prefetch on PCI, for which I currently disable the prefetch in the
>workarounds for the cell blade. I don't know if you handle that at all
>neither.

We've noticed the problem you mentioned, and been developing the support
for dummy read(please refer to previous comments for IDE) and etc. to solve
the problem, but we haven't finished yet.  We also currently  disable the
prefetch by initial setup of SCC.  We are trying now so that we can post
the fixed driver code in next patch.

>Regards,
>Ben.
>

Best regards,
Akira Iguchi
Toshiba

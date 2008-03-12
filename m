Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE49ADDFF5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 05:04:25 +1100 (EST)
Date: Wed, 12 Mar 2008 19:04:21 +0100
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: linuxppc-embedded@ozlabs.org
Subject: fsldma seems to be buggy, noticed in loop mode
Message-ID: <20080312180421.GC7255@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have a little kmod where I dma data from one place to another (can
post it if someone wants to see it). It works in general according to
memcmp :)

If I set the DAHE flag (DAHTS = 0, for one byte transfers) everything
seems to work as well (I see only the last byte which has the correct
value).
Now if I change the destination address to my FIFO I get the requested
transfer size plus some extra bytes. The extra bytes are looking like
exactly the same DMA transfer once again. Then my FIFO overruns.
Enabling some printks in the kernel gave me the following log:

|of-fsl-dma-channel e0021100.dma-channe: new link desc alloc df32a000
|of-fsl-dma-channel e0021100.dma-channe: --memcpy issue--
|of-fsl-dma-channel e0021100.dma-channe: Ch 0, LD 1f32a000
|of-fsl-dma-channel e0021100.dma-channe: LD offset 0: 00050000
|of-fsl-dma-channel e0021100.dma-channe: LD offset 1: 1f0be000
|of-fsl-dma-channel e0021100.dma-channe: LD offset 2: 00050000
|of-fsl-dma-channel e0021100.dma-channe: LD offset 3: 1f36c000
|of-fsl-dma-channel e0021100.dma-channe: LD offset 4: 00000000
|of-fsl-dma-channel e0021100.dma-channe: LD offset 5: 00000001
|of-fsl-dma-channel e0021100.dma-channe: LD offset 6: 00000100
|of-fsl-dma-channel e0021100.dma-channe: LD offset 7: 00000000
|of-fsl-dma-channel e0021100.dma-channe: ----------------
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring from 0x000000001f32a000
|of-fsl-dma-channel e0021100.dma-channe: chan completed_cookie = 1
|of-fsl-dma-channel e0021100.dma-channe: link descriptor df32a000 will be recycle.
|of-fsl-dma-channel e0021100.dma-channe: chan completed_cookie = 1
|of-fsl-dma-channel e0021100.dma-channe: chan completed_cookie = 1

done. 
I have one list entry which is df32a000. According to the output that
single request gets started a couple of times what would explain why the
FIFO overruns.
Is it possible that the driver does not properly recognize that the
transfer is finished _and_ that is the last one in line? Enabling the
dma self test Kconfig option shows no error message but the number of
interrupts that have been generated differ from channel to channel,
from boot to boot.

btw: It is a MPC8544 DS with -rc5.

thanks,
 Sebastian

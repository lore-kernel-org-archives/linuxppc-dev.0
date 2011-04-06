Return-Path: <chuckk2333@yahoo.com>
Received: from web36406.mail.mud.yahoo.com (web36406.mail.mud.yahoo.com
	[209.191.91.198]) by ozlabs.org (Postfix) with SMTP id CDBDFB6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 05:41:02 +1000 (EST)
Message-ID: <327152.93855.qm@web36406.mail.mud.yahoo.com>
Date: Wed, 6 Apr 2011 12:40:58 -0700 (PDT)
From: Chuck Ketcham <chuckk2333@yahoo.com>
Subject: Using dmaengine on Freescale P2020 RDB
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All,

I have a Freescale P2020 Reference Design Board.  I am investigating the possibility of using the dmaengine capability in the 2.6.32.13 kernel to transfer data from memory out onto the PCIe bus.  As a first step, I thought I would try the DMA test client (dmatest.ko) to make sure the dmaengine was functioning.  I know this doesn't transfer anything over PCIe but only transfers from one memory buffer to another, but I figured I need to get this working first.  Anyway I built dmatest.ko and ran it (with insmod), and discovered it didn't do anything.  I added some printk's to the kernel to investigate what was going on and I found that all attempts to find a channel within dma_request_channel were unsuccessful.  Three of the channels were not used because they were already publicly allocated.  One channel was not used because it didn't have DMA_MEMCPY capability.

Here are my questions then:
1. Is the dmaengine the appropriate method to use for transferring data from memory out onto the PCIe bus?
2. If dmaengine is correct, what can I do to free up a channel for my own use?

Thank you.

Chuck

Date: Tue, 9 Dec 2003 12:52:17 -0700
From: Jeff Andre <andre@guardian.stortek.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 440GP DMA and dma.h
Message-ID: <20031209195217.GA28122@guardian.stortek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to get DMA working on a custom board with a 440GP.  I was
having problem getting a DMA transfer started and traced the problem
to 'enable_dma' not being called.  After a bit amount of research I
found that my device driver didn't have an undefined external reference
to 'enable_dma'.

I traced the problem to the include of <linux/pci.h> that eventually
included <asm/scatterlist.h> that included <asm/dma.h>.  This header
has many of the DMA functions defined as inline and static, 'enable_dma'
being one of them.  If I comment out the include of <asm/dma.h> the
compiler finds the include in my driver of <asm/ppc4xx_dma.h> and DMA
transfers work (sort-of).

Does anyone have a clue as to what I'm doing wrong?  I can't believe
I'm the first to discover this.

Thanks,

Jeff Andre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

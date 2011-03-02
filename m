Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id E1D81B7104
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Mar 2011 09:23:35 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/9] fsldma: lockup fixes
Date: Wed,  2 Mar 2011 14:23:12 -0800
Message-Id: <1299104601-15447-1-git-send-email-iws@ovro.caltech.edu>
Cc: dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everyone,

I've been chasing random infrequent controller lockups in the fsldma driver
for a long time. I finally managed to find the problem and fix it. I'm not
quite sure about the exact sequence of events which causes the race
condition, but it is related to using the hardware registers to track the
controller state. See the patch changelogs for more detail.

The problems were quickly found by turning on DMAPOOL_DEBUG inside
mm/dmapool.c. This poisons memory allocated with the dmapool API.

With dmapool poisoning turned on, the dmatest driver would start producing
failures within a few seconds. After this patchset has been applied, I have
run several iterations of the 10 threads per channel, 100000 iterations per
thread test without any problems. I have also tested it with the CARMA
drivers (posted at linuxppc-dev previously), which make use of the external
control features.

While making the previous changes, I noticed that the fsldma driver does
not respect the automatic DMA unmapping of src and dst buffers. I have
added support for this feature. This also required a fix to dmatest, which
was sending incorrect flags.

The "support async_tx dependencies" patch could be split apart from the
automatic unmapping patch if it is desirable. They both touch the same
piece of code, so I thought it was ok to combine them. Let me know.

I would really like to see this go into 2.6.39. I think we can get it
reviewed before then. :)

Much thanks goes to Felix Radensky for testing on a P2020 (85xx DMA IP core).
I wouldn't have been able to track down the problems on 85xx without his
dilligent testing.

v1 -> v2:
- reordered patches (dmatest change is first now)
- fix problems on 85xx controller
- only set correct bits for 83xx in dma_halt()

Ira W. Snyder (9):
  dmatest: fix automatic buffer unmap type
  fsldma: move related helper functions near each other
  fsldma: use channel name in printk output
  fsldma: improve link descriptor debugging
  fsldma: minor codingstyle and consistency fixes
  fsldma: fix controller lockups
  fsldma: support async_tx dependencies and automatic unmapping
  fsldma: reduce locking during descriptor cleanup
  fsldma: make halt behave nicely on all supported controllers

 drivers/dma/dmatest.c |    7 +-
 drivers/dma/fsldma.c  |  542 +++++++++++++++++++++++++++----------------------
 drivers/dma/fsldma.h  |    6 +-
 3 files changed, 308 insertions(+), 247 deletions(-)

-- 
1.7.3.4

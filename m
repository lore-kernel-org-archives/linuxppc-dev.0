Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 07745B7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Feb 2011 11:23:36 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/8] fsldma: lockup fixes
Date: Fri, 25 Feb 2011 16:23:17 -0800
Message-Id: <1298679805-14108-1-git-send-email-iws@ovro.caltech.edu>
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
thread test without any problems.

I have made some changes which effect the 85xx/86xx part. I believe that
the changes only effect features which have been unused since the rewrite
in Jan 2010. It would be very good to get a test report from an 85xx/86xx
user.

While making the previous changes, I noticed that the fsldma driver does
not respect the automatic DMA unmapping of src and dst buffers. I have
added support for this feature. This also required a fix to dmatest, which
was sending incorrect flags.

The "support async_tx dependencies" patch could be split apart from the
automatic unmapping patch if it is desirable. They both touch the same
piece of code, so I thought it was ok to combine them. Let me know.

I would really like to see this go into 2.6.39. I think we can get it
reviewed before then. :)

Ira W. Snyder (8):
  fsldma: move related helper functions near each other
  fsldma: use channel name in printk output
  fsldma: improve link descriptor debugging
  fsldma: minor codingstyle and consistency fixes
  fsldma: fix controller lockups
  fsldma: support async_tx dependencies and automatic unmapping
  dmatest: fix automatic buffer unmap type
  fsldma: reduce locking during descriptor cleanup

 drivers/dma/dmatest.c |    7 +-
 drivers/dma/fsldma.c  |  485 +++++++++++++++++++++++++-----------------------
 drivers/dma/fsldma.h  |    6 +-
 3 files changed, 263 insertions(+), 235 deletions(-)

-- 
1.7.3.4

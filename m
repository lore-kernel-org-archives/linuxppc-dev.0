Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 76E49B711F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Sep 2010 09:13:54 +1000 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFCv2 0/2] dma: add support for sg-to-sg transfers
Date: Fri, 24 Sep 2010 16:13:50 -0700
Message-Id: <1285370032-16937-1-git-send-email-iws@ovro.caltech.edu>
Cc: Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for scatterlist to scatterlist transfers to the
generic DMAEngine API. I have hidden it behind a configuration option to
allow specific drivers that need this functionality to enable it.

This series is intended to lay the groundwork for further changes to the
series titled "CARMA Board Support". That series will be updated when I
have time and hardware to test with.

This series has not been runtime tested yet. I am posting it only to
gain comments before I spend the effort to update the driver that
depends on this.

To help reviewers, I'd like to comment on the architecture of
dma_async_memcpy_sg_to_sg(). It explicitly avoids using descriptor
chaining due to the way that feature interacts with the fsldma
controller's external start feature. To use the external start feature
properly, the in-memory descriptor chain must not be fragmented into
multiple smaller chains. This is what is achieved by submitting all
descriptors without using chaining.

An alternative implementation would create a device_prep_sg_to_sg()
function, and use that to allocate all descriptors in one shot. That
implementation would be safer against allocation failures than this one.

I would recommend against committing this until I've tested it on real
hardware.

Ira W. Snyder (2):
  dmaengine: add support for scatterlist to scatterlist transfers
  fsldma: use generic support for scatterlist to scatterlist transfers

 arch/powerpc/include/asm/fsldma.h |  115 ++------------------
 drivers/dma/Kconfig               |    4 +
 drivers/dma/dmaengine.c           |  119 ++++++++++++++++++++
 drivers/dma/fsldma.c              |  219 +++++++------------------------------
 include/linux/dmaengine.h         |   10 ++
 5 files changed, 181 insertions(+), 286 deletions(-)

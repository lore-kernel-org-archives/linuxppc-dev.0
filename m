Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 29AE7B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 09:34:07 +1100 (EST)
Date: Tue, 6 Mar 2012 22:33:21 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/9] DMA engine cookie handling cleanups
Message-ID: <20120306223321.GD15201@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@st.com>, Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Barry Song <baohua.song@csr.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[v2 - more or less same description.  Including lakml in cc for the full
set]

This patch series cleans up the handling of cookies in DMA engine drivers.
This is done by providing a set of inline library functions for common
tasks:

- moving the 'last completed cookie' into struct dma_chan - everyone
  has this in their driver private channel data structure

- consolidate allocation of cookies to DMA descriptors

- common way to update 'last completed cookie' value

- standard way to implement tx_status callback and update the residue

- consolidate initialization of cookies

- update implementations differing from the majority of DMA engine drivers
  to behave the same as the majority implementation in respect of cookies

What this means is that we get to the point where all DMA engine drivers
will hand out cookie value '2' as the first, and incrementing cookie
values up to INT_MAX, returning to cookie '1' as the next cookie.

Think of this patch series as round 1...  I am hoping over time that more
code can be consolidated between the DMA engine drivers and end up with a
consistent way to handle various common themes in DMA engine hardware
(like physical channel<->peripheral request signal selection.)

Overall, the diffstat looks like this:

 arch/arm/include/asm/hardware/iop_adma.h |    2 -
 drivers/dma/amba-pl08x.c                 |   38 ++++---------
 drivers/dma/at_hdmac.c                   |   48 ++++------------
 drivers/dma/at_hdmac_regs.h              |    2 -
 drivers/dma/coh901318.c                  |   39 +++----------
 drivers/dma/dmaengine.h                  |   89 ++++++++++++++++++++++++++++++
 drivers/dma/dw_dmac.c                    |   43 +++-----------
 drivers/dma/dw_dmac_regs.h               |    1 -
 drivers/dma/ep93xx_dma.c                 |   25 ++------
 drivers/dma/fsldma.c                     |   24 ++------
 drivers/dma/fsldma.h                     |    1 -
 drivers/dma/imx-dma.c                    |   32 ++---------
 drivers/dma/imx-sdma.c                   |   23 ++------
 drivers/dma/intel_mid_dma.c              |   37 +++---------
 drivers/dma/intel_mid_dma_regs.h         |    2 -
 drivers/dma/ioat/dma.c                   |   21 +++----
 drivers/dma/ioat/dma.h                   |   23 --------
 drivers/dma/ioat/dma_v2.c                |   13 ++---
 drivers/dma/ioat/dma_v3.c                |   11 ++--
 drivers/dma/iop-adma.c                   |   51 ++++-------------
 drivers/dma/ipu/ipu_idmac.c              |   22 ++-----
 drivers/dma/mpc512x_dma.c                |   25 +++------
 drivers/dma/mv_xor.c                     |   34 ++---------
 drivers/dma/mv_xor.h                     |    3 -
 drivers/dma/mxs-dma.c                    |   23 ++------
 drivers/dma/pch_dma.c                    |   34 ++---------
 drivers/dma/pl330.c                      |   36 ++----------
 drivers/dma/ppc4xx/adma.c                |   49 +++-------------
 drivers/dma/ppc4xx/adma.h                |    2 -
 drivers/dma/shdma.c                      |   30 +++-------
 drivers/dma/shdma.h                      |    1 -
 drivers/dma/sirf-dma.c                   |   23 ++------
 drivers/dma/ste_dma40.c                  |   36 +++---------
 drivers/dma/timb_dma.c                   |   28 +++-------
 drivers/dma/txx9dmac.c                   |   41 +++-----------
 drivers/dma/txx9dmac.h                   |    1 -
 include/linux/amba/pl08x.h               |    2 -
 include/linux/dmaengine.h                |    6 +-
 38 files changed, 293 insertions(+), 628 deletions(-)

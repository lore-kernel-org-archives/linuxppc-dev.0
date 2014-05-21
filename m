Return-Path: <hongbo.zhang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 946B91A082C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 18:03:49 +1000 (EST)
From: <hongbo.zhang@freescale.com>
To: <vkoul@infradead.org>, <dan.j.williams@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH v5 0/3] DMA: Freescale: driver cleanups and enhancements
Date: Wed, 21 May 2014 16:03:00 +0800
Message-ID: <1400659383-6555-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Hongbo Zhang <hongbo.zhang@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 leo.li@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

Hi Dan,
Please have a look at this 3/3 as Vinod mentioned.

Hi Vinod Koul,
Please have a look at the v5 patch set.

v4 -> v5 changes:
 - since previous 5 of 8 patches have been merged by Vinod, this iteration oly
   inludes the last 3 patches of v4.
 - patches order is changed for being reviewed and merged easier.
 - remove the .prepare functions, and use the suspend_late and resume_early in
   the suspend-and-resume patch.

v3 -> v4 changes:
 - Fixed a typo in [2/8] commit message.
 - There was a potential double call of list_del() when apply [4/8] only,
   although this defect is removed again in later [6/8]. This version 
   eliminates this problem by updating [4/8] and [6/8] slightly.
 - Updated [8/8] to use register access method introduced by [2/8]

v2 -> v3 change:
Only add "chan->pm_state = RUNNING" for patch[8/8].

v1 -> v2 change:
The only one change is introducing a new patch[1/7] to remove the unnecessary
macro FSL_DMA_LD_DEBUG, thus the total patches number is 8 now (was 7)

v1 notes:
Note that patch 2~6 had beed sent out for upstream before, but were together
with other storage patches at that time, that was not easy for being reviewed
and merged, so I send them separately this time.

Hongbo Zhang (3):
  DMA: Freescale: use spin_lock_bh instead of spin_lock_irqsave
  DMA: Freescale: add suspend resume functions for DMA driver
  DMA: Freescale: change descriptor release process for supporting
    async_tx

 drivers/dma/fsldma.c |  297 ++++++++++++++++++++++++++++++++++++++------------
 drivers/dma/fsldma.h |   32 +++++-
 2 files changed, 260 insertions(+), 69 deletions(-)

-- 
1.7.9.5

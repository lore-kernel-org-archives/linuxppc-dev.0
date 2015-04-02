Return-Path: <vinod.koul@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id D5FFF1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 21:48:02 +1100 (AEDT)
Date: Thu, 2 Apr 2015 16:13:35 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: xuelin.shi@freescale.com
Subject: Re: [PATCH v6] dmaengine: Driver support for FSL RaidEngine device.
Message-ID: <20150402104335.GD6631@intel.com>
References: <1425363982-14925-1-git-send-email-xuelin.shi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425363982-14925-1-git-send-email-xuelin.shi@freescale.com>
Cc: dmaengine@vger.kernel.org, Harninder Rai <harninder.rai@freescale.com>,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 03, 2015 at 02:26:22PM +0800, xuelin.shi@freescale.com wrote:
> From: Xuelin Shi <xuelin.shi@freescale.com>
> 
> The RaidEngine is a new FSL hardware used for Raid5/6 acceration.
> This patch enables the RaidEngine functionality and provides
> hardware offloading capability for memcpy, xor and pq computation.
> It works with async_tx.
Applied, with below patch added on top

diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 12778bd6446b..4d9470f16552 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -629,7 +629,7 @@ static void fsl_re_free_chan_resources(struct dma_chan
*chan)
                dev_err(re_chan->dev, "chan resource cannot be cleaned!\n");
 }

-int fsl_re_chan_probe(struct platform_device *ofdev,
+static int fsl_re_chan_probe(struct platform_device *ofdev,
                      struct device_node *np, u8 q, u32 off)
 {
        struct device *dev, *chandev;

-- 
~Vinod

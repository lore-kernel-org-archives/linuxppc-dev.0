Return-Path: <vinod.koul@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id E3816140133
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 May 2014 03:09:01 +1000 (EST)
Date: Fri, 2 May 2014 22:16:04 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: hongbo.zhang@freescale.com
Subject: Re: [PATCH v4 8/8] DMA: Freescale: add suspend resume functions
 for DMA driver
Message-ID: <20140502164604.GB32284@intel.com>
References: <1397809071-5353-1-git-send-email-hongbo.zhang@freescale.com>
 <1397809071-5353-9-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397809071-5353-9-git-send-email-hongbo.zhang@freescale.com>
Cc: leo.li@freescale.com, vkoul@infradead.org, linux-kernel@vger.kernel.org,
 scottwood@freescale.com, dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2014 at 04:17:51PM +0800, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
> 
> This patch adds suspend resume functions for Freescale DMA driver.
> .prepare callback is used to stop further descriptors from being added into the
> pending queue, and also issue pending queues into execution if there is any.
> .suspend callback makes sure all the pending jobs are cleaned up and all the
> channels are idle, and save the mode registers.
> .resume callback re-initializes the channels by restore the mode registers.
> 

> +
> +static const struct dev_pm_ops fsldma_pm_ops = {
> +	.prepare	= fsldma_prepare,
> +	.suspend	= fsldma_suspend,
> +	.resume		= fsldma_resume,
> +};
I think this is not correct. We discussed this sometime back on list. The
DMAengine drivers should use late resume and early suspend to ensure they get
suspended after clients (who should use normal ones) and resume before them

-- 
~Vinod

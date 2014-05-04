Return-Path: <hongbo.zhang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 25105140186
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 May 2014 20:22:47 +1000 (EST)
Message-ID: <536614E7.9050301@freescale.com>
Date: Sun, 4 May 2014 18:22:31 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 8/8] DMA: Freescale: add suspend resume functions for
 DMA driver
References: <1397809071-5353-1-git-send-email-hongbo.zhang@freescale.com>
 <1397809071-5353-9-git-send-email-hongbo.zhang@freescale.com>
 <20140502164604.GB32284@intel.com>
In-Reply-To: <20140502164604.GB32284@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
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


On 05/03/2014 12:46 AM, Vinod Koul wrote:
> On Fri, Apr 18, 2014 at 04:17:51PM +0800, hongbo.zhang@freescale.com wrote:
>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>
>> This patch adds suspend resume functions for Freescale DMA driver.
>> .prepare callback is used to stop further descriptors from being added into the
>> pending queue, and also issue pending queues into execution if there is any.
>> .suspend callback makes sure all the pending jobs are cleaned up and all the
>> channels are idle, and save the mode registers.
>> .resume callback re-initializes the channels by restore the mode registers.
>>
>> +
>> +static const struct dev_pm_ops fsldma_pm_ops = {
>> +	.prepare	= fsldma_prepare,
>> +	.suspend	= fsldma_suspend,
>> +	.resume		= fsldma_resume,
>> +};
> I think this is not correct. We discussed this sometime back on list. The
> DMAengine drivers should use late resume and early suspend to ensure they get
> suspended after clients (who should use normal ones) and resume before them
>
OK, will update it like this:
use .suspend to take place of current .prepare
use .suspend_late to take place of current .suspend
use .resume_early to take place of current .resume

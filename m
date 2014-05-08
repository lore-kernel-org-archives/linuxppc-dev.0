Return-Path: <hongbo.zhang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 33BF914007D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 19:52:59 +1000 (EST)
Message-ID: <536B53E5.30506@freescale.com>
Date: Thu, 8 May 2014 17:52:37 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 8/8] DMA: Freescale: add suspend resume functions for
 DMA driver
References: <1397809071-5353-1-git-send-email-hongbo.zhang@freescale.com>
 <1397809071-5353-9-git-send-email-hongbo.zhang@freescale.com>
 <20140502164604.GB32284@intel.com> <536614E7.9050301@freescale.com>
 <1399451493.2677.11.camel@smile.fi.intel.com>
In-Reply-To: <1399451493.2677.11.camel@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "leo.li@freescale.com" <leo.li@freescale.com>, "Koul,
 Vinod" <vinod.koul@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vkoul@infradead.org" <vkoul@infradead.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05/07/2014 04:31 PM, Shevchenko, Andriy wrote:
> On Sun, 2014-05-04 at 18:22 +0800, Hongbo Zhang wrote:
>> On 05/03/2014 12:46 AM, Vinod Koul wrote:
>>> On Fri, Apr 18, 2014 at 04:17:51PM +0800, hongbo.zhang@freescale.com wrote:
>>>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>>>
>>>> This patch adds suspend resume functions for Freescale DMA driver.
>>>> .prepare callback is used to stop further descriptors from being added into the
>>>> pending queue, and also issue pending queues into execution if there is any.
>>>> .suspend callback makes sure all the pending jobs are cleaned up and all the
>>>> channels are idle, and save the mode registers.
>>>> .resume callback re-initializes the channels by restore the mode registers.
>>>>
>>>> +
>>>> +static const struct dev_pm_ops fsldma_pm_ops = {
>>>> +	.prepare	= fsldma_prepare,
>>>> +	.suspend	= fsldma_suspend,
>>>> +	.resume		= fsldma_resume,
>>>> +};
>>> I think this is not correct. We discussed this sometime back on list. The
>>> DMAengine drivers should use late resume and early suspend to ensure they get
>>> suspended after clients (who should use normal ones) and resume before them
>>>
>> OK, will update it like this:
>> use .suspend to take place of current .prepare
> Could you remove this at all?
>
> Answering to your previous statements I could say that.
> Device drivers (DMAc users) that don't implement .suspend callback are
> on their own with troubles, you have not to care about them in the DMA
> driver.

Thanks for pointing out this issue.
Then how to handle the descriptors in the pending list if there is any?
a. let them finished.
     but if the DMA user has already suspended prior DMA controller, it 
is meaningless somehow and may even ask for trouble.
b. don't touch them.
     after resume these pending descriptors could be executed, it is 
also meaningless because the resumed DMA user may in different state 
from before being suspended.
c. delete them.
     should we do this? is is a bit crude?
d. return a non-success value
     then the whole suspend process is reversed, e.g. suspend fails.
I've looked through some dma drivers, most of them is in case b.

>> use .suspend_late to take place of current .suspend
>> use .resume_early to take place of current .resume
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

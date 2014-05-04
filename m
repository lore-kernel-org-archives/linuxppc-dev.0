Return-Path: <hongbo.zhang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9C44914015E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 May 2014 18:55:38 +1000 (EST)
Message-ID: <5365FCF2.9090008@freescale.com>
Date: Sun, 4 May 2014 16:40:18 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 7/8] DMA: Freescale: use spin_lock_bh instead of
 spin_lock_irqsave
References: <1397809071-5353-1-git-send-email-hongbo.zhang@freescale.com>
 <1397809071-5353-8-git-send-email-hongbo.zhang@freescale.com>
 <20140502165143.GI32284@intel.com>
In-Reply-To: <20140502165143.GI32284@intel.com>
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


On 05/03/2014 12:51 AM, Vinod Koul wrote:
> On Fri, Apr 18, 2014 at 04:17:50PM +0800, hongbo.zhang@freescale.com wrote:
>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>
>> The usage of spin_lock_irqsave() is a stronger locking mechanism than is
>> required throughout the driver. The minimum locking required should be used
>> instead. Interrupts will be turned off and context will be saved, it is
>> unnecessary to use irqsave.
>>
>> This patch changes all instances of spin_lock_irqsave() to spin_lock_bh(). All
>> manipulation of protected fields is done using tasklet context or weaker, which
>> makes spin_lock_bh() the correct choice.
>>
> This doesnt apply, perhpas due to depends on 6/8
>
So let's wait for the review result of 6/8.

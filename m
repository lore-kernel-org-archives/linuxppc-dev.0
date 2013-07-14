Return-Path: <lars@metafoo.de>
Received: from smtp-out-124.synserver.de (smtp-out-124.synserver.de
 [212.40.185.124]) by ozlabs.org (Postfix) with ESMTP id 644192C017C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 19:52:37 +1000 (EST)
Message-ID: <51E27508.7040907@metafoo.de>
Date: Sun, 14 Jul 2013 11:53:12 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 5/8] dma: mpc512x: use symbolic specifiers for DMA
 channels
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <201307130917.08904.arnd@arndb.de>
 <20130713141443.GJ2615@book.gsilab.sittig.org>
 <201307141050.05153.arnd@arndb.de>
In-Reply-To: <201307141050.05153.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>, Dan Williams <djbw@fb.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/14/2013 10:50 AM, Arnd Bergmann wrote:
> On Saturday 13 July 2013, Gerhard Sittig wrote:
>> [ MPC8308 knowledge required, see below ]
>>
>> On Sat, Jul 13, 2013 at 09:17 +0200, Arnd Bergmann wrote:
>>>
>>> On Friday 12 July 2013, Gerhard Sittig wrote:
>>>> +++ b/include/dt-bindings/dma/mpc512x-dma.h
>>>> @@ -0,0 +1,21 @@
>>>> +/*
>>>> + * This header file provides symbolic specifiers for DMA channels
>>>> + * within the MPC512x SoC's DMA controller.  Since requester lines
>>>> + * directly map to channel numbers and no additional flexibility
>>>> + * is involved, DMA channels can be considered directly associated
>>>> + * with individual peripherals.
>>>> + *
>>>> + * This header file gets shared among DT bindings which provide
>>>> + * hardware specs, and driver code which implements supporting logic.
>>>> + */
>>>> +
>>>> +#ifndef _DT_BINDINGS_DMA_MPC512x_DMA_H
>>>> +#define _DT_BINDINGS_DMA_MPC512x_DMA_H
>>>> +
>>>> +#define MPC512x_DMACHAN_SCLPC          26
>>>> +#define MPC512x_DMACHAN_SDHC           30
>>>> +#define MPC512x_DMACHAN_MDDRC          32
>>>> +
>>>> +#define MPC512x_DMACHAN_MAX            64
>>>> +
>>>
>>> I think these should not be in the header and should not bve part of the
>>> binding either. They are specific to an SoC that happens to be using this
>>> DMA controller but would be completely different for any other SoC with
>>> the same DMA engine. These belong into the dma descriptors of the slave
>>> drivers and don't need symbolic names.
>>
>> Thank you for the feedback.
>>
>> OK, so not adding the dt-bindings header leads to no change in
>> the DTS nodes, which in turn collapses 5/8 into something local
>> to the .c driver source (introduce an enum and replace a few
>> magic numbers with names), and obsoletes 4/8 as a prerequisite.
>> This will further reduce the patch set's size.
> 
> Actually I think you will need extra changes: The dma-engine driver
> should not require knowledge of any channel-specific settings.
> I did not notice you had them until you mentioned the above, but
> from what I can tell, you need a few flags in the dma-specifier
> to replace code like
> 
>                 /* only start explicitly on MDDRC channel */
> -               if (cid == 32)
> +               if (cid == MPC512x_DMACHAN_MDDRC)
>                         mdesc->tcd->start = 1;
> 
> with
> 
> 		mdesc->tcd->start = dmaspec->explicit_start;
> 
> or something along these lines, where dmaspec is a data structure
> derived from the fields in the DT dma specifier of the child
> node.		
> 

I think the MDDRC channel is used for mem-to-mem transfers. So there is no
peripheral that is going to request it by handle. If the channel that is
used for mem-to-mem transfers differs between different instances of the
controller (e.g. on different SoCs) it should probably be a property of the
dma controllers DT node.

- Lars

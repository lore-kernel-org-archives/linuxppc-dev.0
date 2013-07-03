Return-Path: <B10716@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B9382C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 01:13:45 +1000 (EST)
Received: from mail98-ch1 (localhost [127.0.0.1])	by mail98-ch1-R.bigfish.com
 (Postfix) with ESMTP id 77B84A016A	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jul 2013 15:13:40 +0000 (UTC)
Received: from CH1EHSMHS043.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.253])	by mail98-ch1.bigfish.com (Postfix) with ESMTP id
 BEBE63C05DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 15:13:19 +0000 (UTC)
Message-ID: <51D43F8A.7060008@freescale.com>
Date: Wed, 3 Jul 2013 18:13:14 +0300
From: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH][v2] powerpc/85xx: Move ePAPR paravirt initialization
 earlier
References: <1372769189-17864-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1372787740.8183.113@snotra> <51D41937.3000509@freescale.com>
 <1372863166.8183.129@snotra>
In-Reply-To: <1372863166.8183.129@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2013 05:52 PM, Scott Wood wrote:
> On 07/03/2013 07:29:43 AM, Tudor Laurentiu wrote:
>> On 07/02/2013 08:55 PM, Scott Wood wrote:
>>> On 07/02/2013 07:46:29 AM, Laurentiu Tudor wrote:
>>>> - insts = of_get_property(hyper_node, "hcall-instructions", &len);
>>>> - if (!insts)
>>>> - return -ENODEV;
>>>> +#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
>>>> + if (of_get_flat_dt_prop(node, "has-idle", NULL))
>>>> + ppc_md.power_save = epapr_ev_idle;
>>>> +#endif
>>>
>>> Why are you doing this before processing hcall-instructions?
>>>
>>
>> Nothing of importance. The code seemed more clear to me.
>
> It seems wrong to expose epapr_ev_idle to ppc_md before the hcall has
> been patched in, even if you don't expect to actually go idle at this
> point.
>

Ah, now I understand your concerns. I've submitted a [v3] restoring the 
original ordering.

---
Best Regards, Laurentiu

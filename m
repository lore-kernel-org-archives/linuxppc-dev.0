Return-Path: <clombard@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9AEE1A000C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:47:49 +1100 (AEDT)
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 10:47:46 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id E5D831B08077
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:48:00 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1GAlitZ328158
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:47:44 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G9ljQv025890
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 02:47:46 -0700
Subject: Re: [PATCH v3 14/18] cxl: Support to flash a new image on the adapter
 from a guest
To: Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1454765345-7417-15-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1455097101-sup-8413@delenn.ozlabs.ibm.com>
 <56C23AE2.8050608@linux.vnet.ibm.com>
 <1455577998-sup-2795@delenn.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Message-ID: <56C2FE4F.1010208@linux.vnet.ibm.com>
Date: Tue, 16 Feb 2016 11:47:43 +0100
MIME-Version: 1.0
In-Reply-To: <1455577998-sup-2795@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Excerpts from christophe lombard's message of 2016-02-16 07:53:54 +1100:
>>>> +void cxl_guest_reload_module(struct cxl *adapter)
>>>> +{
>>>> +    struct platform_device *pdev;
>>>> +    int afu;
>>>> +
>>>> +    for (afu = 0; afu < adapter->slices; afu++)
>>>> +        cxl_guest_remove_afu(adapter->afu[afu]);
>>> Should we possibly have done this part earlier?
>>>
>>> I'd think it should be done before any operation that might lead to us
>>> resetting the card. Probably the safest thing is to do it when the first
>>> chunk is handed to the kernel so we can make sure it's safe, and return
>>> -EBUSY if any of the AFUs are still in use.
>> Not necessary. PowerVM - phyp - refuses any type of action when an operation
>> of download/validation is in progress. The reverse is true as well.
> I was more thinking about what could happen in the short window between
> when phyp resets the card and is potentially accepting new operations
> and when we remove the old AFUs from Linux - could anything bad happen
> if someone e.g. did an attach at that moment and Linux still had
> outdated info left over from the previous AFU?
>
> Cheers,
> -Ian

You are absolutely right on this point. A short window could exist.
We have to change our current design.

Thanks for your feedback.

Christophe

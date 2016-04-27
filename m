Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvhVC4BJ0zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:01:07 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id y69so13508799pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 18:01:07 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm: Use jump label to speed up radix_enabled check
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
References: <1461687855-23017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461704701.3135.68.camel@kernel.crashing.org> <571FE8C1.4030903@gmail.com>
 <1461711943.3135.72.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57200F4A.4070104@gmail.com>
Date: Wed, 27 Apr 2016 11:00:58 +1000
MIME-Version: 1.0
In-Reply-To: <1461711943.3135.72.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 27/04/16 09:05, Benjamin Herrenschmidt wrote:
> On Wed, 2016-04-27 at 08:16 +1000, Balbir Singh wrote:
>>
>> On 27/04/16 07:05, Benjamin Herrenschmidt wrote:
>>>
>>> On Tue, 2016-04-26 at 21:54 +0530, Aneesh Kumar K.V wrote:
>>>>
>>>> This add generic mmu_feature_enabled() function that get patched
>>>> to take right code path based on the feature bit enabled. The
>>>> main
>>>> difference between the existing mmu_has_feature() function is the
>>>> hot patching using jump label framework.
>>>>
>>>> The implementation wraps around mmu_has_feature so that we can
>>>> use
>>>> this in early bootup code before we do the hotpatching.
>>> I'd rather we make mmu_has_feature() use jump labels and is the
>>> "main"
>>> API to be used by most code. If we have a need for a lower-level
>>> version for use by early boot code, call it __mmu_has_feature().
>>>
>>> This is more in-line with existing kernel practices and avoids
>>> having
>>> two APIs that somewhat look the same where it's not clear which one
>>> should be used.
>>>
>> Makes sense, but I suspect its a larger impact with loads of testing
>> required across platforms. Should this be done incrementally?
> 
> What kind of impact do you expect ?
> 

Just basic testing across CPUs with various mm features 
enabled/disabled. Just for sanity

Balbir

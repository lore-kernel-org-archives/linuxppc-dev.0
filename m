Return-Path: <zhongjiang@huawei.com>
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42L09Q5Jw9zF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 00:06:31 +1000 (AEST)
Message-ID: <5BAB925D.1030803@huawei.com>
Date: Wed, 26 Sep 2018 22:06:21 +0800
From: zhong jiang <zhongjiang@huawei.com>
MIME-Version: 1.0
To: Christophe LEROY <christophe.leroy@c-s.fr>
CC: <paulus@samba.org>, <benh@kernel.crashing.org>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Move a dereference below a NULL test
References: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com>
 <fb8bc993-2adc-6a70-2643-6195ba5f020f@c-s.fr>
In-Reply-To: <fb8bc993-2adc-6a70-2643-6195ba5f020f@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018/9/26 21:58, Christophe LEROY wrote:
>
>
> Le 26/09/2018 à 13:46, zhong jiang a écrit :
>> It is safe to move dereference below a NULL test.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>   arch/powerpc/kernel/cacheinfo.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
>> index a8f20e5..7f19714 100644
>> --- a/arch/powerpc/kernel/cacheinfo.c
>> +++ b/arch/powerpc/kernel/cacheinfo.c
>> @@ -401,14 +401,13 @@ static struct cache *cache_lookup_or_instantiate(struct device_node *node,
>>       struct cache *cache;
>>         cache = cache_lookup_by_node(node);
>> +    if (!cache)
>> +        cache = cache_do_one_devnode(node, level);
>
> But by doing this, you change the meaning of the following warning. Is that what you want ? In that case the text of the WARN_ONCE() should be changed, because the mismatch is not only on lookup now.
>
Yep, I forget the WARN_ONCE. I think we should just remove it. Thought?

Thanks,
zhong jiang
> Christophe
>
>>         WARN_ONCE(cache && cache->level != level,
>>             "cache level mismatch on lookup (got %d, expected %d)\n",
>>             cache->level, level);
>>   -    if (!cache)
>> -        cache = cache_do_one_devnode(node, level);
>> -
>>       return cache;
>>   }
>>  
>
> .
>

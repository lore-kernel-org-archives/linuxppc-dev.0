Return-Path: <zhongjiang@huawei.com>
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42L0yx6kpZzF3L9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 00:42:31 +1000 (AEST)
Message-ID: <5BAB9ACF.6040102@huawei.com>
Date: Wed, 26 Sep 2018 22:42:23 +0800
From: zhong jiang <zhongjiang@huawei.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>
CC: <paulus@samba.org>, <benh@kernel.crashing.org>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Move a dereference below a NULL test
References: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com>
 <20180926162232.250c0090@naga>
In-Reply-To: <20180926162232.250c0090@naga>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018/9/26 22:22, Michal Suchánek wrote:
> On Wed, 26 Sep 2018 19:46:08 +0800
> zhong jiang <zhongjiang@huawei.com> wrote:
>
>> It is safe to move dereference below a NULL test.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  arch/powerpc/kernel/cacheinfo.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/cacheinfo.c
>> b/arch/powerpc/kernel/cacheinfo.c index a8f20e5..7f19714 100644
>> --- a/arch/powerpc/kernel/cacheinfo.c
>> +++ b/arch/powerpc/kernel/cacheinfo.c
>> @@ -401,14 +401,13 @@ static struct cache
>> *cache_lookup_or_instantiate(struct device_node *node, struct cache
>> *cache; 
>>  	cache = cache_lookup_by_node(node);
>> +	if (!cache)
>> +		cache = cache_do_one_devnode(node, level);
>>  
>>  	WARN_ONCE(cache && cache->level != level,
> This has also null test so cache should be dereferenced only when
> non-null here.
:-[ ,  you're right.  I forget WARN_ONCE.  please ignore the patch.

Sincerely,
zhong jiang
> Thanks
>
> Michal
>
> .
>

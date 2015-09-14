Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E74D21A2BD5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 23:05:12 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Mon, 14 Sep 2015 23:05:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 21D473578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 23:05:08 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8ED4xZ252822096
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 23:05:08 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8ED4YZE003242
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 23:04:35 +1000
Message-ID: <55F6C637.6080807@linux.vnet.ibm.com>
Date: Mon, 14 Sep 2015 18:35:59 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Vladimir Davydov <vdavydov@parallels.com>
CC: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, akpm@linux-foundation.org, nacc@linux.vnet.ibm.com,
 gkurz@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: Replace nr_node_ids for loop with for_each_node
 in list lru
References: <1441737107-23103-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1441737107-23103-2-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <20150914090010.GB30743@esperanza> <55F6B1F3.1010702@linux.vnet.ibm.com>
 <20150914120455.GD30743@esperanza>
In-Reply-To: <20150914120455.GD30743@esperanza>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/14/2015 05:34 PM, Vladimir Davydov wrote:
> On Mon, Sep 14, 2015 at 05:09:31PM +0530, Raghavendra K T wrote:
>> On 09/14/2015 02:30 PM, Vladimir Davydov wrote:
>>> On Wed, Sep 09, 2015 at 12:01:46AM +0530, Raghavendra K T wrote:
>>>> The functions used in the patch are in slowpath, which gets called
>>>> whenever alloc_super is called during mounts.
>>>>
>>>> Though this should not make difference for the architectures with
>>>> sequential numa node ids, for the powerpc which can potentially have
>>>> sparse node ids (for e.g., 4 node system having numa ids, 0,1,16,17
>>>> is common), this patch saves some unnecessary allocations for
>>>> non existing numa nodes.
>>>>
>>>> Even without that saving, perhaps patch makes code more readable.
>>>
>>> Do I understand correctly that node 0 must always be in
>>> node_possible_map? I ask, because we currently test
>>> lru->node[0].memcg_lrus to determine if the list is memcg aware.
>>>
>>
>> Yes, node 0 is always there. So it should not be a problem.
>
> I think it should be mentioned in the comment to list_lru_memcg_aware
> then.
>

Something like this: ?
static inline bool list_lru_memcg_aware(struct list_lru *lru)
{
         /*
          * This needs node 0 to be always present, even
          * in the systems supporting sparse numa ids.
          */
         return !!lru->node[0].memcg_lrus;
}

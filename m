Return-Path: <lizf@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
	by ozlabs.org (Postfix) with ESMTP id DCB38DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 16:08:27 +1100 (EST)
Message-ID: <4758D49A.8090908@cn.fujitsu.com>
Date: Fri, 07 Dec 2007 13:05:30 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 1/3] POWERPC: don't cast a pointer to pointer of list_head
References: <4757C1DA.6060603@cn.fujitsu.com>
	<200712071507.10161.nickpiggin@yahoo.com.au>
In-Reply-To: <200712071507.10161.nickpiggin@yahoo.com.au>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Piggin 写道:
> On Thursday 06 December 2007 20:33, Li Zefan wrote:
>> The casting is safe only when the list_head member is the
>> first member of the structure.
> 
> Even so, I don't think too safe :) It might technically work,
> but it could break more easily.
> 
> So even if you find places where list_head is the first member of
> a structure, it would be nice to explicitly use the list_head member
> and avoid casts IMO.
> 

This is exactly what I think. Those patches actually fix no bugs, but
avoid this kind of technically and currently correct casting.

> 
>> Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
>>
>> ---
>>  arch/ppc/syslib/ocp.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/ppc/syslib/ocp.c b/arch/ppc/syslib/ocp.c
>> index 3f5be2c..d42d408 100644
>> --- a/arch/ppc/syslib/ocp.c
>> +++ b/arch/ppc/syslib/ocp.c
>> @@ -376,7 +376,7 @@ ocp_remove_one_device(unsigned int vendor, unsigned int
>> function, int index)
>>
>>  	down_write(&ocp_devices_sem);
>>  	dev = __ocp_find_device(vendor, function, index);
>> -	list_del((struct list_head *)dev);
>> +	list_del(&dev->link);
>>  	up_write(&ocp_devices_sem);
>>
>>  	DBG(("ocp: ocp_remove_one_device(vendor: %x, function: %x, index: %d)...
>> done.\n", vendor, function, index));
> 
> 

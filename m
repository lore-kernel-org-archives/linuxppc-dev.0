Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A74D9B6F59
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 11:42:11 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 29 Jun 2012 07:12:06 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5T1fXv310420582
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 07:11:33 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5T7BK2I002243
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 17:11:20 +1000
Message-ID: <4FED07CD.6000203@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2012 09:41:33 +0800
From: Zhong Li <zhong@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH powerpc 2/2] kfree the cache name  of pgtable cache if
 SLUB is used
References: <1340617984.13778.37.camel@ThinkPad-T420>
 <1340618099.13778.39.camel@ThinkPad-T420> <1340930720.2563.5.camel@pasglop>
In-Reply-To: <1340930720.2563.5.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Christoph Lameter <cl@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Matt Mackall <mpm@selenic.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2012 08:45 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2012-06-25 at 17:54 +0800, Li Zhong wrote:
> 
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index 620b7ac..c9d2a7f 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -130,6 +130,9 @@ void pgtable_cache_add(unsigned shift, void
>> (*ctor)(void *))
>>  	align = max_t(unsigned long, align, minalign);
>>  	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
>>  	new = kmem_cache_create(name, table_size, align, 0, ctor);
>> +#ifdef CONFIG_SLUB
>> +	kfree(name); /* SLUB duplicates the cache name */
>> +#endif
>>  	PGT_CACHE(shift) = new;
>>  
>>  	pr_debug("Allocated pgtable cache for order %d\n", shift);
> 
> This is very gross ... and fragile. Also the subtle difference in
> semantics between SLUB and SLAB is a VERY BAD IDEA.

I agree.

> I reckon you should make the other allocators all copy the name
> instead.

Thank you for the suggestion. I will do it in the next version.

Thanks, Zhong

> Ben.
> 
> 

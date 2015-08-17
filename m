Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4702A1A0372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 20:51:41 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Aug 2015 20:51:39 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 71F813578057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 20:51:36 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7HApSwD58327244
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 20:51:36 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7HAp3AW014953
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 20:51:04 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V1 0/8] KASAN ppc64 support
In-Reply-To: <1439805684.2416.16.camel@kernel.crashing.org>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439794492.2416.8.camel@kernel.crashing.org>
 <87mvxqp7l5.fsf@linux.vnet.ibm.com>
 <1439805684.2416.16.camel@kernel.crashing.org>
Date: Mon, 17 Aug 2015 16:20:36 +0530
Message-ID: <87io8ep4sj.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2015-08-17 at 15:20 +0530, Aneesh Kumar K.V wrote:
>
>> For kernel linear mapping, our address space looks like
>> 0xc000000000000000 - 0xc0003fffffffffff  (64TB)
>> 
>> We can't have virtual address(effective address) above that range
>> in 0xc region. Hence in-order to shadow the linear mapping, I am 
>> using region 0xe. ie, the shadow mapping now looks liwe
>> 
>> 0xc000000000000000 -> 0xe000000000000000 
>
> Why ? IE. Why can't you put the shadow at address +64T and have it work
> for everything ?
> .../...

Above +64TB ? How will that work ? We have check in different parts of
code like below, where we check each region's top address is within 64TB range. 

PGTABLE_RANGE and (ESID_BITS + SID_SHIFT) and all dependendent on 64TB
range. (46 bits).


static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
				     int ssize)
{
	/*
	 * Bad address. We return VSID 0 for that
	 */
	if ((ea & ~REGION_MASK) >= PGTABLE_RANGE)
		return 0;

	if (ssize == MMU_SEGSIZE_256M)
		return vsid_scramble((context << ESID_BITS)
				     | (ea >> SID_SHIFT), 256M);
	return vsid_scramble((context << ESID_BITS_1T)
			     | (ea >> SID_SHIFT_1T), 1T);
}



>> Another reason why inline instrumentation is difficult is that for
>> inline instrumentation to work, we need to create a mapping for 
>> _possible_
>> virtual address space before kasan is fully initialized. ie, we need
>> to create page table entries for the shadow of the entire 64TB range,
>> with zero page, even though we have lesser ram. We definitely can't 
>> bolt those entries. I am yet to get the shadow for kernel linear 
>> mapping to work without bolting. Also we will have to get the page 
>> table allocated for that, because we can't share page table entries. 
>> Our fault path use pte entries for storing hash slot index.
>
> Hrm, that means we might want to start considering a page table to
> cover the linear mapping...

But that would require us to get a large zero page ? Are you suggesting
to use 16G page ? 


>
>> If we are ok to steal part of that 64TB range, for kasan mapping , ie
>> we make shadow of each region part of the same region, may be we can
>> get inline instrumentation to work. But that still doesn't solve the
>> page table allocation overhead issue mentioned above.
>> 

-aneesh

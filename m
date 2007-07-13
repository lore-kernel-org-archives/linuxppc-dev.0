Return-Path: <htejun@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id F23AEDDD07
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 13:47:00 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so724031pyi
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 20:46:59 -0700 (PDT)
Message-ID: <4696F5AD.1050306@gmail.com>
Date: Fri, 13 Jul 2007 12:46:53 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fix idr_get_new_above id alias bugs
References: <200707021919.27251.hnguyen@linux.vnet.ibm.com>	<1183422700.3130.27.camel@localhost.localdomain>	<200707041611.30056.hnguyen@linux.vnet.ibm.com>	<1184097931.3020.73.camel@localhost.localdomain>
	<20070712143501.2c2cdf1f.akpm@linux-foundation.org>
In-Reply-To: <20070712143501.2c2cdf1f.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kristian Hoegsberg <krh@redhat.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>, jim.houston@ccur.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Andrew Morton wrote:
>> Hoang-Nam Nguyen reported a bug in idr_get_new_above() 
>> which occurred with a starting id value like 0x3ffffffc.
>> His test module easily reproduced the problem.  Thanks.
>>
>> The test revealed the following bugs:
>>
>> 1. Relying on shift operations which have undefined results
>>    e.g.: 1 << n where n > word size.  On i386 an integer shift
>>    only uses the low 5 bits of the shift count.
>>
>> 2. An off by one error which prevented the top most layer
>>    of the radix tree from being allocated.  This meant that
>>    sub_alloc() would allocate an entry in the existing portion
>>    of the radix tree which aliased the requested address.  When
>>    it tried to allocate id 0x40000000, it might use the slot 
>>    belonging to id 0.
>>
>> 3. There was also a failure in the code which walked back up
>>    the tree if an allocation failed.  The normal case is to
>>    descend the tree checking the starting id value against the
>>    bitmap at each level.  If the bit is set, we know that the
>>    entire sub-tree is full and we can short cut the search.
>>    We may still descend to the lowest level and find that the
>>    portion of the id space we want is full.  In this case we
>>    need to walk back up the tree and continue the search.
>>    The existing code just returned to the previous level and
>>    continued.  This resulted in an attempt to allocate an id
>>    above 0x3ffffffc using the slot for id 0x3ffffc00 instead of
>>    0x40000000 which it then claimed to have allocated.  The same
>>    problem occurs with 0x3ff as the requested id value if it
>>    is already in use.

The third one sounds like the bug I fixed.  With it fixed, I verified
idr works correctly at least in the lower range of allocation by running
it parallelly with simple bitmap allocator but haven't tested higher
range like 0x3ffffffc.

-- 
tejun

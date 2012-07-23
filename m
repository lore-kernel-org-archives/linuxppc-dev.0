Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 746D02C0340
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 17:29:26 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Jul 2012 17:29:11 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6N7TJTL58458144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 17:29:19 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6N7TI5d024908
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 17:29:18 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V3 08/11] arch/powerpc: Make some of the PGTABLE_RANGE
 dependency explicit
In-Reply-To: <20120723002019.GJ17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120723002019.GJ17790@bloggs.ozlabs.ibm.com>
Date: Mon, 23 Jul 2012 12:59:15 +0530
Message-ID: <87629fhr5g.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Jul 09, 2012 at 06:43:38PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> slice array size and slice mask size depend on PGTABLE_RANGE. We
>> can't directly include pgtable.h in these header because there is
>> a circular dependency. So add compile time check for these values.
>
> Some comments below...
>
>>  struct slice_mask {
>>  	u16 low_slices;
>>  	/*
>> -	 * This should be derived out of PGTABLE_RANGE. For the current
>> -	 * max 64TB, u64 should be ok.
>> +	 * We do this as a union so that we can verify
>> +	 * SLICE_MASK_SIZE against PGTABLE_RANGE
>>  	 */
>> -	u64 high_slices;
>> +	union {
>> +		u64 high_slices;
>> +		unsigned char not_used[SLICE_MASK_SIZE];
>> +	};
>
> Seems ugly to have to have a union just for that.  Can't we do
> something like BUILD_BUG_ON(sizeof(u64) < SLICE_MASK_SIZE) instead?

Dropped the union from the patch

>
>> @@ -73,7 +73,7 @@ static struct slice_mask slice_range_to_mask(unsigned long start,
>>  					     unsigned long len)
>>  {
>>  	unsigned long end = start + len - 1;
>> -	struct slice_mask ret = { 0, 0 };
>> +	struct slice_mask ret = { 0, {0} };
>
> Wouldn't { 0 } suffice?  Similarly in several places below.

Once i drop the union all these changes can be dropped.

-aneesh

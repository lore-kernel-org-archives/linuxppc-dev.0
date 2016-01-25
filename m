Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDDA41A001D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 22:11:03 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A1546140321
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2016 22:11:02 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 25 Jan 2016 21:11:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 59D232CE8054
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2016 22:10:57 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0PBAd8X35520560
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2016 22:10:47 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0PBAOVU015452
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2016 22:10:24 +1100
Message-ID: <56A6028F.4010504@linux.vnet.ibm.com>
Date: Mon, 25 Jan 2016 16:40:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH V2] selfttest/powerpc: Add memory page migration tests
References: <1448344702-14033-1-git-send-email-khandual@linux.vnet.ibm.com>
 <CAOJe8K2L5JKzQpt2tV6Z_72NatKBfvH3b1J2Orm+NM6NK23snA@mail.gmail.com>
In-Reply-To: <CAOJe8K2L5JKzQpt2tV6Z_72NatKBfvH3b1J2Orm+NM6NK23snA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/24/2015 01:42 PM, Denis Kirjanov wrote:
> On 11/24/15, Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
>> This adds two tests for memory page migration. One for normal page
>> migration which works for both 4K or 64K base page size kernel and
>> the other one is for 16MB huge page migration which will work both
>> 4K or 64K base page sized 16MB huge pages as and when we support
>> huge page migration.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>


>> +
>> +static unsigned long get_npages(unsigned long length, unsigned long size)
>> +{
>> +	unsigned int tmp1 = length, tmp2 = size;
> I think we want unsigned long here but this is very minor nit

Its been some time now, remember using some tricks to get the
division right. Now that Aneesh's new PTE changes are merged,
will try the Hugetlb migration again and enable the self tests
for them.

>> +
>> +int test_migration(unsigned long length)
>> +{
>> +	unsigned long failed;
>> +	void *addr;
>> +	int ret;
>> +
>> +	addr = mmap(MMAP_ADDR, length, MMAP_PROT, MMAP_FLAGS, -1, 0);
>> +	if (addr == MAP_FAILED) {
>> +		perror("mmap() failed");
>> +		exit(-1);
>> +	}
>> +
>> +	write_buffer(addr, length);
>> +	soft_offline_pages(HPAGE_OFF, addr, length/getpagesize(), &failed);
> You've defined get_npages() so I assume it has to be used or not used at all

>> +	npages = get_npages(length, PAGE_SIZE_HUGE);

Its used here.

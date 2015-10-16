Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF8FA1A0676
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 22:40:55 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 780991402D5
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 22:40:55 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 16 Oct 2015 21:40:54 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6B2902BB004D
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 22:40:51 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9GBegIP17105116
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 22:40:51 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9GBeIj8019230
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 22:40:18 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] selfttest/powerpc: Add memory page migration tests
In-Reply-To: <5620D2E2.7090401@linux.vnet.ibm.com>
References: <1444923967-22899-1-git-send-email-khandual@linux.vnet.ibm.com>
 <5620D2E2.7090401@linux.vnet.ibm.com>
Date: Fri, 16 Oct 2015 17:09:51 +0530
Message-ID: <87pp0fhwjc.fsf@linux.vnet.ibm.com>
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

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> On 10/15/2015 09:16 PM, Anshuman Khandual wrote:
>> This adds two tests for memory page migration. One for normal page
>> migration which works for both 4K or 64K base page size kernel and
>> the other one is for 16MB huge page migration which will work both
>> 4K or 64K base page sized 16MB huge pages as and when we support
>> huge page migration.
>> 
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>> - Works for normal page migration on both 64K and 4K base pages
>> - Works for 16MB huge page migration (64K) on Aneesh's V2 PTE changes
>> 
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
>
> Will add a mlock() call here as well. Some times soft offline
> fails while trying to move a huge chunk of memory on a system
> because of swapping. With a mlock() in there the problem gets
> resolved.

Is that with respect to hugetlb pages ? I doubt, because hugetlb pages
are not swapped out.

-aneesh

Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FCAB1A0748
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 14:06:59 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 706181401DA
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2015 14:06:59 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 20 Oct 2015 13:06:58 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B55483578055
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2015 14:06:54 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9K36jf924445122
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2015 14:06:54 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9K36L4l000970
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2015 14:06:21 +1100
Message-ID: <5625AF9B.6080606@linux.vnet.ibm.com>
Date: Tue, 20 Oct 2015 08:36:03 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] selfttest/powerpc: Add memory page migration tests
References: <1444923967-22899-1-git-send-email-khandual@linux.vnet.ibm.com>
 <5620D2E2.7090401@linux.vnet.ibm.com> <87pp0fhwjc.fsf@linux.vnet.ibm.com>
In-Reply-To: <87pp0fhwjc.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/16/2015 05:09 PM, Aneesh Kumar K.V wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> On 10/15/2015 09:16 PM, Anshuman Khandual wrote:
>>> This adds two tests for memory page migration. One for normal page
>>> migration which works for both 4K or 64K base page size kernel and
>>> the other one is for 16MB huge page migration which will work both
>>> 4K or 64K base page sized 16MB huge pages as and when we support
>>> huge page migration.
>>>
>>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>> ---
>>> - Works for normal page migration on both 64K and 4K base pages
>>> - Works for 16MB huge page migration (64K) on Aneesh's V2 PTE changes
>>>
>>> +
>>> +int test_migration(unsigned long length)
>>> +{
>>> +	unsigned long failed;
>>> +	void *addr;
>>> +	int ret;
>>> +
>>> +	addr = mmap(MMAP_ADDR, length, MMAP_PROT, MMAP_FLAGS, -1, 0);
>>> +	if (addr == MAP_FAILED) {
>>> +		perror("mmap() failed");
>>> +		exit(-1);
>>> +	}
>>
>> Will add a mlock() call here as well. Some times soft offline
>> fails while trying to move a huge chunk of memory on a system
>> because of swapping. With a mlock() in there the problem gets
>> resolved.
> 
> Is that with respect to hugetlb pages ? I doubt, because hugetlb pages
> are not swapped out.

Thats correct. It is related to normal pages (4K or 64K). Have not
seen this swap problem of HugeTLB pages.

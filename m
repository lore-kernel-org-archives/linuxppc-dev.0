Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C290606A334
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D28Dshub
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXZgP4h8Cz2xjN;
	Mon, 23 Nov 2026 03:45:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795365905;
	cv=none; b=MTe1ctEjvjoS4vAqtfHzoxTgi4TUOFqDu6cpgT768JzqUhu2eHmpZljOOAGdR/AJffPH02nU+tvT0zVgElh1+lh5iDjl+QgdJfH0eeO8+tn95rsDTBSwsLWSf7F7GkSXWrTcK219cBw43VE3aQ+ycDLyodlP9dIaaftn15APwfMi3Gq7IrePHBbweyUfCRfDH+km/XOhkNUQQmJZa9e8t8MnJMssTfsftVd1EGP8TkOtb3XfLKQ+3OP8JSKE5KF9/i4IUsnDChqpkgNIG3UPjh3zQIcGXHDXXoxJmR3wGs8eAwatFRc88zLejjc98j70tWO3Rzo6WwR/SLupnJrWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795365905; c=relaxed/relaxed;
	bh=KaWb+s8zeKhF6AnCeqIf7E7Vx2X7tWNhfZmMdCpaUGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIh8iebC3dHZVC068pwXH06DZcRXvRNrjxaM3SohDTtzDpxF6kjKOQWZCtTWlklnFjc93fHFvp9+opB34UGy3mmWGNYalhroXRK6A5H/ArxWXrLmxbFrvJ3zx0UyEQMSMX8Hl0sKGAl3kOmadyE9OvpGBKiRWOlpAlxNplVCBBOzZa8iDr+Qk7qUDQJyimEoDX0VifkgI9xziLLSxTynQLKKBWelvj6cF5mWPgJ7YAk3OUQIziR0JOHOLTN220XpfcUyDuNPdiOV+vcngZIg8YFk16KgpCtKXMT8MVjXoHcXZhs5KVftsDcIpVrifvISjXJ4z6ad9a7b7Q8hp72k+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D28Dshub; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D28Dshub;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXZgN5rWsz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 03:45:04 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2E008429CA;
	Sun, 22 Nov 2026 16:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31261F000C0;
	Sun, 22 Nov 2026 16:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795365902;
	bh=KaWb+s8zeKhF6AnCeqIf7E7Vx2X7tWNhfZmMdCpaUGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D28DshubZKDMkBzwpviztYrerD4E6ol3oEYrrdiVPaZa2+dpN2bHePhFa523xOEjS
	 P1SGChtJYjqqQGZD2zkdtpgdYRa0/HNZ2kH6GTQebbVKLsSAL0gg+JYqxLlmytiYS5
	 Ex+Q/i3balIADfHYMBT/5LHmS2G1PdFaQdI+lP6MdSDtTM8POMdy2nVFhfHqkjTzFt
	 VAqP7rZnD0U6kEi2PEGaayOVN50eRaORis8lozJH94u8IIhs5NPEt6fZScZ2PH3LQa
	 midpnrtMUVqUYfFER4rDCmJOVOxGcX3/jgg/5wwPmZ83fxuv0vniu2uXZmIF5M/xmU
	 af6CVbJu8vTXQ==
Message-ID: <cb535634-2d87-451f-be28-ba975281dde8@kernel.org>
Date: Sun, 22 Nov 2026 17:44:54 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] selftests/mm: test fork of PMD-mapped shmem THPs
To: Andrew Morton <akpm@linux-foundation.org>,
 Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org, =?UTF-8?Q?Lo=C3=AFc_Molinari?=
 <loic.molinari@collabora.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Yeoreum Yun <yeoreum.yun@arm.com>
References: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
 <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-4-efa7817a2bb3@virtuozzo.com>
 <20261119103210.24a7612ee26c3ffc3db49451@linux-foundation.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20261119103210.24a7612ee26c3ffc3db49451@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 19:32, Andrew Morton wrote:
> On Thu, 19 Nov 2026 14:44:05 +0100 Konstantin Khorenko <khorenko@virtuozzo.com> wrote:
> 
>> Fork a process that maps shmem THPs with PMDs, in a VMA whose page
>> tables fork copies: a private mapping with an anon_vma, and a shared
>> one with a guard region. The child must find the PMDs before it
>> touches the mapping, and its exit must leave the parent's mapping and
>> the system-wide ShmemPmdMapped counter as they were.
>>
>> With folio_dup_file_rmap_pmd() adding PTE mappings, the child's exit
>> takes the parent's share off ShmemPmdMapped while the parent still maps
>> the folios. Unmapping them drops it once more, so every mapping stays
>> until exit, where the kernel reports "Bad page cache", or hits a
>> VM_BUG_ON with CONFIG_DEBUG_VM. A kernel that leaves file THPs to a
>> refault in the child skips the test.
>>
>> ShmemPmdMapped is system-wide, and reclaim or NUMA balancing can take a
>> PMD from the parent while the test runs. So the test makes up to three
>> attempts, each on a fresh file, and fails only if all of them see the
>> counter drop by exactly the parent's share: the bug does that on every
>> fork, other processes only by chance. It passes on the first clean
>> attempt and skips when none is clean.
>>
>> The test mounts a tmpfs with huge=always over /tmp in a private mount
>> namespace, so it leaves the THP settings and the host's mounts and
>> files alone.
>>
>> ...
>>
>> +static void test_fork(bool shared)
>> +{
>> +	const char *desc = shared ? "shared mapping with a guard region" :
>> +				    "private mapping with an anon_vma";
>> +	long before = 0, after = 0;
>> +	enum result res = NO_THP;
>> +	int i, drops = 0;
>> +	char *mem;
>> +
>> +	for (i = 0; i < ATTEMPTS; i++) {
>> +		mem = map_file(shared);
>> +		/* Make fork copy the page tables; the last PMD gets zapped. */
>> +		if (shared) {
>> +			if (madvise(mem + size - pagesize, pagesize,
>> +				    MADV_GUARD_INSTALL)) {
>> +				ksft_test_result_skip("%s: MADV_GUARD_INSTALL: %s\n",
>> +						      desc, strerror(errno));
>> +				return;
>> +			}
>> +		} else {
>> +			mem[size - pagesize] = 'p';
>> +		}
>> +
>> +		res = pmds_ok(mem) ? fork_once(mem, shared, &before, &after) :
>> +				     res == NO_THP ? NO_THP : LOST_PMDS;
>> +		/* Later children get only their own mapping. */
>> +		madvise(mem, size, MADV_DONTFORK);
> 
> autobot want the return value checked:
> 
> : If this fails, the next child inherits an earlier test mapping too. 
> : Its exit can then change ShmemPmdMapped by more than the expected
> : amount, causing the test to skip a real failure.
> 
> which seems ignorable - MADV_DONTFORK failures are super unlikely at present.
> 
>>
>> ...
>>
>> +int main(void)
>> +{
>> +	ksft_print_header();
>> +	pagesize = getpagesize();
>> +	pmdsize = read_pmd_pagesize();
> 
> This is going to ruin Mark's day again, thanks to "kselftest: mm:
> rename read_pmd_pagesize() to pmd_psize()".
> 
> I think I'll alter Yeoreum's above patch like this (presently untested):
> 
> --- a/tools/testing/selftests/mm/vm_util.h~kselftest-mm-rename-read_pmd_pagesize-to-pmd_psize-fix
> +++ a/tools/testing/selftests/mm/vm_util.h
> @@ -93,6 +93,8 @@ unsigned long pagemap_get_pfn(int fd, ch
>  void clear_softdirty(void);
>  bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len);
>  uint64_t pmd_psize(void);
> +/* temporary cross-tree compatibility thing: */
> +#define read_pmd_pagesize() pmd_psize()

Thanks! Otherwise we could route selftest through a single tree.

They would fail on the tree until the fix is in ... but that's rpecisely what
selftests are for.

-- 
Cheers,

David


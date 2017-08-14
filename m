Return-Path: <victora@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWVD309StzDr02
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 08:10:26 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7EM8u4w019133
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 18:10:24 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cbfp04shu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 18:10:24 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <victora@linux.vnet.ibm.com>;
 Mon, 14 Aug 2017 16:10:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 14 Aug 2017 19:12:28 -0300
From: Victor Aoqui <victora@linux.vnet.ibm.com>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, victora@br.ibm.com,
 mauricfo@linux.vnet.ibm.com
Subject: Re: [PATCH v3] powerpc/mm: Implemented default_hugepagesz
 verification for powerpc
In-Reply-To: <797c6885-06ec-4c5a-ecbe-82f259ab0343@oracle.com>
References: <20170724235202.5675-1-victora@linux.vnet.ibm.com>
 <797c6885-06ec-4c5a-ecbe-82f259ab0343@oracle.com>
Message-Id: <e112f549b448653e6c614eea8f9bea68@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em 2017-08-04 15:17, Mike Kravetz escreveu:
> On 07/24/2017 04:52 PM, Victor Aoqui wrote:
>> Implemented default hugepage size verification (default_hugepagesz=)
>> in order to allow allocation of defined number of pages (hugepages=)
>> only for supported hugepage sizes.
>> 
>> Signed-off-by: Victor Aoqui <victora@linux.vnet.ibm.com>
>> ---
>> v2:
>> 
>> - Renamed default_hugepage_setup_sz function to 
>> hugetlb_default_size_setup;
>> - Added powerpc string to error message.
>> 
>> v3:
>> 
>> - Renamed hugetlb_default_size_setup() to hugepage_default_setup_sz();
>> - Implemented hugetlb_bad_default_size();
>> - Reimplemented hugepage_setup_sz() to just parse default_hugepagesz= 
>> and
>> check if it's a supported size;
>> - Added verification of default_hugepagesz= value on 
>> hugetlb_nrpages_setup()
>> before allocating hugepages.
>> 
>>  arch/powerpc/mm/hugetlbpage.c | 15 +++++++++++++++
>>  include/linux/hugetlb.h       |  1 +
>>  mm/hugetlb.c                  | 17 +++++++++++++++--
>>  3 files changed, 31 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/mm/hugetlbpage.c 
>> b/arch/powerpc/mm/hugetlbpage.c
>> index e1bf5ca..5990381 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -780,6 +780,21 @@ static int __init hugepage_setup_sz(char *str)
>>  }
>>  __setup("hugepagesz=", hugepage_setup_sz);
>> 
>> +static int __init hugepage_default_setup_sz(char *str)
>> +{
>> +	unsigned long long size;
>> +
>> +	size = memparse(str, &str);
>> +
>> +	if (add_huge_page_size(size) != 0) {
>> +		hugetlb_bad_default_size();
>> +		pr_err("Invalid ppc default huge page size specified(%llu)\n", 
>> size);
>> +	}
>> +
>> +	return 1;
>> +}
>> +__setup("default_hugepagesz=", hugepage_default_setup_sz);
>> +
>>  struct kmem_cache *hugepte_cache;
>>  static int __init hugetlbpage_init(void)
>>  {
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 0ed8e41..2927200 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -361,6 +361,7 @@ int huge_add_to_page_cache(struct page *page, 
>> struct address_space *mapping,
>>  int __init alloc_bootmem_huge_page(struct hstate *h);
>> 
>>  void __init hugetlb_bad_size(void);
>> +void __init hugetlb_bad_default_size(void);
>>  void __init hugetlb_add_hstate(unsigned order);
>>  struct hstate *size_to_hstate(unsigned long size);
>> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index bc48ee7..3c24266 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -54,6 +54,7 @@
>>  static unsigned long __initdata default_hstate_max_huge_pages;
>>  static unsigned long __initdata default_hstate_size;
>>  static bool __initdata parsed_valid_hugepagesz = true;
>> +static bool __initdata parsed_valid_default_hugepagesz = true;
>> 
>>  /*
>>   * Protects updates to hugepage_freelists, hugepage_activelist, 
>> nr_huge_pages,
>> @@ -2804,6 +2805,12 @@ void __init hugetlb_bad_size(void)
>>  	parsed_valid_hugepagesz = false;
>>  }
>> 
>> +/* Should be called on processing a default_hugepagesz=... option */
>> +void __init hugetlb_bad_default_size(void)
>> +{
>> +	parsed_valid_default_hugepagesz = false;
>> +}
>> +
>>  void __init hugetlb_add_hstate(unsigned int order)
>>  {
>>  	struct hstate *h;
>> @@ -2846,8 +2853,14 @@ static int __init hugetlb_nrpages_setup(char 
>> *s)
>>  	 * !hugetlb_max_hstate means we haven't parsed a hugepagesz= 
>> parameter yet,
>>  	 * so this hugepages= parameter goes to the "default hstate".
>>  	 */
>> -	else if (!hugetlb_max_hstate)
>> -		mhp = &default_hstate_max_huge_pages;
>> +	else if (!hugetlb_max_hstate) {
>> +		if (!parsed_valid_default_hugepagesz) {
>> +			pr_warn("hugepages = %s cannot be allocated for "
>> +				"unsupported default_hugepagesz, ignoring\n", s);
>> +			parsed_valid_default_hugepagesz = true;
>> +		} else
>> +			mhp = &default_hstate_max_huge_pages;
>> +	}
>>  	else
>>  		mhp = &parsed_hstate->max_huge_pages;
>> 
>> 
> 
> My compiler tells me,
> 
> mm/hugetlb.c: In function ‘hugetlb_nrpages_setup’:
> mm/hugetlb.c:2873:8: warning: ‘mhp’ may be used uninitialized in
> this function [-Wmaybe-uninitialized]
> 
> You have added a way of getting out of that big if/else if statement 
> without
> setting mhp.  mhp will be examined later in the code, so this is indeed 
> a bug.
> 
> Like Aneesh, I am not sure if there is great benefit in this patch.
> 
> You added this change in functionality only for powerpc.  IMO, it would 
> be
> best if behavior was consistent in all architectures.  So, if we change 
> it
> for powerpc we may want to change everywhere.

Hi Mike,

Yes, the patch mentioned by Aneesh solves the issue.

Thanks

-- 
Victor Aoqui

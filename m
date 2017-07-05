Return-Path: <victora@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2m5w0SdkzDqhp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 02:09:23 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v65G8sEN094136
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 12:09:21 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bh3a6g82e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 12:09:21 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <victora@linux.vnet.ibm.com>;
 Wed, 5 Jul 2017 12:09:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 05 Jul 2017 13:09:42 -0300
From: victora <victora@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Victor Aoqui <victora@br.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com,
 mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc/mm: Implemented default_hugepagesz verification
 for powerpc
In-Reply-To: <4d5950e6-d208-b8d1-ffee-6e54c741c8e0@linux.vnet.ibm.com>
References: <20170703200559.3743-1-victora@br.ibm.com>
 <4d5950e6-d208-b8d1-ffee-6e54c741c8e0@linux.vnet.ibm.com>
Message-Id: <2e7aa4b69ac391fdaed7275551a511ff@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em 2017-07-05 01:31, Anshuman Khandual escreveu:
> On 07/04/2017 01:35 AM, Victor Aoqui wrote:
>> Implemented default hugepage size verification (default_hugepagesz=)
>> in order to allow allocation of defined number of pages (hugepages=)
>> only for supported hugepage sizes.
>> 
>> Signed-off-by: Victor Aoqui <victora@br.ibm.com>
>> ---
>>  arch/powerpc/mm/hugetlbpage.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> 
>> diff --git a/arch/powerpc/mm/hugetlbpage.c 
>> b/arch/powerpc/mm/hugetlbpage.c
>> index a4f33de..464e72e 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -797,6 +797,21 @@ static int __init hugepage_setup_sz(char *str)
>>  }
>>  __setup("hugepagesz=", hugepage_setup_sz);
>> 
>> +static int __init default_hugepage_setup_sz(char *str)
> 
> The function name should be hugetlb_default_size_setup in
> sync with the generic function hugetlb_default_setup for the
> same parameter default_hugepagesz.
> 

Yes, makes sense to me.

>> +{
>> +        unsigned long long size;
>> +
>> +        size = memparse(str, &str);
>> +
>> +        if (add_huge_page_size(size) != 0) {
> 
> I am little bit confused here. Do we always follow another
> 'hugepages=' element after 'default_hugepagesz' ? If not,
> then we dont have to do 'add_huge_page_size'. But then
> that function checks for valid huge page sizes and skips
> adding hstate if its already added. So I guess it okay.
> 

'default_hugepagesz=' is not always followed by 'hugepages=', but if we 
specify 'hugepages=' along with 'default_hugepagesz=' it will try to 
allocate the hugepage size specified. If the size is not supported by 
hardware, it will try to allocate the number of pages specified with the 
default hugepage size of the arch, which is not the desired behavior. So 
calling add_huge_page_size would verify if the hugepage size is 
supported and in case it's not, hugepages will not be allocated.

>> +                hugetlb_bad_size();
>> +                pr_err("Invalid default huge page size 
>> specified(%llu)\n", size);
> 
> Error message should have 'ppc' some where to indicate that
> the arch rejected the size not core MM.

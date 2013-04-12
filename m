Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF8812C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 15:05:27 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 12 Apr 2013 10:30:53 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 30E2FE0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 10:37:12 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3C55Fje30146608
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 10:35:17 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3C55HWE025792
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 15:05:18 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH -V5 21/25] powerpc: Handle hugepage in perf callchain
In-Reply-To: <20130412013449.GD5065@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-22-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130412013449.GD5065@truffula.fritz.box>
Date: Fri, 12 Apr 2013 10:35:16 +0530
Message-ID: <878v4omj8z.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <dwg@au1.ibm.com> writes:

> On Thu, Apr 04, 2013 at 11:27:59AM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/perf/callchain.c |   32 +++++++++++++++++++++-----------
>>  1 file changed, 21 insertions(+), 11 deletions(-)
>> 
>> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
>> index 578cac7..99262ce 100644
>> --- a/arch/powerpc/perf/callchain.c
>> +++ b/arch/powerpc/perf/callchain.c
>> @@ -115,7 +115,7 @@ static int read_user_stack_slow(void __user *ptr, void *ret, int nb)
>>  {
>>  	pgd_t *pgdir;
>>  	pte_t *ptep, pte;
>> -	unsigned shift;
>> +	unsigned shift, hugepage;
>>  	unsigned long addr = (unsigned long) ptr;
>>  	unsigned long offset;
>>  	unsigned long pfn;
>> @@ -125,20 +125,30 @@ static int read_user_stack_slow(void __user *ptr, void *ret, int nb)
>>  	if (!pgdir)
>>  		return -EFAULT;
>>  
>> -	ptep = find_linux_pte_or_hugepte(pgdir, addr, &shift, NULL);
>> +	ptep = find_linux_pte_or_hugepte(pgdir, addr, &shift, &hugepage);
>
> So, this patch pretty much demonstrates that your earlier patch adding
> the optional hugepage argument and making the existing callers pass
> NULL was broken.
>
> Any code which calls this function and doesn't use and handle the
> hugepage return value is horribly broken, so permitting the hugepage
> parameter to be optional is itself broken.
>
> I think instead you need to have an early patch that replaces
> find_linux_pte_or_hugepte with a new, more abstracted interface, so
> that code using it will remain correct when hugepage PMDs become
> possible.


The entire thing could have been simple if we supported only one
hugepage size (this is what sparc ended up doing). I guess we don't want
to do that. Also we want to support 16MB and 16GB, which mean we need
hugepd for 16GB at PGD level. My goal was to keep the hugetlb related
code for both 16MB and 16GB similar and consider THP huge page in a
different bucket.

Let me look at again how best I can simplify find_linux_pte_or_hugepte

-aneehs

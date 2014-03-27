Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4EB7414008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 17:20:17 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 27 Mar 2014 11:50:12 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4D6B61258059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 11:52:34 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2R6JqWG60883076
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 11:49:52 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2R6K68Z026747
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 11:50:07 +0530
Message-ID: <5333C315.3000405@linux.vnet.ibm.com>
Date: Thu, 27 Mar 2014 11:50:05 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 1/1] mm: move FAULT_AROUND_ORDER to arch/
References: <1395730215-11604-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1395730215-11604-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20140325173605.GA21411@node.dhcp.inet.fi>
In-Reply-To: <20140325173605.GA21411@node.dhcp.inet.fi>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ak@linux.intel.com, paulus@samba.org, mgorman@suse.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 25 March 2014 11:06 PM, Kirill A. Shutemov wrote:
> On Tue, Mar 25, 2014 at 12:20:15PM +0530, Madhavan Srinivasan wrote:
>> Kirill A. Shutemov with the commit 96bacfe542 introduced
>> vm_ops->map_pages() for mapping easy accessible pages around
>> fault address in hope to reduce number of minor page faults.
>> Based on his workload runs, suggested FAULT_AROUND_ORDER
>> (knob to control the numbers of pages to map) is 4.
>>
>> This patch moves the FAULT_AROUND_ORDER macro to arch/ for
>> architecture maintainers to decide on suitable FAULT_AROUND_ORDER
>> value based on performance data for that architecture.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/pgtable.h |    6 ++++++
>>  arch/x86/include/asm/pgtable.h     |    5 +++++
>>  include/asm-generic/pgtable.h      |   10 ++++++++++
>>  mm/memory.c                        |    2 --
>>  4 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
>> index 3ebb188..9fcbd48 100644
>> --- a/arch/powerpc/include/asm/pgtable.h
>> +++ b/arch/powerpc/include/asm/pgtable.h
>> @@ -19,6 +19,12 @@ struct mm_struct;
>>  #endif
>>  
>>  /*
>> + * With a few real world workloads that were run,
>> + * the performance data showed that a value of 3 is more advantageous.
>> + */
>> +#define FAULT_AROUND_ORDER	3
>> +
>> +/*
>>   * We save the slot number & secondary bit in the second half of the
>>   * PTE page. We use the 8 bytes per each pte entry.
>>   */
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index 938ef1d..8387a65 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -7,6 +7,11 @@
>>  #include <asm/pgtable_types.h>
>>  
>>  /*
>> + * Based on Kirill's test results, fault around order is set to 4
>> + */
>> +#define FAULT_AROUND_ORDER 4
>> +
>> +/*
>>   * Macro to mark a page protection value as UC-
>>   */
>>  #define pgprot_noncached(prot)					\
>> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
>> index 1ec08c1..62f7f07 100644
>> --- a/include/asm-generic/pgtable.h
>> +++ b/include/asm-generic/pgtable.h
>> @@ -7,6 +7,16 @@
>>  #include <linux/mm_types.h>
>>  #include <linux/bug.h>
>>  
>> +
>> +/*
>> + * Fault around order is a control knob to decide the fault around pages.
>> + * Default value is set to 0UL (disabled), but the arch can override it as
>> + * desired.
>> + */
>> +#ifndef FAULT_AROUND_ORDER
>> +#define FAULT_AROUND_ORDER	0UL
>> +#endif
> 
> FAULT_AROUND_ORDER == 0 case should be handled separately in
> do_read_fault(): no reason to go to do_fault_around() if we are going to
> fault in only one page.
> 

ok agreed. I am thinking of adding FAULT_AROUND_ORDER check with
map_pages check in the do_read_fault. Kindly share your thoughts.

With regards
Maddy

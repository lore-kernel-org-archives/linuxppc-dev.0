Return-Path: <zhlcindy@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D59081A0615
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 00:52:55 +1100 (AEDT)
Received: by mail-yw0-x242.google.com with SMTP id s188so2955749ywe.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Mar 2016 05:52:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56D94BEE.1080506@suse.cz>
References: <1456988501-29046-1-git-send-email-zhlcindy@gmail.com>
 <1456988501-29046-2-git-send-email-zhlcindy@gmail.com>
 <56D94BEE.1080506@suse.cz>
Date: Fri, 4 Mar 2016 21:52:53 +0800
Message-ID: <CAD8of+rxkV85H5RDyzLZowkxUhJxgVuMt7-hjwP1yxYZCNsqUg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] mm: meminit: initialise more memory for
 inode/dentry hash tables in early boot
From: Li Zhang <zhlcindy@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: mpe@ellerman.id.au, Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 aneesh.kumar@linux.vnet.ibm.com, mgorman@techsingularity.net,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Li Zhang <zhlcindy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 4, 2016 at 4:48 PM, Vlastimil Babka <vbabka@suse.cz> wrote:
> On 03/03/2016 08:01 AM, Li Zhang wrote:
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -293,13 +293,20 @@ static inline bool update_defer_init(pg_data_t *pgdat,
>>                               unsigned long pfn, unsigned long zone_end,
>>                               unsigned long *nr_initialised)
>>  {
>> +     unsigned long max_initialise;
>> +
>>       /* Always populate low zones for address-contrained allocations */
>>       if (zone_end < pgdat_end_pfn(pgdat))
>>               return true;
>> +     /*
>> +     * Initialise at least 2G of a node but also take into account that
>> +     * two large system hashes that can take up 1GB for 0.25TB/node.
>> +     */
>
> The indentation is wrong here.

Thanks for reviewing, I will fix it in next version.

>
>> +     max_initialise = max(2UL << (30 - PAGE_SHIFT),
>> +             (pgdat->node_spanned_pages >> 8));
>>
>> -     /* Initialise at least 2G of the highest zone */
>>       (*nr_initialised)++;
>> -     if (*nr_initialised > (2UL << (30 - PAGE_SHIFT)) &&
>> +     if ((*nr_initialised > max_initialise) &&
>>           (pfn & (PAGES_PER_SECTION - 1)) == 0) {
>>               pgdat->first_deferred_pfn = pfn;
>>               return false;
>>
>



-- 

Best Regards
-Li

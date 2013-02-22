Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8109B2C029D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 16:14:22 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 22 Feb 2013 15:08:17 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D13892BB0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 16:14:12 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1M51oIl34340946
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 16:01:50 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1M5ECmY000746
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 16:14:12 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC PATCH -V2 05/21] powerpc: Reduce PTE table memory wastage
In-Reply-To: <20130222003235.GJ21011@truffula.fritz.box>
References: <1361465248-10867-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1361465248-10867-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130222003235.GJ21011@truffula.fritz.box>
Date: Fri, 22 Feb 2013 10:44:09 +0530
Message-ID: <871uc9vske.fsf@linux.vnet.ibm.com>
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

David Gibson <david@gibson.dropbear.id.au> writes:

> On Thu, Feb 21, 2013 at 10:17:12PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> We now have PTE page consuming only 2K of the 64K page.This is in order to
>> facilitate transparent huge page support, which works much better if our PMDs
>> cover 16MB instead of 256MB.
>> 
>> Inorder to reduce the wastage, we now have multiple PTE page fragment
>> from the same PTE page.
>
> This needs a much better description of what you're doing here to
> manage the allocations.  It's certainly not easy to figure out from
> the code.


I will add more detailed description in the commit message.

We allocate one page for the last level of linux page table. With THP and
large page size of 16MB, that would mean we are be wasting large part
of that page. To map 16MB area, we only need a PTE space of 2K with 64K
Page size. This patch reduce the space wastage by sharing the page
allocated for the last level of linux page table with multiple pmd
entries. We call these smaller chunks PTE page fragments and allocated
page, PTE page. We use the page->_mapcount as bitmap to indicate which
PTE fragments are free.


>
>
> [snip]
>> +#ifdef CONFIG_PPC_64K_PAGES
>> +typedef pte_t *pgtable_t;
>> +#else
>>  typedef struct page *pgtable_t;
>> +#endif
>
> This looks really bogus.  A pgtable_t is a pointer to PTEs on 64K, but
> a pointer to a struct page on 4k.
>

We enable all the above only with 64K Pages. 

-aneesh

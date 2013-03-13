Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FD222C0296
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 20:25:27 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Mar 2013 14:51:52 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2DCDDE004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 14:56:39 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2D9PFO730408754
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 14:55:15 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2D9PHKQ014681
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 09:25:18 GMT
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V2 07/26] powerpc: Add size argument to pgtable_cache_add
In-Reply-To: <20130313024725.GA21125@iris.ozlabs.ibm.com>
References: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1362550227-575-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130313024725.GA21125@iris.ozlabs.ibm.com>
Date: Wed, 13 Mar 2013 14:55:17 +0530
Message-ID: <877glbd536.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Wed, Mar 06, 2013 at 11:40:08AM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> We will use this later with THP changes to request for pmd table of double the size.
>> THP code does PTE page allocation along with large page request and deposit them
>> for later use. This is to ensure that we won't have any failures when we split
>> huge pages to regular pages.
>> 
>> On powerpc we want to use the deposited PTE page for storing hash pte slot and
>> secondary bit information for the HPTEs. Hence we save them in the second half
>> of the pmd table.
>
> That much is fine, but...
>
>> -void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
>> +extern void __pgtable_cache_add(unsigned shift, unsigned long table_size,
>> +				void (*ctor)(void *));
>>  void pgtable_cache_init(void);
>> +static inline void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
>> +{
>> +	return __pgtable_cache_add(shift, sizeof(void *) << shift, ctor);
>> +}
>
> NAK to this (and in fact the rest of this patch).
>
> If you need twice the size, use the next slot along in pgtable_cache,
> which will give you the size you need, rather than breaking the
> relationship between slot index and allocation size.

That would mean we will have to do 

 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PMD_INDEX_SIZE),
+	return kmem_cache_alloc(PGT_CACHE(PMD_INDEX_SIZE + 1),
 				GFP_KERNEL|__GFP_REPEAT);
 }

is that ok ?

-aneesh

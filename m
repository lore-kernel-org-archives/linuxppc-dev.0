Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 61B902C037E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 16:03:33 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 10:29:48 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id A5AB1E004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 10:34:32 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2653Ftl31981656
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 10:33:15 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2653Hcd023806
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 16:03:17 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V1 06/24] powerpc: Reduce PTE table memory wastage
In-Reply-To: <20130305021219.GC2888@iris.ozlabs.ibm.com>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1361865914-13911-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130304045853.GB27523@drongo> <874ngr2zz1.fsf@linux.vnet.ibm.com>
 <20130305021219.GC2888@iris.ozlabs.ibm.com>
Date: Wed, 06 Mar 2013 10:33:16 +0530
Message-ID: <877gll86i3.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Mar 04, 2013 at 04:28:42PM +0530, Aneesh Kumar K.V wrote:
>> The last one that ends up doing atomic_xor_bits which cause the mapcount
>> to go zero, will take the page off the list and free the page. 
>
> No, look at the example again.  page_table_free_rcu() won't take it
> off the list because it uses the (mask & FRAG_MASK) == 0 test, which
> fails (one fragment is still in use).  page_table_free() won't take it
> off the list because it uses the mask == 0 test, which also fails (one
> fragment is still waiting for the RCU grace period).  Finally,
> __page_table_free_rcu() doesn't take it off the list, it just frees
> the page.  Oops. :)


How about the below

--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -425,7 +425,7 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
        bit = 1 << ((__pa(table) & ~PAGE_MASK) / PTE_FRAG_SIZE);
        spin_lock(&mm->page_table_lock);
        mask = atomic_xor_bits(&page->_mapcount, bit);
-       if (mask == 0)
+       if (!(mask & FRAG_MASK))
                list_del(&page->lru);
        else if (mask & FRAG_MASK) {
                /*
@@ -446,7 +446,7 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)


ie, we always remove the page from the list, when the lower half is
zero or lower half is FRAG_MASK.  We free the page when _mapcount is 0.

-aneesh

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 942A91A0048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 18:45:23 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 14:15:19 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id F37A73940053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 14:15:17 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L8jGfi8388938
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 14:15:16 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L8jBv8021282
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 14:15:12 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 18/31] powerpc/mm: Increase the pte frag size.
In-Reply-To: <1442823285.2819.1.camel@kernel.crashing.org>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442823285.2819.1.camel@kernel.crashing.org>
Date: Mon, 21 Sep 2015 14:15:08 +0530
Message-ID: <87mvwgduuj.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2015-09-21 at 12:10 +0530, Aneesh Kumar K.V wrote:
>> /*
>> - * We use a 2K PTE page fragment and another 2K for storing
>> - * real_pte_t hash index
>> + * We use a 2K PTE page fragment and another 4K for storing
>> + * real_pte_t hash index. Rounding the entire thing to 8K
>>   */
>
> Isn't this a LOT of memory wasted ? Page tables have a non-negligible
> footprint, we were already wasting half, now we are wasting 3/4 no ?
>

The actual math is, we used to allocate 16 PTE page from a 64K page
before. We now do 8 pte page from a 64K linux page. 

> Ie, in most cases on modern machines we never use the other "half"...
>

That is true. We will use this only when we use 4K subpage. But I am
not sure there is a better solution. Also, we should find this slightly
imporve our contention on ptl lock. With SPLIT_PTLOCK we now have less
number of pte page using the same spin lock.

-aneesh

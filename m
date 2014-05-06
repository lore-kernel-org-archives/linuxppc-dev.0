Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E92FB1412E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 00:21:03 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 May 2014 00:21:02 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BB2AB3578048
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 00:20:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s46DxoYM43647230
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 23:59:50 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s46EKxd7019451
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 May 2014 00:20:59 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: Don't try to allocate from kernel
 page allocator for hash page table.
In-Reply-To: <53688D89.1070201@suse.de>
References: <1399224322-22028-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <53677558.50900@suse.de> <87r4489ttk.fsf@linux.vnet.ibm.com>
 <20FFDF8F-1A3D-4719-B492-1E4B70F9D1B4@suse.de>
 <1399334797.20388.71.camel@pasglop> <536889C6.1050603@suse.de>
 <1399360775.20388.112.camel@pasglop> <53688D89.1070201@suse.de>
Date: Tue, 06 May 2014 19:50:48 +0530
Message-ID: <87wqdzq98f.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 06.05.14 09:19, Benjamin Herrenschmidt wrote:
>> On Tue, 2014-05-06 at 09:05 +0200, Alexander Graf wrote:
>>> On 06.05.14 02:06, Benjamin Herrenschmidt wrote:
>>>> On Mon, 2014-05-05 at 17:16 +0200, Alexander Graf wrote:
>>>>> Isn't this a greater problem? We should start swapping before we hit
>>>>> the point where non movable kernel allocation fails, no?
>>>> Possibly but the fact remains, this can be avoided by making sure that
>>>> if we create a CMA reserve for KVM, then it uses it rather than using
>>>> the rest of main memory for hash tables.
>>> So why were we preferring non-CMA memory before? Considering that Aneesh
>>> introduced that logic in fa61a4e3 I suppose this was just a mistake?
>> I assume so.

....
...

>>
>> Whatever remains is split between CMA and the normal page allocator.
>>
>> Without Aneesh latest patch, when creating guests, KVM starts allocating
>> it's hash tables from the latter instead of CMA (we never allocate from
>> hugetlb pool afaik, only guest pages do that, not hash tables).
>>
>> So we exhaust the page allocator and get linux into OOM conditions
>> while there's plenty of space in CMA. But the kernel cannot use CMA for
>> it's own allocations, only to back user pages, which we don't care about
>> because our guest pages are covered by our hugetlb reserve :-)
>
> Yes. Write that in the patch description and I'm happy ;).
>

How about the below:

Current KVM code first try to allocate hash page table from the normal
page allocator before falling back to the CMA reserve region. One of the
side effects of that is, we could exhaust the page allocator and get
linux into OOM conditions while we still have plenty of space in CMA. 

Fix this by trying the CMA reserve region first and then falling back
to normal page allocator if we fail to get enough memory from CMA
reserve area.

-aneesh

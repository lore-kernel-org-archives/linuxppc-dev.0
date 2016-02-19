Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CC601A0668
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 13:40:11 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 18 Feb 2016 21:40:09 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9A38A6E8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 21:26:58 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1J2e60i30277816
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 02:40:06 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1J2aREr030807
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 21:36:28 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH V3 01/30] mm: Make vm_get_page_prot arch specific.
In-Reply-To: <20160218231546.GC2765@fergus.ozlabs.ibm.com>
References: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1455814254-10226-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160218231546.GC2765@fergus.ozlabs.ibm.com>
Date: Fri, 19 Feb 2016 08:10:00 +0530
Message-ID: <87egc9e83j.fsf@linux.vnet.ibm.com>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> On Thu, Feb 18, 2016 at 10:20:25PM +0530, Aneesh Kumar K.V wrote:
>> With next generation power processor, we are having a new mmu model
>> [1] that require us to maintain a different linux page table format.
>> 
>> Inorder to support both current and future ppc64 systems with a single
>> kernel we need to make sure kernel can select between different page
>> table format at runtime. With the new MMU (radix MMU) added, we will
>> have to dynamically switch between different protection map. Hence
>> override vm_get_page_prot instead of using arch_vm_get_page_prot. We
>> also drop arch_vm_get_page_prot since only powerpc used it.
>
> This seems like unnecessary churn to me.  Let's just make hash use the
> same values as radix for things like _PAGE_RW, _PAGE_EXEC etc., and
> then we don't need any of this.
>

I was hoping to do that after this series. Something similar to

https://github.com/kvaneesh/linux/commit/0c2ac1328b678a6e187d1f2644a007204c59a047

"
powerpc/mm: Add helper for page flag access in ioremap_at

Instead of using variables we use static inline which get patched during
boot to either hash or radix version.
"

That gives us a base to revert patches if we find issues with hash and
still have a working radix base. So idea is to introduce radix with minimal
changes to hash and then consolidate hash and radix as much as we can by
updating hash linux format.

-aneesh

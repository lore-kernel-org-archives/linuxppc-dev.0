Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80A941A0757
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 13:40:35 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 18 Feb 2016 21:40:33 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 96BAE6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 21:27:23 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1J2eVkM34537624
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 02:40:31 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1J2eUHF014498
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 21:40:31 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH V3 01/30] mm: Make vm_get_page_prot arch specific.
In-Reply-To: <56C66FBB.7000808@intel.com>
References: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1455814254-10226-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56C66FBB.7000808@intel.com>
Date: Fri, 19 Feb 2016 08:10:26 +0530
Message-ID: <87bn7de82t.fsf@linux.vnet.ibm.com>
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

Dave Hansen <dave.hansen@intel.com> writes:

> On 02/18/2016 08:50 AM, Aneesh Kumar K.V wrote:
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
> Hi Aneesh,
>
> I've got some patches I'm hoping to get in to 4.6 that start using
> arch_vm_get_page_prot() on x86:
>
>> http://git.kernel.org/cgit/linux/kernel/git/daveh/x86-pkeys.git/commit/?h=pkeys-v024&id=aa1e61398fb598869981cfe48275cff832945669
>
> So I'd prefer that it stay in place. :)

Ok. I will update the patch to keep that.

-aneesh

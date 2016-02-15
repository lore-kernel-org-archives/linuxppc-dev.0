Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 996F11A004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 15:40:35 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 14 Feb 2016 21:40:33 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E66053E40047
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Feb 2016 21:40:29 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1F4eTWF33685546
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Feb 2016 21:40:29 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1F4eTmO006674
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Feb 2016 21:40:29 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 07/29] mm: Make vm_get_page_prot arch specific.
In-Reply-To: <20160215032124.GB3797@oak.ozlabs.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1454923241-6681-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160215032124.GB3797@oak.ozlabs.ibm.com>
Date: Mon, 15 Feb 2016 10:10:24 +0530
Message-ID: <87io1qfux3.fsf@linux.vnet.ibm.com>
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

> On Mon, Feb 08, 2016 at 02:50:19PM +0530, Aneesh Kumar K.V wrote:
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
> What's different about ISA v3.0 that means that the protection_map[]
> entries need to be different?
>
> If it's just different bit assignments for things like _PAGE_READ
> etc., couldn't we fix this up at early boot time by writing new values
> into protection_map[]?  Is there a reason why that wouldn't work, or
> why you don't want to do that?
>

Yes, that is other way to do this. But I thought it is easier to have
different protection_map array for radix and hash. That made the code
more readable.

-aneesh

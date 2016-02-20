Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6878C1A0914
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 01:40:34 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 20 Feb 2016 07:40:32 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 56C913E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 07:40:30 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1KEeU3626411054
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 07:40:30 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1KEeURb027450
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 07:40:30 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 0/9] powerpc/mm: Restructure Linux PTE on Book3S/64 to
 radix format
In-Reply-To: <1455948760-24710-1-git-send-email-paulus@samba.org>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
Date: Sat, 20 Feb 2016 20:10:26 +0530
Message-ID: <87ziuvcun9.fsf@linux.vnet.ibm.com>
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

Paul Mackerras <paulus@samba.org> writes:

> This patch series modifies the Linux PTE format used on 64-bit Book3S
> processors (i.e. POWER server processors) to make the bits line up
> with the PTE format used in the radix trees defined in PowerISA v3.0.
> This will reduce the amount of further change required to make a
> kernel that can run with either a radix MMU or a hashed page table
> (HPT) MMU.
>
> This also changes the upper levels of the tree to use real addresses
> rather than kernel virtual addresses - that is, we no longer have the
> 0xc000... at the top of each PGD/PUD/PMD entry.  I made this change
> for all 64-bit machines, both embedded and server.
>
> The patch series is against v4.5-rc4 plus Aneesh's "powerpc/mm/hash:
> Clear the invalid slot information correctly" patch.
>
> I have compiled this for all the defconfigs in the tree, without
> error.  I have tested this, with the fixes branch of the powerpc tree
> merged in, both running bare-metal on a POWER8 and in a KVM guest on
> that POWER8 system.  In the guest I tested both 4k and 64k configs,
> with THP enabled; in the host I tested with 64k page size and THP
> enabled.  All these tests ran fine, including running a KVM guest on
> the bare-metal system.  So far I have done kernel compiles in a loop
> as the test, but I plan to run LTP and possibly some other tests.
>
> Comments welcome.

I was expecting some complex changes in asm and other part of the code. That
is one of the reason I was holding of a series like this till I get the
radix merged. I should have really tried the radix/hash linux page table 
consolidation to see the impact.

Now how do we want to go with this series ?. If we are taking this
series before the books3 hash linux abstraction series, I will have to
redo that series now on top of this.

-aneesh

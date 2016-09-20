Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdYdh0q26zDsfh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 17:04:08 +1000 (AEST)
In-Reply-To: <1473748807-9604-1-git-send-email-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v2] Fix __tlbiel in hash_native_64
Message-Id: <3sdYdg6rwYz9sdn@ozlabs.org>
Date: Tue, 20 Sep 2016 17:04:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-13-09 at 06:40:07 UTC, Balbir Singh wrote:
> __tlbie and __tlbiel are out of sync. __tlbie does the right thing
> it calls tlbie with "tlbie rb, L" if CPU_FTR_ARCH_206 (cpu feature) is clear
> and with "tlbie rb" otherwise. During the cleanup of __tlbiel I noticed
> that __tlbiel was setting bit 11 PPC_BIT(21) independent of the ISA
> version for non-4k (L) pages. This patch fixes that issue. It also changes
> the current PPC_TLBIEL to PPC_TLBIEL_5 and introduces a new PPC_TLBIEL similar
> to PPC_TLBIE.

This should give more description of what the problem is, ie. we're setting a
bit in the instruction which is reserved on some processors, before talking
about the solution or what tlbie does.
 
> The arguments to PPC_TLBIE have also been changed/switched in order
> to be consistent with the actual assembly usage for clearer reading
> of code.

The whole thing should be split in 3 patches:

One which fixes the buglet where we set L=1 on 2.06 and 2.07.
One which renames PPC_TLBIEL() to PPC_TLBIEL_5().
One which switches the order of the arguments to PPC_TLBIEL().

Also do we even need a macro for the two argument form? We've had uses of the
two argument tlbie since 2011, so I suspect the assembler will happily accept
it?

cheers

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqHYm4HyYzDqFP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 22:04:12 +1000 (AEST)
Message-ID: <1468411441.20552.80.camel@kernel.crashing.org>
Subject: Re: [PATCH for-4.8_set4 0/2] Segment table support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 13 Jul 2016 07:04:01 -0500
In-Reply-To: <1468402850-6052-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402850-6052-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-07-13 at 15:10 +0530, Aneesh Kumar K.V wrote:
> Hi,
> 
> This series add support for ISA 3.0 memory segment table.
> 
> Aneesh Kumar K.V (2):
>   powerpc/mm: Switch user slb fault handling to translation enabled
>   powerpc/mm: Support segment table for Power9

The segment table will only be used for the nest MMU, shouldn't we keep
that a separate path that we call explictly from fault interrupts
coming from NestMMU agents instead ?

>  Documentation/kernel-parameters.txt           |   3 +
>  arch/powerpc/include/asm/book3s/64/hash.h     |  10 +
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  17 ++
>  arch/powerpc/include/asm/book3s/64/mmu.h      |   4 +
>  arch/powerpc/include/asm/mmu.h                |   6 +-
>  arch/powerpc/include/asm/mmu_context.h        |   5 +-
>  arch/powerpc/kernel/exceptions-64s.S          |  55 +++-
>  arch/powerpc/kernel/prom.c                    |  13 +-
>  arch/powerpc/mm/hash_utils_64.c               |  83 +++++-
>  arch/powerpc/mm/mmu_context_book3s64.c        |  32 ++-
>  arch/powerpc/mm/slb.c                         | 359
> ++++++++++++++++++++++++++
>  11 files changed, 564 insertions(+), 23 deletions(-)
> 

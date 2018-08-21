Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vgMV2GhNzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 16:12:53 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7L6AFMM141803
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 02:12:51 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m07vdje5s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 02:12:51 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 21 Aug 2018 07:12:49 +0100
Subject: Re: [PATCH] powerpc/64s/hash: convert SLB miss handlers to C
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 21 Aug 2018 16:12:44 +1000
In-Reply-To: <20180821051306.17869-1-npiggin@gmail.com>
References: <20180821051306.17869-1-npiggin@gmail.com>
Mime-Version: 1.0
Message-Id: <a8f6f7ca5ae67e0a7bce6ed8a37d50f6e282d256.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-08-21 at 15:13 +1000, Nicholas Piggin wrote:
> This patch moves SLB miss handlers completely to C, using the standard
> exception handler macros to set up the stack and branch to C.
> 
> This can be done because the segment containing the kernel stack is
> always bolted, so accessing it with relocation on will not cause an
> SLB exception.
> 
> Arbitrary kernel memory may not be accessed when handling kernel space
> SLB misses, so care should be taken there. However user SLB misses can
> access any kernel memory, which can be used to move some fields out of
> the paca (in later patches).
> 
> User SLB misses could quite easily reconcile IRQs and set up a first
> class kernel environment and exit via ret_from_except, however that
> doesn't seem to be necessary at the moment, so we only do that if a
> bad fault is encountered.
> 
> [ Credit to Aneesh for bug fixes, error checks, and improvements to bad
>   address handling, etc ]
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Since RFC:
> - Send patch 1 by itself to focus on the big change.
> - Added MSR[RI] handling
> - Fixed up a register loss bug exposed by irq tracing (Aneesh)
> - Reject misses outside the defined kernel regions (Aneesh)
> - Added several more sanity checks and error handlig (Aneesh), we may
>   look at consolidating these tests and tightenig up the code but for
>   a first pass we decided it's better to check carefully.
> ---
>  arch/powerpc/include/asm/asm-prototypes.h |   2 +
>  arch/powerpc/kernel/exceptions-64s.S      | 202 +++----------
>  arch/powerpc/mm/Makefile                  |   2 +-
>  arch/powerpc/mm/slb.c                     | 257 +++++++++--------
>  arch/powerpc/mm/slb_low.S                 | 335 ----------------------
>  5 files changed, 185 insertions(+), 613 deletions(-)
                    ^^^                ^^^

Nice ! :-)

Cheers,
Ben.

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vh5k6w6vzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 16:46:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 1/5] powerpc/64s/hash: convert SLB miss handlers to C
In-Reply-To: <20180820094200.13003-2-npiggin@gmail.com>
References: <20180820094200.13003-1-npiggin@gmail.com>
 <20180820094200.13003-2-npiggin@gmail.com>
Date: Tue, 21 Aug 2018 16:46:02 +1000
Message-ID: <87y3d0kyj9.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> This patch moves SLB miss handlers completely to C, using the standard
> exception handler macros to set up the stack and branch to C.
>
> This can be done because the segment containing the kernel stack is
> always bolted, so accessing it with relocation on will not cause an
> SLB exception.
>
> Arbitrary kernel memory may not be accessed when handling kernel space
> SLB misses, so care should be taken there.

We'll need to mark everything that's used in slb.c as notrace, otherwise

Probably we just need to mark the whole file as not traceable.

cheers

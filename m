Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sWVcm1npzzDrq8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 20:27:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kim Phillips <kim.phillips@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Arnd Bergmann <arnd@arndb.de>,
 Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] perf_event: remove unused DEBUG_PERF_USE_VMALLOC
In-Reply-To: <20160830140834.6d1edf7abd9d95c02dae7820@arm.com>
References: <20160830140834.6d1edf7abd9d95c02dae7820@arm.com>
Date: Sat, 10 Sep 2016 20:27:18 +1000
Message-ID: <87lgz0nj7d.fsf@concordia.ellerman.id.au>
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

Kim Phillips <kim.phillips@arm.com> writes:

> This 'DEBUG'-prefixed version of PERF_USE_VMALLOC is not used anywhere.
> It appears to be leftovers from commit 906010b "perf_event: Provide
> vmalloc() based mmap() backing" that introduced it.
>
> Not sure what commit cb30711 "perf_event: Don't allow vmalloc() backed
> perf on powerpc" was trying to do with it either.

Preventing its use on powerpc, because it doesn't work, I thought the
change log was pretty clear:

    perf_event: Don't allow vmalloc() backed perf on powerpc
    
    On powerpc the perf event interrupt is not masked when interrupts are
    disabled, allowing it to function as an NMI.
    
    This causes problems if perf is using vmalloc. If we take a page fault
    on the vmalloc region the fault handler will fail the page fault because
    it detects we are coming in from an NMI (see do_hash_page()).
    
    We don't actually need or want vmalloc backed perf so just disable it on
    powerpc.


If there are ARM cpus that don't want it enabled then you should
probably do a similar patch for ARM.

cheers

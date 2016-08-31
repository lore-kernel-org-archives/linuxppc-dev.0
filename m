Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPGcB0kJqzDrfP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 17:05:14 +1000 (AEST)
Date: Wed, 31 Aug 2016 09:04:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Arnd Bergmann <arnd@arndb.de>,
 Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] perf_event: remove unused DEBUG_PERF_USE_VMALLOC
Message-ID: <20160831070457.GY10138@twins.programming.kicks-ass.net>
References: <20160830140834.6d1edf7abd9d95c02dae7820@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160830140834.6d1edf7abd9d95c02dae7820@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 30, 2016 at 02:08:34PM -0500, Kim Phillips wrote:
> This 'DEBUG'-prefixed version of PERF_USE_VMALLOC is not used anywhere.
> It appears to be leftovers from commit 906010b "perf_event: Provide
> vmalloc() based mmap() backing" that introduced it.
> 
> Not sure what commit cb30711 "perf_event: Don't allow vmalloc() backed
> perf on powerpc" was trying to do with it either.
> 
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  init/Kconfig | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index cac3f09..934a61f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1707,19 +1707,6 @@ config PERF_EVENTS
>  
>  	  Say Y if unsure.
>  
> -config DEBUG_PERF_USE_VMALLOC
> -	default n
> -	bool "Debug: use vmalloc to back perf mmap() buffers"
> -	depends on PERF_EVENTS && DEBUG_KERNEL && !PPC
> -	select PERF_USE_VMALLOC

^^^^^


It forces the use of vmalloc backed pages for the ring-buffer so that we
can test that code on x86, which otherwise doesn't use it.

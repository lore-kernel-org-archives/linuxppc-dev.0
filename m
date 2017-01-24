Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6ybr5ZTCzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 17:15:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: BUILD_BUG_ON(!__builtin_constant_p(feature)) breaks bcc trace tool
In-Reply-To: <20170121204948.742f89bf@kryten>
References: <20170121120339.1c774b28@kryten> <20170121204948.742f89bf@kryten>
Date: Tue, 24 Jan 2017 17:15:50 +1100
Message-ID: <87pojd9e5l.fsf@concordia.ellerman.id.au>
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

Anton Blanchard <anton@samba.org> writes:
>> We added:
>> 
>> BUILD_BUG_ON(!__builtin_constant_p(feature)) 
>> 
>> to cpu_has_feature() and mmu_has_feature() in order to catch usage
>> issues (such as cpu_has_feature(cpu_has_feature(X)). Unfortunately
>> LLVM isn't smart enough to resolve this, and it errors out.
>> 
>> I work around it in my clang/LLVM builds of the kernel, but I have
>> just discovered that it causes a lot of issues for the bcc (eBPF)
>> trace tool (which uses LLVM).
>> 
>> How should we work around this? Wrap the checks in !clang perhaps?
>
> Looks like it's a weakness in LLVM with inlining:
>
> #include <assert.h>
>
> #if 1
> static inline void foo(unsigned long x)
> {
>         assert(__builtin_constant_p(x));
> }
> #else
> #define foo(X) assert(__builtin_constant_p(X))
> #endif
>
> int main(void)
> {
>         foo(1);
>
>         return 0;
> }

OK. cpu_has_feature() is __always_inline:

static __always_inline bool cpu_has_feature(unsigned long feature)
{
	int i;

	BUILD_BUG_ON(!__builtin_constant_p(feature));


But I guess even that doesn't work?

Hmm, in fact it seems because we don't define
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING and CONFIG_OPTIMIZE_INLINING, we
get:

#define inline		inline		__attribute__((always_inline)) notrace

So in fact every inline function is marked always_inline all the time,
which seems dubious.

But still, it seems clang is ignoring always_inline.

cheers

Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v5CVR0x5bzDqSY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 20:50:06 +1100 (AEDT)
Date: Sat, 21 Jan 2017 20:49:48 +1100
From: Anton Blanchard <anton@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Nicholas Piggin  <npiggin@gmail.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: BUILD_BUG_ON(!__builtin_constant_p(feature)) breaks bcc trace tool
Message-ID: <20170121204948.742f89bf@kryten>
In-Reply-To: <20170121120339.1c774b28@kryten>
References: <20170121120339.1c774b28@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> We added:
> 
> BUILD_BUG_ON(!__builtin_constant_p(feature)) 
> 
> to cpu_has_feature() and mmu_has_feature() in order to catch usage
> issues (such as cpu_has_feature(cpu_has_feature(X)). Unfortunately
> LLVM isn't smart enough to resolve this, and it errors out.
> 
> I work around it in my clang/LLVM builds of the kernel, but I have
> just discovered that it causes a lot of issues for the bcc (eBPF)
> trace tool (which uses LLVM).
> 
> How should we work around this? Wrap the checks in !clang perhaps?

Looks like it's a weakness in LLVM with inlining:

#include <assert.h>

#if 1
static inline void foo(unsigned long x)
{
        assert(__builtin_constant_p(x));
}
#else
#define foo(X) assert(__builtin_constant_p(X))
#endif

int main(void)
{
        foo(1);

        return 0;
}

And there is an old bug on it:

https://llvm.org/bugs/show_bug.cgi?id=4898

Anton

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxXyz2Ms2zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 23:30:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH] powerpc/misc: fix exported functions that reference the
 TOC
In-Reply-To: <20170403032512.22085-1-oohall@gmail.com>
References: <20170403032512.22085-1-oohall@gmail.com>
Date: Mon, 03 Apr 2017 23:29:59 +1000
Message-ID: <87r319vctk.fsf@concordia.ellerman.id.au>
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

Oliver O'Halloran <oohall@gmail.com> writes:

> When the kernel is compiled to use 64bit ABIv2 the _GLOBAL() macro does not
> include a global entry point. A function's global entry point is used when the
> function is called from a different TOC context and in the kernel this
> typically means a call from a module into the vmlinux (or vis-a-vis).
>
> There are a few exported ASM functions declared with _GLOBAL() and calling
> them from a module will module will likely crash the kernel since any TOC
> relative load will yield garbage.
>
> To fix this use _GLOBAL_TOC() for exported asm functions rather than _GLOBAL()
> and some documentation about when to use each.

I wonder if we should just change _GLOBAL() to include the global entry
point. Persisting with _GLOBAL_TOC() seems like it's just going to be a
game of whack-a-mole.

Just grepping now I see ~50 functions defined with _GLOBAL() which are
also EXPORT'ed. Now presumably none of them use the TOC? But there's no
way to verify it, other than inspecting each one, and there's no way to
ensure we don't break it again in future.

The other option would be just to make a rule that anything EXPORT'ed
must use _GLOBAL_TOC().

cheers

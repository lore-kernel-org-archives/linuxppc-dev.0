Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vykyc11q1zDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 22:03:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH] powerpc/misc: fix exported functions that reference the
 TOC
In-Reply-To: <87r319vctk.fsf@concordia.ellerman.id.au>
References: <20170403032512.22085-1-oohall@gmail.com>
 <87r319vctk.fsf@concordia.ellerman.id.au>
Date: Wed, 05 Apr 2017 22:03:50 +1000
Message-ID: <874ly383ix.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> Oliver O'Halloran <oohall@gmail.com> writes:
>
>> When the kernel is compiled to use 64bit ABIv2 the _GLOBAL() macro does not
>> include a global entry point. A function's global entry point is used when the
>> function is called from a different TOC context and in the kernel this
>> typically means a call from a module into the vmlinux (or vis-a-vis).
>>
>> There are a few exported ASM functions declared with _GLOBAL() and calling
>> them from a module will module will likely crash the kernel since any TOC
>> relative load will yield garbage.
>>
>> To fix this use _GLOBAL_TOC() for exported asm functions rather than _GLOBAL()
>> and some documentation about when to use each.
>
> I wonder if we should just change _GLOBAL() to include the global entry
> point. Persisting with _GLOBAL_TOC() seems like it's just going to be a
> game of whack-a-mole.

Turns out that doesn't work well at all.

We have *a lot* of places that use _GLOBAL() to make a symbol global,
but which aren't functions entry points, eg:

  	.align	7
  _GLOBAL(ret_from_except)
  	ld	r11,_TRAP(r1)
  	andi.	r0,r11,1
  	bne	ret_from_except_lite
  	REST_NVGPRS(r1)
  
  _GLOBAL(ret_from_except_lite)
  	...


Because ret_from_except wants to fallthrough there, we can't have
_GLOBAL() insert instructions at ret_from_except_lite.

So for now we'll merge a version of this fix.

In the medium term we should change all our asm functions to use
FUNC_START(), so it's clear they are functions, and then FUNC_START()
should add the global entry point.

We can then have a hard rule that anything EXPORT_SYMBOL'ed should use
FUNC_START().

cheers

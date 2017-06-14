Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnkKy6qYhzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 21:04:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org,
 dan.carpenter@oracle.com <dan.carpenter@oracle.com>
Subject: Re: [PATCH kernel] powerpc/debug: Add missing warn flag to WARN_ON's
 non-builtin path
In-Reply-To: <20170614030125.45899-1-aik@ozlabs.ru>
References: <20170614030125.45899-1-aik@ozlabs.ru>
Date: Wed, 14 Jun 2017 21:04:34 +1000
Message-ID: <87mv9a3k59.fsf@concordia.ellerman.id.au>
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

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> When trapped on WARN_ON(), report_bug() is expected to return
> BUG_TRAP_TYPE_WARN so the caller could increment NIP by 4 and continue.
> The __builtin_constant_p() path of the PPC's WARN_ON() calls (indirectly)
> __WARN_FLAGS() which has BUGFLAG_WARNING set, however the other branch
> does not which makes report_bug() report a bug rather than a warning.
>
> Fixes: 19d436268dde95389 ("debug: Add _ONCE() logic to report_bug()")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> Actually 19d436268dde95389 replaced __WARN_TAINT() with __WARN_FLAGS()
> and lost BUGFLAG_TAINT() and this is not in the commit log so it is
> unclear:
> 1) why

I think the rename is because previously the argument was a taint value,
whereas now it is a flags value (which is a superset of taint).

> 2) whether this particular patch should be doing
>    BUGFLAG_WARNING|BUGFLAG_TAINT(TAINT_WARN)
>  or
>    BUGFLAG_WARNING|(flags)

There is no flags here so the latter won't work AFAICS.

> Any ideas? Thanks.

Your patch looks correct to me. I assume it works?


The bug isn't introduced by 19d436268dde ("debug: Add _ONCE() logic to
report_bug()") as far as I can see.

If you check out that revision you see that BUGFLAG_TAINT still contains
BUGFLAG_WARNING:

#define BUGFLAG_TAINT(taint)	(BUGFLAG_WARNING | ((taint) << 8))

But that was removed in f26dee15103f ("debug: Avoid setting
BUGFLAG_WARNING twice"). So I think the Fixes: tag should point at that
commit.

cheers

> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> index f2c562a0a427..0151af6c2a50 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -104,7 +104,7 @@
>  		"1:	"PPC_TLNEI"	%4,0\n"			\
>  		_EMIT_BUG_ENTRY					\
>  		: : "i" (__FILE__), "i" (__LINE__),		\
> -		  "i" (BUGFLAG_TAINT(TAINT_WARN)),		\
> +		  "i" (BUGFLAG_WARNING|BUGFLAG_TAINT(TAINT_WARN)),\
>  		  "i" (sizeof(struct bug_entry)),		\
>  		  "r" (__ret_warn_on));				\
>  	}							\
> -- 
> 2.11.0

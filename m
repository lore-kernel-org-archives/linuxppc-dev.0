Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyWkb50l2zDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 19:38:15 +1000 (AEST)
Received: by mail-pf0-x233.google.com with SMTP id g65so2953326pfe.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 02:38:15 -0700 (PDT)
Date: Thu, 21 Sep 2017 18:38:08 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v2 6/7] symbol lookup: use new kernel and module
 dereference functions
Message-ID: <20170921093808.GE773@jagdpanzerIV.localdomain>
References: <20170920162910.32053-1-sergey.senozhatsky@gmail.com>
 <20170920162910.32053-7-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920162910.32053-7-sergey.senozhatsky@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (09/21/17 01:29), Sergey Senozhatsky wrote:
[..]
> +	%pS	versatile_init+0x0/0x110
> +	%ps	versatile_init
>  	%pF	versatile_init+0x0/0x110
>  	%pf	versatile_init
> -	%pS	versatile_init+0x0/0x110
>  	%pSR	versatile_init+0x9/0x110
>  		(with __builtin_extract_return_addr() translation)
> -	%ps	versatile_init
>  	%pB	prev_fn_of_versatile_init+0x88/0x88
>  
> -The ``F`` and ``f`` specifiers are for printing function pointers,
> -for example, f->func, &gettimeofday. They have the same result as
> -``S`` and ``s`` specifiers. But they do an extra conversion on
> -ia64, ppc64 and parisc64 architectures where the function pointers
> -are actually function descriptors.
> -
>  The ``S`` and ``s`` specifiers can be used for printing symbols
>  from direct addresses, for example, __builtin_return_address(0),
>  (void *)regs->ip. They result in the symbol name with (``S``) or
>  without (``s``) offsets. If KALLSYMS are disabled then the symbol
>  address is printed instead.
>  
> +Note, that the ``F`` and ``f`` specifiers are identical to ``S`` (``s``)
> +and thus deprecated.

JFI,

I have updated this part. it's probably too early to completely
wipe out pF/pf info.

the updated Doc goes like this:

+Note, that the ``F`` and ``f`` specifiers are identical to ``S`` (``s``)
+and thus deprecated. We have ``F`` and ``f`` because on ia64, ppc64 and
+parisc64 function pointers are indirect and, in fact, are function
+descriptors, which require additional dereferencing before we can lookup
+the symbol. As of now, ``S`` and ``s`` perform dereferencing on those
+platforms (when needed), so ``F`` and ``f`` exist for compatibility
+reasons only.

	-ss

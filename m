Return-Path: <mingo@elte.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 32D03B7148
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 22:08:46 +1000 (EST)
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC0F2DDDB2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 22:08:45 +1000 (EST)
Date: Wed, 17 Jun 2009 14:08:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 6/6] perf_counter: tools: Makefile tweaks for 64-bit
	powerpc
Message-ID: <20090617120831.GB26454@elte.hu>
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
	<19000.55666.866148.559620@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19000.55666.866148.559620@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Paul Mackerras <paulus@samba.org> wrote:

> +++ b/tools/perf/Makefile
> @@ -157,9 +157,21 @@ uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
>  uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
>  uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
>  
> +# If we're on a 64-bit kernel, use -m64
> +ifneq ($(patsubst %64,%,$(uname_M)),$(uname_M))
> +  M64 := -m64
> +endif

this is fine.

> +# Don't use -Werror on ppc64; we get warnings due to using
> +# %Lx formats on __u64, which is unsigned long.
> +Werror := -Werror
> +ifeq ($(uname_M),ppc64)
> +  Werror :=
> +endif

hm, i dont really like this one - it just adds a special case on an 
arch. Why is __u64 unsigned long on powerpc and not unsigned long 
long? I thought the whole mess with u64 was fixed there recently and 
powerpc too now uses include/asm-generic/int-ll64.h ?

ah, it does this:

/*
 * This is here because we used to use l64 for 64bit powerpc
 * and we don't want to impact user mode with our change to ll64
 * in the kernel.
 */
#if defined(__powerpc64__) && !defined(__KERNEL__)
# include <asm-generic/int-l64.h>
#else
# include <asm-generic/int-ll64.h>
#endif

That's crappy really.

	Ingo

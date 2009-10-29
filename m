Return-Path: <hollisb@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E679DB7C0F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Oct 2009 08:31:05 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9TLN5HP008188
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2009 17:23:05 -0400
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9TLV1Cu082010
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2009 17:31:01 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9TLWOPw032490
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2009 15:32:24 -0600
Subject: Re: [PATCH] BUILD_BUG_ON: make it handle more cases
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <200910201415.34361.rusty@rustcorp.com.au>
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<200910201142.34006.rusty@rustcorp.com.au>
	<1256002193.6546.2.camel@slab>
	<200910201415.34361.rusty@rustcorp.com.au>
Content-Type: text/plain
Date: Thu, 29 Oct 2009 14:30:50 -0700
Message-Id: <1256851850.9044.114.camel@slab.beaverton.ibm.com>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	linux-next@vger.kernel.org, Jan Beulich <JBeulich@novell.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-20 at 14:15 +1030, Rusty Russell wrote:
> BUILD_BUG_ON used to use the optimizer to do code elimination or fail
> at link time; it was changed to first the size of a negative array (a
> nicer compile time error), then (in
> 8c87df457cb58fe75b9b893007917cf8095660a0) to a bitfield.
> 
> bitfields: needs a literal constant at parse time, and can't be put under
> 	"if (__builtin_constant_p(x))" for example.
> negative array: can handle anything, but if the compiler can't tell it's
> 	a constant, silently has no effect.
> link time: breaks link if the compiler can't determine the value, but the
> 	linker output is not usually as informative as a compiler error.
> 
> If we use the negative-array-size method *and* the link time trick,
> we get the ability to use BUILD_BUG_ON() under __builtin_constant_p()
> branches, and maximal ability for the compiler to detect errors at
> build time.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -683,12 +683,6 @@ struct sysinfo {
>  	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
>  };
> 
> -/* Force a compilation error if condition is true */
> -#define BUILD_BUG_ON(condition) ((void)BUILD_BUG_ON_ZERO(condition))
> -
> -/* Force a compilation error if condition is constant and true */
> -#define MAYBE_BUILD_BUG_ON(cond) ((void)sizeof(char[1 - 2 * !!(cond)]))
> -
>  /* Force a compilation error if condition is true, but also produce a
>     result (of value 0 and type size_t), so the expression can be used
>     e.g. in a structure initializer (or where-ever else comma expressions
> @@ -696,6 +690,33 @@ struct sysinfo {
>  #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
>  #define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))
> 
> +/**
> + * BUILD_BUG_ON - break compile if a condition is true.
> + * @cond: the condition which the compiler should know is false.
> + *
> + * If you have some code which relies on certain constants being equal, or
> + * other compile-time-evaluated condition, you should use BUILD_BUG_ON to
> + * detect if someone changes it.
> + *
> + * The implementation uses gcc's reluctance to create a negative array, but
> + * gcc (as of 4.4) only emits that error for obvious cases (eg. not arguments
> + * to inline functions).  So as a fallback we use the optimizer; if it can't
> + * prove the condition is false, it will cause a link error on the undefined
> + * "__build_bug_on_failed".  This error message can be harder to track down
> + * though, hence the two different methods.
> + */
> +#ifndef __OPTIMIZE__
> +#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
> +#else
> +extern int __build_bug_on_failed;
> +#define BUILD_BUG_ON(condition)					\
> +	do {							\
> +		((void)sizeof(char[1 - 2*!!(condition)]));	\
> +		if (condition) __build_bug_on_failed = 1;	\
> +	} while(0)
> +#endif
> +#define MAYBE_BUILD_BUG_ON(condition) BUILD_BUG_ON(condition)
> +
>  /* Trap pasters of __FUNCTION__ at compile-time */
>  #define __FUNCTION__ (__func__)

What's the state of this patch?

-- 
Hollis Blanchard
IBM Linux Technology Center

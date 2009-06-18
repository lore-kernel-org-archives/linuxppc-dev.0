Return-Path: <mingo@elte.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 29FB0B7291
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 19:13:46 +1000 (EST)
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8F8BDDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 19:13:45 +1000 (EST)
Date: Thu, 18 Jun 2009 11:13:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 6/6] perf_counter: tools: Makefile tweaks for 64-bit
	powerpc
Message-ID: <20090618091334.GB21191@elte.hu>
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

> This also removes the -Werror flag when building on a 64-bit powerpc
> machine.  The userspace definition of u64 is unsigned long rather
> than unsigned long long, meaning that gcc warns every time a u64
> is printed with %Lx or %llx (though that does work properly).
> In future we may use PRI64 etc. for printing 64-bit quantities,
> which would eliminate these warnings.

> +# Don't use -Werror on ppc64; we get warnings due to using
> +# %Lx formats on __u64, which is unsigned long.
> +Werror := -Werror
> +ifeq ($(uname_M),ppc64)
> +  Werror :=
> +endif

Note, i left out this bit from the commit - we need to find a better 
solution than to allow ugly warnings on PowerPC.

Could we use the kernel's u64 type directly perhaps? That would 
allow us to change all __u64 to u64 in all of tools/perf/ which is a 
nice clean-up in any case.

	Ingo

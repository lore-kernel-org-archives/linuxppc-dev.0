Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E66F4B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 13:56:49 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p172umQp001039
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Feb 2011 13:56:48 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p172umrb2461834
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Feb 2011 13:56:48 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p172umaK021824
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Feb 2011 13:56:48 +1100
Date: Mon, 7 Feb 2011 08:26:43 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix call to flush_ptrace_hw_breakpoint()
Message-ID: <20110207025643.GA12223@in.ibm.com>
References: <1297032853.14982.3.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297032853.14982.3.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 07, 2011 at 09:54:13AM +1100, Benjamin Herrenschmidt wrote:
> A typo in the #ifdef statement makes us never call it
> in flush_thread()
>

I wish it never compiled for such typos :-)

 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: K.Prasad <prasad@linux.vnet.ibm.com>

> ---
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 7a1d5cb..c4e4eab 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -670,11 +670,11 @@ void flush_thread(void)
>  {
>  	discard_lazy_cpu_state();
> 
> -#ifdef CONFIG_HAVE_HW_BREAKPOINTS
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
>  	flush_ptrace_hw_breakpoint(current);
> -#else /* CONFIG_HAVE_HW_BREAKPOINTS */
> +#else /* CONFIG_HAVE_HW_BREAKPOINT */
>  	set_debug_reg_defaults(&current->thread);
> -#endif /* CONFIG_HAVE_HW_BREAKPOINTS */
> +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
>  }
> 
>  void
> 
> 

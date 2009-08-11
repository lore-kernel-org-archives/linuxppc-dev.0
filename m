Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 86EB8B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 17:02:03 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CADE9DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 17:02:02 +1000 (EST)
Subject: Re: [PATCH v2] perf_counter: powerpc: Add callchain support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <19066.25333.469817.404676@drongo.ozlabs.ibm.com>
References: <19066.25278.925555.133212@drongo.ozlabs.ibm.com>
	<19066.25333.469817.404676@drongo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 11 Aug 2009 17:01:56 +1000
Message-Id: <1249974116.9841.119.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-06 at 14:58 +1000, Paul Mackerras wrote:

> +
> +#else  /* CONFIG_PPC64 */
> +/*
> + * On 32-bit we just access the address and let hash_page create a
> + * HPTE if necessary, so there is no need to fall back to reading
> + * the page tables.  Since this is called at interrupt level,
> + * do_page_fault() won't treat a DSI as a page fault.
> + */

Minor nit here... The comment makes it think there's only hash based
32-bit processors :-) In fact, there's a little issue with non-hash ones
here, which is that they rely on
do_page_fault->handle_mm_fault->ptep_set_access_flags to set
_PAGE_ACCESSED, and the TLB miss handlers are going to fault if that's
not set.

Not a big deal, but it does mean that if you have stack pages that
aren't young, they will fail to backtrace (though that's probably
unlikely unless you spend a lot of time very deep down a huge call
chain).

> +static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> +{
> +	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> +	    ((unsigned long)ptr & 3))
> +		return -EFAULT;
> +
> +	return __get_user_inatomic(*ret, ptr);
> +}
> +
> +static inline void perf_callchain_user_64(struct pt_regs *regs,
> +					  struct perf_callchain_entry *entry)
> +{
> +}
> +
> +static inline int current_is_64bit(void)
> +{
> +	return 0;
> +}
> +
> +static inline int valid_user_sp(unsigned long sp, int is_64)
> +{
> +	if (!sp || (sp & 7) || sp > TASK_SIZE - 32)

I know the above is right but I would still have preferred () around
TASK_SIZE - 32 :-) In fact, || has lower precedence than & (I checked !)
so in theory if you really wanted to get rid of braces, you could have
written

	if (!sp || sp & 7 || sp > TASK_SIZE - 32)

But heh, that sucks :-)

> +struct signal_frame_32 {
> +	char			dummy[__SIGNAL_FRAMESIZE32];
> +	struct sigcontext32	sctx;
> +	struct mcontext32	mctx;
> +	int			abigap[56];
> +};
> +
> +/*
> + * Layout for RT signal frames
> + */
> +struct rt_signal_frame_32 {
> +	char			dummy[__SIGNAL_FRAMESIZE32 + 16];
> +	compat_siginfo_t	info;
> +	struct ucontext32	uc;
> +	int			abigap[56];
> +};

Should we put those somewhere shared ? They are almost the same
as the ones in signal_32.c apart from the initial gap... oh well, no big
deal if you want to keep them here for now.
 
Overall looks fine and I suppose it also works but I may have missed
something subtle.

Cheers,
Ben.

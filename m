Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0F6DD1007D2
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Dec 2010 06:05:40 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: prasad@linux.vnet.ibm.com
Subject: Re: ppc_set_hwdebug vs ptrace_set_debugreg
References: <m2lj4ezhhd.fsf@igel.home> <20101129072233.GA15560@in.ibm.com>
	<m38w0c77vs.fsf@linux-m68k.org> <20101201043758.GA2219@in.ibm.com>
	<20101213082619.GA6582@in.ibm.com>
Date: Mon, 13 Dec 2010 20:05:36 +0100
In-Reply-To: <20101213082619.GA6582@in.ibm.com> (K. Prasad's message of "Mon,
	13 Dec 2010 13:56:19 +0530")
Message-ID: <m2vd2x1ojj.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"K.Prasad" <prasad@linux.vnet.ibm.com> writes:

> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	/* Create a new breakpoint request if one doesn't exist already */
> +	hw_breakpoint_init(&attr);
> +	attr.bp_addr = bp_info->addr & ~HW_BREAKPOINT_ALIGN;
> +	arch_bp_generic_fields(bp_info->addr &
> +				(DABR_DATA_WRITE | DABR_DATA_READ),
> +							&attr.bp_type);
> +
> +	bp = register_user_hw_breakpoint(&attr, ptrace_triggered, task);
> +	if (IS_ERR(bp))
> +		return PTR_ERR(bp);
> +
> +	child->thread.ptrace_bps[0] = bp;
> +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> +
>  	child->thread.dabr = (unsigned long)bp_info->addr;

That cannot work, see
<http://permalink.gmane.org/gmane.linux.ports.ppc64.devel/71418>.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

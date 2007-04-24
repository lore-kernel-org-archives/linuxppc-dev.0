Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17965.21687.567012.175024@cargo.ozlabs.ibm.com>
Date: Tue, 24 Apr 2007 10:52:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
Subject: Re: [RFC 2/3] PowerPC: lazy altivec enabling in kernel
In-Reply-To: <20070417120925.263638000@linux.vnet.ibm.com>
References: <20070417115206.709701000@linux.vnet.ibm.com>
	<20070417120925.263638000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sebastian Siewior writes:

>  void enable_kernel_altivec(void)
>  {
> -	WARN_ON(preemptible());
> +	BUG_ON(preemptible());
> +	/*
> +	 * enable_kernel_altivec() will just save current AltiVec registers (if needed) and
> +	 * return to caller (with MSR_VEC unchanged (probably not set)). The first AltiVec
> +	 * instruction will raise an exception and the exception will enable the AltiVec for
> +	 * the kernel. This is done to avoid the expensive "enable altivec" operation if it
> +	 * is allready enabled. However, you have to disable preemtion while you are using
> +	 * AltiVec.
> +	 */

It would be better to put a test and conditional branch in
giveup_altivec to skip the mtmsrd if MSR_VEC is already set.  That
would avoid adding the overhead of the trap in the case when MSR_VEC
isn't already set, besides being much less code.

Paul.

MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16358.4872.857438.957341@cargo.ozlabs.ibm.com>
Date: Mon, 22 Dec 2003 08:39:20 +1100
From: Paul Mackerras <paulus@samba.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: org@stop.crashing.org, linuxppc-dev@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>
Subject: Re: 8xx drivers for 2.6
In-Reply-To: <20031211191854.GK23731@stop.crashing.org>
References: <20031211191854.GK23731@stop.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini writes:

> (serial), and in 2.6 having request_8xxirq becomes much uglier because
> of the irqreturn_t stuff (at least I couldn't make it happen w/o chaning
> <linux/interrupt.h>, and I never did figure out why cond_syscall()
> doesn't work in some files but not others.

Gaahhhh, I thought we had got rid of request_8xxirq.  I don't want to
see it come back.  And this sort of thing is just bad:

> diff -Nru a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
> --- a/include/asm-ppc/mpc8xx.h	Thu Dec 11 12:14:00 2003
> +++ b/include/asm-ppc/mpc8xx.h	Thu Dec 11 12:14:00 2003
> @@ -96,8 +96,10 @@
>  extern unsigned char __res[];
>
>  struct pt_regs;
> +typedef int irqreturn_t;	/* FIXME -- Tom */
> +

[snip]

> diff -Nru a/include/linux/interrupt.h b/include/linux/interrupt.h
> --- a/include/linux/interrupt.h	Thu Dec 11 12:14:00 2003
> +++ b/include/linux/interrupt.h	Thu Dec 11 12:14:00 2003
> @@ -26,7 +26,9 @@
>   * IRQ_HANDLED means that we did have a valid interrupt and handled it.
>   * IRQ_RETVAL(x) selects on the two depending on x being non-zero (for handled)
>   */
> +#ifndef __CONFIG_8xx_DEFS
>  typedef int irqreturn_t;
> +#endif

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

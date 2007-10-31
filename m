Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18216.19826.611308.659235@cargo.ozlabs.ibm.com>
Date: Wed, 31 Oct 2007 20:40:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [POWERPC] Fix off-by-one error in setting decrementer on Book
 E
In-Reply-To: <47260FE5.5080107@ru.mvista.com>
References: <18213.19469.827909.663373@cargo.ozlabs.ibm.com>
	<47260FE5.5080107@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov writes:

> +       /*
> +        * The "classic"  decrementer  interrupts at 0 to -1 transition, while
> +        * 40x and book E decrementers interrupt  at 1 to  0 transition.

Funky  spacing .  : )

If I take out the removed lines in the rest of your patch, I get:

> +        */
>   #if defined(CONFIG_40x)
>          mtspr(SPRN_PIT, val);
> +#else
> +#if !defined(CONFIG_BOOKE)
> +       val = val ? val - 1 : 0;
> +#endif
> +#if defined(CONFIG_8xx_CPU6)
>          set_dec_cpu6(val);
> +#if defined(CONFIG_PPC_ISERIES)

I think you're missing a #else here.

Paul.

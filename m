Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C149DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 14:50:55 +1100 (EST)
In-Reply-To: <18213.19469.827909.663373@cargo.ozlabs.ibm.com>
References: <18213.19469.827909.663373@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <42A23BAB-6081-41CC-870C-7C7F094D69C3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [POWERPC] Fix off-by-one error in setting decrementer on Book E
Date: Mon, 29 Oct 2007 22:52:04 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 28, 2007, at 9:57 PM, Paul Mackerras wrote:

> The decrementer in Book E and 4xx processors interrupts on the
> transition from 1 to 0, rather than on the 0 to -1 transition as on
> 64-bit server and 32-bit "classic" (6xx/7xx/7xxx) processors.
>
> This fixes the problem by making set_dec subtract 1 from the count for
> server and classic processors.  Since set_dec already had a bunch of
> ifdefs to handle different processor types, there is no net increase
> in ugliness. :)
>
> This also removes a redundant call to set the decrementer to
> 0x7fffffff - it was already set to that earlier in timer_interrupt.
>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---

...

> diff --git a/include/asm-powerpc/time.h b/include/asm-powerpc/time.h
> index f058955..eed64bd 100644
> --- a/include/asm-powerpc/time.h
> +++ b/include/asm-powerpc/time.h
> @@ -183,6 +183,7 @@ static inline void set_dec(int val)
>  #elif defined(CONFIG_8xx_CPU6)
>  	set_dec_cpu6(val);
>  #else
> +	--val;	/* classic decrementer interrupts when dec goes negative */
>  #ifdef CONFIG_PPC_ISERIES
>  	int cur_dec;
>

Unless I'm reading set_dec() you are getting --val on booke.

- k

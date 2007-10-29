Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D94EFDE007
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 14:08:23 +1100 (EST)
Date: Sun, 28 Oct 2007 22:16:21 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [POWERPC] Fix off-by-one error in setting decrementer on Book E
Message-ID: <20071029031620.GA14667@lixom.net>
References: <18213.19469.827909.663373@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18213.19469.827909.663373@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

On Mon, Oct 29, 2007 at 01:57:17PM +1100, Paul Mackerras wrote:

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

This will mix code and declarations, I think some toolchains complain
about that?

It doesn't look like cur_dec is really needed, the call can be inlined
directly where it's used.


-Olof

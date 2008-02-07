Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79F8BDDDEC
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 19:45:08 +1100 (EST)
Subject: Re: asm-offsets.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <47AA8C7D.3030109@pikatech.com>
References: <47AA8C7D.3030109@pikatech.com>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 19:44:48 +1100
Message-Id: <1202373888.7079.124.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-02-06 at 23:43 -0500, Sean MacLennan wrote:
> I just did a git pull of Josh's tree, and 
> arch/powerpc/kernel/asm-offsets.c does not compile. I have only been 
> glossing over the linuxppc-dev emails, so forgive me if this already 
> came up.
> 
> It looks like, at least for the Warp, CLOCK_REALTIME_RES is not defined 
> so asm-offsets.c gets an error. The following patch fixes it.... but I 
> am not sure it is right since I don't know if CLOCK_REALTIME_RES should 
> be defined.

Hrm... this macro should -define- CLOCK_REALTIME_RES, not rely on an
existing definition...


> Cheers,
>   Sean
> 
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets
> .c
> index e6e4928..c1568aa 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -313,7 +313,9 @@ int main(void)
>         DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
>         DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
>         DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
> +#ifdef CLOCK_REALTIME_RES
>         DEFINE(CLOCK_REALTIME_RES, (KTIME_MONOTONIC_RES).tv64);
> +#endif
>  
>  #ifdef CONFIG_BUG
>         DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

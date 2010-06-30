Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59ACDB6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 08:18:48 +1000 (EST)
In-Reply-To: <20100630160422.3087bdf0.sfr@canb.auug.org.au>
References: <20100630160422.3087bdf0.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B6229BDC-F290-4A71-9F61-AAA5EC87F0F6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix compile errors in prom_init_check for gcc 4.5
Date: Thu, 1 Jul 2010 00:16:40 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Just whitelist these extra compiler generated symbols.
> Fixes these errors:

[...]

I've used an identical patch for almost a year now, so...

> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

You probably also need something similar to http://git.infradead.org/ 
users/segher/linux.git/commitdiff/ 
98194f54cc8e19ecd752bc10e2d19ef94074f502
(note: only build-tested, not run-tested).


Segher

> ---
>  arch/powerpc/kernel/prom_init_check.sh |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/ 
> kernel/prom_init_check.sh
> index 1ac136b..9f82f49 100644
> --- a/arch/powerpc/kernel/prom_init_check.sh
> +++ b/arch/powerpc/kernel/prom_init_check.sh
> @@ -52,12 +52,18 @@ do
>  	if [ "${UNDEF:0:9}" = "_restgpr_" ]; then
>  		OK=1
>  	fi
> +	if [ "${UNDEF:0:10}" = "_restgpr0_" ]; then
> +		OK=1
> +	fi
>  	if [ "${UNDEF:0:11}" = "_rest32gpr_" ]; then
>  		OK=1
>  	fi
>  	if [ "${UNDEF:0:9}" = "_savegpr_" ]; then
>  		OK=1
>  	fi
> +	if [ "${UNDEF:0:10}" = "_savegpr0_" ]; then
> +		OK=1
> +	fi
>  	if [ "${UNDEF:0:11}" = "_save32gpr_" ]; then
>  		OK=1
>  	fi
> -- 
> 1.7.1
>
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

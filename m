Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B84AFB7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Sep 2009 11:50:13 +1000 (EST)
Subject: Re: [PATCH] fix ppc64 build failure on fedora
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle McMartin <kyle@mcmartin.ca>
In-Reply-To: <20090917174144.GA11961@bombadil.infradead.org>
References: <20090917174144.GA11961@bombadil.infradead.org>
Content-Type: text/plain
Date: Fri, 18 Sep 2009 11:50:06 +1000
Message-Id: <1253238606.4932.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-17 at 13:41 -0400, Kyle McMartin wrote:
> From: Kyle McMartin <kyle@redhat.com>
> 
> For some reason or another (newer gcc?) on Fedora 12 koji builders we're
> seeing _restgpr0_$n symbols instead of _restgpr_$n as handled in the
> prom_init_check.sh file:
> Checking prom_init.o symbol '_restgpr0_14'
> Error: External symbol '_restgpr0_14' referenced from prom_init.c
> Checking prom_init.o symbol '_restgpr0_17'
> 
> Add cases to handle this to the filter portion of the script.

My concern tho is if one of thse is actually called ... we implement
them in arch/powerpc/lib/crtsaveres.S but with the "other" names..

Ben.

> Signed-off-by: Kyle McMartin <kyle@redhat.com>
> ---
> 
> diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
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
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

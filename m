Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B7A867A3E
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 07:08:43 +1000 (EST)
Subject: Re: [PATCH] Fix pSeries identification in prom_init.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20060515161810.E633C679EB@ozlabs.org>
References: <1147671963.21291.91.camel@localhost.localdomain>
	<1147672282.21291.92.camel@localhost.localdomain>
	<20060515161810.E633C679EB@ozlabs.org>
Content-Type: text/plain
Date: Tue, 16 May 2006 07:08:27 +1000
Message-Id: <1147727308.20301.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, segher@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> To be safe if we are returned a non terminated string.  I'd not realised
> the case you've mentioned.
> 
> How much we should trust firmware?  With strcpy, should we explicitly
> terminate the string first (I removed one of these originally)?  Patch
> below, compiled not run.

I wouldn't bother. If it returns a non-terminated string there, a lot of
stuff will break anyway including the kernel probe code

Ben.

> The OF trampoline code prom_init.c still needs to identify IBM pSeries
> (PAPR) machines in order to run some platform specific code on them like
> instantiating the TCE tables. The code doing that detection was changed
> recently in 2.6.17 early stages but was done slightly incorrectly. It
> should be testing for an exact match of "chrp" and it currently tests
> for anything that begins with "chrp". That means it will incorrectly
> match with platforms using Maple-like device-trees and have open
> firmware. This fixes it by using strcmp instead of strncmp to match what
> the actual platform detection code does.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> 
>  arch/powerpc/kernel/prom_init.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6-powerpc/arch/powerpc/kernel/prom_init.c
> ===================================================================
> --- linux-2.6-powerpc.orig/arch/powerpc/kernel/prom_init.c
> +++ linux-2.6-powerpc/arch/powerpc/kernel/prom_init.c
> @@ -1636,7 +1636,8 @@ static int __init prom_find_machine_type
>  			   compat, sizeof(compat)-1);
>  	if (len <= 0)
>  		return PLATFORM_GENERIC;
> -	if (strncmp(compat, RELOC("chrp"), 4))
> +	compat[len] = 0;
> +	if (strcmp(compat, RELOC("chrp")))
>  		return PLATFORM_GENERIC;
>  
>  	/* Default to pSeries. We need to know if we are running LPAR */
> 

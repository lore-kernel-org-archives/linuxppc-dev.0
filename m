Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE1EA679E6
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 19:55:50 +1000 (EST)
From: segher@gate.crashing.org
Message-ID: <10745.195.212.29.163.1147686686.squirrel@gate.crashing.org>
Date: Mon, 15 May 2006 04:51:26 -0500 (CDT)
Subject: Re: [PATCH] Fix pSeries identification in prom_init.c
To: <benh@kernel.crashing.org>
In-Reply-To: <1147671963.21291.91.camel@localhost.localdomain>
References: <1147671963.21291.91.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> Paul, if you are happy with that, please send upsteam ASAP.
>
> Index: linux-work/arch/powerpc/kernel/prom_init.c
> =================================================================== ---
> linux-work.orig/arch/powerpc/kernel/prom_init.c	2006-05-02
> 10:51:33.000000000 +1000 +++
> linux-work/arch/powerpc/kernel/prom_init.c	2006-05-15 15:37:03.000000000
> +1000 @@ -1636,7 +1636,7 @@
>  			   compat, sizeof(compat)-1);
>  	if (len <= 0)
>  		return PLATFORM_GENERIC;
> -	if (strncmp(compat, RELOC("chrp"), 4))
> +	if (strcmp(compat, RELOC("chrp")))
>  		return PLATFORM_GENERIC;
>
>  	/* Default to pSeries. We need to know if we are running LPAR */

Confirmed it works correctly on affected systems.  Thanks Ben.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

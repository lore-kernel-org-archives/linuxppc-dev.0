Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3AF0DDED8
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 21:44:10 +1100 (EST)
Subject: Re: [PATCH 1/2] Implement of_flat_dt_search() and use it for
	of_flat_dt_is_compatible.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <63cdefde19cb2a4adc17ed771f21261673428ce7.1205987625.git.tony@bakeyournoodle.com>
References: <63cdefde19cb2a4adc17ed771f21261673428ce7.1205987625.git.tony@bakeyournoodle.com>
Content-Type: text/plain
Date: Thu, 20 Mar 2008 20:41:00 +1100
Message-Id: <1206006060.8420.5.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Jan-Bernd Themann <themann@de.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-03-20 at 15:33 +1100, Tony Breeds wrote:
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---

What about a comment ? :-)

>  arch/powerpc/kernel/prom.c |   21 ++++++++++++++-------
>  include/asm-powerpc/prom.h |    2 ++
>  2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index eac97f4..f73e18b 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -205,25 +205,32 @@ void* __init of_get_flat_dt_prop(unsigned long node, const char *name,
>  	} while(1);
>  }
>  
> -int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
> +int __init of_flat_dt_search(unsigned long node, const char *str,
> +                             const char *prop_name)
>  {
> -	const char* cp;
> -	unsigned long cplen, l;
> +	const char *cp;
> +	unsigned long plen, l;
>  
> -	cp = of_get_flat_dt_prop(node, "compatible", &cplen);
> +	cp = of_get_flat_dt_prop(node, prop_name, &plen);
>  	if (cp == NULL)
>  		return 0;
> -	while (cplen > 0) {
> -		if (strncasecmp(cp, compat, strlen(compat)) == 0)
> +	while (plen > 0) {
> +		if (strncasecmp(cp, str, strlen(str)) == 0)
>  			return 1;
>  		l = strlen(cp) + 1;
>  		cp += l;
> -		cplen -= l;
> +		plen -= l;
>  	}
>  
>  	return 0;
>  }
>  
> +int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
> +{
> +
> +	return of_flat_dt_search(node, compat, "compatible");
> +}
> +
>  static void *__init unflatten_dt_alloc(unsigned long *mem, unsigned long size,
>  				       unsigned long align)
>  {
> diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
> index 78b7b0d..7b587f1 100644
> --- a/include/asm-powerpc/prom.h
> +++ b/include/asm-powerpc/prom.h
> @@ -134,6 +134,8 @@ extern int __init of_scan_flat_dt(int (*it)(unsigned long node,
>  				  void *data);
>  extern void* __init of_get_flat_dt_prop(unsigned long node, const char *name,
>  					unsigned long *size);
> +extern int __init of_flat_dt_search(unsigned long node, const char *str,
> +                                  const char *prop_name);
>  extern int __init of_flat_dt_is_compatible(unsigned long node, const char *name);
>  extern unsigned long __init of_get_flat_dt_root(void);
>  

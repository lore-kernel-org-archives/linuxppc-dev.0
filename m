Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50A3167CA5
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 02:38:05 +1100 (EST)
In-Reply-To: <Pine.LNX.4.62.0612071627400.16653@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0612071627400.16653@pademelon.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <F5EB4110-C3A8-4C7F-98AE-9096A12482B6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] of_platform_make_bus_id(): kill compiler warning
Date: Thu, 7 Dec 2006 09:36:57 -0600
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 7, 2006, at 9:29 AM, Geert Uytterhoeven wrote:

>
> of_platform_make_bus_id(): Kill a compiler warning which is a real =20
> bug on
> PPC64: format =91%d=92 expects type =91int=92, but argument 5 has type =
=20
> =91long int=92
>
> Signed-Off-By: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

I think its better to change magic to type int.  atomic_add_return is =20=

going to return an int so magic this %ld on ppc32 has to value.

- k

> Index: ps3-linux-src/arch/powerpc/kernel/of_platform.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ps3-linux-src.orig/arch/powerpc/kernel/of_platform.c	=
2006-12-05 =20
> 11:16:13.000000000 +0100
> +++ ps3-linux-src/arch/powerpc/kernel/of_platform.c	2006-12-07 =20
> 16:24:26.000000000 +0100
> @@ -212,7 +212,7 @@ static void of_platform_make_bus_id(stru
>  	 * counter (and pray...)
>  	 */
>  	magic =3D atomic_add_return(1, &bus_no_reg_magic);
> -	snprintf(name, BUS_ID_SIZE, "%s.%d", node->name, magic - 1);
> +	snprintf(name, BUS_ID_SIZE, "%s.%ld", node->name, magic - 1);
>  }
>
>  struct of_device* of_platform_device_create(struct device_node *np,
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- Sony Network and Software Technology Center =20
> Europe (NSCE)
> Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da =20
> Vincilaan 7-D1
> Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 =20
> Zaventem, Belgium_______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-=20
> dev_______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

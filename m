Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71991DDE42
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 01:26:29 +1000 (EST)
Subject: Re: [PATCH] powerpc timer sysdev: use mktime
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1178115942.13233.61.camel@johannes.berg>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>
	<1169620444.18754.66.camel@localhost.localdomain>
	<1170357390.4036.9.camel@johannes.berg>
	<17976.5964.593278.752595@cargo.ozlabs.ibm.com>
	<1178115942.13233.61.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rsTNwzTv+6E48vnoI+wc"
Date: Wed, 23 May 2007 17:28:01 +0200
Message-Id: <1179934081.14317.29.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-rsTNwzTv+6E48vnoI+wc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 16:25 +0200, Johannes Berg wrote:
> This patch makes the timer sysdev use mktime instead of rtc_tm_to_time
> by simply copying the function to avoid using rtc-lib.

I think you asked for this, any reason you then didn't take it? Just
missed? Or is something wrong with it?

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
>=20
> --- wireless-dev.orig/arch/powerpc/sysdev/timer.c	2007-05-02 16:16:52.639=
177080 +0200
> +++ wireless-dev/arch/powerpc/sysdev/timer.c	2007-05-02 16:21:56.42917708=
0 +0200
> @@ -24,7 +24,12 @@ static int timer_resume(struct sys_devic
> =20
>  	/* get current RTC time and convert to seconds */
>  	get_rtc_time(&cur_rtc_tm);
> -	rtc_tm_to_time(&cur_rtc_tm, &cur_rtc_time);
> +	cur_rtc_time =3D mktime(cur_rtc_tm.tm_year + 1900,
> +			      cur_rtc_tm.tm_mon + 1,
> +			      cur_rtc_tm.tm_mday,
> +			      cur_rtc_tm.tm_hour,
> +			      cur_rtc_tm.tm_min,
> +			      cur_rtc_tm.tm_sec);
> =20
>  	diff =3D cur_rtc_time - suspend_rtc_time;
> =20
> @@ -44,7 +49,12 @@ static int timer_suspend(struct sys_devi
>  	WARN_ON(!ppc_md.get_rtc_time);
> =20
>  	get_rtc_time(&suspend_rtc_tm);
> -	rtc_tm_to_time(&suspend_rtc_tm, &suspend_rtc_time);
> +	suspend_rtc_time =3D mktime(suspend_rtc_tm.tm_year + 1900,
> +				  suspend_rtc_tm.tm_mon + 1,
> +				  suspend_rtc_tm.tm_mday,
> +				  suspend_rtc_tm.tm_hour,
> +				  suspend_rtc_tm.tm_min,
> +				  suspend_rtc_tm.tm_sec);
> =20
>  	return 0;
>  }
> --- wireless-dev.orig/arch/powerpc/Kconfig	2007-05-02 16:22:07.619177080 =
+0200
> +++ wireless-dev/arch/powerpc/Kconfig	2007-05-02 16:22:12.759177080 +0200
> @@ -11,11 +11,6 @@ config PPC64
>  	  This option selects whether a 32-bit or a 64-bit kernel
>  	  will be built.
> =20
> -config PPC_PM_NEEDS_RTC_LIB
> -	bool
> -	select RTC_LIB
> -	default y if PM
> -
>  config PPC32
>  	bool
>  	default y if !PPC64
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20

--=-rsTNwzTv+6E48vnoI+wc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGVF2B/ETPhpq3jKURAku5AJ4zAs+kdZlQ7G6Fq6jYdf3dNiKiugCdEH0L
wXr1K8nbeSHPpwB2x1UZDIk=
=joDr
-----END PGP SIGNATURE-----

--=-rsTNwzTv+6E48vnoI+wc--

Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A650E67F1A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Nov 2006 08:45:51 +1100 (EST)
Date: Sat, 11 Nov 2006 00:15:27 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: hs@denx.de
Subject: Re: Compile Error using SMC1 on a MPC8272 for 2.6.19-rc4
Message-ID: <20061111001527.1274c7f4@localhost.localdomain>
In-Reply-To: <1163159594.6319.56.camel@Zeus.EmbLux>
References: <1163159594.6319.56.camel@Zeus.EmbLux>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_UaXCV3O7EWp7iif.sdrx2d4;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_UaXCV3O7EWp7iif.sdrx2d4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Nov 2006 12:53:14 +0100
Heiko Schocher wrote:

> Hello,
>=20
> I tried to compile the Linux Kernel 2.6.19-rc5 with a MPC8272 CPU and
> a console on SMC1, and get the following Compile Error:
>=20
>   CC      drivers/serial/cpm_uart/cpm_uart_cpm2.o
> drivers/serial/cpm_uart/cpm_uart_cpm2.c: In function
> 'cpm_uart_init_portdesc':
> drivers/serial/cpm_uart/cpm_uart_cpm2.c:364: warning: assignment makes
> integer from pointer without a cast
> drivers/serial/cpm_uart/cpm_uart_cpm2.c:368: error: invalid type
> argument of 'unary *'
> make[3]: *** [drivers/serial/cpm_uart/cpm_uart_cpm2.o] Error 1
> make[2]: *** [drivers/serial/cpm_uart] Error 2
> make[1]: *** [drivers/serial] Error 2
> make: *** [drivers] Error 2
>=20
> The following Code solves the problem:
>=20
> diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> index 0599030..bb0a6c1 100644
> --- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> @@ -349,7 +349,7 @@ void cpm_uart_freebuf(struct uart_cpm_po
>  int cpm_uart_init_portdesc(void)
>  {
>  #if defined(CONFIG_SERIAL_CPM_SMC1) ||
> defined(CONFIG_SERIAL_CPM_SMC2)
> -	u32 addr;
> +	u32 *addr;
>  #endif
>  	pr_debug("CPM uart[-]:init portdesc\n");
> =20
Yes, but that is not the only issue. I am working on that.

Thanks,

-Vitaly

--Sig_UaXCV3O7EWp7iif.sdrx2d4
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFVOvvuOg9JvQhSEsRAu0KAJ4z4B2gfQWVmdgpf4TX43CHFULNUgCfSGgS
8PwKUHqcTOvq9sFaInxU6GI=
=k29K
-----END PGP SIGNATURE-----

--Sig_UaXCV3O7EWp7iif.sdrx2d4--

Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9223167B89
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 05:28:09 +1000 (EST)
Date: Thu, 19 Oct 2006 23:28:03 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: kalle.pokki@iki.fi
Subject: Re: [PATCH] CPM_UART: Fix non-console transmit
Message-ID: <20061019232803.6f28ca85@localhost.localdomain>
In-Reply-To: <Pine.OSF.4.61.0610191519020.318096@kosh.hut.fi>
References: <Pine.OSF.4.61.0610191519020.318096@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_7KQbBuxYK=9nQE_/0IJ4ZU=";
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

--Sig_7KQbBuxYK=9nQE_/0IJ4ZU=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Oct 2006 15:25:55 +0300 (EEST)
kalle.pokki@iki.fi wrote:

> The SMC and SCC hardware transmitter is enabled at the wrong
> place. Simply writing twice to the non-console port, like
>=20
> $ echo asdf > /dev/ttyCPM1
> $ echo asdf > /dev/ttyCPM1
>=20
> puts the shell into endless uninterruptible sleep, since the
> transmitter is stopped after the first write, and is not enabled
> before the shutdown function of the second write. Thus the transmit
> buffers are never emptied.
>=20
Was about to Ack, but... need one more glance at it on hw.=20
I recall something that might be reason of the current implementation,
but had no chance to recover the details.

Thanks for the input. I'll follow-up tomorrow.

> Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
> ---
>   drivers/serial/cpm_uart/cpm_uart_core.c |    5 ++---
>   1 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c
> b/drivers/serial/cpm_uart/cpm_uart_core.c index 90ff96e..8f3b3e5
> 100644 --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> @@ -194,10 +194,8 @@ static void cpm_uart_start_tx(struct uar
>   	if (cpm_uart_tx_pump(port) !=3D 0) {
>   		if (IS_SMC(pinfo)) {
>   			smcp->smc_smcm |=3D SMCM_TX;
> -			smcp->smc_smcmr |=3D SMCMR_TEN;
>   		} else {
>   			sccp->scc_sccm |=3D UART_SCCM_TX;
> -			pinfo->sccp->scc_gsmrl |=3D SCC_GSMRL_ENT;
>   		}
>   	}
>   }
> @@ -420,9 +418,10 @@ static int cpm_uart_startup(struct uart_
>   	/* Startup rx-int */
>   	if (IS_SMC(pinfo)) {
>   		pinfo->smcp->smc_smcm |=3D SMCM_RX;
> -		pinfo->smcp->smc_smcmr |=3D SMCMR_REN;
> +		pinfo->smcp->smc_smcmr |=3D (SMCMR_REN | SMCMR_TEN);
>   	} else {
>   		pinfo->sccp->scc_sccm |=3D UART_SCCM_RX;
> +		pinfo->sccp->scc_gsmrl |=3D (SCC_GSMRL_ENR |
> SCC_GSMRL_ENT); }
>=20
>   	if (!(pinfo->flags & FLAG_CONSOLE))

--Sig_7KQbBuxYK=9nQE_/0IJ4ZU=
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFN9HDuOg9JvQhSEsRAttdAJ4t3HsV/UAPHe1wji7ofjeXDL7iRgCdGObV
K6tgyZAtG6/HfKpVQLnH0fs=
=PXvY
-----END PGP SIGNATURE-----

--Sig_7KQbBuxYK=9nQE_/0IJ4ZU=--

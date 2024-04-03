Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E33C6FD1F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2024 05:15:54 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ePzR1yDU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V8Xyd3fq3z3cWN
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2024 16:15:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ePzR1yDU;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V8Xxp5hJTz30dn
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2024 16:15:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712121305;
	bh=5J/vLQrpGhgqQsZ80PIigutoMIakBJ7aJJ3MmitBdiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ePzR1yDUO9Ongm+ac85mPhRRna7nfIhqLmj6fcYtsfm/+VsT2swGklamXED769K86
	 +O2uDG2SxnIrqf1h3rKHWnvKUeGaljSokCgXKVkSE2sRjr5pDFQnYuri0p2Nr5NANy
	 KHQdBzAVt+06DJ5eCBlUMps59rQQIiGKnixdoUelOTpLyE0DaSnpC1tYMsta+zbqpF
	 f+ZPITtVqkgllb04gGzxYatpkuyG0At88rpzIhcFPR2XYLp2vu188YGM2ZI9vT6hCC
	 WH+jNN8xeMetg9wYgTknycTmi/+w6/KwqvIXQwIYERRlFdwZjr2+vFm3pq1RV7O964
	 ymrcVWrFO11rg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V8Xxg6QZqz4wcg;
	Wed,  3 Apr 2024 16:15:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Greg
 Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Dawei Li
 <set_pte_at@outlook.com>, Damien Le Moal
 <damien.lemoal@opensource.wdc.com>, Jakub Kicinski <kuba@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] serial: pmac_zilog: Drop usage of platform_driver_probe()
In-Reply-To: <5ea3174616abc9fa256f115b4fb175d289ac1754.1711748999.git.u.kleine-koenig@pengutronix.de>
References: <2e3783106bf6bd9a7bdeb12b706378fb16316471.1711748999.git.u.kleine-koenig@pengutronix.de>
 <5ea3174616abc9fa256f115b4fb175d289ac1754.1711748999.git.u.kleine-koenig@pengutronix.de>
Date: Wed, 03 Apr 2024 16:15:01 +1100
Message-ID: <877chf81t6.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kernel@pengutronix.de, linux-kbuild@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, linux-serial@vger.kernel.org, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
> There are considerations to drop platform_driver_probe() as a concept
> that isn't relevant any more today. It comes with an added complexity
> that makes many users hold it wrong. (E.g. this driver should have
> marked the driver struct with __refdata to prevent the below mentioned
> false positive section mismatch warning.)
>
> This fixes a W=3D1 build warning:
>
> 	WARNING: modpost: drivers/tty/serial/pmac_zilog: section mismatch in ref=
erence: pmz_driver+0x8 (section: .data) -> pmz_detach (section: .exit.text)
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/pmac_zilog.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

I gave it a quick spin in qemu, no issues.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zi=
log.c
> index 05d97e89511e..e44621218248 100644
> --- a/drivers/tty/serial/pmac_zilog.c
> +++ b/drivers/tty/serial/pmac_zilog.c
> @@ -1695,7 +1695,7 @@ static void pmz_dispose_port(struct uart_pmac_port =
*uap)
>  	memset(uap, 0, sizeof(struct uart_pmac_port));
>  }
>=20=20
> -static int __init pmz_attach(struct platform_device *pdev)
> +static int pmz_attach(struct platform_device *pdev)
>  {
>  	struct uart_pmac_port *uap;
>  	int i;
> @@ -1714,7 +1714,7 @@ static int __init pmz_attach(struct platform_device=
 *pdev)
>  	return uart_add_one_port(&pmz_uart_reg, &uap->port);
>  }
>=20=20
> -static void __exit pmz_detach(struct platform_device *pdev)
> +static void pmz_detach(struct platform_device *pdev)
>  {
>  	struct uart_pmac_port *uap =3D platform_get_drvdata(pdev);
>=20=20
> @@ -1789,7 +1789,8 @@ static struct macio_driver pmz_driver =3D {
>  #else
>=20=20
>  static struct platform_driver pmz_driver =3D {
> -	.remove_new	=3D __exit_p(pmz_detach),
> +	.probe		=3D pmz_attach,
> +	.remove_new	=3D pmz_detach,
>  	.driver		=3D {
>  		.name		=3D "scc",
>  	},
> @@ -1837,7 +1838,7 @@ static int __init init_pmz(void)
>  #ifdef CONFIG_PPC_PMAC
>  	return macio_register_driver(&pmz_driver);
>  #else
> -	return platform_driver_probe(&pmz_driver, pmz_attach);
> +	return platform_driver_register(&pmz_driver);
>  #endif
>  }
>=20=20
> base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
> --=20
> 2.43.0

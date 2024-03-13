Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2EAC54E68
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2024 23:06:38 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=imUlJR18;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tw5jm4kC1z3dVS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2024 10:06:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=imUlJR18;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tw5hm5zrGz30h5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2024 10:05:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710371140;
	bh=gp+TnZi1grjtsA+tY43oV2ZNvLXf735UomqNNCGEsHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=imUlJR18pGUI7/j0FzyNCKnwUcxTkbKRk4oT3d98U6C0YIHQ8LLHKCGNS2yisGQ6G
	 giZE7D+niajnn/tK2YkOIeU0xSDevUhVcYf4fKXs9WA9wYo/rFJ/AAjFFUs0P/AK6f
	 cGW4jhSdNJ25F7KApb2F6w5G8Qu9aAzy6tn8uxjqm3nxTUoysHPiq0yjRNLz/s5leo
	 KK3tFHTrrj9iGDE58urYNTfS5FcRK1mCl4cCM34ZuuS0tuQvfb9dDfpk5H14z2pZ3+
	 DOaRpUWDD4Ug1CF1qJ3JaHATAzTJkcCziyq1lnX0/VMWGorhMPtpFakQDJXZC+xMn2
	 CA8mjUFkVOSZw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tw5hd5tS2z4wcT;
	Thu, 14 Mar 2024 10:05:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Herve Codina <herve.codina@bootlin.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Herve Codina <herve.codina@bootlin.com>, Yury
 Norov <yury.norov@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v7 1/5] net: wan: Add support for QMC HDLC
In-Reply-To: <20240307113909.227375-2-herve.codina@bootlin.com>
References: <20240307113909.227375-1-herve.codina@bootlin.com>
 <20240307113909.227375-2-herve.codina@bootlin.com>
Date: Thu, 14 Mar 2024 10:05:37 +1100
Message-ID: <87ttl93f7i.fsf@mail.lhotse>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Herve,

Herve Codina <herve.codina@bootlin.com> writes:
> The QMC HDLC driver provides support for HDLC using the QMC (QUICC
> Multichannel Controller) to transfer the HDLC data.
...
>=20=20
> diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdl=
c.c
> new file mode 100644
> index 000000000000..5fd7ed325f5b
> --- /dev/null
> +++ b/drivers/net/wan/fsl_qmc_hdlc.c
> @@ -0,0 +1,419 @@
...
> +static int qmc_hdlc_remove(struct platform_device *pdev)
> +{
> +	struct qmc_hdlc *qmc_hdlc =3D platform_get_drvdata(pdev);
> +
> +	unregister_hdlc_device(qmc_hdlc->netdev);
> +	free_netdev(qmc_hdlc->netdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qmc_hdlc_id_table[] =3D {
> +	{ .compatible =3D "fsl,qmc-hdlc" },
> +	{} /* sentinel */
> +};
> +MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);

This breaks when building as a module (eg. ppc32_allmodconfig):

  In file included from ../include/linux/device/driver.h:21,
                   from ../include/linux/device.h:32,
                   from ../include/linux/dma-mapping.h:8,
                   from ../drivers/net/wan/fsl_qmc_hdlc.c:13:
  ../drivers/net/wan/fsl_qmc_hdlc.c:405:25: error: =E2=80=98qmc_hdlc_driver=
=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98qmc_hd=
lc_probe=E2=80=99?
    405 | MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);
        |                         ^~~~~~~~~~~~~~~


IIUIC it should be pointing to the table, not the driver, so:

diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
index 5fd7ed325f5b..705c3681fb92 100644
--- a/drivers/net/wan/fsl_qmc_hdlc.c
+++ b/drivers/net/wan/fsl_qmc_hdlc.c
@@ -402,7 +402,7 @@ static const struct of_device_id qmc_hdlc_id_table[] =
=3D {
        { .compatible =3D "fsl,qmc-hdlc" },
        {} /* sentinel */
 };
-MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);
+MODULE_DEVICE_TABLE(of, qmc_hdlc_id_table);

 static struct platform_driver qmc_hdlc_driver =3D {
        .driver =3D {


Which then builds correctly.

cheers

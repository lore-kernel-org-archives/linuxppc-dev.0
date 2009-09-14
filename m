Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0D2B1B7B6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 04:37:51 +1000 (EST)
Received: from mail-yx0-f187.google.com (mail-yx0-f187.google.com
	[209.85.210.187]) by ozlabs.org (Postfix) with ESMTP id 4B3A7DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 04:37:49 +1000 (EST)
Received: by yxe17 with SMTP id 17so4142879yxe.9
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 11:37:48 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090914181617.ACF4B17B804F@mail59-sin.bigfish.com>
References: <20090914181617.ACF4B17B804F@mail59-sin.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 14 Sep 2009 12:37:28 -0600
Message-ID: <fa686aa40909141137h214036b2m1ad0b570001e0f05@mail.gmail.com>
Subject: Re: [PATCH] Xilinx: SPI: Fix bits_per_word for transfers
To: John Linn <john.linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, akonovalov@ru.mvista.com,
	dbrownell@users.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 14, 2009 at 12:17 PM, John Linn <john.linn@xilinx.com> wrote:
> The bits_per_word value can be set for each transfer, or can
> be set to zero in each transfer in which case it should default
> to the value in the driver.
>
> The driver was fixed to properly check the bits_per_word in
> the transfer that is passed in.
>
> Signed-off-by: John Linn <john.linn@xilinx.com>

Looks good to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0drivers/spi/xilinx_spi.c | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> index 46b8c5c..5a143b9 100644
> --- a/drivers/spi/xilinx_spi.c
> +++ b/drivers/spi/xilinx_spi.c
> @@ -148,7 +148,8 @@ static int xilinx_spi_setup_transfer(struct spi_devic=
e *spi,
> =A0{
> =A0 =A0 =A0 =A0u8 bits_per_word;
>
> - =A0 =A0 =A0 bits_per_word =3D (t) ? t->bits_per_word : spi->bits_per_wo=
rd;
> + =A0 =A0 =A0 bits_per_word =3D (t && t->bits_per_word)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0? t->bits_per_word : spi=
->bits_per_word;
> =A0 =A0 =A0 =A0if (bits_per_word !=3D 8) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&spi->dev, "%s, unsupported bits_p=
er_word=3D%d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, bits_per_word);
> --
> 1.6.2.1
>
>
>
> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

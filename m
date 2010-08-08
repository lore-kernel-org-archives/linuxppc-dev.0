Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) by ozlabs.org (Postfix) with ESMTP id 5E1B4B6EDF
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 01:03:01 +1000 (EST)
Received: by ywi6 with SMTP id 6so5660450ywi.15
	for <linuxppc-dev@ozlabs.org>; Sun, 08 Aug 2010 08:03:00 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100808141422.GA9670@oksana.dev.rtsoft.ru>
References: <20100808141422.GA9670@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 8 Aug 2010 09:02:40 -0600
Message-ID: <AANLkTin3pWr02GytxH=c7Z=HGocc0kDJu=tfWR_7PzU3@mail.gmail.com>
Subject: Re: [PATCH] mmc_spi: Fix unterminated of_match_table
To: Anton Vorontsov <avorontsov@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 8, 2010 at 8:14 AM, Anton Vorontsov <avorontsov@mvista.com> wro=
te:
> commit 2ffe8c5f323c3b9749bf7bc2375d909d20bdbb15 ("of: refactor
> of_modalias_node() and remove explicit match table"), introduced
> an unterminated of_match_table, which may cause kernel to oops.
>
> This patch fixes the issue by adding an empty device ID.
>
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>

Thanks Anton.  Merged into my next-devicetree branch.

g.

> ---
> =A0drivers/mmc/host/mmc_spi.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 7b0f3ef..1145ea0 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1536,6 +1536,7 @@ static int __devexit mmc_spi_remove(struct spi_devi=
ce *spi)
> =A0#if defined(CONFIG_OF)
> =A0static struct of_device_id mmc_spi_of_match_table[] __devinitdata =3D =
{
> =A0 =A0 =A0 =A0{ .compatible =3D "mmc-spi-slot", },
> + =A0 =A0 =A0 {},
> =A0};
> =A0#endif
>
> --
> 1.7.0.5
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

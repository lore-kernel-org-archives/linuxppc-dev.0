Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DA29F2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 12:40:39 +1000 (EST)
Message-ID: <1346812817.2257.23.camel@pasglop>
Subject: Re: [PATCH 13/25] macintosh/mediabay: add a const qualifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Wed, 05 Sep 2012 12:40:17 +1000
In-Reply-To: <1343034810-3386-14-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-14-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>,
 kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-23 at 11:13 +0200, Uwe Kleine-König wrote:
> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
> 
> 	drivers/macintosh/mediabay.c: In function 'media_bay_attach':
> 	drivers/macintosh/mediabay.c:589:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Ack all of these assuming you test built (I didn't). Do you need me to
carry any of this via the powerpc tree ?

Cheers,
Ben.

>  drivers/macintosh/mediabay.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
> index 831d751..54bf584 100644
> --- a/drivers/macintosh/mediabay.c
> +++ b/drivers/macintosh/mediabay.c
> @@ -63,7 +63,7 @@ struct media_bay_info {
>  	int				value_count;
>  	int				timer;
>  	struct macio_dev		*mdev;
> -	struct mb_ops*			ops;
> +	const struct mb_ops*		ops;
>  	int				index;
>  	int				cached_gpio;
>  	int				sleeping;

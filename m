Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (s3.sipsolutions.net [5.9.151.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKJ7n20ZnzDrcZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 06:00:21 +1000 (AEST)
Message-ID: <1472067803.5143.20.camel@sipsolutions.net>
Subject: Re: [PATCH] ALSA: snd-aoa: enable sound on PowerBook G4 12"
From: Johannes Berg <johannes@sipsolutions.net>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Date: Wed, 24 Aug 2016 21:43:23 +0200
In-Reply-To: <20160824175747.31180-1-aaro.koskinen@iki.fi>
References: <20160824175747.31180-1-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-24 at 20:57 +0300, Aaro Koskinen wrote:
> Enable sound on PowerBook G4 12".

Looks good to me, I assume you tested it and it works :)

johannes

> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  sound/aoa/fabrics/layout.c       | 8 ++++++++
>  sound/aoa/soundbus/i2sbus/core.c | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
> index 8f71f7e..edc8681 100644
> --- a/sound/aoa/fabrics/layout.c
> +++ b/sound/aoa/fabrics/layout.c
> @@ -112,6 +112,7 @@ MODULE_ALIAS("sound-layout-100");
>  
>  MODULE_ALIAS("aoa-device-id-14");
>  MODULE_ALIAS("aoa-device-id-22");
> +MODULE_ALIAS("aoa-device-id-31");
>  MODULE_ALIAS("aoa-device-id-35");
>  MODULE_ALIAS("aoa-device-id-44");
>  
> @@ -362,6 +363,13 @@ static struct layout layouts[] = {
>  		.connections = tas_connections_nolineout,
>  	  },
>  	},
> +	/* PowerBook6,1 */
> +	{ .device_id = 31,
> +	  .codecs[0] = {
> +		.name = "tas",
> +		.connections = tas_connections_nolineout,
> +	  },
> +	},
>  	/* PowerBook6,5 */
>  	{ .device_id = 44,
>  	  .codecs[0] = {
> diff --git a/sound/aoa/soundbus/i2sbus/core.c
> b/sound/aoa/soundbus/i2sbus/core.c
> index 1cbf210..000b585 100644
> --- a/sound/aoa/soundbus/i2sbus/core.c
> +++ b/sound/aoa/soundbus/i2sbus/core.c
> @@ -197,7 +197,7 @@ static int i2sbus_add_dev(struct macio_dev
> *macio,
>  			 * so restrict to those we do handle for
> now.
>  			 */
>  			if (id && (*id == 22 || *id == 14 || *id ==
> 35 ||
> -				   *id == 44)) {
> +				   *id == 31 || *id == 44)) {
>  				snprintf(dev->sound.modalias, 32,
>  					 "aoa-device-id-%d", *id);
>  				ok = 1;

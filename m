Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 21D362C016B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 07:14:26 +1100 (EST)
Message-ID: <1381349653.7979.366.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/3] gianfar: Use mpc85xx support for errata detection
From: Scott Wood <scottwood@freescale.com>
To: Claudiu Manoil <claudiu.manoil@freescale.com>
Date: Wed, 9 Oct 2013 15:14:13 -0500
In-Reply-To: <1381339242-32030-2-git-send-email-claudiu.manoil@freescale.com>
References: <1381339242-32030-1-git-send-email-claudiu.manoil@freescale.com>
 <1381339242-32030-2-git-send-email-claudiu.manoil@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-09 at 20:20 +0300, Claudiu Manoil wrote:
> +static void gfar_detect_errata(struct gfar_private *priv)
> +{
> +	struct device *dev = &priv->ofdev->dev;
> +
> +	/* no plans to fix */
> +	priv->errata |= GFAR_ERRATA_A002;
> +
> +	if (pvr_version_is(PVR_VER_E500V1) || pvr_version_is(PVR_VER_E500V2))
> +		__gfar_detect_errata_85xx(priv);
> +	else /* non-mpc85xx parts, i.e. e300 core based */
> +		__gfar_detect_errata_83xx(priv);

It would be better to use CONFIG_E500 here (note that we do not support
building e500 and 83xx/86xx in the same kernel), on the off chance that
we put a gianfar in a chip with a newer e500 derivative.  I suppose it's
harmless as long as the 83xx version checks the full PVR, until such a
chip exists and has an erratum workaround (other than A002) added for
it.

What about 86xx?  Are there any gianfar errata there besides A002?

-Scott

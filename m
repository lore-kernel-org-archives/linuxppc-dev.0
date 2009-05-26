Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 67D89DE10D
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 00:10:09 +1000 (EST)
Message-ID: <4A1BF827.6010409@freescale.com>
Date: Tue, 26 May 2009 09:09:43 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V5 3/5] AC97 driver for mpc5200
References: <20090526123235.17472.73912.stgit@terra>
	<20090526123410.17472.15251.stgit@terra>
In-Reply-To: <20090526123410.17472.15251.stgit@terra>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> +static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
> +{
> +	int rc;
> +	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
> +
> +	out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_AWR);
> +	spin_event_timeout(0, 3, 0, rc);

I still think you should use udelay() here.  spin_event_timeout(<constant>) will just reduce to a udelay() call anyway.  In addition, there's no "event" that you're waiting for.

-- 
Timur Tabi
Linux kernel developer at Freescale

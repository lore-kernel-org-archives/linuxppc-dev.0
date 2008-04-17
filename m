Return-Path: <neko@genesi-usa.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.176])
	by ozlabs.org (Postfix) with ESMTP id 00FB7DE1ED
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:10:12 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id b32so33937ika.1
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 08:10:10 -0700 (PDT)
Message-ID: <4807684C.4000508@genesi-usa.com>
Date: Thu, 17 Apr 2008 16:10:04 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: RFC: MPC5200 PSC AC97 driver
References: <47FDEF9B.5000506@semihalf.com>	<200804151003.17865.jbe@pengutronix.de>	<200804161324.15887.jbe@pengutronix.de>
	<200804171619.56615.jbe@pengutronix.de>
In-Reply-To: <200804171619.56615.jbe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Juergen Beisert wrote:
> Hi,
> +	/* the fifo starts right after psc ends */
> +	priv->fifo = (struct mpc52xx_psc_fifo*)&priv->psc[1];	/* FIXME */

Wouldn't

	priv->fifo = (struct mpc52xx_psc_fifo*) (priv->psc + sizeof(struct mpc52xx_psc));

Be a little less obtuse use of C?

I just added 0x58 and gave it a pretty define in my version (PSC_FIFO_OFFSET or
something). I guess that was lame since the structure might change size in some
other dimension, but I don't think there is any smart way to do it... the 5121E
stuff really stomped on the way the device tree should be organised for the 5200B.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

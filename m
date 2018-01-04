Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x232.google.com (mail-pl0-x232.google.com
 [IPv6:2607:f8b0:400e:c01::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCKrz4NXNzDqls
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 07:58:27 +1100 (AEDT)
Received: by mail-pl0-x232.google.com with SMTP id b12so1738206plm.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jan 2018 12:58:27 -0800 (PST)
Date: Thu, 4 Jan 2018 12:58:36 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: Re: [PATCH v1 11/15] ASoC: fsl_ssi: Setup AC97 in dai_probe()
Message-ID: <20180104205834.GA8729@Asurada-Nvidia>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-12-git-send-email-nicoleotsuka@gmail.com>
 <b8e41d81-948a-fbac-af75-3e31c3382426@maciej.szmigiero.name>
 <20180104190732.GA27975@Asurada-Nvidia>
 <61acf616-dd63-bccd-2c91-ce244b799f09@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <61acf616-dd63-bccd-2c91-ce244b799f09@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 04, 2018 at 09:38:52PM +0100, Maciej S. Szmigiero wrote:

> > Hmm...What's the dependency here? Why is it required like this?

> And a AC'97 CODEC probe needs AC'97 communication to be working,
> since it has to detect the CODEC model, configure it, etc.

Okay. If the CODEC configurations depend on (or are done via)
the AC link, it has to be in this way then.

> > I am okay to put everything to a separate fsl_ssi_hw_init() and
> > move it back to the platform probe() though.
> 
> This could be a solution - I assume that by "everything" in the above
> sentence you mean (at least) enabling the AC'97 communication at the
> SSI.

All register configurations -- I was trying to move them to dai
probe() so a deferring probe or the platform remove() does not
need to revert these register configurations.

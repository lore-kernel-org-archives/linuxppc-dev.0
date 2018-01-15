Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zL65C6mz7zF0Y1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 08:32:31 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id bi12so4565431plb.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 13:32:31 -0800 (PST)
Date: Mon, 15 Jan 2018 13:32:21 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: Re: [PATCH v3 16/17] ASoC: fsl_ssi: Move DT related code to a
 separate probe()
Message-ID: <20180115213221.GA10868@Asurada>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
 <1515990087-11598-17-git-send-email-nicoleotsuka@gmail.com>
 <0be4b57d-cb28-896a-3d97-f36316a351c5@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0be4b57d-cb28-896a-3d97-f36316a351c5@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 15, 2018 at 10:16:39PM +0100, Maciej S. Szmigiero wrote:

> >  	/* Check if being used in AC97 mode */
> >  	sprop = of_get_property(np, "fsl,mode", NULL);
> > -	if (sprop) {
> > -		if (!strcmp(sprop, "ac97-slave"))
> > -			ssi->dai_fmt = FSLSSI_AC97_DAIFMT;
> > +	if (sprop && !strcmp(sprop, "ac97-slave")) {
> > +		ssi->dai_fmt = FSLSSI_AC97_DAIFMT;
> > +
> > +		ret = of_property_read_u32(np, "cell-index", &ssi->card_idx);
> > +		if (ret) {
> > +			dev_err(dev, "failed to get SSI index property\n");
> > +			return -EINVAL;
> > +		}
> > +		strcpy(ssi->card_name, "ac97-codec");
> >  	}
> >  
> >  	/* Select DMA or FIQ */
> >  	ssi->use_dma = !of_property_read_bool(np, "fsl,fiq-stream-filter");
> >  
> > +	/* In synchronous mode, STCK and STFS ports are used by RX as well */
> > +	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL))
> > +		ssi->synchronous = true;
> 
> You are setting ssi->synchronous in the AC'97 mode here, the old code
> didn't do that (see the next patch hunk below).

Will modify this part. Thanks

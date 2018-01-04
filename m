Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x231.google.com (mail-pl0-x231.google.com
 [IPv6:2607:f8b0:400e:c01::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCHQ36mb0zF0R0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 06:08:25 +1100 (AEDT)
Received: by mail-pl0-x231.google.com with SMTP id bd8so1563631plb.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jan 2018 11:08:25 -0800 (PST)
Date: Thu, 4 Jan 2018 11:08:37 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: Re: [PATCH v1 01/15] ASoC: fsl_ssi: Clean up set_dai_tdm_slot()
Message-ID: <20180104190836.GB27975@Asurada-Nvidia>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-2-git-send-email-nicoleotsuka@gmail.com>
 <b910e12c-bee7-18ba-f878-bece9a9f9cc1@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b910e12c-bee7-18ba-f878-bece9a9f9cc1@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 01, 2018 at 07:39:52PM +0100, Maciej S. Szmigiero wrote:

> >  	/* The slot number should be >= 2 if using Network mode or I2S mode */
> > -	regmap_read(regs, REG_SSI_SCR, &val);
> > -	val &= SSI_SCR_I2S_MODE_MASK | SSI_SCR_NET;
> > -	if (val && slots < 2) {
> > +	if (ssi->i2s_net && slots < 2) {
> >  		dev_err(dai->dev, "slot number should be >= 2 in I2S or NET\n");
> >  		return -EINVAL;
> >  	}
> 
> Are you sure that ssi->i2s_net SSI_SCR_I2S_MODE_MASK | SSI_SCR_NET bits
> (also known as SSI_SCR_I2S_NET_MASK) zero or non-zero status is always
> consistent with that in the SCR register?
> 
> I can see that in fsl_ssi_hw_params() these bits in SCR are zeroed in
> a one special case and in the second special case they are hardcoded
> to SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET, in both cases regardless of
> what is currently in ssi->i2s_net.

You are right. I should update the i2s_net in hw_params() too. Thanks!

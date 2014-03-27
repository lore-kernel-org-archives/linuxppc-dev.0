Return-Path: <guangyu.chen@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AE0CD140079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 14:07:30 +1100 (EST)
Date: Thu, 27 Mar 2014 10:56:48 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Xiubo Li-B47053 <Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add isr to deal with error flag
Message-ID: <20140327025647.GC16197@MrMyself>
References: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
 <11a8271c31044515bd2657a93aefdaec@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140327023617.GB16197@MrMyself>
 <1e2d210764724c7e834c5307b54c37ab@BY2PR03MB505.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1e2d210764724c7e834c5307b54c37ab@BY2PR03MB505.namprd03.prod.outlook.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 27, 2014 at 10:53:50AM +0800, Xiubo Li-B47053 wrote:
> > On Thu, Mar 27, 2014 at 10:13:48AM +0800, Xiubo Li-B47053 wrote:
> > > > +	regmap_read(sai->regmap, FSL_SAI_TCSR, &xcsr);
> > > > +	regmap_write(sai->regmap, FSL_SAI_TCSR, xcsr);
> > > > +
> > > > +	if (xcsr & FSL_SAI_CSR_WSF)
> > > > +		dev_dbg(dev, "isr: Start of Tx word detected\n");
> > > > +
> > > > +	if (xcsr & FSL_SAI_CSR_SEF)
> > > > +		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
> > > > +
> > > > +	if (xcsr & FSL_SAI_CSR_FEF)
> > > > +		dev_dbg(dev, "isr: Transmit underrun detected\n");
> > > > +
> > >
> > > Actually, the above three isrs should to write a logic 1 to this field
> > > to clear this flag.
> > >
> > >
> > > > +	if (xcsr & FSL_SAI_CSR_FWF)
> > > > +		dev_dbg(dev, "isr: Enabled transmit FIFO is empty\n");
> > > > +
> > > > +	if (xcsr & FSL_SAI_CSR_FRF)
> > > > +		dev_dbg(dev, "isr: Transmit FIFO watermark has been reached\n");
> > > > +
> > >
> > > While are these ones really needed to clear manually ?
> > 
> > The reference manual doesn't mention about the requirement. So SAI should do
> > the self-clearance.
> 
> Yes, I do think we should let it do the self-clearance, and shouldn't interfere
> of them...

SAI is supposed to ignore the interference, isn't it?

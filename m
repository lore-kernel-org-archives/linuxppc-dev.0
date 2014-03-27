Return-Path: <Li.Xiubo@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DF2D2140088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 15:07:01 +1100 (EST)
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>
Subject: RE: [PATCH] ASoC: fsl_sai: Add isr to deal with error flag
Date: Thu, 27 Mar 2014 04:06:53 +0000
Message-ID: <62630844c7434df6937ca25d3f47b656@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
 <11a8271c31044515bd2657a93aefdaec@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140327023617.GB16197@MrMyself>
 <1e2d210764724c7e834c5307b54c37ab@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140327025647.GC16197@MrMyself>
 <12f887b3889a41849026965f0cf7db1f@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140327033117.GD16197@MrMyself>
In-Reply-To: <20140327033117.GD16197@MrMyself>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
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

> > > > > > > +	if (xcsr & FSL_SAI_CSR_FWF)
> > > > > > > +		dev_dbg(dev, "isr: Enabled transmit FIFO is empty\n");
> > > > > > > +
> > > > > > > +	if (xcsr & FSL_SAI_CSR_FRF)
> > > > > > > +		dev_dbg(dev, "isr: Transmit FIFO watermark has been
> > > reached\n");
> > > > > > > +
> > > > > >
> > > > > > While are these ones really needed to clear manually ?
> > > > >
> > > > > The reference manual doesn't mention about the requirement. So SA=
I
> should
> > > do
> > > > > the self-clearance.
> > > >
> > > > Yes, I do think we should let it do the self-clearance, and shouldn=
't
> > > interfere
> > > > of them...
> > >
> > > SAI is supposed to ignore the interference, isn't it?
> > >
> >
> > Maybe, but I'm not very sure.
> > And these bits are all writable and readable.
>=20
> Double-confirmed? Because FWF and FRF should be read-only bits.
>=20

So let's just ignore the clearance of these bits in isr().

+++++
SAI Transmit Control Register (I2S1_TCSR) : 32 : R/W : 0000_0000h
-----

I have checked in the Vybrid and LS1 SoC datasheets, and they are all the
Same as above, and nothing else.

Have I missed ?

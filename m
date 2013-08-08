Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EC3CD2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 05:50:34 +1000 (EST)
Date: Thu, 8 Aug 2013 21:50:20 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 11/31] net: can: mscan: improve clock API use
Message-ID: <20130808195020.GZ2580@book.gsilab.sittig.org>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-12-git-send-email-gsi@denx.de>
 <5201F70F.8090007@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5201F70F.8090007@pengutronix.de>
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>,
 Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 07, 2013 at 09:28 +0200, Marc Kleine-Budde wrote:
> 
> On 08/06/2013 10:43 PM, Gerhard Sittig wrote:
> > [ ... ]
> > diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
> > index e6b4095..4f998f5 100644
> > --- a/drivers/net/can/mscan/mscan.c
> > +++ b/drivers/net/can/mscan/mscan.c
> > @@ -573,10 +573,24 @@ static int mscan_open(struct net_device *dev)
> >  	struct mscan_priv *priv = netdev_priv(dev);
> >  	struct mscan_regs __iomem *regs = priv->reg_base;
> >  
> > +	if (priv->clk_ipg) {
> > +		ret = clk_prepare_enable(priv->clk_ipg);
> > +		if (ret)
> > +			goto exit_retcode;
> > +	}
> > +	if (priv->clk_can) {
> > +		ret = clk_prepare_enable(priv->clk_can);
> > +		if (ret) {
> > +			if (priv->clk_ipg)
> > +				clk_disable_unprepare(priv->clk_ipg);
> > +			goto exit_retcode;
> 
> Why don't you add another jump label and jump to that to disable the
> ipkg clock?

You are right.  I've queued this change for v5 (adding a label in
the existing error path, jumping to it instead of explicitly
disabling the clock).

> 
> > +		}
> > +	}
> > +
> >  	/* common open */
> >  	ret = open_candev(dev);
> >  	if (ret)
> > -		return ret;
> > +		goto exit_dis_clock;
> >  
> >  	napi_enable(&priv->napi);
> >  
> > @@ -604,6 +618,12 @@ exit_free_irq:
> >  exit_napi_disable:
> >  	napi_disable(&priv->napi);
> >  	close_candev(dev);
> > +exit_dis_clock:
> > +	if (priv->clk_can)
> > +		clk_disable_unprepare(priv->clk_can);
> > +	if (priv->clk_ipg)
> > +		clk_disable_unprepare(priv->clk_ipg);
> > +exit_retcode:
> >  	return ret;
> >  }
> 
> Marc

Thank you for reviewing several versions of the patch!


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de

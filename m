Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8E83D2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 21:58:16 +1000 (EST)
Date: Tue, 23 Jul 2013 13:58:12 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 01/31] spi: mpc512x: cleanup clock API use
Message-ID: <20130723115812.GG19071@book.gsilab.sittig.org>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-2-git-send-email-gsi@denx.de>
 <20130722140904.GU9858@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130722140904.GU9858@sirena.org.uk>
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>,
 Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <rob.herring@calxeda.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, Anatolij Gustschin <agust@denx.de>,
 David Woodhouse <dwmw2@infradead.org>, Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ devicetree@vger adjusted ]

On Mon, Jul 22, 2013 at 15:09 +0100, Mark Brown wrote:
> 
> On Mon, Jul 22, 2013 at 02:14:28PM +0200, Gerhard Sittig wrote:
> 
> > +	ret = clk_prepare_enable(clk);
> > +	if (ret) {
> > +		devm_clk_put(dev, clk);
> > +		goto free_irq;
> 
> The main point of the devm_ APIs is to avoid the need for explicit
> freeing so you should just remove these puts.

OK, will do in v4.

Shall these get removed everywhere including regular shutdown
paths, or just from error paths during setup?

[ the same topic came up for the CAN patch, might answer there ]


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de

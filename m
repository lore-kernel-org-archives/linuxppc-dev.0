Return-Path: <gsi@denx.de>
Date: Thu, 18 Jul 2013 09:04:02 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1 05/24] clk: wrap I/O access for improved portability
Message-ID: <20130718070402.GO7080@book.gsilab.sittig.org>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-6-git-send-email-gsi@denx.de>
 <20130715193829.GS14452@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130715193829.GS14452@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 15, 2013 at 21:38 +0200, Sascha Hauer wrote:
> 
> On Mon, Jul 15, 2013 at 08:47:34PM +0200, Gerhard Sittig wrote:
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index 6d55eb2..2c07061 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -104,7 +104,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
> >  	struct clk_divider *divider = to_clk_divider(hw);
> >  	unsigned int div, val;
> >  
> > -	val = readl(divider->reg) >> divider->shift;
> > +	val = clk_readl(divider->reg) >> divider->shift;
> >  	val &= div_mask(divider);
> 
> Would it be an option to use regmap for the generic dividers/muxes
> instead? This should be suitable for ppc and also for people who want to
> use the generic clocks on i2c devices.

Some other thought crossed my mind regarding access to clock
control registers that reside behind some communication channel
like I2C:

The common clock API assumes (it's part of the contract) that
there are potentially expensive operations like get, put, prepare
and unprepare, as well as swift and non-blocking operations like
enable and disable.

Would the regmap abstraction hide the potentially blocking nature
of a register access (I understand that you can implement "local"
as well as "remote" register sets by this mechanism)?  Or could
you still meet the assumptions or requirements of the common
clock API?

It might as well be the responsibility of the clock driver's
implementor to arrange for the availability of non-blocking
enable/disable operations, just as it is today.  Such that
expensive register access need not be forbidden in general.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de

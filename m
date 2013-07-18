Return-Path: <sha@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 241772C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 18:07:15 +1000 (EST)
Date: Thu, 18 Jul 2013 10:06:57 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 devicetree-discuss@lists.ozlabs.org, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH v1 05/24] clk: wrap I/O access for improved portability
Message-ID: <20130718080657.GI10380@pengutronix.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-6-git-send-email-gsi@denx.de>
 <20130715193829.GS14452@pengutronix.de>
 <20130718070402.GO7080@book.gsilab.sittig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130718070402.GO7080@book.gsilab.sittig.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 18, 2013 at 09:04:02AM +0200, Gerhard Sittig wrote:
> On Mon, Jul 15, 2013 at 21:38 +0200, Sascha Hauer wrote:
> > 
> > On Mon, Jul 15, 2013 at 08:47:34PM +0200, Gerhard Sittig wrote:
> > > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > > index 6d55eb2..2c07061 100644
> > > --- a/drivers/clk/clk-divider.c
> > > +++ b/drivers/clk/clk-divider.c
> > > @@ -104,7 +104,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
> > >  	struct clk_divider *divider = to_clk_divider(hw);
> > >  	unsigned int div, val;
> > >  
> > > -	val = readl(divider->reg) >> divider->shift;
> > > +	val = clk_readl(divider->reg) >> divider->shift;
> > >  	val &= div_mask(divider);
> > 
> > Would it be an option to use regmap for the generic dividers/muxes
> > instead? This should be suitable for ppc and also for people who want to
> > use the generic clocks on i2c devices.
> 
> Some other thought crossed my mind regarding access to clock
> control registers that reside behind some communication channel
> like I2C:
> 
> The common clock API assumes (it's part of the contract) that
> there are potentially expensive operations like get, put, prepare
> and unprepare, as well as swift and non-blocking operations like
> enable and disable.
> 
> Would the regmap abstraction hide the potentially blocking nature
> of a register access (I understand that you can implement "local"
> as well as "remote" register sets by this mechanism)?  Or could
> you still meet the assumptions or requirements of the common
> clock API?
> 
> It might as well be the responsibility of the clock driver's
> implementor to arrange for the availability of non-blocking
> enable/disable operations, just as it is today.  Such that
> expensive register access need not be forbidden in general.

regmap for mmio uses a spinlock for read/modify/write operations, just
like you have to use a spinlock in the common clk dividers/gates. This
part wouldn't change with regmap.

For i2c connected clocks where a spinlock doesn't work due to the
nonatomic nature of i2c devices we would have to move the enable/disble
stuff to prepare/unprepare in the common gate code. This can be left
for someone who works on i2c clocks though.

I think regmap has the potential to solve a number of issues like the
hardcoded readl/writel in the common clock blocks, issues with i2c
clocks and your endianess issue. The biggest question probably is how
to get there without putting too much of a burden on you. It's probably
not an option to convert all users to regmap, so it seems additional
functions like clk_register_gate_regmap are better to handle.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Return-Path: <gsi@denx.de>
Date: Wed, 17 Jul 2013 13:22:29 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 01/24] spi: mpc512x: prepare clocks before enabling them
Message-ID: <20130717112229.GK7080@book.gsilab.sittig.org>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-2-git-send-email-gsi@denx.de>
 <20130715201734.GF11538@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130715201734.GF11538@sirena.org.uk>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
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

On Mon, Jul 15, 2013 at 21:17 +0100, Mark Brown wrote:
> 
> On Mon, Jul 15, 2013 at 08:47:30PM +0200, Gerhard Sittig wrote:
> > clocks need to get prepared before they can get enabled,
> > fix the MPC512x PSC SPI master's initialization
> 
> > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > ---
> >  drivers/spi/spi-mpc512x-psc.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
> > index 29fce6a..76b20ea 100644
> > --- a/drivers/spi/spi-mpc512x-psc.c
> > +++ b/drivers/spi/spi-mpc512x-psc.c
> > @@ -395,7 +395,7 @@ static int mpc512x_psc_spi_port_config(struct spi_master *master,
> >  
> >  	sprintf(name, "psc%d_mclk", master->bus_num);
> >  	spiclk = clk_get(&master->dev, name);
> > -	clk_enable(spiclk);
> > +	clk_prepare_enable(spiclk);
> >  	mps->mclk = clk_get_rate(spiclk);
> >  	clk_put(spiclk);
> 
> This code is *clearly* buggy and should be fixed rather than papered
> over.  Not only is there no matching put the driver is also dropping the
> reference to the clock rather than holding on to it while it's in use.

"This code" refers to the driver's original condition, right?  I
agree that the driver has been suffering from incomplete clock
handling since it was born three years ago.  And that this issue
shall get addressed.  The question is just whether it needs to be
part of this series which has a different focus.

What the above patch addresses is prevention of an immediate and
fatal breakage, when common clock gets used but clocks aren't
prepared before getting enabled.  So I consider it appropriate as
a step in preparation before introducing support for common clock
on the platform.  (It's funny that I had a comment in this spirit
in the commit message, but trimmed it to not be overly verbose.)

What the patch does not address is to fix any other deficiencies
in the driver which might have been lurking there for ages.  This
would be the scope of a different patch or series, as addressing
it here as well would mix orthogonal issues within one series,
and would complicate review and test (and would delay or even
potentially kill the introduction of desirable support for common
infrastructure just because other legacy non-fatal issues aren't
addressed as well in bypassing).

I will look into what I can do to address your concerns about
proper general clock handling in this specific driver.  But I'm
unable to do this for all other drivers as well which I happen to
pass by as I work on platform code (partially due to lack of
knowledge).  In any case I won't be able to test all of these
changes in all subsystems (mostly due to lack of hardware and
test setups).

So I suggest to leave these general cleanup activities for a
separate series.  The current series certainly improves general
platform code, transparently brings new drivers into successful
operation, and keeps the quality of existing code (doesn't break
anything, does even actively prevent breakage).  So it shall be
acceptable despite its not being perfect (like addressing each
and every other aspect which may arise elsewhere).  Where would I
stop then?

Sorry for the lengthy reply, but I guess it's about just one
general aspect which equally applies to other parts of the
series, not just the specific SPI driver which the feedback was
provided for.  And I do appreciate your looking at the
submission.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de

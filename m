Return-Path: <gsi@denx.de>
Date: Wed, 17 Jul 2013 13:27:50 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1 15/24] serial: mpc512x: OF clock lookup, use the
 'mclk' name
Message-ID: <20130717112750.GL7080@book.gsilab.sittig.org>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373924770-22599-1-git-send-email-gsi@denx.de>
 <20130715215423.GU14452@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130715215423.GU14452@pengutronix.de>
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

On Mon, Jul 15, 2013 at 23:54 +0200, Sascha Hauer wrote:
> 
> On Mon, Jul 15, 2013 at 11:46:01PM +0200, Gerhard Sittig wrote:
> > with device tree based clock lookup, the MCLK name no longer
> > depends on the PSC index
> > 
> > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > ---
> >  drivers/tty/serial/mpc52xx_uart.c |    8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
> > index 53c1093..221fb89 100644
> > --- a/drivers/tty/serial/mpc52xx_uart.c
> > +++ b/drivers/tty/serial/mpc52xx_uart.c
> > @@ -619,21 +619,17 @@ static irqreturn_t mpc512x_psc_handle_irq(struct uart_port *port)
> >  static int mpc512x_psc_clock(struct uart_port *port, int enable)
> >  {
> >  	struct clk *psc_clk;
> > -	int psc_num;
> > -	char clk_name[10];
> >  
> >  	if (uart_console(port))
> >  		return 0;
> >  
> > -	psc_num = (port->mapbase & 0xf00) >> 8;
> > -	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
> > -	psc_clk = clk_get(port->dev, clk_name);
> > +	psc_clk = clk_get(port->dev, "mclk");
> 
> Same comment applies here as Mark made to the spi driver.

So I'd like to respond in the same way as I did for the SPI
driver. :)

The scope of this series is the introduction of support for the
common clock framework.  Addressing other (legacy non-fatal and
previously accepted) issues as they get identified in bypassing
would be the scope of a separate patch or series.

I'm not questioning the need to fix other additionally identified
issues.  I'm just asking whether they shall be in the scope of
this very series.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de

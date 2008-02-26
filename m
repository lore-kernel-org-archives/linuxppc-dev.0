Return-Path: <olof@lixom.net>
Date: Tue, 26 Feb 2008 08:14:20 -0600
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [patch 1/6] pasemi_mac: Move RX/TX section enablement to dma_lib
Message-ID: <20080226141420.GA22572@lixom.net>
References: <20080221025753.903665000@lixom.net>
	<20080221025929.082348000@lixom.net>
	<1204026366.7203.9.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204026366.7203.9.camel@concordia>
Cc: netdev@vger.kernel.org, pasemi-linux@ozlabs.org, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, Feb 26, 2008 at 10:46:06PM +1100, Michael Ellerman wrote:
> On Wed, 2008-02-20 at 20:57 -0600, Olof Johansson wrote:
> > +	i = 1000;
> > +	pasemi_write_dma_reg(PAS_DMA_COM_RXCMD, 0);
> > +	while ((i > 0) && (pasemi_read_dma_reg(PAS_DMA_COM_RXSTA) & 1))
> > +		i--;
> > +	if (i < 0)
> > +		printk(KERN_INFO "Warning: Could not disable RX section\n");
> > +
> > +	i = 1000;
> > +	pasemi_write_dma_reg(PAS_DMA_COM_TXCMD, 0);
> > +	while ((i > 0) && (pasemi_read_dma_reg(PAS_DMA_COM_TXSTA) & 1))
> > +		i--;
> 
> This kind of caught my eye, is it still going to work when the next core
> is twice as fast?

Actually, I added the variable right before posting, I used to have an
infinite loop there while testing the patch. I've never seen it do more
than a few rounds, so I'm not that worried.

We already have a similar loop in the channel shutdown code, but it runs
a bit longer. I might bring that over instead. Thanks for pointing it
out.


-Olof

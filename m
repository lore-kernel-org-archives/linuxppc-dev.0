Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3AC7B7D58
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Feb 2010 07:23:58 +1100 (EST)
Date: Fri, 26 Feb 2010 14:23:35 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] 8250: add workaround for MPC8[356]xx UART break IRQ storm
Message-ID: <20100226202335.GA28844@loki.buserror.net>
References: <1267212301-26851-1-git-send-email-paul.gortmaker@windriver.com>
	<EB2B2912-24C3-46C9-B894-0A84D593570F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EB2B2912-24C3-46C9-B894-0A84D593570F@kernel.crashing.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 26, 2010 at 01:42:39PM -0600, Kumar Gala wrote:
> 
> On Feb 26, 2010, at 1:25 PM, Paul Gortmaker wrote:
> 
> > Sending a break on the SOC UARTs found in some MPC83xx/85xx/86xx
> > chips seems to cause a short lived IRQ storm (/proc/interrupts
> > typically shows somewhere between 300 and 1500 events).  Unfortunately
> > this renders SysRQ over the serial console completely inoperable.
> > Testing with obvious things like ACKing the event doesn't seem to
> > change anything vs. a completely dumb approach of just ignoring
> > it and waiting for it to stop, so that is what is implemented here.
> > 
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> > 
> > This is a refresh of a patch I'd done earlier -- I've tried to make
> > the bug support as generic as possible to minimize having board
> > specific ifdef crap in 8250.c -- any suggestions on how to further
> > improve it are welcome.
> > 
> > drivers/serial/8250.c      |    6 ++++++
> > drivers/serial/8250.h      |   20 ++++++++++++++++++++
> > drivers/serial/Kconfig     |   14 ++++++++++++++
> > include/linux/serial_reg.h |    2 ++
> > 4 files changed, 42 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> > index e9b15c3..850b0e9 100644
> > --- a/drivers/serial/8250.c
> > +++ b/drivers/serial/8250.c
> > @@ -1531,6 +1531,11 @@ static void serial8250_handle_port(struct uart_8250_port *up)
> > 
> > 	status = serial_inp(up, UART_LSR);
> > 
> > +	if ((up->bugs & UART_BUG_PPC) && (status == UART_LSR_RFE_ERROR_BITS)) {
> > +		spin_unlock_irqrestore(&up->port.lock, flags);
> > +		return;
> > +	}

Will LSR always be 0xf1 when this problem hits?  At least the transmit bits
shouldn't be relevant.

This has been listed as an erratum in some of the newer chips (e.g.
mpc8568).

The suggested as workaround is to, upon seeing a break condition:
- read RBR
- delay at least one character period
- read RBR again

If I'm interpreting this correctly, it could be implemented by doing the
normal break handling on the first interrupt, plus setting a flag so that the
next interrupt simply reads RBR, clears the flag, and returns, without ever
reading LSR.

-Scott

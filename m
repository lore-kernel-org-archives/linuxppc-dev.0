Date: Fri, 19 Oct 2001 16:07:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geoff Wyche <GWyche@DATUM.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx + serial console on SCC
Message-ID: <20011019160733.G10163@cpe-24-221-152-185.az.sprintbbd.net>
References: <607BF0A2B4F3D411A09500508BC225427E8329@mailctx.datum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <607BF0A2B4F3D411A09500508BC225427E8329@mailctx.datum.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 19, 2001 at 01:08:34PM -0700, Geoff Wyche wrote:
>
> Hello all,
>
> > Yes, we've tested this configuration once when we were re-working the
> > UART driver for hardware-handshake support, configurable buffer sizes
> > etc.
> > We tested all 6 channels ( 2 x SMC, 4 x SCC) on a IP860 board.
>
> I think I've found a bug related to SCCs and serial console IO.
> Looks like this might have crept in as a result of two transposed lines.
> A patch showing the difference is included at the end of this post.

Grr, I hate reading diff -c's.  If I'm reading it right, you say it
should be:
sccp->scc_gsmrl &= ~(UART_SCCM_TX | UART_SCCM_RX);
#ifdef CONFIG_SERIAL_CONSOLE
...

Right?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

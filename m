Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id CF4AADDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 11:20:48 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so1007462wri
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 16:20:47 -0800 (PST)
Message-ID: <fa686aa40711211620q4450f3c2g2450157e37eb7c9@mail.gmail.com>
Date: Wed, 21 Nov 2007 17:20:46 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: [PATCH 12/14] powerpc: Add early udbg support for 40x processors
In-Reply-To: <1195689601.6970.115.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071121061555.55B06DDFA8@ozlabs.org>
	<fa686aa40711211547nf9d58c4t1bc7a512c699cb02@mail.gmail.com>
	<1195689601.6970.115.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/21/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Wed, 2007-11-21 at 16:47 -0700, Grant Likely wrote:
> > On 11/20/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > This adds some basic real mode based early udbg support for 40x
> > > in order to debug things more easily
> > >
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > ---
> > > --- linux-work.orig/arch/powerpc/platforms/Kconfig.cputype      2007-11-21 12:50:16.000000000 +1100
> > > +++ linux-work/arch/powerpc/platforms/Kconfig.cputype   2007-11-21 12:50:18.000000000 +1100
> > > @@ -43,6 +43,7 @@ config 40x
> > >         bool "AMCC 40x"
> > >         select PPC_DCR_NATIVE
> > >         select WANT_DEVICE_TREE
> > > +       select PPC_UDBG_16550
> >
> > Unfortunately, this isn't always true.  The Xilinx Virtex parts us
> > config 40x, but not all FPGA bitstreams have a 16550 serial port.
> > Sometimes it's a uartlite instead.
>
> What does uartlite looks like ?

fixed speed
4 registers: rx, tx, status & control

rx & tx are... well... rx and tx registers
status has a number of bits reporting fifos full/empty etc.
control has three bits; reset tx, reset rx and interrupt enable.

See the top of drivers/serial/uartlite.c

Very simple stuff; but definitely not 16550.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

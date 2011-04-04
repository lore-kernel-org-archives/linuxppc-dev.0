Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 06783B6FB5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 08:49:31 +1000 (EST)
Date: Tue, 5 Apr 2011 00:49:22 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Pegasos i8042 broken again
Message-ID: <20110404224922.GB8564@iram.es>
References: <20101010013755.1697.qmail@kosh.dhis.org>
	<1286696147.2463.499.camel@pasglop> <20110404222637.GA4633@iram.es>
	<1301956130.2549.93.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301956130.2549.93.camel@pasglop>
Cc: pacman@kosh.dhis.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 05, 2011 at 08:28:50AM +1000, Benjamin Herrenschmidt wrote:
> 
> > Ok, I got fed up about it. The patch referred above is obviously wrong since
> > it leaves interrupts at 0 when a device_type or name of 8042 is found,
> > so what about the following? 
> > 
> > I can ship it with a signed-off-by and proper comments a bit later if people agree.
> > 
> > Compiled and tested, otherwise I couldn't even type this message :-)
> 
> Shouldn't that be a pegasos specific quirk in chrp/setup.c ?

In this case I don't think so: 
1) The code looks for the pnp id for the 8042 controllers and tries
  to fill the interrupt fields from OF/DT, but falls back to defaults 
  1 and 12 if it does not get them.

2) Then it tries to find device_type of 8042 or node name of 8042
  and returns success if it finds them, but in this case leaves
  the interrupt numbers at zero. Note that in this case the code does 
  not even attempt to get interrupt information from OF/DT, this looks
  like a fallback case where filling with defaults seems reasonable.
  Actually, it is not filling with defaults which seems wrong since
  the other case always provides interrupt information.

	Regards,
	Gabriel
> > 
> > diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> > index 9d4882a..06865ac 100644
> > --- a/arch/powerpc/kernel/setup-common.c
> > +++ b/arch/powerpc/kernel/setup-common.c
> > @@ -599,6 +599,10 @@ int check_legacy_ioport(unsigned long base_port)
> >  		 * name instead */
> >  		if (!np)
> >  			np = of_find_node_by_name(NULL, "8042");
> > +		if (np) {
> > +			of_i8042_kbd_irq = 1;
> > +			of_i8042_aux_irq = 12;
> > +		}
> >  		break;
> >  	case FDC_BASE: /* FDC1 */
> >  		np = of_find_node_by_type(NULL, "fdc");
> 

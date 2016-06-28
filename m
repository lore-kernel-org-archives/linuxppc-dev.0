Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdtgk2qXszDqmv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 14:51:46 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdtgh45LRz9s9c
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2016 14:51:44 +1000 (AEST)
Message-ID: <1467084912.20278.117.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] tty/hvc: Use opal irqchip interface if available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@ozlabs.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jslaby@suse.com>, "# 4 . 1 . x-" <stable@vger.kernel.org>, Alistair Popple
 <alistair@popple.id.au>
Date: Tue, 28 Jun 2016 13:35:12 +1000
In-Reply-To: <1467084869.20278.116.camel@kernel.crashing.org>
References: <20160628031139.12500-1-sam@mendozajonas.com>
 <20160628031139.12500-2-sam@mendozajonas.com>
 <1467084869.20278.116.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-28 at 13:34 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2016-06-28 at 13:11 +1000, Samuel Mendoza-Jonas wrote:
> > Update the hvc driver to use the OPAL irqchip if made available by
> > the
> > running firmware. If it is not present, the driver falls back to
> > the
> > existing OPAL event number.
> 
> One thing that worries me a bit with the original transition to using
> an interrupt from the old OPAL callback is that when passed an
> interrupt,
> the HVC thread assumes interrupts work reliably and thus stops
> polling.

Note to Greg: This patch is fine, this is a reflexion about a change
that was already done.

> However, not all platforms have a functional serial interrupt. For
> example rhesus doesn't. In fact we don't always know when we build
> the device-tree whether the serial interrupt will work or not.
> 
> Now we might be saved by the OPAL heartbeat ... we do call
> opal_poll_events regularily there. But I'd like you to verify it
> by disabling the LPC interrupt for example on an openpower machine
> and see how the console beahves.
> 
> Cheers,
> Ben.
>  
> 
> > Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> > Cc: <stable@vger.kernel.org> # 4.1.x-
> > ---
> >  drivers/tty/hvc/hvc_opal.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/hvc/hvc_opal.c
> > b/drivers/tty/hvc/hvc_opal.c
> > index b7cd0ae..8c53f5b 100644
> > --- a/drivers/tty/hvc/hvc_opal.c
> > +++ b/drivers/tty/hvc/hvc_opal.c
> > @@ -170,6 +170,8 @@ static int hvc_opal_probe(struct
> > platform_device *dev)
> >  	hv_protocol_t proto;
> >  	unsigned int termno, irq, boot = 0;
> >  	const __be32 *reg;
> > +	u32 prop;
> > +	int rc;
> >  
> >  	if (of_device_is_compatible(dev->dev.of_node, "ibm,opal-
> > console-raw")) {
> >  		proto = HV_PROTOCOL_RAW;
> > @@ -214,7 +216,15 @@ static int hvc_opal_probe(struct
> > platform_device *dev)
> >  		dev->dev.of_node->full_name,
> >  		boot ? " (boot console)" : "");
> >  
> > -	irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
> > +	rc = of_property_read_u32(dev->dev.of_node, "interrupts",
> > &prop);
> > +	if (rc) {
> > +		pr_info("hvc%d: No interrupts property, using OPAL
> > event\n",
> > +				termno);
> > +		irq =
> > opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
> > +	} else {
> > +		irq = irq_of_parse_and_map(dev->dev.of_node, 0);
> > +	}
> > +
> >  	if (!irq) {
> >  		pr_err("hvc_opal: Unable to map interrupt for
> > device %s\n",
> >  			dev->dev.of_node->full_name);

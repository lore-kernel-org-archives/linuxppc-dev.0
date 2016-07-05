Return-Path: <sam@mendozajonas.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkD1v5WqzzDsl8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 16:07:31 +1000 (AEST)
Received: from mendozajonas.com (mendozajonas.com [188.166.185.233])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkD1t3v4vz9sdn
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 16:07:30 +1000 (AEST)
Message-ID: <1467698844.1951.4.camel@mendozajonas.com>
Subject: Re: [2/2] tty/hvc: Use opal irqchip interface if available
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jslaby@suse.com>, "# 4 . 1 . x-" <stable@vger.kernel.org>, Alistair Popple
 <alistair@popple.id.au>
Date: Tue, 05 Jul 2016 16:07:24 +1000
In-Reply-To: <3rkCDZ1WWTz9sBc@ozlabs.org>
References: <3rkCDZ1WWTz9sBc@ozlabs.org>
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

On Tue, 2016-07-05 at 15:31 +1000, Michael Ellerman wrote:
> On Tue, 2016-28-06 at 03:11:39 UTC, Sam Mendoza-Jonas wrote:
> > diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> > index b7cd0ae..8c53f5b 100644
> > --- a/drivers/tty/hvc/hvc_opal.c
> > +++ b/drivers/tty/hvc/hvc_opal.c
> > @@ -214,7 +216,15 @@ static int hvc_opal_probe(struct platform_device *dev)
> >  		dev->dev.of_node->full_name,
> >  		boot ? " (boot console)" : "");
> >  
> > -	irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
> > +	rc = of_property_read_u32(dev->dev.of_node, "interrupts", &prop);
> > +	if (rc) {
> > +		pr_info("hvc%d: No interrupts property, using OPAL event\n",
> > +				termno);
> > +		irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
> > +	} else {
> > +		irq = irq_of_parse_and_map(dev->dev.of_node, 0);
> > +	}
> 
> That seems a bit backward.
> 
> Shouldn't we try irq_of_parse_and_map() and if that fails, then we go back to
> opal_event_request() ?
> 
> cheers

I was unsure for a minute so I double checked this;
of_property_read_u32() returns of_property_read_u32_array(), which
returns 0 on success, unlike a bunch of other of_property helpers.

So if the 'interrupts' property does exist we get 0, and try
irq_of_parse_and_map(). But are you suggesting we try
irq_of_parse_and_map() regardless and then fall back to
opal_event_request()?

Cheers,
Sam

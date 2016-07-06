Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkwyH4cBtzDqyv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 19:51:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@ozlabs.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, "# 4 . 1 . x-" <stable@vger.kernel.org>,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: [2/2] tty/hvc: Use opal irqchip interface if available
In-Reply-To: <1467698844.1951.4.camel@mendozajonas.com>
References: <3rkCDZ1WWTz9sBc@ozlabs.org>
 <1467698844.1951.4.camel@mendozajonas.com>
Date: Wed, 06 Jul 2016 19:51:47 +1000
Message-ID: <871t379jrg.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Samuel Mendoza-Jonas <sam@mendozajonas.com> writes:

> On Tue, 2016-07-05 at 15:31 +1000, Michael Ellerman wrote:
>> On Tue, 2016-28-06 at 03:11:39 UTC, Sam Mendoza-Jonas wrote:
>> > diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
>> > index b7cd0ae..8c53f5b 100644
>> > --- a/drivers/tty/hvc/hvc_opal.c
>> > +++ b/drivers/tty/hvc/hvc_opal.c
>> > @@ -214,7 +216,15 @@ static int hvc_opal_probe(struct platform_device *dev)
>> >  		dev->dev.of_node->full_name,
>> >  		boot ? " (boot console)" : "");
>> >  
>> > -	irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
>> > +	rc = of_property_read_u32(dev->dev.of_node, "interrupts", &prop);
>> > +	if (rc) {
>> > +		pr_info("hvc%d: No interrupts property, using OPAL event\n",
>> > +				termno);
>> > +		irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
>> > +	} else {
>> > +		irq = irq_of_parse_and_map(dev->dev.of_node, 0);
>> > +	}
>> 
>> That seems a bit backward.
>> 
>> Shouldn't we try irq_of_parse_and_map() and if that fails, then we go back to
>> opal_event_request() ?

> But are you suggesting we try irq_of_parse_and_map() regardless and
> then fall back to opal_event_request()?

Yes.

cheers

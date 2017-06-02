Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfR3l0w01zDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 00:12:02 +1000 (AEST)
Message-ID: <1496412702.2842.11.camel@kernel.crashing.org>
Subject: Re: powerpc/opal-irqchip: Use interrupt names if present
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date: Sat, 03 Jun 2017 00:11:42 +1000
In-Reply-To: <CAMuHMdWGZYkM_aQ=vXr5J9-KFGzzWgq3hf+ZRY-n-+8-ghG5nQ@mail.gmail.com>
References: <20170222190235.92E5F661CEB@gitolite.kernel.org>
 <CAMuHMdWGZYkM_aQ=vXr5J9-KFGzzWgq3hf+ZRY-n-+8-ghG5nQ@mail.gmail.com>
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

On Fri, 2017-06-02 at 14:39 +0200, Geert Uytterhoeven wrote:
> 
> > diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
> > index 998316bf2dad..ecdcba9d1220 100644
> > --- a/arch/powerpc/platforms/powernv/opal-irqchip.c
> > +++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
> > @@ -183,8 +183,9 @@ void opal_event_shutdown(void)
> > +       /* It's not an error for the names to be missing */
> > +       of_property_read_string_array(opal_node, "opal-interrupts-names",
> > +                                     names, opal_irq_count);
> 
> Just double-checking, as it's different from the standard "interrupt-names":
> is "opal-interrupts-names" the correct name?

Yes, because the property it refers to isn't a standard "interrupts"
property... it's ... complicated :-)

It could have been mind you, but the decision for that was made years
ago... it's a bunch of interrupts OPAL is interested in, which Linux
requests and sets up a handler for which just calls back into OPAL. 

In any case, firmwares with that property are out now.

Cheers,
Ben.

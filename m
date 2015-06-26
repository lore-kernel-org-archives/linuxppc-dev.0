Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40F111A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2015 07:55:00 +1000 (AEST)
Message-ID: <1435355687.26815.8.camel@kernel.crashing.org>
Subject: Re: pSeries boot failure due to wrong interrupt controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Linton <jlinton@tributary.com>
Cc: Rob Herring <robherring2@gmail.com>, Jeremy Linton
 <lintonrjeremy@gmail.com>, Grant Likely <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Date: Sat, 27 Jun 2015 07:54:47 +1000
In-Reply-To: <558D91C1.6030004@tributary.com>
References: <CAEFTgiyHkf8ooYdWW0nTLcdraJ_L9FpLSVZa4KS3CcdpGWJxew@mail.gmail.com>
 <CAL_JsqJqkUL8XyqR6yjg+-thj4YOQ6cUohGHHid71tdRFft7vw@mail.gmail.com>
 <558D91C1.6030004@tributary.com>
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

On Fri, 2015-06-26 at 12:54 -0500, Jeremy Linton wrote:
> Ping? Anyone?
> 
> I'm adding ppc-dev to see if anyone there is interested in picking up the patch..

Ah I missed that completely. From your discussion, it looks correct,
I'll see if I can find a machine to test, however I think we dropped
support for POWER3 so it might be non-trivial to do so.

And yes, when there is no map, the parent should be the interrupt-parent
with a fallback to the parent node if that doesn't exist.

Cheers,
Ben.

> Thanks,
> 	Jeremy
> 
> 
> Ok so I messed up the formatting a little and was lazy and didn't checkpatch it
> cause I mean, it was 1 line! If someone wants it resent I will do so.
> 
> 
> 
> 
> 
> On 6/23/2015 8:42 AM, Rob Herring wrote:
> > +Grant
> > 
> > On Mon, Jun 22, 2015 at 2:44 PM, Jeremy Linton <lintonrjeremy@gmail.com> wrote:
> >> The OF IRQ logic was refactored a while back, and it appears that it
> >> broke the case where a device doesn't have an interrupt-map
> >> (legacy/ISA platform peripherals). In particular on the older pSeries
> >> platforms the console serial port (keyboard/etc) is attached via a
> >> Winbond super I/O controller. With the refactored logic
> >> of_irq_parse_raw() returns with the out_irq->np pointing at the bus,
> >> rather than the interrupt controller. This results in the platform
> >> logic getting confused about the appropriate interrupt host, and in
> >> ics_rtas_host_match() it doesn't match "chrp,iic" and the xics takes
> >> over and tries to use RTAS to map the interrupt. RTAS then crashes the
> >> machine.
> >>
> >> This tweaks the "-> no map, getting parent" behavior to behave as
> >> before, and the machine boots.
> > 
> > I think the real question is why doesn't of_irq_find_parent return the
> > interrupt controller node instead of the bus node.
> > 
> > While I think this fix is correct, I think of_irq_parse_raw should be
> > a nop in the case of no interrupt-map.
> > 
> > Rob
> > 
> >>
> >> Thanks
> >>
> >> Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
> >>
> >>
> >> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> >> index 1a79806..78b4161b 100644
> >> --- a/drivers/of/irq.c
> >> +++ b/drivers/of/irq.c
> >> @@ -252,7 +252,6 @@ int of_irq_parse_raw(const __be32 *addr, struct
> >> of_phandle_args *out_irq)
> >>                  * Successfully parsed an interrrupt-map translation; copy new
> >>                  * interrupt specifier into the out_irq structure
> >>                  */
> >> -               out_irq->np = newpar;
> >>
> >>                 match_array = imap - newaddrsize - newintsize;
> >>                 for (i = 0; i < newintsize; i++)
> >> @@ -262,6 +261,7 @@ int of_irq_parse_raw(const __be32 *addr, struct
> >> of_phandle_args *out_irq)
> >>
> >>         skiplevel:
> >>                 /* Iterate again with new parent */
> >> +               out_irq->np = newpar;
> >>                 pr_debug(" -> new parent: %s\n", of_node_full_name(newpar));
> >>                 of_node_put(ipar);
> >>                 ipar = newpar;

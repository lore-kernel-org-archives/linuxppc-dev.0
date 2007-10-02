Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id E883CDE017
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 02:10:22 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5349678wag
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 09:10:20 -0700 (PDT)
Message-ID: <fa686aa40710020910u3a679ea2m15b005d0ba5fb054@mail.gmail.com>
Date: Tue, 2 Oct 2007 10:10:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH 2 6/7] Uartlite: Add of-platform-bus binding
In-Reply-To: <871wcd33ux.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
	<20070930224208.1871.2913.stgit@trillian.cg.shawcable.net>
	<1191304386.6310.92.camel@pasglop>
	<fa686aa40710020726s330d586p6ece70ae378f1206@mail.gmail.com>
	<871wcd33ux.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/2/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
>
> Hi,
>
>  Grant> static int __devinit
>  Grant> ulite_of_probe(struct of_device *op, const struct of_device_id *match)
>
> This looks like uartlite code to me ;)
>
>  Grant> {
>  Grant>         struct resource res;
>  Grant>         const unsigned int *id;
>  Grant>         int irq, rc;
>  Grant>         dev_dbg(&op->dev, "%s(%p, %p)\n", __FUNCTION__, op, match);
>  Grant>         rc = of_address_to_resource(op->node, 0, &res);
>  Grant>         if (rc) {
>  Grant>                 dev_err(&op->dev, "invalide address\n");
>  Grant>                 return rc;
>  Grant>         }
>  Grant>         irq = irq_of_parse_and_map(op->node, 0);
>  Grant>         id = of_get_property(op->node, "port-number", NULL);
>  Grant>         return ulite_assign(&op->dev, id ? *id : -1, res.start, irq);
>  Grant> }
>
>  Grant> What advantages do you see with the constructor approach?
>
> One advantage is that it keeps the of stuff out of the drivers. There
> already is one bus for platform stuff in the kernel, so from a device
> driver writer POV the of stuff is just extra fluff. Imagine the ARM or
> MIPS people coming up with 2 other incompatible ways of doing this and
> you'll see the drivers bloat.
>
> E.G. I use the smsc911x.c network driver on powerpc which is written
> by an ARM guy. Why should he need to care about of stuff in his driver?

The problem is that driver specific constructor code needs to be
written regardless.  Where should it live?  With the driver or in the
arch code?  Actually, with the arch code doesn't work well either
because multiple archs will be using of_platform (microblaze for
example), so they need to live somewhere common.

My opinion is that since it is driver-specific code anyway, then it
belongs with the driver.  Plus a driver writer for ARM doesn't need to
write them.  It's the powerpc or microblaze developer who will do it.
If the driver maintainer doesn't want the binding in the main driver
.c file, then the binding can easily be in an additional .c file
without needing to add a constructor.  (Kind of like how many USB host
controllers are managed)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

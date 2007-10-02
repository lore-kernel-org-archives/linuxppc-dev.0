Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id A4C3CDDF3A
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 00:26:44 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5306108wag
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 07:26:43 -0700 (PDT)
Message-ID: <fa686aa40710020726s330d586p6ece70ae378f1206@mail.gmail.com>
Date: Tue, 2 Oct 2007 08:26:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2 6/7] Uartlite: Add of-platform-bus binding
In-Reply-To: <1191304386.6310.92.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
	<20070930224208.1871.2913.stgit@trillian.cg.shawcable.net>
	<1191304386.6310.92.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/1/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Sun, 2007-09-30 at 16:42 -0600, Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > Add of_platform bus binding so this driver can be used with arch/powerpc
>
> Another option is to have a "constructor" in the platform code that
> generates the platform device from the DT. It might even become the
> preferred way one of these days, I'm not too sure at this stage. Anyway,
> do what you prefer.

I've looked at both, and I'm not to fond of the 'constructor'
approach.  Here are my reasons:

- Separate constructor code must be written for each driver anyway
(except perhaps for very simple cases which only require 'regs' and
'interrupts' properties).  The device tree data must then be mapped
onto a pdata structure; which the driver immediately turns around and
unmaps from pdata to populate it's driver state structure.  It ends up
being a lot of indirection to follow.
- Many (but perhaps not all) of these devices will be registered as an
of_device anyway.  By having a constructor to generate a
platform_device from that means each device will get probed twice;
once by the of_platform bus and once by the platform bus.
- Writing device drivers with multiple binding is easy and probable
results in smaller simpler code than the two step process of using a
constructor.

For example, here is my of_device binding for the systemace driver:

static int __devinit
ulite_of_probe(struct of_device *op, const struct of_device_id *match)
{
        struct resource res;
        const unsigned int *id;
        int irq, rc;
        dev_dbg(&op->dev, "%s(%p, %p)\n", __FUNCTION__, op, match);
        rc = of_address_to_resource(op->node, 0, &res);
        if (rc) {
                dev_err(&op->dev, "invalide address\n");
                return rc;
        }
        irq = irq_of_parse_and_map(op->node, 0);
        id = of_get_property(op->node, "port-number", NULL);
        return ulite_assign(&op->dev, id ? *id : -1, res.start, irq);
}

That's 3 calls to get data out of the device tree and one call to
setup the device.  The final 'ulite_assign()' call is called by both
the of_device and platform_device bindings.

To do the same thing with a constructor requires an additional
allocation and registration of a platform device structure and a pdata
structure.  Plus it requires the platform code to explicitly call a
set of helper functions to find and create platform devices for nodes
in the device tree.  (Unless you're thinking about leveraging the
of_platform probe code and have the .probe hook to the 'constructor'
bit)

What advantages do you see with the constructor approach?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

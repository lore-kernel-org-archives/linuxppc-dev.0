Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 029D667B3C
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 09:10:34 +1000 (EST)
Subject: Re: [RFC/PATCH 0/8] Overhaul of virt IRQ configuration. / Kill
	ppc64_interrupt_controller.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <1149029585.6507.39.camel@brick>
References: <1148935262.25048.31.camel@brick>
	<1148938117.5959.24.camel@localhost.localdomain>
	<1148997289.25048.153.camel@brick>
	<1149027185.9986.46.camel@localhost.localdomain>
	<1149029585.6507.39.camel@brick>
Content-Type: text/plain
Date: Wed, 31 May 2006 09:10:25 +1000
Message-Id: <1149030626.9986.79.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The fact that the allocation may be sparse does not mean it actually
> will be.  As long as code expects arbitrary remappings it will have a
> degree of robustness; but that does not mean that the mechanism by which
> remappings are done cannot instantiate simple mappings.  In other words,
> I'd like to see the concept of "irq offsets" being banished, but having
> re-mapping code be smart enough so that, for example, an MPIC that must
> deal with interrupt vectors 0..127 has these vectors made visible to the
> system at 16..143.
> 
> I think that the current virt irq remapping algorithm would provide you
> with exactly this behavior.

The current virt irq remapper is not very efficient. It's especially
slow in the critical path of real -> virt translation which is probably
why xics locally has a radix tree version. I suppose we could generalize
that in a "better" remapper using both the array and the radix tree
though.

Offsets sounded like a simpler thing, specially for platforms that don't
need arbitrary remappings, and less code/memory hungry (embedded
platformns would like that for example).

> In cases where we have a struct device_node, the struct device_node
> should have a pointer to the PIC (or the PIC's device_node), and the
> raw, unmodified interrupt line values.   When one wants to present an
> irq to generic code, we use the (PIC,line) information from the
> device_node to instantiate a virq.
> 
> If there is no struct device_node, you still have to come up with a
> (PIC,line) pair in order to get a virq.

I won't add anything to struct device node. Only remove from it. The
device node is only used initially when binding a given device to an
irq, no need to "cache" that in the struct device node or whatever. The
generic code will provide means for walking the interrupt tree along the
lines I described to obtain a line,PIC pair, which will then be looked
up in a table of PICs so an offset  can be obtained or a remapping of
the line into a global virq.

> virt_irq_create_mapping() (or whatever replaces it) should take the
> physical line and a PIC identifier/pointer as arguments so that it can
> inform the PIC about a mapping it has instantiated (in case we really
> have to make an arbitrary re-mapping) and so that it can try to
> instantiate an identity or offset-only translation if possible.  In the
> latter case, the PIC object will tell the remapper what offset range to
> use.

Sounds over complicated to me.

> I think our thoughts on this differ only on the aspect of whether the
> remapper is considered to be an arbitrary remapper, a smart
> implementation of which results in IRQ being remapped via offsets,
> versus multi-level remapping, with offsets first followed by arbitrary
> remappings as necessary (and the distinction between offsets and
> arbitrary remapping being visible beyond the remapper function).

Beware of over engineering :)

Ben.

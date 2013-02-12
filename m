Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 761F22C0323
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2013 19:53:47 +1100 (EST)
Message-ID: <1360659217.2035.5.camel@pasglop>
Subject: Re: [BUG] irq_dispose_mapping after irq request failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 12 Feb 2013 19:53:37 +1100
In-Reply-To: <20130212061822.GA8977@concordia>
References: <20130211053100.GB18462@sapphire.tkos.co.il>
 <20130211061949.GA5561@concordia> <20130211205255.72B513E3530@localhost>
 <1360630273.2035.2.camel@pasglop> <20130212061822.GA8977@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Baruch Siach <baruch@tkos.co.il>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-02-12 at 17:18 +1100, Michael Ellerman wrote:
> 
> I don't think you can, "active" is not well defined. Other code may have
> done nothing other than create the mapping and remembered the virq,
> which will break if you destroy the mapping. Or?

Active as in "requested". Yes there's a potential problems with multiple
requests for mappings & shared interrupts. This is not a problem for PCI
on powerpc because we don't free those mappings afaik.

> I agree refcounting is not fun. It'll end up with the same mess as
> of_node_get/put() where practically every 2nd piece of code leaks
> references.
> 
> I guess we can't go the other way, and say that mapping the same hwirq
> twice is an error.

Might be worth it, and force the sharing case to be handled at some kind
of upper level (bus or platform).

Ben.

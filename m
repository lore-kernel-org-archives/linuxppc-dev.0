Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTD4y04y3zDvpJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 19:25:37 +1100 (AEDT)
Message-ID: <1480494324.3459.9.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/opal-irqchip: Use interrupt names if present
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc dev list
 <linuxppc-dev@lists.ozlabs.org>, "stewart@linux.vnet.ibm.com"
 <stewart@linux.vnet.ibm.com>
Date: Wed, 30 Nov 2016 19:25:24 +1100
In-Reply-To: <1480494084.3459.7.camel@kernel.crashing.org>
References: <1480463779.11342.79.camel@kernel.crashing.org>
 <87d1hdpf0r.fsf@concordia.ellerman.id.au>
 <1480494084.3459.7.camel@kernel.crashing.org>
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

On Wed, 2016-11-30 at 19:21 +1100, Benjamin Herrenschmidt wrote:
> 
> There isn't one. The existing "opal-interrupts" from day one was a
> bit
> weird anyway, it's not a proper "interrupts" property to begin with,
> but it's unfixable now. Also I don't think there's a generic way to
> name interrupts either.
> 
> So for this specific case, just adding a new prop with a string-list
> matching 1:1 the entries in "opal-interrupts" is the most logical
> choice.

I spoke too soon... people have come up with an "interrupt-names"
property that matches a corresponding standard "interrupts" property.

The format is the same, a string-list with an entry per entry in
"interrupts".

So we have choices here... we could use the standard for both, making
OPAL generate both the old property and the new property "pair", then
make the code in linux look for the new one(s) and fallback, or we can
just add opal-interrupt-names, which is less churn but keeps it non-
standard.

I do have a soft-spot for going down the standard path even if it means
effectively duplicating the information between two properties. We'll
probably never be able to get rid of the old one, unless we backport
enough to make the new one mandatory for P9 in which case skiboot can
drop the "legacy" one on P9 and later.

Cheers,
Ben

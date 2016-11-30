Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTD0J2gpdzDvJD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 19:21:36 +1100 (AEDT)
Message-ID: <1480494084.3459.7.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/opal-irqchip: Use interrupt names if present
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc dev list
 <linuxppc-dev@lists.ozlabs.org>, "stewart@linux.vnet.ibm.com"
 <stewart@linux.vnet.ibm.com>
Date: Wed, 30 Nov 2016 19:21:24 +1100
In-Reply-To: <87d1hdpf0r.fsf@concordia.ellerman.id.au>
References: <1480463779.11342.79.camel@kernel.crashing.org>
 <87d1hdpf0r.fsf@concordia.ellerman.id.au>
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

On Wed, 2016-11-30 at 19:07 +1100, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Recent versions of OPAL will be able to provide names for the
> > various
> > OPAL interrupts via a new "opal-interrupt-names" property. So let's
> > use them to make /proc/interrupts more informative.
> 
> I guess there's no point asking whether there's a generic device tree
> spec for this sort of thing, and if so whether we should use it?

There isn't one. The existing "opal-interrupts" from day one was a bit
weird anyway, it's not a proper "interrupts" property to begin with,
but it's unfixable now. Also I don't think there's a generic way to
name interrupts either.

So for this specific case, just adding a new prop with a string-list
matching 1:1 the entries in "opal-interrupts" is the most logical
choice.

Cheers,
Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1E76B6FA0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 15:46:28 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix xmon ml/mz commands to work with 64-bit
	values
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1304484194.2513.348.camel@pasglop>
References: <20110408121822.GG2754@zod.rchland.ibm.com>
	<1304484194.2513.348.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 May 2011 15:46:20 +1000
Message-ID: <1304487980.2513.355.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-04 at 14:43 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2011-04-08 at 08:18 -0400, Josh Boyer wrote:
> > The ml and and mz commands in xmon currently only work on 32-bit values.
> > This leads to odd issues when trying to use them on a ppc64 machine.  If
> > one specified 64-bit addresses to mz, it would loop on the same output
> > indefinitely.  The ml command would fail to find any 64-bit values in a
> > memory range, even though one could clearly see them present with the d
> > command.
> > 
> > This adds a small function that mimics GETWORD, but works for 64-bit
> > values.  The data types involved in these commands are also changed to
> > 'unsigned long' instead of just 'unsigned'.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> Well if you're going to mimic GETWORD, why not replace it everywhere ?
> 
> Or just do that :-)
> 
> #if BITS_PER_LONG == 32
> #define GETLONG(v)	GETWORD(v)
> #else
> #define GETLONG(v)	((GETWORD(v) << 32) | GETWORD(v + 4))
> #endif

Note that Paul mentions the whole thing is pretty much useless
anyways :-)

It's a remnant of the xmon code running in "foreign" environments such
as little endian he reckons. You could probably just dereference the
value.

Now it has the side effect of potentially avoiding alignment interrupts
which might be a "good thing" but then, we don't do it everywhere in
xmon so it's pointless.

Cheers,
Ben.

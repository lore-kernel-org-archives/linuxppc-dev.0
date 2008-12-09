Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3FA1DDED9
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 14:05:34 +1100 (EST)
Subject: Re: [PATCH 3/9] powerpc/4xx: Extended DCR support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081208203011.GB10929@yoda.jdub.homelinux.org>
References: <1228714789.103940.266501677728.qpush@grosgo>
	<20081208054057.34A5FDDD04@ozlabs.org>
	<20081208203011.GB10929@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Tue, 09 Dec 2008 14:03:23 +1100
Message-Id: <1228791803.7101.51.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-08 at 15:30 -0500, Josh Boyer wrote:

> Can we call this CPU_FTRS_440x6 please?  The H really has no relevance
> here from what I understand as both the hard and synthysized x6 cores
> would do the indexed instructions.

I'll change that.

> I'm wondering how much that is worth it.  Aren't you adding a
> runtime if here (and in the *dcri functions), which might
> impact performance for anything not implementing m*dcrx?
> 
> Does anyone know how much impact this has either way, and if
> it's significant could it be patched out after the CPU
> features are set?

So whatever the construct, gcc generates something quite horrible, on
the other hand, written like this is probably the less horrible I've
seen. The performance penalty shouldn't be huge, DCR accesses are slow.

Now, what we can/should do, but I'd rather do that from a separate patch
after you also cleanup that 440x5 stuff for machine check, is to be more
pro-active in cputable,h, at defining which 440 variants are effectively
enabled in Kconfig, and reflecting that in CPU_FTRS_POSSIBLE and
CPU_FTRS_ALWAYS.

That way, the cpu_has_feature() statement would be resolved at compile
time (either way) for all cases where only one variant of 440 is
compiled in (most cases). Only the case where support for multiple
variants is compiled in would result in the actual condition being in
the final code.

A way to do this is to define CONFIG_PPC_440x0, x5 and x6 and have those
be select'ed by the various SoC types which are themselves selected by
the platforms (I use x0 as "anything < x5" here). Then we can use these
to selectively or/and in thse various CPU features in cputable.h
"possible" and "always" masks.

So I'll resend the patch with just the 440H6->440x6 change and we'll do
those feature improvements in a separate patch.
 
Cheers,
Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB870DDF23
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 15:19:22 +1000 (EST)
Subject: Re: [PATCH] kill useless SMT code in prom_hold_cpus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080715022440.GU9594@localdomain>
References: <20080708223631.GP9594@localdomain>
	<1216087555.7740.42.camel@pasglop> <20080715022440.GU9594@localdomain>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 14:53:33 +1000
Message-Id: <1216097613.7740.52.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-14 at 21:24 -0500, Nathan Lynch wrote:
> Benjamin Herrenschmidt wrote:
> > On Tue, 2008-07-08 at 17:36 -0500, Nathan Lynch wrote:
> > > I think this code that counts SMT threads and compares against NR_CPUS
> > > is an artifact of pre-powerpc-merge ppc64.  We care about starting
> > > only primary threads in the OF client code.
> > > 
> > > Signed-off-by: Nathan Lynch <ntl@pobox.com>
> > 
> > That looks good. I'm not merging it right now because I want to dbl
> > check that it's allright on all SMT machines. IE. We compare reg[0]
> > against _prom->cpu now instead of interrupt_server[0] and I thus
> > want to ensure it's the same everywhere.
> 
> Thanks.  Looks like prom_find_boot_cpu is setting _prom->cpu to reg
> (or 0), so I think it should be fine... a system where reg differed
> from interrupt_server[0] would have been broken before this patch
> anyway, I think?

I tend to agree, just didn't have time to look closely / test before
I get to prepare my batch of patches for Linus, I'll stick it in the
next one.

Cheers,
Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B16CDDE38
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 06:56:14 +1100 (EST)
Subject: Re: [RFC/PATCH] powerpc: Fix 8xx build breakage due to _tlbie changes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <20071119060623.67387f2c@vader.jdub.homelinux.org>
References: <1195454481.61987.176042550045.qpush@grosgo>
	<20071119064209.03A53DDE21@ozlabs.org>
	<20071119060623.67387f2c@vader.jdub.homelinux.org>
Content-Type: text/plain
Date: Tue, 20 Nov 2007 06:50:26 +1100
Message-Id: <1195501826.6539.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Index: linux-work/arch/powerpc/mm/mmu_decl.h
> > ===================================================================
> > --- linux-work.orig/arch/powerpc/mm/mmu_decl.h	2007-11-15 14:09:16.000000000 +1100
> > +++ linux-work/arch/powerpc/mm/mmu_decl.h	2007-11-15 14:14:29.000000000 +1100
> > @@ -56,7 +56,7 @@ extern unsigned long total_lowmem;
> >   * architectures.  -- Dan
> >   */
> >  #if defined(CONFIG_8xx)
> > -#define flush_HPTE(X, va, pg)	_tlbie(va)
> > +#define flush_HPTE(X, va, pg)	_tlbie(va, 0, /* 8xx doesn't care about PID */)
> 
> Spurious ','?

Weird, it did build ...

Ben.

Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9B4A6B722C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 09:24:11 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7AF28DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 09:24:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19001.31402.236289.767105@cargo.ozlabs.ibm.com>
Date: Thu, 18 Jun 2009 09:22:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/6] perf_counter: powerpc: Enable use of software
	counters on 32-bit powerpc
In-Reply-To: <A731338A-E954-46D9-8BF7-6E74C797209C@kernel.crashing.org>
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
	<A731338A-E954-46D9-8BF7-6E74C797209C@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala writes:

> On Jun 17, 2009, at 6:50 AM, Paul Mackerras wrote:

> > +config PPC_HAVE_PMU_SUPPORT
> > +       bool
> 
> what does this mean?

At the moment it means that arch/powerpc/kernel/perf_counters.c works
for at least some processors in the selected processor family.

> > +
> > +config PPC_PERF_CTRS
> > +       def_bool y
> > +       depends on PERF_COUNTERS && PPC_HAVE_PMU_SUPPORT
> > +       help
> > +         This enables the powerpc-specific perf_counter back-end.
> 
> Can we distinguish between the two different architected perf counters  
> programming models to start with.  Maybe something like:
> 
> PPC_BOOK3S_PERF_CTRS and PPC_BOOK3E_PERF_CTRS (or  
> PPC_SERVER_PERF_CTRS / PPC_EMB_PERF_CTRS)

We can do that once we have code to support the Freescale embedded PMU
and we know how much of arch/powerpc/kernel/perf_counters.c is or
isn't useful there.  We don't have to get to the final state in one
patch.  I'd rather put this patch in as-is and then see a patch series
that adds the Freescale embedded PMU support and makes whatever
Kconfig changes are necessary later.

Paul.

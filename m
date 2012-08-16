Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 205F02C0092
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2012 21:45:15 +1000 (EST)
Message-ID: <1345117498.29668.23.camel@twins>
Subject: Re: powerpc/perf: hw breakpoints return ENOSPC
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Michael Neuling <mikey@neuling.org>
Date: Thu, 16 Aug 2012 13:44:58 +0200
In-Reply-To: <20344.1345115849@neuling.org>
References: <28857.1345091034@neuling.org>
 <1345102812.31459.114.camel@twins> <20344.1345115849@neuling.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>,
 K Prasad <prasad@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-08-16 at 21:17 +1000, Michael Neuling wrote:
> Peter,
>=20
> > > On this second syscall, fetch_bp_busy_slots() sets slots.pinned to be=
 1,
> > > despite there being no breakpoint on this CPU.  This is because the c=
all
> > > the task_bp_pinned, checks all CPUs, rather than just the current CPU=
.
> > > POWER7 only has one hardware breakpoint per CPU (ie. HBP_NUM=3D1), so=
 we
> > > return ENOSPC.
> >=20
> > I think this comes from the ptrace legacy, we register a breakpoint on
> > all cpus because when we migrate a task it cannot fail to migrate the
> > breakpoint.
> >=20
> > Its one of the things I hate most about the hwbp stuff as it relates to
> > perf.
> >=20
> > Frederic knows more...
>=20
> Maybe I should wait for Frederic to respond but I'm not sure I
> understand what you're saying.
>=20
> I can see how using ptrace hw breakpoints and perf hw breakpoints at the
> same time could be a problem, but I'm not sure how this would stop it.

ptrace uses perf for hwbp support so we're stuck with all kinds of
stupid ptrace constraints.. or somesuch.

> Are you saying that we need to keep at least 1 slot free at all times,
> so that we can use it for ptrace?

No, I'm saying perf-hwbp is weird because of ptrace, maybe the ptrace
weirdness shouldn't live in perf-hwpb but in the ptrace-perf glue
however..

> Is "perf record -e mem:0x10000000 true" ever going to be able to work on
> POWER7 with only one hw breakpoint resource per CPU? =20

I think it should work... but I'm fairly sure it currently doesn't
because of how things are done. 'perf record -ie mem:0x100... true'
might just work.

I always forget all the ptrace details but I am forever annoyed at the
mess that is perf-hwbp.. Frederic is there really nothing we can do
about this?

The fact that ptrace hwbp semantics are different per architecture
doesn't help of course.

Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZ0BR51yCzDsW5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 21:46:39 +1000 (AEST)
Message-ID: <1473853599.22937.85.camel@neuling.org>
Subject: Re: [PATCH 0/2] Enable MSR_TM lazily
From: Michael Neuling <mikey@neuling.org>
To: Nicholas Piggin <npiggin@gmail.com>, Cyril Bur <cyrilbur@gmail.com>,
 Carlos Eduardo Seo <cseo@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 wei.guo.simon@gmail.com,  anton@samba.org
Date: Wed, 14 Sep 2016 21:46:39 +1000
In-Reply-To: <20160914212824.4936a9a2@roar.ozlabs.ibm.com>
References: <20160914080216.13833-1-cyrilbur@gmail.com>
 <20160914212824.4936a9a2@roar.ozlabs.ibm.com>
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

On Wed, 2016-09-14 at 21:28 +1000, Nicholas Piggin wrote:
> Cc'ing Carlos
>=20
> On Wed, 14 Sep 2016 18:02:14 +1000
> Cyril Bur <cyrilbur@gmail.com> wrote:
>=20
> >=20
> > Currently the kernel checks to see if the hardware is transactional
> > memory capable and always enables the MSR_TM bit. The problem with
> > this is that the TM related SPRs become available to userspace,
> > requiring them to be switched between processes. It turns out these
> > SPRs are expensive to read and write and if a thread doesn't use TM
> > (or worse yet isn't even TM aware) then context switching incurs this
> > penalty for nothing.
> >=20
> > The solution here is to leave the MSR_TM bit disabled and enable it
> > more 'on demand'. Leaving MSR_TM disabled cause a thread to take a
> > facility unavailable fault if and when it does decide to use TM. As
> > with recent updates to the FPU, VMX and VSX units the MSR_TM bit will
> > be enabled upon taking the fault and left on for some time afterwards
> > as the assumption is that if a thread used TM ones it may well use it
> > again. The kernel will turn the MSR_TM bit off after some number of
> > context switches of that thread.
> >=20
> > Performance numbers haven't been completely gathered as yet but early
> > runs of tools/testing/selftests/powerpc/benchmarks/context_switch
> > (which doesn't use TM) yields a jump from ~160000 switches per second
> > to ~180000 switches per second with patch 3/3 applied.
> Cool!
>=20
> Question: glibc when built with lock elision seems like it will
> execute tabort. before every syscall, to work around old kernel
> behaviour. That's always going to fault TM on, isn't it?

I think we might be able to detect this case in the kernel. If it's a tabor=
t
that's trapped on, we can't have been transactional. =C2=A0Hence we can saf=
ely PC+=3D4
and leave off TM off.=C2=A0

It would cost us a get_user(inst, regs->nip); but it might be worth it for =
this
special but common case.

> How common it is for glibc to be built with elision?

IIRC Ubuntu uses it on 16.04 (and maybe 15.10).

> We should probably be testing PPC_FEATURE2_HTM_NOSC to skip the
> tabort.

Agree, that would be idea. Binary patching glic at runtime.

> (BTW, this is a pretty good writeup, would you consider adding
> a bit more of it to patch 2 so it gets into the changelog?)

Agreed.

Mikey

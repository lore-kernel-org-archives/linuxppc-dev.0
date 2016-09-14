Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZ0mL0QgWzDsW4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 22:12:34 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id g202so721532pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 05:12:33 -0700 (PDT)
Date: Wed, 14 Sep 2016 22:12:22 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Cc: Cyril Bur <cyrilbur@gmail.com>, Carlos Eduardo Seo
 <cseo@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, wei.guo.simon@gmail.com, anton@samba.org
Subject: Re: [PATCH 0/2] Enable MSR_TM lazily
Message-ID: <20160914221222.57e84324@roar.ozlabs.ibm.com>
In-Reply-To: <1473853599.22937.85.camel@neuling.org>
References: <20160914080216.13833-1-cyrilbur@gmail.com>
 <20160914212824.4936a9a2@roar.ozlabs.ibm.com>
 <1473853599.22937.85.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 14 Sep 2016 21:46:39 +1000
Michael Neuling <mikey@neuling.org> wrote:

> On Wed, 2016-09-14 at 21:28 +1000, Nicholas Piggin wrote:
> > Cc'ing Carlos
> >=20
> > On Wed, 14 Sep 2016 18:02:14 +1000
> > Cyril Bur <cyrilbur@gmail.com> wrote:
> >  =20
> > >=20
> > > Currently the kernel checks to see if the hardware is transactional
> > > memory capable and always enables the MSR_TM bit. The problem with
> > > this is that the TM related SPRs become available to userspace,
> > > requiring them to be switched between processes. It turns out these
> > > SPRs are expensive to read and write and if a thread doesn't use TM
> > > (or worse yet isn't even TM aware) then context switching incurs this
> > > penalty for nothing.
> > >=20
> > > The solution here is to leave the MSR_TM bit disabled and enable it
> > > more 'on demand'. Leaving MSR_TM disabled cause a thread to take a
> > > facility unavailable fault if and when it does decide to use TM. As
> > > with recent updates to the FPU, VMX and VSX units the MSR_TM bit will
> > > be enabled upon taking the fault and left on for some time afterwards
> > > as the assumption is that if a thread used TM ones it may well use it
> > > again. The kernel will turn the MSR_TM bit off after some number of
> > > context switches of that thread.
> > >=20
> > > Performance numbers haven't been completely gathered as yet but early
> > > runs of tools/testing/selftests/powerpc/benchmarks/context_switch
> > > (which doesn't use TM) yields a jump from ~160000 switches per second
> > > to ~180000 switches per second with patch 3/3 applied. =20
> > Cool!
> >=20
> > Question: glibc when built with lock elision seems like it will
> > execute tabort. before every syscall, to work around old kernel
> > behaviour. That's always going to fault TM on, isn't it? =20
>=20
> I think we might be able to detect this case in the kernel. If it's a tab=
ort
> that's trapped on, we can't have been transactional. =C2=A0Hence we can s=
afely PC+=3D4
> and leave off TM off.=C2=A0
>=20
> It would cost us a get_user(inst, regs->nip); but it might be worth it fo=
r this
> special but common case.

That would take an extra trap for every syscall, I think.


> > How common it is for glibc to be built with elision? =20
>=20
> IIRC Ubuntu uses it on 16.04 (and maybe 15.10).

Ah yes, but I was wrong: it also has to be linked against -lpthread
because it depends on r13 !=3D 0. That's why I couldn't see it in my
trace. Now I do when using -lpthread. On 16.04.


> > We should probably be testing PPC_FEATURE2_HTM_NOSC to skip the
> > tabort. =20
>=20
> Agree, that would be idea. Binary patching glic at runtime.

That would be nice. Does glibc support binary patching? I'm not very
familiar with the code. Current syscall code ends up something like
this:

    cmpdi    13,0
    beq      1f
    lwz      0,TM_CAPABLE(13)
    cmpwi    0,0
    beq      1f
    li       11,_ABORT_SYSCALL
    tabort.  11
    .align 4
1:
    li 0,syscall
    sc

Without runtime patching, then if we had another variable that meant
we are TM capable *and* need to issue a tabort., then we can do the
same sequence without extra instructions. That might be the first
step.

Thanks,
Nick

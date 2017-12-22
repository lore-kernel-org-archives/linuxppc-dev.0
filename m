Return-Path: <groug@kaod.org>
Received: from 2.mo1.mail-out.ovh.net (2.mo1.mail-out.ovh.net [178.32.119.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z36g12VHHzDrXN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 23:06:20 +1100 (AEDT)
Received: from player795.ha.ovh.net (gw6.ovh.net [213.251.189.206])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 32A4CB7856
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 12:58:54 +0100 (CET)
Date: Fri, 22 Dec 2017 12:58:47 +0100
From: Greg Kurz <groug@kaod.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@ozlabs.org>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, kvm-ppc@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Book3S: fix XIVE migration of pending interrupts
Message-ID: <20171222125847.1e5a4f5f@bahia.lan>
In-Reply-To: <87wp1fnh27.fsf@concordia.ellerman.id.au>
References: <20171212120204.6799-1-clg@kaod.org>
 <4be897d4-2d54-305b-8416-b32384de73a9@redhat.com>
 <878tdvpeib.fsf@concordia.ellerman.id.au>
 <20171222075430.GB6945@fergus.ozlabs.ibm.com>
 <87wp1fnh27.fsf@concordia.ellerman.id.au>
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

On Fri, 22 Dec 2017 22:22:08 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Paul Mackerras <paulus@ozlabs.org> writes:
>=20
> > On Fri, Dec 22, 2017 at 03:34:20PM +1100, Michael Ellerman wrote: =20
> >> Laurent Vivier <lvivier@redhat.com> writes:
> >>  =20
> >> > On 12/12/2017 13:02, C=C3=A9dric Le Goater wrote: =20
> >> >> When restoring a pending interrupt, we are setting the Q bit to for=
ce
> >> >> a retrigger in xive_finish_unmask(). But we also need to force an E=
OI
> >> >> in this case to reach the same initial state : P=3D1, Q=3D0.
> >> >>=20
> >> >> This can be done by not setting 'old_p' for pending interrupts which
> >> >> will inform xive_finish_unmask() that an EOI needs to be sent.
> >> >>=20
> >> >> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> >> ---
> >> >>=20
> >> >>  Tested with a guest running iozone.
> >> >>=20
> >> >>  arch/powerpc/kvm/book3s_xive.c | 4 ++--
> >> >>  1 file changed, 2 insertions(+), 2 deletions(-) =20
> >> >
> >> > We really need this patch to fix VM migration on POWER9.
> >> > When will it be merged? =20
> >>=20
> >> Paul is away, so I'll merge it via the powerpc tree.
> >>=20
> >> I'll mark it:
> >>=20
> >>   Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE =
interrupt controller")
> >>   Cc: stable@vger.kernel.org # v4.12+ =20
> >
> > Thanks for doing that.
> >
> > If you felt like merging Alexey's patch "KVM: PPC: Book3S PR: Fix WIMG
> > handling under pHyp" with my acked-by, that would be fine too.  The
> > commit message needs a little work - the reason for using HPTE_R_M is
> > not just because it seems to work, but because current POWER
> > processors require M set on mappings for normal pages, and pHyp
> > enforces that. =20
>=20
> OK. I saw this too late, but I'll pick that one up next week. If someone
> sends me an updated change log I will merge all of their patches for
> ever.
>=20

Really ? Opportunity makes the thief, so here's my take :P

8<---------------------------------------------------------------------->8
KVM: PPC: Book3S: fix XIVE migration of pending interrupts

96df226 "KVM: PPC: Book3S PR: Preserve storage control bits" added WIMG
bits preserving but it missed 2 special cases:
- a magic page in kvmppc_mmu_book3s_64_xlate() and
- guest real mode in kvmppc_handle_pagefault().

For these ptes WIMG were 0 and pHyp failed on these causing a guest to
stop in the very beginning at NIP=3D0x100 (due to bd9166ffe
"KVM: PPC: Book3S PR: Exit KVM on failed mapping").

According to LoPAPR v1.1 14.5.4.1.2 H_ENTER:

 The hypervisor checks that the WIMG bits within the PTE are appropriate
 for the physical page number else H_Parameter return. (For System Memory
 pages WIMG=3D0010, or, 1110 if the SAO option is enabled, and for IO pages
 WIMG=3D01**.)

This hence initializes WIMG to non-zero value HPTE_R_M (0x10), as expected
by pHyp.

Fixes: 96df226 "KVM: PPC: Book3S PR: Preserve storage control bits"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
8<---------------------------------------------------------------------->8

Cheers,

--
Greg

> cheers
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KkQS5KgZzF27h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 13:46:56 +1000 (AEST)
Message-ID: <cc2f3d4526039cf71e4dac1c0a231e27d59cb4c0.camel@neuling.org>
Subject: Re: [PATCH] powerpc/tm: Avoid possible userspace r1 corruption on
 reclaim
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 paulus@ozlabs.org, benh@kernel.crashing.org, Breno Leitao
 <leitao@debian.org>,  aneesh.kumar@linux.vnet.ibm.com
Date: Wed, 26 Sep 2018 13:46:56 +1000
In-Reply-To: <87d0t14wiz.fsf@concordia.ellerman.id.au>
References: <20180925093647.23723-1-mikey@neuling.org>
 <87d0t14wiz.fsf@concordia.ellerman.id.au>
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

On Tue, 2018-09-25 at 22:00 +1000, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
> > Current we store the userspace r1 to PACATMSCRATCH before finally
> > saving it to the thread struct.
> >=20
> > In theory an exception could be taken here (like a machine check or
> > SLB miss) that could write PACATMSCRATCH and hence corrupt the
> > userspace r1. The SLB fault currently doesn't touch PACATMSCRATCH, but
> > others do.
> >=20
> > We've never actually seen this happen but it's theoretically
> > possible. Either way, the code is fragile as it is.
> >=20
> > This patch saves r1 to the kernel stack (which can't fault) before we
> > turn MSR[RI] back on. PACATMSCRATCH is still used but only with
> > MSR[RI] off. We then copy r1 from the kernel stack to the thread
> > struct once we have MSR[RI] back on.
> >=20
> > Suggested-by: Breno Leitao <leitao@debian.org>
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >  arch/powerpc/kernel/tm.S | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
> > index 701b0f5b09..8207816a1e 100644
> > --- a/arch/powerpc/kernel/tm.S
> > +++ b/arch/powerpc/kernel/tm.S
> > @@ -178,6 +178,12 @@ _GLOBAL(tm_reclaim)
> > =20
> >  	std	r11, GPR11(r1)			/* Temporary stash */
> > =20
> > +	/* Move r1 to kernel stack in case PACATMSCRATCH is used once
> > +	 * we turn on RI
> > +	 */
>=20
> I see we still need to send you to Comment Formatting Re-Education Camp.

The rest of that file has they style, so I'm just keeping with that.  I can
submit a patch later to fix them all up.

> I rewrote it a bit too, to hopefully be clearer?
>=20
> 	/*
> 	 * Move the saved user r1 to the kernel stack in case PACATMSCRATCH is
> 	 * clobbered by an exception once we turn on MSR_RI below.
> 	 */
> 	ld	r11, PACATMSCRATCH(r13)
> 	std	r11, GPR1(r1)

Yeah, that's clearer... thanks.

Mikey

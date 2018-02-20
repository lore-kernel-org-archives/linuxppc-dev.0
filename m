Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlpwF2bdyzF0WY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 16:25:01 +1100 (AEDT)
Message-ID: <1519104300.5655.2.camel@neuling.org>
Subject: Re: [RFC PATCH 05/12] [WIP] powerpc/tm: Reclaim/recheckpoint on
 entry/exit
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 20 Feb 2018 16:25:00 +1100
In-Reply-To: <1519098854.6563.15.camel@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
 <20180220002241.29648-6-cyrilbur@gmail.com>
 <1519095033.7360.52.camel@neuling.org> <1519098854.6563.15.camel@gmail.com>
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


> > > @@ -1055,6 +1082,8 @@ void restore_tm_state(struct pt_regs *regs)
> > >  	msr_diff =3D current->thread.ckpt_regs.msr & ~regs->msr;
> > >  	msr_diff &=3D MSR_FP | MSR_VEC | MSR_VSX;
> > > =20
> > > +	tm_recheckpoint(&current->thread);
> > > +
> >=20
> > So why do we do tm_recheckpoint at all? Shouldn't most of the tm_blah c=
ode go
> > away in process.c after all this?
> >=20
>=20
> I'm not sure I follow, we need to recheckpoint because we're going back
> to userspace? Or would you rather calling the tm.S code directly from
> the exception return path?

Yeah, I was thinking the point of this series was.  We do tm_reclaim right =
on
entry and tm_recheckpoint right on exit. =20

The bits in between (ie. the tm_blah() calls process.c) would mostly go awa=
y.


> Yes, I hope we'll be able to have a fairly big cleanup commit of tm_
> code in process.c at the end of this series.

Yep, agreed.

Mikey

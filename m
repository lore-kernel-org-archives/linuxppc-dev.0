Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvjwP1MR3zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 12:05:25 +1000 (AEST)
Message-ID: <1461722724.3233.32.camel@neuling.org>
Subject: Re: [PATCH] powerpc: Add support for userspace P9 copy paste
From: Michael Neuling <mikey@neuling.org>
To: Balbir Singh <bsingharora@gmail.com>, Chris Smart <chris@distroguy.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 27 Apr 2016 12:05:24 +1000
In-Reply-To: <571F1CA5.9020208@gmail.com>
References: <20160426002844.GA9198@x1.distroguy.com>
 <571F1CA5.9020208@gmail.com>
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

On Tue, 2016-04-26 at 17:45 +1000, Balbir Singh wrote:
> >=C2=A0
> > /*
> > =C2=A0* System calls.
> > @@ -508,6 +509,14 @@ BEGIN_FTR_SECTION
> > =C2=A0=C2=A0=C2=A0=C2=A0ldarx=C2=A0=C2=A0=C2=A0=C2=A0r6,0,r1
> > END_FTR_SECTION_IFSET(CPU_FTR_STCX_CHECKS_ADDRESS)
> >=C2=A0
> > +BEGIN_FTR_SECTION
> > +/*
> > + * A cp_abort (copy paste abort) here ensures that when context
> > switching, a
> > + * copy from one process can't leak into the paste of another.
> > + */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PPC_CP_ABORT
> I think the alignment issue has been called out, but it is not clear from
> the changelog that
> we do this during syscall_exit/syscalls.

I don't think we need this during syscall entry exit until we use this
in the kernel.

> And also, do we need to care about preemptions, etc by the scheduler?

This handles the userspace preemption case.

kernel support is not handled here, so kernel preemption is TBD.

Mikey

>=C2=A0
> >=C2=A0
> > +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> > +
> > #ifdef CONFIG_PPC_BOOK3S
> > /* Cancel all explict user streams as they will have no use after conte=
xt
> > =C2=A0* switch and will stop the HW from creating streams itself
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

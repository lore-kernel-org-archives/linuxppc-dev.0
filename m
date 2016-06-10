Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQryG0GKSzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 15:56:06 +1000 (AEST)
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rQryF0x5Bz9sCk
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Jun 2016 15:56:05 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id fg1so4340092pad.3
 for <linuxppc-dev@ozlabs.org>; Thu, 09 Jun 2016 22:56:05 -0700 (PDT)
Date: Fri, 10 Jun 2016 15:55:53 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/5] selftests/powerpc: Add test to check TM ucontext
 creation
Message-ID: <20160610155553.7240b3b9@camb691>
In-Reply-To: <87a8ivlzcc.fsf@possimpible.ozlabs.ibm.com>
References: <20160608040036.13064-1-cyrilbur@gmail.com>
 <20160608040036.13064-3-cyrilbur@gmail.com>
 <87a8ivlzcc.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 09 Jun 2016 15:12:51 +1000
Daniel Axtens <dja@axtens.net> wrote:

As stated in the cover-letter, this patch needs the most work and quite a lot
too.

Turns out the comment you took is wrong (the code actually does the opposite),
once again, just sent the series to get eyes on the actual patch.

> I'm trying not to be too nit picky or difficult on tests, so here's a
> pre-written commit message for you:
> 
> "The kernel sets up two sets of ucontexts if the signal was to be
> delivered while the thread was in a transaction. Expected behaviour is
> that the currently executing code is in the first and the checkpointed
> state (the state that will be rolled back to) is in the uc_link
> ucontext.
> 
> The reason for this is that:
> 
>  - code which is not TM aware and installs a signal handler will expect
>    to see/modify its currently running state in the uc.
> 
>  - but, that TM-unaware code may have dynamicially linked against code
>    which is TM aware and is doing HTM under the hood, so the
>    checkpointed state needs to be made available somewhere
> 
> Test if the live and checkpointed state is made stored correctly.
> Test:
>  - GPRs
>  - FP registers
>  - VMX
>  - VSX
> "
> 
> > +#define TBEGIN .long 0x7C00051D
> > +#define TSUSPEND .long 0x7C0005DD
> > +#define TRESUME .long 0x7C2005DD  
> You define these 3 opcodes in a number of files. I assume you're going
> to consolidate them in v2?
> 
> > + * The kernel sets up two sets of ucontexts if the signal was to be delivered
> > + * while the thread was in a transaction. Expected behaviour is that the
> > + * currently executing code is in the first and the checkpointed state (the
> > + * state that will be rolled back to) is in the uc_link ucontext.
> > + *
> > + * The reason for this is that code which is not TM aware and installs a signal
> > + * handler will expect to see/modify its currently running state in the uc,
> > + * this code may have dynamicially linked against code which is TM aware and is
> > + * doing HTM under the hood.  
> 
> I had real trouble parsing this sentence the first few times. I think
> it's missing a while:
> 
> The reason for this is that _while_ code which is not TM aware...
> 
> (Although it would be better in several sentences :P)
> 
> > +++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
> > @@ -0,0 +1,96 @@
> > +/*
> > + * Copyright 2016, Cyril Bur, IBM Corp.
> > + * Licensed under GPLv2.  
> Ironically, it seems this now needs to be GPLv2+, probably with the
> regular license grant paragraph.
> 
> > +	/* Always be 64bit, don't really care about 32bit */  
> Forgive my ignorance of the test suite: are we guaranteed this by the
> build system, or should we add a SKIP_IF() for it?
> > +	for (i = 0; i < NV_GPR_REGS && !fail; i++) {
> > +		fail = (ucp->uc_mcontext.gp_regs[i + 14] != gps[i]);
> > +		fail |= (tm_ucp->uc_mcontext.gp_regs[i + 14] != gps[i + NV_GPR_REGS]);
> > +	}
> > +	if (fail)
> > +		printf("Failed on %d GPR %lu or %lu\n", i - 1,
> > +				ucp->uc_mcontext.gp_regs[i + 13], tm_ucp->uc_mcontext.gp_regs[i + 13]);
> > +}
> > +  
> 
> Looking good otherwise!
> 
> Regards,
> Daniel

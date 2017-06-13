Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn7XM1g51zDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 21:56:35 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y7so20992556pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 04:56:35 -0700 (PDT)
Date: Tue, 13 Jun 2017 21:56:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: svaidy@linux.vnet.ibm.com, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, "Shreyas B .
 Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 13/14] powerpc/64: runlatch CTRL[RUN] set optimisation
Message-ID: <20170613215620.16831c69@roar.ozlabs.ibm.com>
In-Reply-To: <87zidcgq50.fsf@concordia.ellerman.id.au>
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-14-npiggin@gmail.com>
 <20170612171138.GB4340@drishya.in.ibm.com>
 <87zidcgq50.fsf@concordia.ellerman.id.au>
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

On Tue, 13 Jun 2017 20:04:27 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> writes:
> > * Nicholas Piggin <npiggin@gmail.com> [2017-06-12 09:58:34]:
> >  
> >> The CTRL register is read-only except bit 63 which is the run latch
> >> control. This means it can be updated with a mtspr rather than
> >> mfspr/mtspr.
> >> 
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
> >  
> >> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> >> index baae104b16c7..a44ea034c226 100644
> >> --- a/arch/powerpc/kernel/process.c
> >> +++ b/arch/powerpc/kernel/process.c
> >> @@ -1973,13 +1969,9 @@ void notrace __ppc64_runlatch_on(void)
> >>  void notrace __ppc64_runlatch_off(void)
> >>  {
> >>  	struct thread_info *ti = current_thread_info();
> >> -	unsigned long ctrl;
> >> 
> >>  	ti->local_flags &= ~_TLF_RUNLATCH;
> >> -
> >> -	ctrl = mfspr(SPRN_CTRLF);
> >> -	ctrl &= ~CTRL_RUNLATCH;
> >> -	mtspr(SPRN_CTRLT, ctrl);
> >> +	mtspr(SPRN_CTRLT, 0);  
> >
> > Good idea.  Writing to CTRL register can change only the RUN field.
> > Was this any different in older generations?  
> 
> No AFAICS back to 2.02.
> 
> > Anton and Ben kept the mfspr/mtspr part in earlier updates to this
> > routine.  
> 
> Doing the read/modify write is forward compatible vs a new writable
> field, whereas writing the whole register with a known value is not.

Can we call that an incompatible arch change and not worry about
it? ISA says we may expect TS (read-only) field to expand, but I
guess they could shoehorn something else in there.

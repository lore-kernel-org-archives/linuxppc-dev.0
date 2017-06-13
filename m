Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn6Vq2zSVzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 21:10:11 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id f127so18099393pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 04:10:11 -0700 (PDT)
Date: Tue, 13 Jun 2017 21:09:54 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 06/14] powerpc/64s: interrupt replay balance the return
 branch predictor
Message-ID: <20170613210954.0c82c47e@roar.ozlabs.ibm.com>
In-Reply-To: <8737b4i5bc.fsf@concordia.ellerman.id.au>
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-7-npiggin@gmail.com>
 <8737b4i5bc.fsf@concordia.ellerman.id.au>
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

On Tue, 13 Jun 2017 19:51:19 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > The __replay_interrupt code is branched to with bl, but the caller is
> > returned to directly with rfid from the interrupt.
> >
> > Instead return to a return stub that returns to the caller with blr,
> > which should do better with the return predictor.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/kernel/exceptions-64s.S | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index a04ee0d7f88e..d55201625ea3 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -1586,7 +1586,7 @@ _GLOBAL(__replay_interrupt)
> >  	 * we don't give a damn about, so we don't bother storing them.
> >  	 */
> >  	mfmsr	r12
> > -	mflr	r11
> > +	LOAD_REG_ADDR(r11, __replay_interrupt_return)  
> 
> Can you make it a local label, to make it clear nothing outside the file
> returns to there, and to not clutter the symbol map?

I can do that. Interrupt returns will now get significantly
attributed to this guy in profiles (and you can see it on some
sleep/wake workloads). __replay_interrupt is probably better
than arch_local_irq_restore, I guess.

Thanks,
Nick

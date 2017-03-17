Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkyBh6h7ZzDqc8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 18:48:28 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id p189so2882201pfp.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 00:48:28 -0700 (PDT)
Date: Fri, 17 Mar 2017 17:48:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc/pasemi,cbe: Do not process decremeter or
 external wakeup from powersave
Message-ID: <20170317174815.3e9686e2@roar.ozlabs.ibm.com>
In-Reply-To: <87r31wbfes.fsf@concordia.ellerman.id.au>
References: <20170315154350.6256-1-npiggin@gmail.com>
 <874lytldgw.fsf@concordia.ellerman.id.au>
 <87r31wbfes.fsf@concordia.ellerman.id.au>
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

On Fri, 17 Mar 2017 17:12:11 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > Nicholas Piggin <npiggin@gmail.com> writes:
> >  
> >> Hi,
> >>
> >> I would like to start using a dedicated stack for system reset interrupt
> >> and treat it as a Linux nmi, which makes it tricky to call complex
> >> interrupt handlers directly from the system reset trap handler.
> >>
> >> So I would like to remove the decrementer and external handler calls from
> >> Cell and Pasemi platforms' system reset handler. I think we can just
> >> remove them if they can be handled when they re-fire as normal interrupts?
> >> At the moment I don't have environments set up to test if this works.  
> >
> > My QS22 has booted OK with it applied, so it seems OK.
> >
> > I'll test it a bit more tomorrow.  
> 
> OK, seems fine, and I have a trace that shows it's definitely going
> through that path:

Thanks for testing it.

>  1)               |    .default_idle_call() {
>  1)               |      .arch_cpu_idle() {
>  1)               |        .cbe_power_save() {
>  1)   0.128 us    |          .prep_irq_for_idle();
>  1)               |          .system_reset_exception() {
>  1)   0.512 us    |            .cbe_system_reset_exception();
>  1)   6.016 us    |          }
>  1)               |          .do_IRQ() {

It seems to do the right thing. I think decrementer should be working
proprely by setting it to 1 to get another exception?

In that case I will add a changelog and submit the patch.

Thanks,
Nick

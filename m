Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59FBB67BB2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 08:38:23 +1000 (EST)
Subject: Re: Hang with isync
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Manoj Sharma <manoj.shar@gmail.com>
In-Reply-To: <d6dada100609201531oefd71ch8557067bbf77484e@mail.gmail.com>
References: <d6dada100609181828j1804f4f5ic0d1dd8a225980c@mail.gmail.com>
	<d6dada100609191816q75d1455cobeb1e0bd21dab8a8@mail.gmail.com>
	<1158788111.6002.310.camel@localhost.localdomain>
	<d6dada100609201531oefd71ch8557067bbf77484e@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 08:38:13 +1000
Message-Id: <1158791893.6002.327.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-09-20 at 15:31 -0700, Manoj Sharma wrote:
> This is the stack trace.
> 
> Registers:
> GPR00: 00069030 C01F3000 C01F1080 00000000 00048000 C0639F48 C01F1080
> FFFFFC18
> GPR08: C02203FC 00000020 C0638000 C01F31B0 42FEE022 1056A7F8 00FE502A
> 00000000
> GPR16: 00000000 FFC44232 00000000 00000000 FFC441EC 00080000 00010000
> 0000000A 
> GPR24: 00000000 0007CD80 00000CE0 00000000 00000000 C02B0000 00000000
> C02B0000
> 
> NIP; c0005da4 _<_nmask_and_or_msr+0x18/0x20 [kernel]>
> Trace; c0025328 _<check_pgt_cache+0x20/0x30 [kernel]>
> Trace; c0004f4c _<idled+0x58/0x70 [kernel]> 
> Trace; c0004f74 _<cpu_idle+0x10/0x24 [kernel]>
> Trace; c00012b0 _<rest_init+0x30/0x40 [kernel]>
> Trace; c02a45a4 _<start_kernel+0x168/0x17c [kernel]>
> Trace; c0000250 _<skpinv+0x1f8/0x234 [kernel]> 

Is this upstream 2.6.20 or do you have any additional patches ? (Like
Montavista stuff or RT linux or whatever ?)

It's unclear to me from just that backtrace what mask it is... it could
just be re-enabling interrupt and you have a stale IRQ line asserted....

Have you also checked the errata list for your 405 core, in case it has
a known issue ?

Ben.

> 
> On 9/20/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>         On Tue, 2006-09-19 at 18:16 -0700, Manoj Sharma wrote:
>         >         Hi,
>         >
>         >         We use linux kernel 2.4.20 on ppc405 and the system
>         hangs once
>         >         in a while when isync gets called in this function: 
>         >
>         >         _GLOBAL(_nmask_and_or_msr)
>         >             mfmsr   r0      /* Get current msr */
>         >             andc    r0,r0,r3    /* And off the bits set in
>         r3 (first
>         >         parm) */`
>         >             or  r0,r0,r4    /* Or on the bits in r4 (second
>         parm) */ 
>         >             sync            /* Some chip revs have problems
>         here... */
>         >             isync
>         >             mtmsr   r0      /* Update machine state */
>         >             isync
>         >             blr         /* Done */ 
>         >
>         >          2.5 onwards, I find that "sync; isync" has been
>         replaced by a
>         >         macro SYNC (defined only for 601). I don't find it
>         in any
>         >         changelog and reason for the change. 
>         >
>         >         Can someone give some information on this change?
>         
>         Regardless of the change... on 2.4, _nmask_and_or_msr() was
>         used for a
>         number of things. We would need to know where it was called
>         from with 
>         what values as arguments to have an idea of what's going
>         wrong. It's
>         probably not dying on the isync, but rather on the following
>         mtmsr due
>         to a problem with the values passed in....
>         
>         Ben.
>         
>         
>         
> 

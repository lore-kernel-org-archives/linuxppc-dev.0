Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Bqbs3XqtzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 17:15:53 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id k190-v6so5258426oib.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 00:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180408194821.19682-1-malat@debian.org>
 <20180620190038.3250-1-malat@debian.org>
 <87602cfkh5.fsf@concordia.ellerman.id.au>
In-Reply-To: <87602cfkh5.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 22 Jun 2018 09:15:39 +0200
Message-ID: <CA+7wUswdBvm+XCi6r6ewGFuSTAaV9FWmhUyV9vNKatCnurvL-A@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/32: Remove left over function prototypes
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 21, 2018 at 1:27 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Mathieu Malaterre <malat@debian.org> writes:
>
> > In commit 4aea909eeba3 ("powerpc: Add missing prototypes in setup_32.c")
>
> I don't have that commit ^ ?
>
> That might be because I squashed some of your fixes together or something?

I am doing an awful lots of mistakes these days. Indeed you've changed
one of my patch:

https://patchwork.kernel.org/patch/10240997/

This one appeared after a git rebase on my side.

> > diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
> > index 35ca309848d7..829ed66f0a40 100644
> > --- a/arch/powerpc/kernel/setup.h
> > +++ b/arch/powerpc/kernel/setup.h
> > @@ -19,9 +19,6 @@ void irqstack_early_init(void);
> >  void setup_power_save(void);
> >  unsigned long __init early_init(unsigned long dt_ptr);
> >  void __init machine_init(u64 dt_ptr);
> > -int __init ppc_setup_l2cr(char *str);
> > -int __init ppc_setup_l3cr(char *str);
> > -int __init ppc_init(void);
> >  #else
> >  static inline void setup_power_save(void) { };
> >  #endif
>
> I have:
>
> #ifdef CONFIG_PPC32
> void setup_power_save(void);
> #else
> static inline void setup_power_save(void) { };
> #endif

Correct.

Sorry for the noise.

>
> cheers

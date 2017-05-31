Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcsRm2xf9zDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 10:53:56 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id f27so498159pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 17:53:56 -0700 (PDT)
Date: Wed, 31 May 2017 10:53:35 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [RFC][PATCH] powerpc/64s: stop using r14 register
Message-ID: <20170531105335.5a57befe@roar.ozlabs.ibm.com>
In-Reply-To: <20170530190817.GW19390@naverao1-tp.localdomain>
References: <20170521140011.17548-1-npiggin@gmail.com>
 <20170530190817.GW19390@naverao1-tp.localdomain>
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

On Wed, 31 May 2017 00:38:17 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2017/05/22 12:00AM, Nicholas Piggin wrote:
> > I'd like to take over the r14 register for use as a per-cpu kernel
> > register similar to the way r13 is used for the paca.
> > 
> > r14 being the last non-volatile register gcc allocates, appears with
> > about 0.5% the frequency as r31 in (static) instructions. I haven't
> > counted dynamically how many extra spills and fills that removing it
> > causes, but I should. My guess is the memory ops saved by using
> > it as a per-cpu variable will significantly outweigh the cost of
> > losing it as a general use register.
> > 
> > This part of the patch is pretty mechanical. A couple of places (prom)
> > still have to use it, and I haven't quite understood the KVM code yet.
> > 
> > Question is whether this approach seems okay, and whether we should do
> > the same for 64e.
> > 
> > Thanks,
> > Nick
> > 
> > ---  
> 
> [snip]
> 
> > diff --git a/arch/powerpc/net/bpf_jit32.h 
> > b/arch/powerpc/net/bpf_jit32.h
> > index a8cd7e289ecd..52a30db033c1 100644
> > --- a/arch/powerpc/net/bpf_jit32.h
> > +++ b/arch/powerpc/net/bpf_jit32.h
> > @@ -44,9 +44,11 @@
> >   * A register	r4
> >   * X register	r5
> >   * addr param	r6
> > - * r7-r10	scratch
> > - * skb->data	r14
> > - * skb headlen	r15	(skb->len - skb->data_len)
> > + * scratch	r7-r8
> > + * skb headlen	r9	(skb->len - skb->data_len)
> > + * skb->data	r10
> > + * fixed regs	r13-r14
> > + * unused	r15
> >   * m[0]		r16
> >   * m[...]	...
> >   * m[15]	r31
> > @@ -58,8 +60,8 @@
> >  #define r_addr		6
> >  #define r_scratch1	7
> >  #define r_scratch2	8
> > -#define r_D		14
> > -#define r_HL		15
> > +#define r_HL		9
> > +#define r_D		10  
> 
> You'll also need changes in the JIT code itself, at least in 
> bpf_jit_build_prologue() and elsewhere -- some code expects r_D and r_HL 
> to be NVRs. It's probably easier to just choose other NVRs here...

Thanks for taking a look. We're out of non volatile registers here,
however... This is for PPC32 only by the looks, so the patch is not
required at all.

I should have looked a bit more closely.

Thanks,
Nick

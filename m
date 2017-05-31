Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wd08l5ZDPzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 15:56:23 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4V5rYWk043016
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 01:56:19 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2aspg3uu61-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 01:56:18 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 31 May 2017 15:56:14 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4V5u2c87340472
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 15:56:10 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4V5tc5b029555
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 15:55:38 +1000
Date: Wed, 31 May 2017 11:25:21 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [RFC][PATCH] powerpc/64s: stop using r14 register
References: <20170521140011.17548-1-npiggin@gmail.com>
 <20170530190817.GW19390@naverao1-tp.localdomain>
 <20170531105335.5a57befe@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531105335.5a57befe@roar.ozlabs.ibm.com>
Message-Id: <20170531055521.GX19390@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/05/31 10:53AM, Nicholas Piggin wrote:
> On Wed, 31 May 2017 00:38:17 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > On 2017/05/22 12:00AM, Nicholas Piggin wrote:
> > > I'd like to take over the r14 register for use as a per-cpu kernel
> > > register similar to the way r13 is used for the paca.
> > > 
> > > r14 being the last non-volatile register gcc allocates, appears with
> > > about 0.5% the frequency as r31 in (static) instructions. I haven't
> > > counted dynamically how many extra spills and fills that removing it
> > > causes, but I should. My guess is the memory ops saved by using
> > > it as a per-cpu variable will significantly outweigh the cost of
> > > losing it as a general use register.
> > > 
> > > This part of the patch is pretty mechanical. A couple of places (prom)
> > > still have to use it, and I haven't quite understood the KVM code yet.
> > > 
> > > Question is whether this approach seems okay, and whether we should do
> > > the same for 64e.
> > > 
> > > Thanks,
> > > Nick
> > > 
> > > ---  
> > 
> > [snip]
> > 
> > > diff --git a/arch/powerpc/net/bpf_jit32.h 
> > > b/arch/powerpc/net/bpf_jit32.h
> > > index a8cd7e289ecd..52a30db033c1 100644
> > > --- a/arch/powerpc/net/bpf_jit32.h
> > > +++ b/arch/powerpc/net/bpf_jit32.h
> > > @@ -44,9 +44,11 @@
> > >   * A register	r4
> > >   * X register	r5
> > >   * addr param	r6
> > > - * r7-r10	scratch
> > > - * skb->data	r14
> > > - * skb headlen	r15	(skb->len - skb->data_len)
> > > + * scratch	r7-r8
> > > + * skb headlen	r9	(skb->len - skb->data_len)
> > > + * skb->data	r10
> > > + * fixed regs	r13-r14
> > > + * unused	r15
> > >   * m[0]		r16
> > >   * m[...]	...
> > >   * m[15]	r31
> > > @@ -58,8 +60,8 @@
> > >  #define r_addr		6
> > >  #define r_scratch1	7
> > >  #define r_scratch2	8
> > > -#define r_D		14
> > > -#define r_HL		15
> > > +#define r_HL		9
> > > +#define r_D		10  
> > 
> > You'll also need changes in the JIT code itself, at least in 
> > bpf_jit_build_prologue() and elsewhere -- some code expects r_D and r_HL 
> > to be NVRs. It's probably easier to just choose other NVRs here...
> 
> Thanks for taking a look. We're out of non volatile registers here,
> however... This is for PPC32 only by the looks, so the patch is not
> required at all.

Ah, indeed. Good catch.

- Naveen

Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3fhz0WzzzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 22:09:07 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id o126so10537054pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 05:09:06 -0700 (PDT)
Date: Thu, 13 Apr 2017 22:08:41 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Balbir
 Singh <bsingharora@gmail.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Mahesh J Salgaonkar
 <mahesh@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] powernv:idle: Set LPCR_UPRT on wakeup from deep-stop
Message-ID: <20170413220841.68e75ec4@roar.ozlabs.ibm.com>
In-Reply-To: <20170413115434.GC2425@in.ibm.com>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
 <9be8410e0abe5ae1afa16a6f987c53046ef51757.1491996797.git.ego@linux.vnet.ibm.com>
 <8737ddq7py.fsf@skywalker.in.ibm.com>
 <1492056725.7236.95.camel@kernel.crashing.org>
 <1492064854.4624.48.camel@neuling.org>
 <20170413171817.2854f597@roar.ozlabs.ibm.com>
 <20170413115434.GC2425@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 13 Apr 2017 17:24:34 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> On Thu, Apr 13, 2017 at 05:18:17PM +1000, Nicholas Piggin wrote:
> > On Thu, 13 Apr 2017 16:27:34 +1000
> > Michael Neuling <mikey@neuling.org> wrote:
> >   
> > > On Thu, 2017-04-13 at 14:12 +1000, Benjamin Herrenschmidt wrote:  
> > > > On Thu, 2017-04-13 at 09:28 +0530, Aneesh Kumar K.V wrote:    
> > > > > >   #endif
> > > > > >        mtctr   r12
> > > > > >        bctrl
> > > > > > +/*
> > > > > > + * cur_cpu_spec->cpu_restore would restore LPCR to a
> > > > > > + * sane value that is set at early boot time,
> > > > > > + * thereby clearing LPCR_UPRT.
> > > > > > + * LPCR_UPRT is required if we are running in Radix mode.
> > > > > > + * Set it here if that be the case.
> > > > > > + */
> > > > > > +BEGIN_MMU_FTR_SECTION
> > > > > > +     mfspr   r3, SPRN_LPCR
> > > > > > +     LOAD_REG_IMMEDIATE(r4, LPCR_UPRT)
> > > > > > +     or      r3, r3, r4
> > > > > > +     mtspr   SPRN_LPCR, r3
> > > > > > +END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)    
> > > > 
> > > > We are probably better off saving the value somewhere during boot
> > > > and just "blasting" it whole back.    
> > > 
> > > We seem to touch LPCR in a bunch of places these days.  Not sure when "sometimes
> > >  during boot" should actually be.  
> > 
> > In the short term, what if we just save LPCR and restore it after calling
> > cpu_restore? As you say there are a lot of things that touch LPCR we're
> > not catching here.  
> 
> In that case can we skip calling cpu_restore in the idle_exit path
> altogether and simply restore LPCR to the value that the thread had
> before executing stop ?

Good question. For a minimal fix I would keep calling cpu_restore. I'd
like to get rid of it if we can though, but that might take a bit more
work.

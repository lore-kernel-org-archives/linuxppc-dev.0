Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQ2Cv1N4SzDqmv
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 10:51:23 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id c65so5487560pfl.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Aug 2017 17:51:23 -0700 (PDT)
Date: Sun, 6 Aug 2017 10:51:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/13] powerpc/64s: irq replay remove spurious irq reason
Message-ID: <20170806105106.1362d100@roar.ozlabs.ibm.com>
In-Reply-To: <1501974032.2664.135.camel@au1.ibm.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-9-npiggin@gmail.com>
 <1501974032.2664.135.camel@au1.ibm.com>
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

On Sun, 06 Aug 2017 09:00:32 +1000
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

> On Sun, 2017-08-06 at 03:02 +1000, Nicholas Piggin wrote:
> > HVI interrupts have always used 0x500, so remove the dead branch.  
> 
> Maybe we should fix that and "catch" in incorrect entry via 0x500
> which would mean the XIVE is trying to deliver guest irqs to the OS...

I should be more clear, when I say 0x500, it is only in reference to
the constant used by the soft-irq replay. After patch 6 the replay is
sent to the 0xea0 common handler.

> That can happen if some LPCR bits aren't set properly and/or KVM
> doesn't pull the guest in time. I had bugs like that in my early
> dev so I've been running with a b . at 0x500 for a while :-)

So that's a separate issue of hardware actually doing a 0x500. I
had this

http://patchwork.ozlabs.org/patch/750033/


> 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/kernel/exceptions-64s.S | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index 29253cecf713..566cf126c13b 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -1680,8 +1680,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_300)
> >  BEGIN_FTR_SECTION
> >  	cmpwi	r3,0xa00
> >  	beq	h_doorbell_common_msgclr
> > -	cmpwi	r3,0xea0
> > -	beq	h_virt_irq_common
> >  	cmpwi	r3,0xe60
> >  	beq	hmi_exception_common
> >  FTR_SECTION_ELSE  
> 

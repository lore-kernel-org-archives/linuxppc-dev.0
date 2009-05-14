Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id EFA6EDE023
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 00:18:37 +1000 (EST)
Date: Thu, 14 May 2009 16:18:35 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC Patch 6/6] Adapt kexec and samples code to recognise PPC64
	hardware breakpoint usage
In-Reply-To: <1242310317.8608.1.camel@concordia>
Message-ID: <alpine.LRH.2.00.0905141617480.2225@vixen.sonytel.be>
References: <20090514133312.360702378@prasadkr_t60p.in.ibm.com>
	<20090514134614.GG14229@in.ibm.com>
	<alpine.LRH.2.00.0905141557260.2225@vixen.sonytel.be>
	<1242310317.8608.1.camel@concordia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 15 May 2009, Michael Ellerman wrote:
> On Thu, 2009-05-14 at 15:59 +0200, Geert Uytterhoeven wrote:
> > On Thu, 14 May 2009, K.Prasad wrote:
> > > Modify kexec code to disable DABR registers before a reboot. Adapt the samples
> > > code to populate PPC64-arch specific fields.
> > > 
> > > Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> > > ---
> > >  arch/powerpc/kernel/machine_kexec_64.c   |    6 
> > >  samples/hw_breakpoint/data_breakpoint.c  |    4 
> > > 
> > > Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/machine_kexec_64.c
> > > ===================================================================
> > > --- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/machine_kexec_64.c	2009-05-14 00:17:24.000000000 +0530
> > > +++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/machine_kexec_64.c	2009-05-14 09:48:09.000000000 +0530
> > > @@ -24,6 +24,7 @@
> > >  #include <asm/sections.h>	/* _end */
> > >  #include <asm/prom.h>
> > >  #include <asm/smp.h>
> > > +#include <asm/hw_breakpoint.h>
> > >  
> > >  int default_machine_kexec_prepare(struct kimage *image)
> > >  {
> > > @@ -214,6 +215,9 @@
> > >  	put_cpu();
> > >  
> > >  	local_irq_disable();
> > > +#ifdef CONFIG_PPC64
> >    ^^^^^^^^^^^^^^^^^^^
> > > +	hw_breakpoint_disable();
> > > +#endif
> >    ^^^^^^
> > 
> > What about providing a dummy definition of hw_breakpoint_disable()
> > in <asm/hw_breakpoint.h> if !CONFIG_PPC64?
> 
> That would be good.
> 
> What would be better, is to notice that machine_kexec_64.c is only ever
> built for 64-bit - hence the name. And so no ifdefs or anything else is
> required.

Right ;-)

But that can't be said for other files, like e.g. arch/powerpc/kernel/ptrace.c.

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010

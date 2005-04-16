Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A30E367B38
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Apr 2005 10:50:28 +1000 (EST)
Date: Fri, 15 Apr 2005 17:50:26 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050416005026.GB1086@gate.ebshome.net>
References: <c3d0340b05041514362746169a@mail.gmail.com>
	<20050415221235.GA29802@gate.ebshome.net>
	<c3d0340b0504151609397d73f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b0504151609397d73f7@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Interrupt prioritization on linux for ppc440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Apr 15, 2005 at 04:09:08PM -0700, Shawn Jin wrote:
> On 4/15/05, Eugene Surovegin <ebs@ebshome.net> wrote:
> > On Fri, Apr 15, 2005 at 02:36:51PM -0700, Shawn Jin wrote:
> > >
> > > The home-made interrupt controller PIC supports interrupt priorities
> > > and critical/non-critical interrupts. I found that the current kernel
> > > doesn't support interrupt priorities.
> > 
> > Yes, we don't have IRQ priorities on 4xx. Theoretically, they can be
> > emulated in get_irq, but I really don't think it's worth it.
> 
> Hmmm...that's one way I thought of to implement IRQ priority. Why
> isn't it worth it? 

It will significantly complicate PIC code, so if we want to go down 
this road, there should be some _real_ reasons and examples, that such 
change will be beneficial. For all the time I have been working with 
4xx based designs, I never needed such functionality.

> ppc4xx_pic gets the first irq from the least
> significant bit by calling ffs(). So theoretically and maybe
> practically some external interrupts will keep UART's interrupt from
> being served.

Yeah, _theoretically_ this is possible, although, in this case I think 
UART IRQ starvation will be your least problem :).

> > > I noticed that the implementation of ppc4xx_pic.c disables all
> > > critical interrupts during initialization. To support critical
> > > interrupts, is it so simple that we change the handler of critical
> > > exception from CriticalInput to do_IRQ in head_44x.S?
> > 
> > No, it's not that simple. Linux doesn't support a notion of critical
> > IRQs versus normal ones. Until there is an infrastructure for this, it
> > doesn't make any sense to implement 4xx support.
> 
> What kind of infrastructure can you think of to support this? ppc440
> at least provides some interrupt processing registers (CSSR0/1) to
> differentiate critical and non-critical interrupts.

OK, think about local_irq_disable/enable, and all code which is 
affected by this. Should these function disable all IRQs or just 
normal ones? If just normal one, what will happen if your critical IRQ 
handler calls the code, which assumes it's non-reentrant, because it 
called local_irq_disable()? Etc..

I really think that if you need some special higher-priority IRQ 
context you'd better use RTAI or RTLinux. At least, they make clear 
(IIRC) that these IRQ contexts are special.

> 
> Another confusion about 440GP/GX UIC is the registers VCR (Vector
> Configuration Reg) and VR (Vector Reg). They seem to be totally
> useless on linux. The interrupt vector is already in the table of
> irq_desc[]. Why does the controller have to generate the address?

It's being generated only for critical IRQs, so yes, because we don't 
use them, it's completely useless for us.

What could be interesting, though, is to to make all 4xx IRQs 
critical, in this case we could use VR to quickly determine which IRQ 
was asserted, instead of current implementation when we use bit 
operations. Not sure, if performance gain is really worth the 
effort :)

-- 
Eugene

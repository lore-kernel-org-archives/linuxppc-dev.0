Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.196])
	by ozlabs.org (Postfix) with ESMTP id CDDCC67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 09:11:03 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id 40so477544rnz
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Apr 2005 16:11:02 -0700 (PDT)
Message-ID: <c3d0340b050418161112b879b5@mail.gmail.com>
Date: Mon, 18 Apr 2005 16:11:02 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: Shawn Jin <shawnxjin@gmail.com>,
	ppcembed <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050418220605.GE25352@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c3d0340b05041514362746169a@mail.gmail.com>
	<20050415221235.GA29802@gate.ebshome.net>
	<c3d0340b0504151609397d73f7@mail.gmail.com>
	<20050416005026.GB1086@gate.ebshome.net>
	<c3d0340b05041814144133a608@mail.gmail.com>
	<20050418220605.GE25352@gate.ebshome.net>
Subject: Re: Interrupt prioritization on linux for ppc440
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/18/05, Eugene Surovegin <ebs@ebshome.net> wrote:
> On Mon, Apr 18, 2005 at 02:14:23PM -0700, Shawn Jin wrote:
> >
> > > What could be interesting, though, is to to make all 4xx IRQs
> > > critical, in this case we could use VR to quickly determine which IRQ
> > > was asserted, instead of current implementation when we use bit
> > > operations. Not sure, if performance gain is really worth the
> > > effort :)
> >
> > If we use VR to determine which IRQ was asserted, it's kind of
> > reverse. We usually fetch a handler by its IRQ number. It could
> > require to change irq_desc[] and request_irq().
>=20
> You seems don't undestand what I'm talking about. VR can help us with
> determining what IRQ was asserted. It has nothing to do with irq_desc.

I guess I understand your statement of using VR to quickly determin
IRQ number. (VR - VCR) >> 9 is the irq number if UIC0_SR0 has the
highest priority, which  is quicker than bit searching.

However there could be a possible problem when a 2nd critical
interrupt is asserted before the 1st one is served. Then fetching the
VR returns the address for the 2nd interrupt. Of course if UIC can
queue interrupts when calculating VRs, there wouldn't be such a
problem.

Regards,
-Shawn.

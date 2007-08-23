Return-Path: <fernando@oss.ntt.co.jp>
Received: from serv1.oss.ntt.co.jp (serv1.oss.ntt.co.jp [222.151.198.98])
	by ozlabs.org (Postfix) with ESMTP id 16D09DDF38
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 15:27:30 +1000 (EST)
Subject: Re: [PATCH] ppc: remove unused amiga_request_irq and mach_request_irq
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18124.1417.743332.974941@cargo.ozlabs.ibm.com>
References: <1187767237.25624.11.camel@sebastian.kern.oss.ntt.co.jp>
	<18124.1417.743332.974941@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Aug 2007 14:27:27 +0900
Message-Id: <1187846847.12759.38.camel@sebastian.kern.oss.ntt.co.jp>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-08-22 at 19:44 +1000, Paul Mackerras wrote: 
> Fernando Luis Vázquez Cao writes:
> 
> > amiga_request_irq and mach_request_irq are never used, so delete them.
> 
> OK, but is there a particular reason you want to do this?
Hi Paul,

Thank you for your reply.

I am currently auditing all the interrupt handlers and related code
(request_irq(), free_irq(), and others of that ilk) and, in the process,
I found some dead code. Getting rid of this cruft would just make my
life easier.

The final goal of this audit is to determine whether the Linux interrupt
handlers are kdump-ready. With the advent of kdump it is now possible
that device drivers have to handle pending interrupts generated in the
context of a previous kernel. Any pending interrupts will come in as
soon as the IRQ is allocated, but, unfortunately, not all the device
drivers handle this situation properly.

Besides, I am also trying to determine if applying this patch:
http://lkml.org/lkml/2007/7/19/687
is a sane thing to do.

> The whole of arch/ppc is going away eventually, so I don't think we
> need to remove it piece by piece.
As Linas mentioned in his reply, cleaning things up first will probably
make things easier for you too.

Please consider merging the four patches I sent to the PPC mailing list.

Fernando

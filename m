Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whC2x4fk0zDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 21:17:29 +1000 (AEST)
Message-ID: <1496661424.31588.1.camel@kernel.crashing.org>
Subject: Re: [v2] powerpc: handle simultaneous interrupts at once
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <patch-notifications@ellerman.id.au>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Paul Mackerras <paulus@samba.org>, Scott Wood
 <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Jun 2017 21:17:04 +1000
In-Reply-To: <3wh9ph0pv2z9s7f@ozlabs.org>
References: <3wh9ph0pv2z9s7f@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-06-05 at 20:21 +1000, Michael Ellerman wrote:
> On Thu, 2017-03-16 at 08:55:45 UTC, Christophe Leroy wrote:
> > It often happens to have simultaneous interrupts, for instance
> > when having double Ethernet attachment. With the current
> > implementation, we suffer the cost of kernel entry/exit for each
> > interrupt.
> > 
> > This patch introduces a loop in __do_irq() to handle all interrupts
> > at once before returning.
> > 
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/45cb08f4791ce6a15c54598b4cb73d

Hrm, I hadn't noticed that patch...

We used to do that and then removed the code for it. There's a cost,
sometimes noticeable, to an extra call to ppc_md.get_irq.

Why not have your get_irq (or eoi) implementation set a per-cpu
requesting a new spin of the loop ?

We could move the xive force replay stuff to use the same thing.

Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40msww3cPlzF14v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 23:44:32 +1000 (AEST)
Message-ID: <d981664a47150acbe5eab9c666c9ce6676848037.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 5/5] powerpc/lib: inline memcmp() for small constant
 sizes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>, Mathieu Malaterre
 <malat@debian.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, LKML
 <linux-kernel@vger.kernel.org>
Date: Thu, 17 May 2018 23:44:15 +1000
In-Reply-To: <c184c807-dac0-0617-f449-492f5b6eeec1@c-s.fr>
References: <cover.1526553552.git.christophe.leroy@c-s.fr>
 <8a6f90d882c8b60e5fa0826cd23dd70a92075659.1526553552.git.christophe.leroy@c-s.fr>
 <CA+7wUsyEBW-sKiwP_KJpwuWC0JGi_Cg-xnxcnw0d_Wc7-GWeeA@mail.gmail.com>
 <c184c807-dac0-0617-f449-492f5b6eeec1@c-s.fr>
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

On Thu, 2018-05-17 at 15:21 +0200, Christophe LEROY wrote:
> > > +static inline int __memcmp8(const void *p, const void *q, int off)
> > > +{
> > > +       s64 tmp = be64_to_cpu(*(u64*)(p + off)) - be64_to_cpu(*(u64*)(q + off));
> > 
> > I always assumed 64bits unaligned access would trigger an exception.
> > Is this correct ?
> 
> As far as I know, an unaligned access will only occur when the operand 
> of lmw, stmw, lwarx, or stwcx. is not aligned.
> 
> Maybe that's different for PPC64 ?

It's very implementation specific.

Recent ppc64 chips generally don't trap (unless it's cache inhibited
space). Earlier variants might trap on page boundaries or segment
boundaries. Some embedded parts are less forgiving... some earlier
POWER chips will trap on unaligned in LE mode...

I wouldn't worry too much about it though. I think if 8xx shows an
improvement then it's probably fine everywhere else :-)

Cheers,
Ben.

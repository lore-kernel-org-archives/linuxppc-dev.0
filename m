Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW34X5Zw4zDqhT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 11:46:04 +1000 (AEST)
Message-ID: <1466127964.12899.5.camel@ellerman.id.au>
Subject: Re: unrecoverable exception on G5 with CONFIG_PPC_EARLY_DEBUG enabled
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Denis Kirjanov
 <kda@linux-powerpc.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 17 Jun 2016 11:46:04 +1000
In-Reply-To: <1466116390.24271.27.camel@kernel.crashing.org>
References: <CAOJe8K1S9-AjJ106rQJMmTg_5238RzKgjFb9dyGuDY5ddydkgQ@mail.gmail.com>
 <1465216025.2658.7.camel@ellerman.id.au>
 <CAOJe8K1bBf-J6ZJq+VfVv+CVcwGyff32beGL4kXaZBr5ZL9hmw@mail.gmail.com>
 <1466078830.19127.0.camel@ellerman.id.au>
 <CAOJe8K2L8D1M_yZPmyiZ11JvJ+HAS0aFHOnsqaY=xLOnQTA3AA@mail.gmail.com>
 <1466116390.24271.27.camel@kernel.crashing.org>
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

On Fri, 2016-06-17 at 08:33 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2016-06-16 at 22:49 +0300, Denis Kirjanov wrote:
> > -
> > +BEGIN_MMU_FTR_SECTION
> > +       b       2f
> > +END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
> >         andi.   r10,r12,MSR_RI  /* check for unrecoverable exception
> > */
> >         beq-    2f
> 
> Are we taking an SLB miss before we do the fixup maybe ?

Yeah that's the only explanation that makes any sense.

I think instead of patching down this low we should instead be redirecting SLB
misses to unknown_exception() when radix is enabled. Aneesh?

cheers

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B47E81A023F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 14:03:23 +1100 (AEDT)
Message-ID: <1418612601.19970.8.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/kernel: Make syscall_exit a local label
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>
Date: Mon, 15 Dec 2014 14:03:21 +1100
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CA03452@AcuExch.aculab.com>
References: <1417774619-30858-1-git-send-email-mpe@ellerman.id.au>
 <063D6719AE5E284EB5DD2968C1650D6D1CA03452@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-12-05 at 10:27 +0000, David Laight wrote:
> From: Michael Ellerman
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index 0905c8da90f1..d8828e50dbef 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -178,7 +178,7 @@ system_call:			/* label this so stack traces look sane */
> >  	mtctr   r12
> >  	bctrl			/* Call handler */
> 
> Why not add a 'nop' here instead?

Because we'd rather not add extra instructions to the syscall path unless we
really need to. A local label seems like the preferable solution to me.

cheers

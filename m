Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 20919DDD09
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 19:07:37 +1100 (EST)
Subject: Re: [PATCH] CPM_UART: Fixed SMC handling for CPM2 processors
From: Heiko Schocher <hs@denx.de>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20070212205500.1b7135fe@vitb.ru.mvista.com>
References: <1171276422.14090.54.camel@Apollo>
	<20070212205500.1b7135fe@vitb.ru.mvista.com>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 09:09:47 +0100
Message-Id: <1171354187.5919.29.camel@Apollo>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Vitaly,

Vitaly Bordug wrote:
> > I tried the Patch from Kalle Pokki
> > http://ozlabs.org/pipermail/linuxppc-embedded/2006-November/025108.html
> > 
> > but my SMC didnt work, without this patch, it works fine. I think that
> > the pram_base must be set the follwing way:
> > 
> Thanks for the patch, but I guess it requires a bit of investigation first since 
> we cannot just drop ioremapped offset and get back to raw one that has been returned by 
> platform_get_....

Ok, "Linux" writes/reads with the ioremapped Address in the Dualported
RAM we get with platform_get_...("pram"), thats Okay, but the CPM needs
the "real" Dualported RAM Address from this Area at offset SMCx_BASE,
which we get with platform_get_...("pram_base"), so it can find the SMC
Parameter RAM, he(CPM) didnt know anything about ioremapped addresses.

> We require ioremap stuff for powerpc approach, and I think we'd have to figure out why 
> ioremapped address did not satisfy smc (and I'll try on my 8xx).

Hmm... you mean the following?:

  r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram_base");
  if (r) {
+           pram_base = (u32)ioremap(r->start, r->end - r->start + 1);
            out_be16((u16 *)pram_base, base & 0xffff);
+           iounmap(pram_base);
         }

But thats not, what I correct with my patch, the error was, that
we wrote the ioremapped address pram in pram_base and not the real
address ... and with this ioremapped address, the CPM cannot do anything
(I think).

> Guessing we are speaking about arch/ppc/ domain upper...

Yes.

thanks
Heiko

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany

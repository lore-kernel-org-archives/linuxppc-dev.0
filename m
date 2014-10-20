Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0C441A002B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 06:11:33 +1100 (AEDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [POWERPC] 4xx: EP405 boards support for arch/powerpc
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <1413802359.18300.7.camel@pasglop>
References: <20141020090627.GA24768@mwanda> <1413802359.18300.7.camel@pasglop>
Date: Mon, 20 Oct 2014 21:02:11 +0200
Message-Id: <20141020190211.47B063833B9@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Ben,

In message <1413802359.18300.7.camel@pasglop> you wrote:
>
> Ah, I even forgot I wrote that ... I'll have to dig out the docs of
> that chip, maybe later this week. Thanks !
...
> >    565          cbdv = ((pllmr & 0x00060000) >> 17) + 1; /* CPU:PLB */
> >    566          opdv = ((pllmr & 0x00018000) >> 15) + 1; /* PLB:OPB */
> >    567          ppdv = ((pllmr & 0x00001800) >> 13) + 1; /* PLB:PCI */
> >                          ^^^^^^^^^^^^^^^^^^^^^^^^^
> > This mask and shift means that ppdv is always 1.

See 7.7.1 PLL Mode Register (CPC0_PLLMR) page 7.10f:

Bits 17:18 PPDV PCI­PLB Frequency Divisor

So that should be (... & 0x00006000) >> 13 ?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Only in our dreams we are free.  The rest of the time we need  wages.
                                    - Terry Pratchett, _Wyrd Sisters_

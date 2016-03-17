Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQXwC3QPWzDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 13:52:59 +1100 (AEDT)
Message-ID: <1458183179.7475.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix possible unrecoverable exception caused by
 '70fe3d9'
From: Michael Ellerman <mpe@ellerman.id.au>
To: benh@au1.ibm.com, Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
Date: Thu, 17 Mar 2016 13:52:59 +1100
In-Reply-To: <1458128720.3107.66.camel@au1.ibm.com>
References: <1458095370-26731-1-git-send-email-cyrilbur@gmail.com>
 <1458128720.3107.66.camel@au1.ibm.com>
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

On Wed, 2016-03-16 at 22:45 +1100, Benjamin Herrenschmidt wrote:

> On Wed, 2016-03-16 at 13:29 +1100, Cyril Bur wrote:

> > +#ifdef CONFIG_PPC_BOOK3S
> > +       ld      r10,PACAKMSR(r13)
> > +       li      r9,MSR_RI
> > +       andc    r11,r10,r9 /* Re-clear RI */
> > +       mtmsrd  r11,1
> > +#endif
>
> Do you need that ? IE, mtmsrd with "1" will only update RI and EE, is
> the value of EE in PACAMSR variable ?

Yeah that's a bit brain dead when you look at it. But in Cyril's defence he
just copied it from the existing code.

PACAKMSR does not include EE, so the code is correct, just suboptimal.

I've already merged it though in my rush to get my next branch working. Cyril
is looking at reworking the EE/RI clearing in there so we'll fix it up as part
of that.

cheers

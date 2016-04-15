Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmd1J0gByzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 23:00:04 +1000 (AEST)
Message-ID: <1460725197.22415.7.camel@ellerman.id.au>
Subject: Re: [v4, 2/3] ppc64/book3s: make some room for common interrupt
 vector code
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, Michael Neuling
 <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
Date: Fri, 15 Apr 2016 22:59:57 +1000
In-Reply-To: <3qmZVp4lgdz9t5C@ozlabs.org>
References: <3qmZVp4lgdz9t5C@ozlabs.org>
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

On Fri, 2016-04-15 at 21:06 +1000, Michael Ellerman wrote:
> Hi Hari,
>
> Thanks for persisting with this.
>
> On Thu, 2016-07-04 at 21:58:50 UTC, Hari Bathini wrote:

> > With the previous patch, we choke out whatever little space is left
> > below 0x7000 (FWNMI hard block) while there is a hole of ~1400 bytes
> > below __end_interrupts marker when CONFIG_CBE_RAS is disabled.
> > Considering CONFIG_CBE_RAS is not enabled by default for BOOK3S, this
> > is not a desirable scenario especially when we have to worry about
> > each additional instruction that goes below 0x7000.
> >
> > Memory region from 0x1800 to 0x4000 is dedicated for common interrupt
> > vector code. Also, we never hit an interrupt below 0x300 when IR=DR=1
> > implying memory region between 0x4000 to 0x4300 can also be used for
> > common interrupt vector code. So, we can effectively use memory region
> > between 0x1800 to 0x4300 for common interrupt vector code.
>
> On Power9 the system-call-vectored instruction will use the region at 0x3000, so
> moving code into that space is not a good long term plan.
>
> I'll take your v2 and put it in next next week.

I'll add this fixes line, which I think is correct:

Fixes: c1fb6816fb1b ("powerpc: Add relocation on exception vector handlers")

cheers

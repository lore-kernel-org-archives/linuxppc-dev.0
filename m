Return-Path: <cl@linux.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4389D1A04B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 00:49:34 +1100 (AEDT)
Received: from resqmta-po-11v.sys.comcast.net (resqmta-po-11v.sys.comcast.net
 [96.114.154.170])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B43C7140085
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2014 00:49:33 +1100 (AEDT)
Date: Wed, 29 Oct 2014 08:49:25 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Replace __get_cpu_var uses
In-Reply-To: <20141029063957.76C6014008E@ozlabs.org>
Message-ID: <alpine.DEB.2.11.1410290848470.1768@gentwo.org>
References: <20141029063957.76C6014008E@ozlabs.org>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Oct 2014, Michael Ellerman wrote:

> >  #define __ARCH_IRQ_STAT
> >
> > -#define local_softirq_pending()	__get_cpu_var(irq_stat).__softirq_pending
> > +#define local_softirq_pending()	__this_cpu_read(irq_stat.__softirq_pending)
> > +#define set_softirq_pending(x) __this_cpu_write(irq_stat._softirq_pending, (x))
> > +#define or_softirq_pending(x) __this_cpu_or(irq_stat._softirq_pending, (x))
>
> This breaks the build, because we also get the version of set_ and or_ from
> include/linux/interrupt.h, and then because it's __softirq_pending.
>
> Fixed by adding:
>
> #define __ARCH_SET_SOFTIRQ_PENDING
>
> And fixing the typo.

Ok.

> >
> >  void __set_breakpoint(struct arch_hw_breakpoint *brk)
> >  {
> > -	__get_cpu_var(current_brk) = *brk;
> > +	__this_cpu_write(current_brk, *brk);
>
> This breaks the build because we're trying to do a structure assignment but
> __this_cpu_write() only supports certain sizes.
>
> I replaced it with this which I think is right?
>
> 	memcpy(this_cpu_ptr(&current_brk), brk, sizeof(*brk));
>
>

Yes that is right. Thank you.

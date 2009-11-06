Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31903B7334
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Nov 2009 09:49:36 +1100 (EST)
Subject: Re: [PATCH v3] powerpc/ppc64: Use preempt_schedule_irq instead of
	preempt_schedule
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine <vbarshak@ru.mvista.com>
In-Reply-To: <4AF4A554.9010000@ru.mvista.com>
References: <20091019182858.GA10495@ru.mvista.com>
	<1256601324.2076.49.camel@pasglop> <1256622077.11607.85.camel@pasglop>
	<4AE89936.6080803@ru.mvista.com> <1256761844.26770.2.camel@pasglop>
	<4AE8B761.3090902@ru.mvista.com> <1256765834.26770.6.camel@pasglop>
	<4AE8CA95.7060402@ru.mvista.com> <1256777373.26770.14.camel@pasglop>
	<4AF4A554.9010000@ru.mvista.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 07 Nov 2009 09:49:18 +1100
Message-ID: <1257547758.13611.265.camel@pasglop>
Mime-Version: 1.0
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-11-07 at 01:38 +0300, Valentine wrote:
> Benjamin Herrenschmidt wrote:
> >> Yes, the MSR_EE is cleared before we jump to do_work. I'm OK with 
> >> clearing the hardirqenable flag. I just assumed that the hardirq flag 
> >> was supposed to reflect the MSR_EE state, so it looked a bit odd 
> >> clearing the MSR_EE at one place and then reflecting the change at another.
> > 
> > Yeah well, it is supposed to reflect EE in the "general case", it's just
> > that in the exception entry/exit, we take shortcuts when turning EE off
> > for short amount of times without reflecting it in the PACA. This is
> > why, in this case, since we are going back to C code, I want to have it
> > "fixed up" to reflect reality.
> > 
> 
> Ben, this one works fine. Are you going to pick it?

Already upstream:

Gitweb:
http://git.kernel.org/linus/4f917ba3d5ee9c98d60fa357e799942df8412de3
Commit:     4f917ba3d5ee9c98d60fa357e799942df8412de3
Parent:     01deab98e3ad8ff27243a8d5f8dd746c7110ae4f
Author:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
AuthorDate: Mon Oct 26 19:41:17 2009 +0000
Committer:  Benjamin Herrenschmidt <benh@kernel.crashing.org>
CommitDate: Tue Oct 27 16:42:43 2009 +1100

    powerpc/ppc64: Use preempt_schedule_irq instead of preempt_schedule
    
    Based on an original patch by Valentine Barshak <vbarshak@ru.mvista.com>
    
    Use preempt_schedule_irq to prevent infinite irq-entry and
    eventual stack overflow problems with fast-paced IRQ sources.

    .../...

Now, it might be a good idea to do a -stable variant of it for 2.6.31
and back, but that will have to be a separate patch due to the new
Book3E churn in .32

Cheers,
Ben.

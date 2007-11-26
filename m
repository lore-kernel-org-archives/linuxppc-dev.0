Return-Path: <sonny@kevlar.boston.burdell.org>
Received: from asclepius.site5.com (asclepius.site5.com [70.47.36.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8204ADDF04
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 20:36:15 +1100 (EST)
Date: Mon, 26 Nov 2007 02:44:38 -0500
From: Sonny Rao <sonny@burdell.org>
To: perfmon2-devel@lists.sourceforge.net
Subject: perfmon2 needs hard_irq_disable() for powerpc
Message-ID: <20071126074438.GA27499@kevlar.boston.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mikey@neuling.org, miltonm@bga.com, dwg@au1.ibm.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
	eranian@hpl.hp.com, cjashfor@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, I've been reading through the perfmon2 patch for 2.6.23 and it
dawned on me that in the powerpc architecture we have the notion of
lazy-disabling of interrupts where we don't actually disable
interrupts unless we see one come in and then turn them off.  I believe
a notable exception is the performance monitor interrupt which we
allow to break into our critical sections.  This is desirable because
we want to profile those sections  and right now, no in-kernel user of
the performance monitor interrupt in powerpc does any synchronization
across cpus inside the interrupt handler (oprofile seems to use
per-cpu buffers/state for everything).  We use hard_irq_disable() when
we _really_ have to disable interrupts because we're switching out the
kernel stack, etc. 

Perfmon2 is more demanding in its synchronization requirements and it
uses spin_lock_irqsave() in the generic arch-neutral code in several
places, I think this will break on powerpc the way we're handling
things now.

I'm copying a few people to solicit opinions on how best to deal with
this.  I think it's desirable to keep the property of letting us
profile critical sections in the kernel wherever possible. So we would
need to add hard_irq_disable/enable calls to the generic code, but want to
check with you guys first.   

Sonny 

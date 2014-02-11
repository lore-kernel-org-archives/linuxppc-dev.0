Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D91622C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 07:36:55 +1100 (EST)
Message-ID: <1392147268.3835.11.camel@pasglop>
Subject: Re: [PATCH v2] powerpc ticket locks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 12 Feb 2014 06:34:28 +1100
In-Reply-To: <1392143455.6733.386.camel@snotra.buserror.net>
References: <20140207165801.GC2107@lst.de> <1392001823.3996.21.camel@pasglop>
 <CAC4Lta2Pssu5QY_QLmy5C3Fm2G3fwpiuc5BNOLBnQTmmRH+W4Q@mail.gmail.com>
 <20140211104030.GG2107@lst.de>
 <1392143455.6733.386.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tom Musta <tommusta@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Raghavendra KT <raghavendra.kt.linux@gmail.com>,
 Raghavendra KT <raghavendra.kt@linux.vnet.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Torsten Duwe <duwe@lst.de>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-02-11 at 12:30 -0600, Scott Wood wrote:
> > It's something very special to IBM pSeries: the hypervisor can assign
> > fractions of physical CPUs to guests. Sometimes a guest with 4 quarter
> > CPUs will be faster than 1 monoprocessor. (correct me if I'm wrong).
> > 
> > The directed yield resolves the silly situation when holder and waiter
> > reside on the same physical CPU, as I understand it.
> > 
> > x86 has nothing comparable.
> 
> How is this different from the very ordinary case of an SMP KVM guest
> whose vcpus are not bound to host cpus, and thus you could have multiple
> vcpus running on the same host cpu?

It's not really ... though I can see drawbacks with the scheme as well
and I think in KVM we should be careful to only confer if the owner
vcpu last scheduled on the same physical cpu where the waiter is, other
wise, there's too much chances of us bouncing things around the machine
for minor contention cases.

Paul, what's your policy today ?

Cheers,
Ben.

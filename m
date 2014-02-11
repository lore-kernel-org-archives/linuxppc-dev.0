Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AE5572C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 05:31:12 +1100 (EST)
Message-ID: <1392143455.6733.386.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc ticket locks
From: Scott Wood <scottwood@freescale.com>
To: Torsten Duwe <duwe@lst.de>
Date: Tue, 11 Feb 2014 12:30:55 -0600
In-Reply-To: <20140211104030.GG2107@lst.de>
References: <20140207165801.GC2107@lst.de> <1392001823.3996.21.camel@pasglop>
 <CAC4Lta2Pssu5QY_QLmy5C3Fm2G3fwpiuc5BNOLBnQTmmRH+W4Q@mail.gmail.com>
 <20140211104030.GG2107@lst.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Tom Musta <tommusta@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Raghavendra KT <raghavendra.kt.linux@gmail.com>,
 Raghavendra KT <raghavendra.kt@linux.vnet.ibm.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Anton
 Blanchard <anton@samba.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-02-11 at 11:40 +0100, Torsten Duwe wrote:
> On Tue, Feb 11, 2014 at 03:23:51PM +0530, Raghavendra KT wrote:
> > How much important to have holder information for PPC? From my
> > previous experiment
> > on x86, it was lock-waiter preemption which is problematic rather than
> > lock-holder preemption.
> 
> It's something very special to IBM pSeries: the hypervisor can assign
> fractions of physical CPUs to guests. Sometimes a guest with 4 quarter
> CPUs will be faster than 1 monoprocessor. (correct me if I'm wrong).
> 
> The directed yield resolves the silly situation when holder and waiter
> reside on the same physical CPU, as I understand it.
> 
> x86 has nothing comparable.

How is this different from the very ordinary case of an SMP KVM guest
whose vcpus are not bound to host cpus, and thus you could have multiple
vcpus running on the same host cpu?

-Scott

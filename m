Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3CED92C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 21:40:38 +1100 (EST)
Date: Tue, 11 Feb 2014 11:40:30 +0100
From: Torsten Duwe <duwe@lst.de>
To: Raghavendra KT <raghavendra.kt.linux@gmail.com>
Subject: Re: [PATCH v2] powerpc ticket locks
Message-ID: <20140211104030.GG2107@lst.de>
References: <20140207165801.GC2107@lst.de> <1392001823.3996.21.camel@pasglop>
 <CAC4Lta2Pssu5QY_QLmy5C3Fm2G3fwpiuc5BNOLBnQTmmRH+W4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAC4Lta2Pssu5QY_QLmy5C3Fm2G3fwpiuc5BNOLBnQTmmRH+W4Q@mail.gmail.com>
Cc: Tom Musta <tommusta@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Raghavendra KT <raghavendra.kt@linux.vnet.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>,
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

On Tue, Feb 11, 2014 at 03:23:51PM +0530, Raghavendra KT wrote:
> How much important to have holder information for PPC? From my
> previous experiment
> on x86, it was lock-waiter preemption which is problematic rather than
> lock-holder preemption.

It's something very special to IBM pSeries: the hypervisor can assign
fractions of physical CPUs to guests. Sometimes a guest with 4 quarter
CPUs will be faster than 1 monoprocessor. (correct me if I'm wrong).

The directed yield resolves the silly situation when holder and waiter
reside on the same physical CPU, as I understand it.

x86 has nothing comparable.

	Torsten

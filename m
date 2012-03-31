Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DB2F4B6FCC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2012 08:33:53 +1000 (EST)
Date: Sat, 31 Mar 2012 23:32:00 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
Message-ID: <20120331223200.GA32482@n2100.arm.linux.org.uk>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120331163321.GA15809@linux.vnet.ibm.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, jejb@parisc-linux.org,
 dhowells@redhat.com, linux390@de.ibm.com, linux-am33-list@redhat.com,
 cmetcalf@tilera.com, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 01, 2012 at 12:33:21AM +0800, Paul E. McKenney wrote:
> Although there have been numerous complaints about the complexity of
> parallel programming (especially over the past 5-10 years), the plain
> truth is that the incremental complexity of parallel programming over
> that of sequential programming is not as large as is commonly believed.
> Despite that you might have heard, the mind-numbing complexity of modern
> computer systems is not due so much to there being multiple CPUs, but
> rather to there being any CPUs at all.  In short, for the ultimate in
> computer-system simplicity, the optimal choice is NR_CPUS=0.
> 
> This commit therefore limits kernel builds to zero CPUs.  This change
> has the beneficial side effect of rendering all kernel bugs harmless.
> Furthermore, this commit enables additional beneficial changes, for
> example, the removal of those parts of the kernel that are not needed
> when there are zero CPUs.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Great work, but I don't think you've gone far enough with this.

What would really help is if you could consolidate all these NR_CPUS
definitions into one place so we don't have essentially the same thing
scattered across all these architectures.  We're already doing this on
ARM across our platforms, and its about time such an approach was taken
across the entire kernel tree.

It looks like the MIPS solution would be the best one to pick.
Could you rework your patch to do this please?

While you're at it, you might like to consider that having zero CPUs
makes all this architecture support redundant, so maybe you've missed
a trick there - according to my count, we could get rid of almost 3
million lines of code from arch.  We could replace all that with a
single standard implementation.

Bah, maybe I shouldn't have pushed that bpf_jit code for ARM after all...

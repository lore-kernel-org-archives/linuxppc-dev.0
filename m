Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6855EB6FEA
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2012 11:22:33 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 31 Mar 2012 21:22:29 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id DF21338C8052
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 21:22:24 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q311MO1w308858
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 21:22:24 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q311MMRq022984
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 19:22:24 -0600
Date: Sat, 31 Mar 2012 18:22:12 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state	space
Message-ID: <20120401012212.GP2450@linux.vnet.ibm.com>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <20120331223200.GA32482@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120331223200.GA32482@n2100.arm.linux.org.uk>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, jejb@parisc-linux.org,
 dhowells@redhat.com, linux390@de.ibm.com, linux-am33-list@redhat.com,
 cmetcalf@tilera.com, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 31, 2012 at 11:32:00PM +0100, Russell King - ARM Linux wrote:
> On Sun, Apr 01, 2012 at 12:33:21AM +0800, Paul E. McKenney wrote:
> > Although there have been numerous complaints about the complexity of
> > parallel programming (especially over the past 5-10 years), the plain
> > truth is that the incremental complexity of parallel programming over
> > that of sequential programming is not as large as is commonly believed.
> > Despite that you might have heard, the mind-numbing complexity of modern
> > computer systems is not due so much to there being multiple CPUs, but
> > rather to there being any CPUs at all.  In short, for the ultimate in
> > computer-system simplicity, the optimal choice is NR_CPUS=0.
> > 
> > This commit therefore limits kernel builds to zero CPUs.  This change
> > has the beneficial side effect of rendering all kernel bugs harmless.
> > Furthermore, this commit enables additional beneficial changes, for
> > example, the removal of those parts of the kernel that are not needed
> > when there are zero CPUs.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Great work, but I don't think you've gone far enough with this.
> 
> What would really help is if you could consolidate all these NR_CPUS
> definitions into one place so we don't have essentially the same thing
> scattered across all these architectures.  We're already doing this on
> ARM across our platforms, and its about time such an approach was taken
> across the entire kernel tree.
> 
> It looks like the MIPS solution would be the best one to pick.
> Could you rework your patch to do this please?
> 
> While you're at it, you might like to consider that having zero CPUs
> makes all this architecture support redundant, so maybe you've missed
> a trick there - according to my count, we could get rid of almost 3
> million lines of code from arch.  We could replace all that with a
> single standard implementation.
> 
> Bah, maybe I shouldn't have pushed that bpf_jit code for ARM after all...

;-) ;-) ;-)

							Thanx, Paul

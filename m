Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9F5DAB700C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2012 03:35:27 +1000 (EST)
Date: Sun, 1 Apr 2012 19:34:55 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
In-Reply-To: <20120331223200.GA32482@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1204011930010.2542@ionos>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <20120331223200.GA32482@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, jejb@parisc-linux.org,
 dhowells@redhat.com, linux390@de.ibm.com, linux-am33-list@redhat.com,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, x86@kernel.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 31 Mar 2012, Russell King - ARM Linux wrote:

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

For a first step we can deprecated arch/ and make it depend on
CONFIG_STAGING. That way we can have it around a bit for sentimental
reasons w/o having a lot of churn.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: tip/Makefile
===================================================================
--- tip.orig/Makefile
+++ tip/Makefile
@@ -564,7 +564,9 @@ else
 KBUILD_CFLAGS	+= -O2
 endif
 
+ifdef CONFIG_ARCH_SUPPORT
 include $(srctree)/arch/$(SRCARCH)/Makefile
+endif
 
 ifneq ($(CONFIG_FRAME_WARN),0)
 KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
Index: tip/drivers/staging/Kconfig
===================================================================
--- tip.orig/drivers/staging/Kconfig
+++ tip/drivers/staging/Kconfig
@@ -1,6 +1,10 @@
+config ARCH_SUPPORT
+	bool
+
 menuconfig STAGING
 	bool "Staging drivers"
 	default n
+	select ARCH_SUPPORT
 	---help---
 	  This option allows you to select a number of drivers that are
 	  not of the "normal" Linux kernel quality level.  These drivers
Index: tip/Documentation/feature-removal-schedule.txt
===================================================================
--- tip.orig/Documentation/feature-removal-schedule.txt
+++ tip/Documentation/feature-removal-schedule.txt
@@ -537,3 +537,13 @@ When:	3.6
 Why:	setitimer is not returning -EFAULT if user pointer is NULL. This
 	violates the spec.
 Who:	Sasikantha Babu <sasikanth.v19@gmail.com>
+
+-----------------------------
+
+What:	Remove arch
+When:	April 1st 2013
+Why:    NR_CPUS=0 made arch/ obsolete. Keep it around a bit for
+	sentimental reasons.
+Who:	paulmck,tglx.rmk
+
+	

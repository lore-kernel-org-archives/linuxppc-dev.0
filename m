Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v1Mgm3CJfzDqWJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 14:44:51 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0F3i0RB102772
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 22:44:48 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27ynffsa0t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 22:44:48 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 14 Jan 2017 20:44:47 -0700
Date: Sat, 14 Jan 2017 13:41:59 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
 akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
 josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
 rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
 dvhart@linux.intel.com, fweisbec@gmail.com, oleg@redhat.com,
 bobby.prani@gmail.com, will.deacon@arm.com,
 boqun.feng@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH tip/core/rcu 2/3] srcu: Force full grace-period ordering
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170114091941.GA22961@linux.vnet.ibm.com>
 <1484385601-23379-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170114093550.GB14970@gmail.com>
 <20170114195417.GW5238@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170114195417.GW5238@linux.vnet.ibm.com>
Message-Id: <20170114214159.GA7098@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 14, 2017 at 11:54:17AM -0800, Paul E. McKenney wrote:
> On Sat, Jan 14, 2017 at 10:35:50AM +0100, Ingo Molnar wrote:
> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

[ . . . ]

> > > + */
> > > +#ifdef CONFIG_PPC
> > > +#define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
> > > +#else /* #ifdef CONFIG_PPC */
> > > +#define smp_mb__after_unlock_lock()	do { } while (0)
> > > +#endif /* #else #ifdef CONFIG_PPC */
> > 
> > Yeah, so I realize that this was pre-existing code, but putting CONFIG_$ARCH
> > #ifdefs into generic headers is generally frowned upon.
> > 
> > The canonical approach would be either to define a helper Kconfig variable that 
> > can be set by PPC (but other architectures don't need to set it), or to expose a 
> > suitable macro (function) for architectures to define in their barrier.h arch 
> > header file.
> 
> Very well, I will add a separate commit for this.  4.11 OK?

Does the patch below seem reasonable?

							Thanx, Paul

------------------------------------------------------------------------

commit 271c0601237c41a279f975563e13837bace0df03
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Sat Jan 14 13:32:50 2017 -0800

    rcu: Make arch select smp_mb__after_unlock_lock() strength
    
    The definition of smp_mb__after_unlock_lock() is currently smp_mb()
    for CONFIG_PPC and a no-op otherwise.  It would be better to instead
    provide an architecture-selectable Kconfig option, and select the
    strength of smp_mb__after_unlock_lock() based on that option.  This
    commit therefore creates CONFIG_ARCH_WEAK_RELACQ, has PPC select it,
    and bases the definition of smp_mb__after_unlock_lock() on this new
    CONFIG_ARCH_WEAK_RELACQ Kconfig option.
    
    Reported-by: Ingo Molnar <mingo@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Will Deacon <will.deacon@arm.com>
    Cc: Boqun Feng <boqun.feng@linux.vnet.ibm.com>
    Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Cc: Paul Mackerras <paulus@samba.org>
    Cc: Michael Ellerman <mpe@ellerman.id.au>
    Cc: <linuxppc-dev@lists.ozlabs.org>

diff --git a/arch/Kconfig b/arch/Kconfig
index 99839c23d453..94dd90d33f95 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -316,6 +316,9 @@ config HAVE_CMPXCHG_LOCAL
 config HAVE_CMPXCHG_DOUBLE
 	bool
 
+config ARCH_WEAK_RELACQ
+	bool
+
 config ARCH_WANT_IPC_PARSE_VERSION
 	bool
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a8ee573fe610..e7083d27271e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -165,6 +165,7 @@ config PPC
 	select HAVE_ARCH_HARDENED_USERCOPY
 	select HAVE_KERNEL_GZIP
 	select HAVE_CC_STACKPROTECTOR
+	select ARCH_WEAK_RELACQ
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 357b32aaea48..5fdfe874229e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1175,11 +1175,11 @@ do { \
  * if the UNLOCK and LOCK are executed by the same CPU or if the
  * UNLOCK and LOCK operate on the same lock variable.
  */
-#ifdef CONFIG_PPC
+#ifdef CONFIG_ARCH_WEAK_RELACQ
 #define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
-#else /* #ifdef CONFIG_PPC */
+#else /* #ifdef CONFIG_ARCH_WEAK_RELACQ */
 #define smp_mb__after_unlock_lock()	do { } while (0)
-#endif /* #else #ifdef CONFIG_PPC */
+#endif /* #else #ifdef CONFIG_ARCH_WEAK_RELACQ */
 
 
 #endif /* __LINUX_RCUPDATE_H */

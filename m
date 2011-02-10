Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB2A1B70DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Feb 2011 01:44:43 +1100 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp03.in.ibm.com (8.14.4/8.13.1) with ESMTP id p1AEibEd010960
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 20:14:37 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p1AEibc02216084
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 20:14:37 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p1AEiabW001777
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 20:14:37 +0530
Date: Thu, 10 Feb 2011 20:14:35 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix call to flush_ptrace_hw_breakpoint()
Message-ID: <20110210144435.GB2488@in.ibm.com>
References: <1297032853.14982.3.camel@pasglop>
	<20110207025643.GA12223@in.ibm.com>
	<1297048239.14982.29.camel@pasglop>
	<20110207045230.GB4287@in.ibm.com>
	<1297055617.14982.59.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297055617.14982.59.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Kleikamp <shaggy@us.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 07, 2011 at 04:13:37PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2011-02-07 at 10:22 +0530, K.Prasad wrote:
> > Okay! Another wrapper of "#ifndef CONFIG_HAVE_HW_BREAKPOINT" around
> > the
> > definition of 'set_debug_reg_defaults'.
> 
> Can you send a patch ?
>

Pasted below.
 
> > There's indeed too much sprinkling of #ifdefs in the code, but most of
> > it would go away when the BookE code also uses the generic
> > hw-breakpoint interfaces. 
> 
> What's your status for those patches ?
> 

The last I checked, I knew that the version of patchset I sent out
(linuxppc-dev message id: 20100629165152.GA8586@in.ibm.com)
didn't actually work when tested on hardware (it was just compile tested
before sending). It needs substantial amount of time to get it in shape,
which I'm unfortunately lacking now (plenty of priority items in hand that
needs dedicated attention).

Thanks,
K.Prasad

Fix the error in spelling the config option for hw-breakpoints and fix
the build issue that follows.

Signed-off by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/process.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6.set_hwdebug/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.set_hwdebug.orig/arch/powerpc/kernel/process.c
+++ linux-2.6.set_hwdebug/arch/powerpc/kernel/process.c
@@ -353,6 +353,7 @@ static void switch_booke_debug_regs(stru
 			prime_debug_regs(new_thread);
 }
 #else	/* !CONFIG_PPC_ADV_DEBUG_REGS */
+#ifndef CONFIG_HAVE_HW_BREAKPOINT
 static void set_debug_reg_defaults(struct thread_struct *thread)
 {
 	if (thread->dabr) {
@@ -360,6 +361,7 @@ static void set_debug_reg_defaults(struc
 		set_dabr(0);
 	}
 }
+#endif /* !CONFIG_HAVE_HW_BREAKPOINT */
 #endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
 
 int set_dabr(unsigned long dabr)
@@ -670,11 +672,11 @@ void flush_thread(void)
 {
 	discard_lazy_cpu_state();
 
-#ifdef CONFIG_HAVE_HW_BREAKPOINTS
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
 	flush_ptrace_hw_breakpoint(current);
-#else /* CONFIG_HAVE_HW_BREAKPOINTS */
+#else /* CONFIG_HAVE_HW_BREAKPOINT */
 	set_debug_reg_defaults(&current->thread);
-#endif /* CONFIG_HAVE_HW_BREAKPOINTS */
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 }
 
 void

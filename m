Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 812B5B7BB4
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Sep 2009 18:14:01 +1000 (EST)
In-Reply-To: <1254208057.5771.7.camel@pasglop>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>	
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>	
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>	
	<1253843480.7103.492.camel@pasglop>
	<20090929012106.GA22798@compile2.chatsunix.int.mrv.com>	
	<OF1870F4D5.BB673882-ONC1257640.00233638-C1257640.00236DC9@transmode.se>
	<1254208057.5771.7.camel@pasglop>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 29 Sep 2009 10:13:13 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 29/09/2009 09:07:37:
>
> On Tue, 2009-09-29 at 08:26 +0200, Joakim Tjernlund wrote:
> > > I've tried sticking tlbil_va() in those places, nothing seems to
> > help.
> > > In some cases userspace is slow, in other cases userspace is faster
> > and
> > > unstable: sometimes commands hang, sometimes I am able to ctrl-c and
> > > and kill it, sometimes I get other strange crashes or falures (so
> > far no
> > > kernel oopses though).
> >
> > This is exactly what you get when the "cache insn does not update DAR"
> > bug hits
> > you.
>
> But then why was it working fine before ? Or it wasn't ?

hmm, yes. You do get this and mysterious SEGV if you hit the but so does
other bugs too so this is probably due to missing invalidation.

I suspect that something like below will fix the problem and
is the "correct" fix(untested, not even compiled):

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 52ff8c5..f579a11 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -428,7 +428,7 @@ DataStoreTLBMiss:
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-2:	li	r11, 0x00f0
+	li	r11, 0x00f0
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
@@ -441,7 +441,23 @@ DataStoreTLBMiss:
 	lwz	r3, 8(r0)
 #endif
 	rfi
+2:
+	/* Copy 20 msb from MD_EPN to DAR since the dcxx instructions fails
+	 * to update DAR when they cause a DTLB Miss.
+	 */
+	mfspr	r11, SPRN_MD_EPN
+	mfspr	r10, SPRN_DAR
+	rlwimi	r10, r11, 0, 0, 19
+	mtspr	SPRN_DAR, r10

+	mfspr	r10, SPRN_M_TW	/* Restore registers */
+	lwz	r11, 0(r0)
+	mtcr	r11
+	lwz	r11, 4(r0)
+#ifdef CONFIG_8xx_CPU6
+	lwz	r3, 8(r0)
+#endif
+	b	DataAccess
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
  * addresses.  There is nothing to do but handle a big time error fault.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1C12A2C0095
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2012 11:08:47 +1000 (EST)
Message-ID: <1346807308.2257.14.camel@pasglop>
Subject: Re: 3.5+: yaboot, Invalid memory access
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>
Date: Wed, 05 Sep 2012 11:08:28 +1000
In-Reply-To: <alpine.DEB.2.01.1209040223380.25392@trent.utfs.org>
References: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
 <alpine.DEB.2.01.1209032310220.25392@trent.utfs.org>
 <1346741491.7619.12.camel@concordia>
 <alpine.DEB.2.01.1209040223380.25392@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-09-04 at 02:32 -0700, Christian Kujau wrote:
> On Tue, 4 Sep 2012 at 16:51, Michael Ellerman wrote:
> > My guess would be we're calling that quite early and the __put_user()
> > check is getting confused and failing. That means we'll have left some
> > code unpatched, which then fails.
> > 
> > Can you try with the patch applied, but instead of returning if the
> > __put_user() fails, just continue on anyway.
> 
> You mean, like this?

Try this:

powerpc: Don't use __put_user() in patch_instruction

patch_instruction() can be called very early on ppc32, when the kernel
isn't yet running at it's linked address. That can cause the !
is_kernel_addr() test in __put_user() to trip and call might_sleep()
which is very bad at that point during boot.

Use a lower level function instead for now, at least until we get to
rework ppc32 boot process to do the code patching later, like ppc64
does.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index dd223b3..17e5b23 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -20,7 +20,7 @@ int patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	int err;
 
-	err = __put_user(instr, addr);
+	__put_user_size(instr, addr, 4, err);
 	if (err)
 		return err;
 	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (addr));

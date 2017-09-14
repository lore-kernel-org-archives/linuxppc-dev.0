Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt698694SzDrFs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 15:12:28 +1000 (AEST)
Date: Thu, 14 Sep 2017 14:57:07 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Possible bug in commit f3b3f28493d9
Message-ID: <20170914045707.GA25715@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit f3b3f28493d9 ("powerpc/powernv/idle: Don't override
default/deepest directly in kernel", 2017-03-22) made the following
change in pnv_cpu_offline() in arch/powerpc/platforms/powernv/idle.c:

-	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+	if (cpu_has_feature(CPU_FTR_ARCH_300) && deepest_stop_found) {
 		srr1 = power9_idle_stop(pnv_deepest_stop_psscr_val,
 					pnv_deepest_stop_psscr_mask);
 	} else if (idle_states & OPAL_PM_WINKLE_ENABLED) {
 		srr1 = power7_winkle();

Which seems to be saying that previously, on POWER9 we would always
call power9_idle_stop(), but now we might possibly call
power7_idle_insn() to do a nap or sleep or rvwinkle instruction.

Is this really what was meant?  Nap, sleep and rvwinkle are illegal
instructions on POWER9.  It looks to me as if that statement needs to
be restructured to do what the commit description says, which is to
call power9_idle_stop if we have found a valid stop state, and
otherwise to poll.

At present we are relying on idle_states not not having any of the
nap/sleep/winkle bits set in it.  Is that guaranteed on POWER9?  If so
it is at least deserving of a comment.

Paul.

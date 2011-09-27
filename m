Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CA1E0B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Sep 2011 14:12:34 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p8R4CQCM009254
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2011 23:12:28 -0500
Subject: [PATCH] powerpc/ptrace: Fix build with gcc 4.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Sep 2011 14:12:26 +1000
Message-ID: <1317096746.29415.42.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

gcc (rightfully) complains that we are accessing beyond the
end of the fpr array (we do, to access the fpscr).

The only sane thing to do (whether anything in that code can be
called remotely sane is debatable) is to special case fpscr and
handle it as a separate statement.

I initially tried to do it it by making the array access conditional
to index < PT_FPSCR and using a 3rd else leg but for some reason gcc
was unable to understand it and still spewed the warning.

So I ended up with something a tad more intricated but it seems to
build on 32-bit and on 64-bit with and without VSX.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I very much welcome a few more pairs of eyes on this one in case I
missed something, this code sucks. It took me a good 15mn to figure
out that it was actually correct to begin with (hint: look at the
definition of PT_FPSCR on 32-bit, don't miss the *2 in there).
 
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 05b7dd2..adf4d73 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1497,9 +1497,14 @@ long arch_ptrace(struct task_struct *child, long request,
 		if (index < PT_FPR0) {
 			tmp = ptrace_get_reg(child, (int) index);
 		} else {
+			unsigned int fpidx = index - PT_FPR0;
+
 			flush_fp_to_thread(child);
-			tmp = ((unsigned long *)child->thread.fpr)
-				[TS_FPRWIDTH * (index - PT_FPR0)];
+			if (fpidx < (PT_FPSCR - PT_FPR0))
+				tmp = ((unsigned long *)child->thread.fpr)
+					[fpidx * TS_FPRWIDTH];
+			else
+				tmp = child->thread.fpscr.val;
 		}
 		ret = put_user(tmp, datalp);
 		break;
@@ -1525,9 +1530,12 @@ long arch_ptrace(struct task_struct *child, long request,
 		if (index < PT_FPR0) {
 			ret = ptrace_put_reg(child, index, data);
 		} else {
+			unsigned int fpidx = index - PT_FPR0;
+
 			flush_fp_to_thread(child);
-			((unsigned long *)child->thread.fpr)
-				[TS_FPRWIDTH * (index - PT_FPR0)] = data;
+			if (fpidx < (PT_FPSCR - PT_FPR0))
+				((unsigned long *)child->thread.fpr)
+					[fpidx * TS_FPRWIDTH] = data;
 			ret = 0;
 		}
 		break;

Return-Path: <anton.vorontsov@linaro.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F2A56B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 21:31:19 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id j10so3226820bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 03:31:19 -0700 (PDT)
Date: Sat, 24 Mar 2012 14:30:08 +0400
From: Anton Vorontsov <anton.vorontsov@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 06/10] blackfin: Fix possible deadlock in decode_address()
Message-ID: <20120324103008.GF29067@lizard>
References: <20120324102609.GA28356@lizard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120324102609.GA28356@lizard>
Cc: Mike Frysinger <vapier@gentoo.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, linux-mm@kvack.org,
 Paul Mundt <lethal@linux-sh.org>, John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Russell King <linux@arm.linux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oleg Nesterov found an interesting deadlock possibility:

> sysrq_showregs_othercpus() does smp_call_function(showacpu)
> and showacpu() show_stack()->decode_address(). Now suppose that IPI
> interrupts the task holding read_lock(tasklist).

To fix this, blackfin should not grab the write_ variant of the
tasklist lock, read_ one is enough.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/blackfin/kernel/trace.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/blackfin/kernel/trace.c b/arch/blackfin/kernel/trace.c
index 5102cdf..9cc9302 100644
--- a/arch/blackfin/kernel/trace.c
+++ b/arch/blackfin/kernel/trace.c
@@ -28,7 +28,7 @@ void decode_address(char *buf, unsigned long address)
 {
 	struct task_struct *p;
 	struct mm_struct *mm;
-	unsigned long flags, offset;
+	unsigned long offset;
 	struct rb_node *n;
 
 #ifdef CONFIG_KALLSYMS
@@ -112,7 +112,7 @@ void decode_address(char *buf, unsigned long address)
 	 * mappings of all our processes and see if we can't be a whee
 	 * bit more specific
 	 */
-	write_lock_irqsave(&tasklist_lock, flags);
+	read_lock(&tasklist_lock);
 	for_each_process(p) {
 		struct task_struct *t;
 
@@ -185,7 +185,7 @@ __continue:
 	sprintf(buf, "/* kernel dynamic memory */");
 
 done:
-	write_unlock_irqrestore(&tasklist_lock, flags);
+	read_unlock(&tasklist_lock);
 }
 
 #define EXPAND_LEN ((1 << CONFIG_DEBUG_BFIN_HWTRACE_EXPAND_LEN) * 256 - 1)
-- 
1.7.9.2

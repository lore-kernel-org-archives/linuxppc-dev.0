Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 1A24EDE29C
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 04:18:19 +1000 (EST)
Date: Thu, 22 May 2008 14:18:17 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] rcupreempt: remove export of rcu_batches_completed_bh
Message-ID: <Pine.LNX.4.58.0805221415330.14724@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


In rcupreempt, rcu_batches_completed_bh is defined as a static inline in
the header file. This does not need to be exported, and not only that,
this breaks my PPC build.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 kernel/rcupreempt.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-tip.git/kernel/rcupreempt.c
===================================================================
--- linux-tip.git.orig/kernel/rcupreempt.c	2008-05-22 11:12:30.000000000 -0700
+++ linux-tip.git/kernel/rcupreempt.c	2008-05-22 11:12:33.000000000 -0700
@@ -217,8 +217,6 @@ long rcu_batches_completed(void)
 }
 EXPORT_SYMBOL_GPL(rcu_batches_completed);

-EXPORT_SYMBOL_GPL(rcu_batches_completed_bh);
-
 void __rcu_read_lock(void)
 {
 	int idx;

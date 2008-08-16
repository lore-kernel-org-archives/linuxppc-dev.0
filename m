Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 947A8DDEEC
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 13:56:47 +1000 (EST)
Date: Fri, 15 Aug 2008 23:56:44 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: remove dead module_find_bug code.
Message-ID: <alpine.DEB.1.10.0808152354150.4450@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Doing some various "make randconfig" and came across an error when CONFIG_BUG
was not set. Looking further in this, I found that module_find_bug, defined
in powerpc arch code, is not called anywhere.

There is a static module_find_bug in lib/bug.c but that is a separate issue.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 arch/powerpc/kernel/module.c |   15 ---------------
 1 file changed, 15 deletions(-)

Index: linux-tip.git/arch/powerpc/kernel/module.c
===================================================================
--- linux-tip.git.orig/arch/powerpc/kernel/module.c	2008-08-15 20:18:52.000000000 -0700
+++ linux-tip.git/arch/powerpc/kernel/module.c	2008-08-15 20:18:58.000000000 -0700
@@ -99,18 +99,3 @@ void module_arch_cleanup(struct module *
 {
 	module_bug_cleanup(mod);
 }
-
-struct bug_entry *module_find_bug(unsigned long bugaddr)
-{
-	struct mod_arch_specific *mod;
-	unsigned int i;
-	struct bug_entry *bug;
-
-	list_for_each_entry(mod, &module_bug_list, bug_list) {
-		bug = mod->bug_table;
-		for (i = 0; i < mod->num_bugs; ++i, ++bug)
-			if (bugaddr == bug->bug_addr)
-				return bug;
-	}
-	return NULL;
-}

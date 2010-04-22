Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D87BBB7D1E
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 02:17:51 +1000 (EST)
Message-Id: <20100422161224.465958039@suse.de>
Date: Fri, 23 Apr 2010 02:06:24 +1000
From: npiggin@suse.de
To: linux-arch@vger.kernel.org
Subject: [patch 11/14] powerpc: invoke oom-killer from page fault
References: <20100422160613.723698029@suse.de>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Rientjes <rientjes@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: linuxppc-dev@ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/fault.c
+++ linux-2.6/arch/powerpc/mm/fault.c
@@ -359,15 +359,10 @@ bad_area_nosemaphore:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (is_global_init(current)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk("VM: killing process %s\n", current->comm);
-	if (user_mode(regs))
-		do_group_exit(SIGKILL);
-	return SIGKILL;
+	if (!user_mode(regs))
+		return SIGKILL;
+	pagefault_out_of_memory();
+	return 0;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);

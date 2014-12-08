Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E5EF1A0A36
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 17:30:34 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 8 Dec 2014 16:30:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EBF7B357805D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 17:30:31 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB86UVYi39846018
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 17:30:31 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB86UV3M029073
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 17:30:31 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc, dscr: Added some in-code documentation
Date: Mon,  8 Dec 2014 12:00:11 +0530
Message-Id: <1418020212-4303-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1418020212-4303-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1418020212-4303-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds some in-code documentation to the DSCR related
code to make it more readable without having any functional
change to it.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/processor.h |  8 ++++++++
 arch/powerpc/kernel/sysfs.c          | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index dda7ac4..81c1aeb 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -295,6 +295,14 @@ struct thread_struct {
 #endif
 #ifdef CONFIG_PPC64
 	unsigned long	dscr;
+	/*
+	 * XXX: dscr_inherit indicates that the process has explicitly
+	 * attempted and changed the DSCR register value for itself.
+	 * Hence kernel wont use the default CPU DSCR value contained
+	 * in the PACA structure anymore during process context switch.
+	 * Once this variable is set, this behaviour will be inherited
+	 * to all the children of this process from that point onwards.
+	 */
 	int		dscr_inherit;
 	unsigned long	ppr;	/* used to save/restore SMT priority */
 #endif
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 67fd2fd..edde3f0 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -496,8 +496,21 @@ static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
 static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
 static DEVICE_ATTR(pir, 0400, show_pir, NULL);
 
+/*
+ * XXX: This is the system wide DSCR register default value.
+ * Any change to this value through the sysfs interface will
+ * update all per-cpu DSCR default values across the system
+ * stored in their respective PACA structures.
+ */
 static unsigned long dscr_default;
 
+/*
+ * XXX: read_dscr and write_dscr are the functions for the
+ * per-cpu DSCR default sysfs files present for each cpu.
+ * Though updates to per-cpu DSCR value also gets called
+ * for all the CPUs on the system when the system wide
+ * global dscr_default gets changed.
+ */
 static void read_dscr(void *val)
 {
 	*(unsigned long *)val = get_paca()->dscr_default;
-- 
1.9.3

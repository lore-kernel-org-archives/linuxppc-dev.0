Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F01B91A006F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 20:56:25 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 18 May 2015 16:26:23 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C5A01E0064
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 16:29:24 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4IAuI4R45351160
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 16:26:19 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4IAFLfs026118
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 15:45:21 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 04/13] powerpc, dscr: Added some in-code documentation
Date: Mon, 18 May 2015 16:26:07 +0530
Message-Id: <1431946576-1009-5-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1431946576-1009-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1431946576-1009-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, shuahkh@osg.samsung.com, anton@samba.org
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
 arch/powerpc/include/asm/processor.h |  9 +++++++++
 arch/powerpc/kernel/sysfs.c          | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index bf117d8..28ded5d 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -295,6 +295,15 @@ struct thread_struct {
 #endif
 #ifdef CONFIG_PPC64
 	unsigned long	dscr;
+	/*
+	 * This member element dscr_inherit indicates that the process
+	 * has explicitly attempted and changed the DSCR register value
+	 * for itself. Hence kernel wont use the default CPU DSCR value
+	 * contained in the PACA structure anymore during process context
+	 * switch. Once this variable is set, this behaviour will also be
+	 * inherited to all the children of this process from that point
+	 * onwards.
+	 */
 	int		dscr_inherit;
 	unsigned long	ppr;	/* used to save/restore SMT priority */
 #endif
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index fa1fd8a..692873b 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -496,13 +496,34 @@ static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
 static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
 static DEVICE_ATTR(pir, 0400, show_pir, NULL);
 
+/*
+ * This is the system wide DSCR register default value. Any
+ * change to this default value through the sysfs interface
+ * will update all per cpu DSCR default values across the
+ * system stored in their respective PACA structures.
+ */
 static unsigned long dscr_default;
 
+/**
+ * read_dscr() - Fetch the cpu specific DSCR default
+ * @val:	Returned cpu specific DSCR default value
+ *
+ * This function returns the per cpu DSCR default value
+ * for any cpu which is contained in it's PACA structure.
+ */
 static void read_dscr(void *val)
 {
 	*(unsigned long *)val = get_paca()->dscr_default;
 }
 
+
+/**
+ * write_dscr() - Update the cpu specific DSCR default
+ * @val:	New cpu specific DSCR default value to update
+ *
+ * This function updates the per cpu DSCR default value
+ * for any cpu which is contained in it's PACA structure.
+ */
 static void write_dscr(void *val)
 {
 	get_paca()->dscr_default = *(unsigned long *)val;
@@ -520,12 +541,29 @@ static void add_write_permission_dev_attr(struct device_attribute *attr)
 	attr->attr.mode |= 0200;
 }
 
+/**
+ * show_dscr_default() - Fetch the system wide DSCR default
+ * @dev:	Device structure
+ * @attr:	Device attribute structure
+ * @buf:	Interface buffer
+ *
+ * This function returns the system wide DSCR default value.
+ */
 static ssize_t show_dscr_default(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%lx\n", dscr_default);
 }
 
+/**
+ * store_dscr_default() - Update the system wide DSCR default
+ * @dev:	Device structure
+ * @attr:	Device attribute structure
+ * @buf:	Interface buffer
+ * @count:	Size of the update
+ *
+ * This function updates the system wide DSCR default value.
+ */
 static ssize_t __used store_dscr_default(struct device *dev,
 		struct device_attribute *attr, const char *buf,
 		size_t count)
-- 
1.9.3

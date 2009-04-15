Return-Path: <rcjenn@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD922DE158
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 01:55:49 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3FFoUOL011563
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 09:50:30 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3FFtZxY188048
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 09:55:36 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3FFtYqk008926
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 09:55:35 -0600
Date: Wed, 15 Apr 2009 10:55:32 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [v2] powerpc: CMO unused page hinting
Message-ID: <20090415155532.GC31337@austin.ibm.com>
References: <20090414013741.GA8678@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090414013741.GA8678@austin.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adds support for the "unused" page hint which can be used in shared
memory partitions to flag pages not in use, which will then be stolen
before active pages by the hypervisor when memory needs to be moved to
LPARs in need of additional memory.  Failure to mark pages as 'unused'
makes the LPAR slower to give up unused memory to other partitions.

This adds the kernel parameter 'cmo_free_hint' to disable this
functionality.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---

 Documentation/kernel-parameters.txt   |    7 +++++
 arch/powerpc/include/asm/page.h       |    5 +++
 arch/powerpc/platforms/pseries/lpar.c |   52 ++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

Index: b/Documentation/kernel-parameters.txt
===================================================================
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -459,6 +459,13 @@ and is between 256 and 4096 characters. 
 			Also note the kernel might malfunction if you disable
 			some critical bits.
 
+	cmo_free_hint=	[PPC] Format: { yes | no }
+			Specify whether pages are marked as being inactive
+			when they are freed.  This is used in CMO environments
+			to determine OS memory pressure for page stealing by
+			a hypervisor.
+			Default: yes
+
 	code_bytes	[IA32/X86_64] How many bytes of object code to print
 			in an oops report.
 			Range: 0 - 8192
Index: b/arch/powerpc/include/asm/page.h
===================================================================
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -231,6 +231,11 @@ extern void copy_user_page(void *to, voi
 		struct page *p);
 extern int page_is_ram(unsigned long pfn);
 
+#ifdef CONFIG_PPC_SMLPAR
+void arch_free_page(struct page *page, int order);
+#define HAVE_ARCH_FREE_PAGE
+#endif
+
 struct vm_area_struct;
 
 typedef struct page *pgtable_t;
Index: b/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -609,3 +609,55 @@ void __init hpte_init_lpar(void)
 	ppc_md.flush_hash_range	= pSeries_lpar_flush_hash_range;
 	ppc_md.hpte_clear_all   = pSeries_lpar_hptab_clear;
 }
+
+#ifdef CONFIG_PPC_SMLPAR
+#define CMO_FREE_HINT_DEFAULT 1
+static int cmo_free_hint_flag = CMO_FREE_HINT_DEFAULT;
+
+static int __init cmo_free_hint(char *str)
+{
+	char *parm;
+	parm = strstrip(str);
+
+	if (strcasecmp(parm, "no") == 0 || strcasecmp(parm, "off") == 0) {
+		printk(KERN_INFO "cmo_free_hint: CMO free page hinting is not active.\n");
+		cmo_free_hint_flag = 0;
+		return 1;
+	}
+
+	cmo_free_hint_flag = 1;
+	printk(KERN_INFO "cmo_free_hint: CMO free page hinting is active.\n");
+
+	if (strcasecmp(parm, "yes") == 0 || strcasecmp(parm, "on") == 0)
+		return 1;
+
+	return 0;
+}
+
+__setup("cmo_free_hint=", cmo_free_hint);
+
+static void pSeries_set_page_state(struct page *page, int order,
+				   unsigned long state)
+{
+	int i, j;
+	unsigned long cmo_page_sz, addr;
+
+	cmo_page_sz = cmo_get_page_size();
+	addr = __pa((unsigned long)page_address(page));
+
+	for (i = 0; i < (1 << order); i++, addr += PAGE_SIZE) {
+		for (j = 0; j < PAGE_SIZE; j += cmo_page_sz)
+			plpar_hcall_norets(H_PAGE_INIT, state, addr + j, 0);
+	}
+}
+
+void arch_free_page(struct page *page, int order)
+{
+	if (!cmo_free_hint_flag || !firmware_has_feature(FW_FEATURE_CMO))
+		return;
+
+	pSeries_set_page_state(page, order, H_PAGE_SET_UNUSED);
+}
+EXPORT_SYMBOL(arch_free_page);
+
+#endif

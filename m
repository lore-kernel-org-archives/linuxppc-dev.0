Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9855ADE004
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 05:32:26 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9TIWMhs002516
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 14:32:22 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9TIWMc6133986
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 14:32:22 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9TIWMcl009239
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 14:32:22 -0400
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH] [Powerpc V2] fix switch_slb handling of 1T ESID values
To: linuxppc-dev@ozlabs.org
Date: Mon, 29 Oct 2007 13:32:19 -0500
Message-ID: <20071029183218.19914.51410.stgit@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


[Powerpc V2] fix switch_slb handling of 1T ESID values

Now that we have 1TB segment size support, we need to be using the
GET_ESID_1T macro when comparing ESID values for pc,stack, and
unmapped_base within switch_slb().    A new helper function called
esids_match() contains the logic for deciding when to call GET_ESID
and GET_ESID_1T.

This also happens to fix a duplicate-slb-entry inspired machine-check
exception I was seeing when trying to run java on a power6 partition.

Tested on power6 and power5.

Signed-Off-By:  Will Schmidt <will_schmidt@vnet.ibm.com>
---

 arch/powerpc/mm/slb.c |   33 ++++++++++++++++++++++++++++++---
 1 files changed, 30 insertions(+), 3 deletions(-)


diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index bbd2c51..152f4cd 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -148,6 +148,34 @@ void slb_vmalloc_update(void)
 	slb_flush_and_rebolt();
 }
 
+/* Helper function to compare esids.  There are four cases to handle.
+ * 1. The system is not 1T segment size capable.  Use the GET_ESID compare.
+ * 2. The system is 1T capable, both addresses are < 1T, use the GET_ESID compare.
+ * 3. The system is 1T capable, only one of the two addresses is > 1T.  This is not a match.
+ * 4. The system is 1T capable, both addresses are > 1T, use the GET_ESID_1T macro to compare.
+ */
+static inline int esids_match(unsigned long addr1, unsigned long addr2)
+{
+	int esid_1t_count;
+
+	/* System is not 1T segment size capable. */
+	if (!cpu_has_feature(CPU_FTR_1T_SEGMENT))
+		return (GET_ESID(addr1) == GET_ESID(addr2));
+
+	esid_1t_count = (((addr1>>SID_SHIFT_1T)!=0) + ((addr2>>SID_SHIFT_1T)!=0));
+
+	/* both addresses are < 1T */
+	if (esid_1t_count == 0)
+		return (GET_ESID(addr1) == GET_ESID(addr2));
+
+	/* One address < 1T, the other > 1T.  Not a match */
+	if (esid_1t_count == 1) 
+		return 0;
+
+	/* Both addresses are > 1T. */
+	return (GET_ESID_1T(addr1) == GET_ESID_1T(addr2));
+}
+
 /* Flush all user entries from the segment table of the current processor. */
 void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -193,15 +221,14 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 		return;
 	slb_allocate(pc);
 
-	if (GET_ESID(pc) == GET_ESID(stack))
+	if (esids_match(pc,stack))
 		return;
 
 	if (is_kernel_addr(stack))
 		return;
 	slb_allocate(stack);
 
-	if ((GET_ESID(pc) == GET_ESID(unmapped_base))
-	    || (GET_ESID(stack) == GET_ESID(unmapped_base)))
+	if (esids_match(pc,unmapped_base) || esids_match(stack,unmapped_base))
 		return;
 
 	if (is_kernel_addr(unmapped_base))

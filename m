Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34BD1DDE32
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 06:46:53 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9QKkocd004875
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 16:46:50 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9QKkoWI123824
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 14:46:50 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9QKkoDB030727
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 14:46:50 -0600
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH] [Powerpc] fix switch_slb handling of 1T ESID values
To: linuxppc-dev@ozlabs.org
Date: Fri, 26 Oct 2007 15:46:42 -0500
Message-ID: <20071026204641.25514.45178.stgit@farscape.rchland.ibm.com>
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


[Powerpc] fix switch_slb handling of 1T ESID values

Now that we have 1TB segment size support, we need to be using the
GET_ESID_1T macro when comparing ESID values for pc,stack, and
unmapped_base within switch_slb() when we're on a CPU that supports it.

This also happens to fix a duplicate-slb-entry inspired machine-check
exception I was seeing when trying to run java on a power6 partition.

Tested on power6 and power5.

Signed-Off-By:  Will Schmidt <will_schmidt@vnet.ibm.com>

---

There is a similar bit of code in stab.c switch_stab().  Should this change also be made there?
---

 arch/powerpc/mm/slb.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)


diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index bbd2c51..0c527d7 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -193,16 +193,25 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 		return;
 	slb_allocate(pc);
 
-	if (GET_ESID(pc) == GET_ESID(stack))
-		return;
+	if (cpu_has_feature(CPU_FTR_1T_SEGMENT)) {
+		if (GET_ESID_1T(pc) == GET_ESID_1T(stack))
+			return;
+	} else
+		if (GET_ESID(pc) == GET_ESID(stack))
+			return;
 
 	if (is_kernel_addr(stack))
 		return;
 	slb_allocate(stack);
 
-	if ((GET_ESID(pc) == GET_ESID(unmapped_base))
-	    || (GET_ESID(stack) == GET_ESID(unmapped_base)))
-		return;
+	if (cpu_has_feature(CPU_FTR_1T_SEGMENT)) {
+		if ((GET_ESID_1T(pc) == GET_ESID_1T(unmapped_base))
+		    || (GET_ESID_1T(stack) == GET_ESID_1T(unmapped_base)))
+			return;
+	} else
+		if ((GET_ESID(pc) == GET_ESID(unmapped_base))
+		    || (GET_ESID(stack) == GET_ESID(unmapped_base)))
+			return;
 
 	if (is_kernel_addr(unmapped_base))
 		return;

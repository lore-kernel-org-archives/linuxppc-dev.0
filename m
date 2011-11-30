Return-Path: <anton@samba.org>
Message-Id: <20111130102415.317658395@samba.org>
Date: Wed, 30 Nov 2011 21:23:15 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 hbabu@us.ibm.com
Subject: [PATCH 7/9] powerpc/xics: Reset the CPPR if H_EOI fails
References: <20111130102308.348262468@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have an intermittent kdump fail where the hypervisor fails an H_EOI.
As a result our CPPR is never reset to 0xff and we no longer accept
interrupts.

This patch calls icp_hv_set_cppr to reset the CPPR if H_EOI fails,
fixing the kdump fail.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

- I'm still trying to understand why the H_EOI is failing, perhaps it's
  the code in machine_kexec_mask_interrupts that EOIs and masks interrupts.

- The patch is simpler than the diff output suggests, icp_hv_set_cppr
  was moved above icp_hv_set_xirr and the call to icp_hv_set_cppr was
  added.

Index: linux-build/arch/powerpc/sysdev/xics/icp-hv.c
===================================================================
--- linux-build.orig/arch/powerpc/sysdev/xics/icp-hv.c	2011-11-25 17:35:38.454558874 +1100
+++ linux-build/arch/powerpc/sysdev/xics/icp-hv.c	2011-11-25 20:15:06.169174037 +1100
@@ -41,23 +41,24 @@ static inline unsigned int icp_hv_get_xi
 	return ret;
 }
 
-static inline void icp_hv_set_xirr(unsigned int value)
+static inline void icp_hv_set_cppr(u8 value)
 {
-	long rc = plpar_hcall_norets(H_EOI, value);
+	long rc = plpar_hcall_norets(H_CPPR, value);
 	if (rc != H_SUCCESS) {
-		pr_err("%s: bad return code eoi xirr=0x%x returned %ld\n",
+		pr_err("%s: bad return code cppr cppr=0x%x returned %ld\n",
 			__func__, value, rc);
 		WARN_ON_ONCE(1);
 	}
 }
 
-static inline void icp_hv_set_cppr(u8 value)
+static inline void icp_hv_set_xirr(unsigned int value)
 {
-	long rc = plpar_hcall_norets(H_CPPR, value);
+	long rc = plpar_hcall_norets(H_EOI, value);
 	if (rc != H_SUCCESS) {
-		pr_err("%s: bad return code cppr cppr=0x%x returned %ld\n",
+		pr_err("%s: bad return code eoi xirr=0x%x returned %ld\n",
 			__func__, value, rc);
 		WARN_ON_ONCE(1);
+		icp_hv_set_cppr(value >> 24);
 	}
 }
 

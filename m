Return-Path: <anton@samba.org>
Date: Fri, 25 Nov 2011 16:39:36 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Harden xics hypervisor backend
Message-ID: <20111125163936.5218fbb3@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


During kdump stress testing I sometimes see the kdump kernel panic
with:

  Interrupt 0x306 (real) is invalid, disabling it.
  Kernel panic - not syncing: bad return code EOI - rc = -4, value=ff000306

Instead of panicing print the error message, dump the stack the first
time it happens and continue on. Add some more information to the
debug messages as well.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/sysdev/xics/icp-hv.c
===================================================================
--- linux-build.orig/arch/powerpc/sysdev/xics/icp-hv.c	2011-11-25 14:01:50.756984686 +1100
+++ linux-build/arch/powerpc/sysdev/xics/icp-hv.c	2011-11-25 14:13:22.389244117 +1100
@@ -27,33 +27,49 @@ static inline unsigned int icp_hv_get_xi
 {
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 	long rc;
+	unsigned int ret = XICS_IRQ_SPURIOUS;
 
 	rc = plpar_hcall(H_XIRR, retbuf, cppr);
-	if (rc != H_SUCCESS)
-		panic(" bad return code xirr - rc = %lx\n", rc);
-	return (unsigned int)retbuf[0];
+	if (rc == H_SUCCESS) {
+		ret = (unsigned int)retbuf[0];
+	} else {
+		pr_err("%s: bad return code xirr cppr=0x%x returned %ld\n",
+			__func__, cppr, rc);
+		WARN_ON_ONCE(1);
+	}
+
+	return ret;
 }
 
 static inline void icp_hv_set_xirr(unsigned int value)
 {
 	long rc = plpar_hcall_norets(H_EOI, value);
-	if (rc != H_SUCCESS)
-		panic("bad return code EOI - rc = %ld, value=%x\n", rc, value);
+	if (rc != H_SUCCESS) {
+		pr_err("%s: bad return code eoi xirr=0x%x returned %ld\n",
+			__func__, value, rc);
+		WARN_ON_ONCE(1);
+	}
 }
 
 static inline void icp_hv_set_cppr(u8 value)
 {
 	long rc = plpar_hcall_norets(H_CPPR, value);
-	if (rc != H_SUCCESS)
-		panic("bad return code cppr - rc = %lx\n", rc);
+	if (rc != H_SUCCESS) {
+		pr_err("%s: bad return code cppr cppr=0x%x returned %ld\n",
+			__func__, value, rc);
+		WARN_ON_ONCE(1);
+	}
 }
 
 static inline void icp_hv_set_qirr(int n_cpu , u8 value)
 {
-	long rc = plpar_hcall_norets(H_IPI, get_hard_smp_processor_id(n_cpu),
-				     value);
-	if (rc != H_SUCCESS)
-		panic("bad return code qirr - rc = %lx\n", rc);
+	int hw_cpu = get_hard_smp_processor_id(n_cpu);
+	long rc = plpar_hcall_norets(H_IPI, hw_cpu, value);
+	if (rc != H_SUCCESS) {
+		pr_err("%s: bad return code qirr cpu=%d hw_cpu=%d mfrr=0x%x "
+			"returned %ld\n", __func__, n_cpu, hw_cpu, value, rc);
+		WARN_ON_ONCE(1);
+	}
 }
 
 static void icp_hv_eoi(struct irq_data *d)

Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Gjk4xkBzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 16:14:34 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u756E6JK026492
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 02:14:32 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkahy7nn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 02:14:32 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 5 Aug 2016 00:14:31 -0600
Date: Thu, 4 Aug 2016 23:14:26 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/pseries: Dynamically increase RMA size
References: <20160805061041.GA31857@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160805061041.GA31857@us.ibm.com>
Message-Id: <20160805061426.GB31857@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>From ddce2a5f439111f08969d66ccc0c7b4d9196b69d Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Thu, 4 Aug 2016 23:13:37 -0400
Subject: [PATCH 2/2] powerpc/pseries: Dynamically increase RMA size

When booting a very large system with a large initrd we run out of space
for the flattened device tree (FDT). To fix this we must increase the
space allocated for the RMA region.

The RMA size is hard-coded in the 'ibm_architecture_vec[]' and increasing
the size there will apply to all systems, large and small, so we want to
increase the RMA region only when necessary.

When we run out of room for the FDT, set a new OF property, 'ibm,new-rma-size'
to the new RMA size (512MB) and issue a client-architecture-support (CAS)
call to the firmware. This will initiate a system reboot. Upon reboot we
notice the new property and update the RMA size accordingly.

The CAS call we issue would end up being a second CAS call in the boot
sequence. Use a static variable, 'fixup_nr_cores_done', to detect this
second CAS and avoid fixing up nr_cores or hitting the WARNING again.

Fix suggested by Michael Ellerman.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c | 86 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f612a99..407cbb9 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -679,6 +679,7 @@ unsigned char ibm_architecture_vec[] = {
 	W(0xffffffff),			/* virt_base */
 	W(0xffffffff),			/* virt_size */
 	W(0xffffffff),			/* load_base */
+#define IBM_ARCH_VEC_MIN_RMA_OFFSET	108
 	W(256),				/* 256MB min RMA */
 	W(0xffffffff),			/* full client load */
 	0,				/* min RMA percentage of total RAM */
@@ -867,6 +868,10 @@ static void fixup_nr_cores(void)
 {
 	u32 cores;
 	unsigned char *ptcores;
+	static bool fixup_nr_cores_done = false;
+
+	if (fixup_nr_cores_done)
+		return;
 
 	/* We need to tell the FW about the number of cores we support.
 	 *
@@ -898,6 +903,41 @@ static void fixup_nr_cores(void)
 		ptcores[1] = (cores >> 16) & 0xff;
 		ptcores[2] = (cores >> 8) & 0xff;
 		ptcores[3] = cores & 0xff;
+		fixup_nr_cores_done = true;
+	}
+}
+
+static void __init fixup_rma_size(void)
+{
+	int rc;
+	u64 size;
+	unsigned char *min_rmap;
+	phandle optnode;
+	char str[64];
+
+	optnode = call_prom("finddevice", 1, 1, ADDR("/options"));
+	if (!PHANDLE_VALID(optnode))
+		prom_panic("Cannot find /options");
+
+	/*
+	 * If a prior boot specified a new RMA size, use that size in
+	 * ibm_architecture_vec[]. See also increase_rma_size().
+	 */
+	size = 0ULL;
+	memset(str, 0, sizeof(str));
+	rc = prom_getprop(optnode, "ibm,new-rma-size", &str, sizeof(str));
+	if (rc <= 0)
+		return;
+
+	size = prom_strtoul(str, NULL);
+	min_rmap = &ibm_architecture_vec[IBM_ARCH_VEC_MIN_RMA_OFFSET];
+
+	if (size) {
+		prom_printf("Using RMA size %lu from ibm,new-rma-size.\n", size);
+		min_rmap[0] = (size >> 24) & 0xff;
+		min_rmap[1] = (size >> 16) & 0xff;
+		min_rmap[2] = (size >> 8) & 0xff;
+		min_rmap[3] = size & 0xff;
 	}
 }
 
@@ -911,6 +951,8 @@ static void __init prom_send_capabilities(void)
 
 		fixup_nr_cores();
 
+		fixup_rma_size();
+
 		/* try calling the ibm,client-architecture-support method */
 		prom_printf("Calling ibm,client-architecture-support...");
 		if (call_prom_ret("call-method", 3, 2, &ret,
@@ -946,6 +988,46 @@ static void __init prom_send_capabilities(void)
 	}
 #endif /* __BIG_ENDIAN__ */
 }
+
+static void __init increase_rma_size(void)
+{
+	int rc;
+	u64 size;
+	char str[64];
+	phandle optnode;
+
+	optnode = call_prom("finddevice", 1, 1, ADDR("/options"));
+	if (!PHANDLE_VALID(optnode))
+		prom_panic("Cannot find /options");
+
+	/*
+	 * If we already increased the RMA size, return.
+	 */
+	size = 0ULL;
+	memset(str, 0, sizeof(str));
+	rc = prom_getprop(optnode, "ibm,new-rma-size", &str, sizeof(str));
+
+	size = prom_strtoul(str, NULL);
+	if (size == 512ULL) {
+		prom_printf("RMA size already at %lu.\n", size);
+		return;
+	}
+	/*
+	 * Otherwise, set the ibm,new-rma-size property and initiate a CAS
+	 * reboot so the RMA size can take effect. See also init_rma_size().
+	 */
+	memset(str, 0, 4);
+	memcpy(str, "512", 3);
+	prom_printf("Setting ibm,new-rma-size property to %s\n", str);
+	rc = prom_setprop(optnode, "/options", "ibm,new-rma-size", &str,
+					strlen(str)+1);
+
+	/* Force a reboot. Will work only if ibm,fw-override-cas==false */
+	prom_send_capabilities();
+
+	prom_printf("No CAS initiated reboot? Try setting ibm,fw-override-cas to 'false' in Open Firmware\n");
+}
+
 #endif /* #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
 /*
@@ -2027,9 +2109,11 @@ static void __init *make_room(unsigned long *mem_start, unsigned long *mem_end,
 		room = alloc_top - alloc_bottom;
 		if (room > DEVTREE_CHUNK_SIZE)
 			room = DEVTREE_CHUNK_SIZE;
-		if (room < PAGE_SIZE)
+		if (room < PAGE_SIZE) {
+			increase_rma_size();
 			prom_panic("No memory for flatten_device_tree "
 				   "(no room)\n");
+		}
 		chunk = alloc_up(room, 0);
 		if (chunk == 0)
 			prom_panic("No memory for flatten_device_tree "
-- 
1.8.3.1

Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s81685RFlzDqdv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 03:11:44 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79H8lY4141487
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 13:11:42 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24na1y3wqc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 13:11:41 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 11:11:40 -0600
Date: Tue, 9 Aug 2016 10:11:31 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Paul Clarke <pc@us.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/pseries: Dynamically increase RMA size
References: <20160805061041.GA31857@us.ibm.com>
 <20160805061426.GB31857@us.ibm.com>
 <20160805183055.GA842@us.ibm.com>
 <aa4efc0a-1a12-5630-b8e4-752931bd9753@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aa4efc0a-1a12-5630-b8e4-752931bd9753@us.ibm.com>
Message-Id: <20160809171131.GA2329@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Clarke [pc@us.ibm.com] wrote:
> Only nits from me...(see below)

Paul,

I agree with your comments and fixed them. Here is the updated patch.

---

>From f9e9e8460206bc3fa7eaa741b9a2bde22870b9e0 Mon Sep 17 00:00:00 2001
From: root <sukadev@linux.vnet.ibm.com>
Date: Thu, 4 Aug 2016 23:13:37 -0400
Subject: [PATCH 2/2] powerpc/pseries: Dynamically grow RMA size

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

Fix suggested by Michael Ellerman.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

[v3]:	- [Paul Clarke] Fix a few nits.

[v2]:	- Add a comment in code regarding 'fixup_nr_cores_done'
	- Fix build break when CONFIG_PPC_PSERIES=n
---
 arch/powerpc/kernel/prom_init.c | 97 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f612a99..d1aaeda 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -87,6 +87,9 @@
 int of_workarounds;
 #endif
 
+#define IBM_NEW_RMA_SIZE_PROP	"ibm,new-rma-size"
+#define IBM_NEW_RMA_SIZE_STR	"512"
+
 #define OF_WA_CLAIM	1	/* do phys/virt claim separately, then map */
 #define OF_WA_LONGTRAIL	2	/* work around longtrail bugs */
 
@@ -679,6 +682,7 @@ unsigned char ibm_architecture_vec[] = {
 	W(0xffffffff),			/* virt_base */
 	W(0xffffffff),			/* virt_size */
 	W(0xffffffff),			/* load_base */
+#define IBM_ARCH_VEC_MIN_RMA_OFFSET	108
 	W(256),				/* 256MB min RMA */
 	W(0xffffffff),			/* full client load */
 	0,				/* min RMA percentage of total RAM */
@@ -867,6 +871,14 @@ static void fixup_nr_cores(void)
 {
 	u32 cores;
 	unsigned char *ptcores;
+	static bool fixup_nr_cores_done = false;
+
+	/*
+	 * If this is a second CAS call in the same boot sequence, (see
+	 * increase_rma_size()), we don't need to do the fixup again.
+	 */
+	if (fixup_nr_cores_done)
+		return;
 
 	/* We need to tell the FW about the number of cores we support.
 	 *
@@ -898,6 +910,42 @@ static void fixup_nr_cores(void)
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
+	rc = prom_getprop(optnode, IBM_NEW_RMA_SIZE_PROP, &str, sizeof(str));
+	if (rc <= 0)
+		return;
+
+	size = prom_strtoul(str, NULL);
+	min_rmap = &ibm_architecture_vec[IBM_ARCH_VEC_MIN_RMA_OFFSET];
+
+	if (size) {
+		prom_printf("Using RMA size %lu from %s.\n", size,
+						IBM_NEW_RMA_SIZE_PROP);
+		min_rmap[0] = (size >> 24) & 0xff;
+		min_rmap[1] = (size >> 16) & 0xff;
+		min_rmap[2] = (size >> 8) & 0xff;
+		min_rmap[3] = size & 0xff;
 	}
 }
 
@@ -911,6 +959,8 @@ static void __init prom_send_capabilities(void)
 
 		fixup_nr_cores();
 
+		fixup_rma_size();
+
 		/* try calling the ibm,client-architecture-support method */
 		prom_printf("Calling ibm,client-architecture-support...");
 		if (call_prom_ret("call-method", 3, 2, &ret,
@@ -946,6 +996,49 @@ static void __init prom_send_capabilities(void)
 	}
 #endif /* __BIG_ENDIAN__ */
 }
+
+static void __init increase_rma_size(void)
+{
+	int rc, len;
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
+	memset(str, 0, sizeof(str));
+	rc = prom_getprop(optnode, IBM_NEW_RMA_SIZE_PROP, &str, sizeof(str));
+
+	if (!strcmp(str, IBM_NEW_RMA_SIZE_STR)) {
+		prom_printf("RMA size already at %.3s.\n", str);
+		return;
+	}
+	/*
+	 * Otherwise, set the ibm,new-rma-size property and initiate a CAS
+	 * reboot so the RMA size can take effect. See also init_rma_size().
+	 */
+	len = strlen(IBM_NEW_RMA_SIZE_STR) + 1;
+	memcpy(str, IBM_NEW_RMA_SIZE_STR, len);
+
+	prom_printf("Setting %s property to %s\n", IBM_NEW_RMA_SIZE_PROP, str);
+	rc = prom_setprop(optnode, "/options", IBM_NEW_RMA_SIZE_PROP, str, len);
+
+	/* Force a reboot. Will work only if ibm,fw-override-cas==false */
+	prom_send_capabilities();
+
+	prom_printf("No CAS initiated reboot? Try setting ibm,fw-override-cas to 'false' in Open Firmware\n");
+}
+
+#else
+
+static void __init increase_rma_size(void)
+{
+}
+
 #endif /* #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
 /*
@@ -2027,9 +2120,11 @@ static void __init *make_room(unsigned long *mem_start, unsigned long *mem_end,
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

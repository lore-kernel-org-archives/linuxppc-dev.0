Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGYwD39NlzDrGy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 23:12:11 +1100 (AEDT)
Subject: [PATCH 1/3] powerpc-opal: Delete ten error messages for a failed
 memory allocation
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org, Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bhumika Goyal <bhumirks@gmail.com>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Rob Herring <robh@kernel.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5fb4f314-cd23-c439-ab13-96b8188070e0@users.sourceforge.net>
Message-ID: <e6e32520-c500-72b9-ce85-418f2f859af3@users.sourceforge.net>
Date: Tue, 17 Oct 2017 14:11:49 +0200
MIME-Version: 1.0
In-Reply-To: <5fb4f314-cd23-c439-ab13-96b8188070e0@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 17 Oct 2017 12:21:40 +0200

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/powernv/opal-async.c        |  2 --
 arch/powerpc/platforms/powernv/opal-dump.c         |  1 -
 arch/powerpc/platforms/powernv/opal-flash.c        |  4 +---
 arch/powerpc/platforms/powernv/opal-hmi.c          |  5 ++---
 .../powerpc/platforms/powernv/opal-memory-errors.c |  6 ++----
 arch/powerpc/platforms/powernv/opal-sysparam.c     | 25 +++++-----------------
 6 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index cf33769a7b72..2b11d8444b5a 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -193,8 +193,6 @@ int __init opal_async_comp_init(void)
 			sizeof(*opal_async_responses) * opal_max_async_tokens,
 			GFP_KERNEL);
 	if (!opal_async_responses) {
-		pr_err("%s: Out of memory, failed to do asynchronous "
-				"completion init\n", __func__);
 		err = -ENOMEM;
 		goto out_opal_node;
 	}
diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 4c827826c05e..b54864feef84 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -244,7 +244,6 @@ static int64_t dump_read_data(struct dump_obj *dump)
 	/* Allocate memory */
 	dump->buffer = vzalloc(PAGE_ALIGN(dump->size));
 	if (!dump->buffer) {
-		pr_err("%s : Failed to allocate memory\n", __func__);
 		rc = -ENOMEM;
 		goto out;
 	}
diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index 2fa3ac80cb4e..77d564266a59 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -437,10 +437,8 @@ static int alloc_image_buf(char *buffer, size_t count)
 	}
 
 	image_data.data = vzalloc(PAGE_ALIGN(image_data.size));
-	if (!image_data.data) {
-		pr_err("%s : Failed to allocate memory\n", __func__);
+	if (!image_data.data)
 		return -ENOMEM;
-	}
 
 	/* Pin memory */
 	addr = image_data.data;
diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index d78fed728cdf..b7dfe41a0a96 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -310,10 +310,9 @@ static int opal_handle_hmi_event(struct notifier_block *nb,
 
 	/* Delay the logging of HMI events to workqueue. */
 	msg_node = kzalloc(sizeof(*msg_node), GFP_ATOMIC);
-	if (!msg_node) {
-		pr_err("HMI: out of memory, Opal message event not handled\n");
+	if (!msg_node)
 		return -ENOMEM;
-	}
+
 	memcpy(&msg_node->hmi_evt, hmi_evt, sizeof(struct OpalHMIEvent));
 
 	spin_lock_irqsave(&opal_hmi_evt_lock, flags);
diff --git a/arch/powerpc/platforms/powernv/opal-memory-errors.c b/arch/powerpc/platforms/powernv/opal-memory-errors.c
index 4495f428b500..8d76c05252d1 100644
--- a/arch/powerpc/platforms/powernv/opal-memory-errors.c
+++ b/arch/powerpc/platforms/powernv/opal-memory-errors.c
@@ -107,11 +107,9 @@ static int opal_memory_err_event(struct notifier_block *nb,
 		return 0;
 
 	msg_node = kzalloc(sizeof(*msg_node), GFP_ATOMIC);
-	if (!msg_node) {
-		pr_err("MEMORY_ERROR: out of memory, Opal message event not"
-		       "handled\n");
+	if (!msg_node)
 		return -ENOMEM;
-	}
+
 	memcpy(&msg_node->msg, msg, sizeof(struct opal_msg));
 
 	spin_lock_irqsave(&opal_mem_err_lock, flags);
diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
index 23fb6647dced..1df05efe55a1 100644
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -184,11 +184,8 @@ void __init opal_sys_param_init(void)
 
 	/* Allocate big enough buffer for any get/set transactions */
 	param_data_buf = kzalloc(MAX_PARAM_DATA_LEN, GFP_KERNEL);
-	if (!param_data_buf) {
-		pr_err("SYSPARAM: Failed to allocate memory for param data "
-				"buf\n");
+	if (!param_data_buf)
 		goto out_kobj_put;
-	}
 
 	/* Number of parameters exposed through DT */
 	count = of_property_count_strings(sysparam, "param-name");
@@ -199,25 +196,16 @@ void __init opal_sys_param_init(void)
 	}
 
 	id = kzalloc(sizeof(*id) * count, GFP_KERNEL);
-	if (!id) {
-		pr_err("SYSPARAM: Failed to allocate memory to read parameter "
-				"id\n");
+	if (!id)
 		goto out_param_buf;
-	}
 
 	size = kzalloc(sizeof(*size) * count, GFP_KERNEL);
-	if (!size) {
-		pr_err("SYSPARAM: Failed to allocate memory to read parameter "
-				"size\n");
+	if (!size)
 		goto out_free_id;
-	}
 
 	perm = kzalloc(sizeof(*perm) * count, GFP_KERNEL);
-	if (!perm) {
-		pr_err("SYSPARAM: Failed to allocate memory to read supported "
-				"action on the parameter");
+	if (!perm)
 		goto out_free_size;
-	}
 
 	if (of_property_read_u32_array(sysparam, "param-id", id, count)) {
 		pr_err("SYSPARAM: Missing property param-id in the DT\n");
@@ -236,11 +224,8 @@ void __init opal_sys_param_init(void)
 	}
 
 	attr = kzalloc(sizeof(*attr) * count, GFP_KERNEL);
-	if (!attr) {
-		pr_err("SYSPARAM: Failed to allocate memory for parameter "
-				"attributes\n");
+	if (!attr)
 		goto out_free_perm;
-	}
 
 	/* For each of the parameters, populate the parameter attributes */
 	for (i = 0; i < count; i++) {
-- 
2.14.2

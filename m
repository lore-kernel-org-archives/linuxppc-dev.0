Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7355606A31B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wi+B7FpF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKDln6m3kz2xDD;
	Wed, 04 Nov 2026 16:39:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793770773;
	cv=none; b=XG7avJfuyCDPlhT+0vLNZKz1YErEfB9FecZF3VufcamfRaxV3oV382i9Q9n6qhpXw1MbTqUAMuIx4obdLa2l51aQUr+w14qc/1r4nLQ/i/FzcsIwABcRk/0QWGDscT+kyXGhkL6YNAIj41Lfeblt2MPTcdgbF0bTUQlBtk+lIgtHuRsw9MxBZCs+1vcKvNRD6ZHjK4f3xn5uIH4ZA82hyxRReTpxdZP9LphUWqTFNg/oNQ+haNFucCqIWr7tcbcSDMN85DaHLvBRgec4Lf7ULDe+niczCddGJDkfCRMI9I/dU0WrMFB4O4glUQSa3cTvrhVO/4clXli33T9ZltvHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793770773; c=relaxed/relaxed;
	bh=aqsZBLatw383ieyhKk8RgP6bu96UGZIgKh968P1yd3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2afvHejYQksfLaqy+MhKaz4zhLja4/lSHlufgedO8B6lM1j6P9b6qxzbSsx5CGh5KxNPVoi84VW+QC4xxOVJV1IzaoYxrbQQian/OFcJkLPMGSruRV7TyfOM0QGk08Qe+8+Ge4Vf7jtga08ORjve2QXlwr02hjHoQclf9tQEKskJK5lkjdpz15YbSppahLJbZdCRYzNWpXpZDC74X+4gvtX84OdC5hC7M8ZZ2+9pPrKka1dnLk72vdYVDt0Xp7NdpMW33r/nJz+z3akOKeFHGeDRUep5YEfFpXDIIPhFfrC+t/xejovY6WjaN4pUrFTjTFXqUTZw3/gCh6mledHlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wi+B7FpF; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wi+B7FpF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKDll5m8kz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 16:39:31 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40imFS3559791;
	Wed, 4 Nov 2026 05:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=aqsZBLatw383ieyhKk8RgP6bu96UGZIgKh968P1yd
	3c=; b=Wi+B7FpFCPo5HQFWbJ3Qs0sUT7QmmnBxQY9R1mRw2OemOqZoLeWehDarx
	gstvCzqmFvr1oksxxCA0gnoO1nXwQOINPI5ysNTeLViEnCy6zv2TznQ+2URGiTgF
	XfvfU/RftbHwUlsNl6bA3ZIp2okwisq2OiB24pic2gRudAOlg6zZIRpjSNhIr1DG
	DHI+MA1Qf1Pc6xPo2JtoiiLJBK9ABKS9A5xOTN773UBrf6cyPcrgxSSwX8MofX6T
	rj3yi/y/7WHPxBVUYrOP/WtEuApS4IQGs5ViZBKzCAGf8tWulhEfPvZD/X4F+8mk
	OLU9g0qQSO7Yf+XDzyEZePUjnO7Ew==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3j5gu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 05:39:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A45WdGF2167454;
	Wed, 4 Nov 2026 05:39:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf593t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 05:39:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A45d0fm31392328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 05:39:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A04620043;
	Wed,  4 Nov 2026 05:39:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FD5E20040;
	Wed,  4 Nov 2026 05:38:55 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.0.69])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 05:38:54 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, sshegde@linux.ibm.com, tglx@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
        pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
        seanjc@google.com, samir@linux.ibm.com, sourabhjain@linux.ibm.com,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH] powerpc/crash: Add only the onlined CPU's node to the crash FDT
Date: Wed,  4 Nov 2026 11:08:48 +0530
Message-ID: <20261104053848.1381005-1-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aeac4f9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=2jOG_h72ART-2k0SlQ4A:9
X-Proofpoint-ORIG-GUID: QQ5rCkI0zmD1N-YSJbT98-0aQkmLRdRc
X-Proofpoint-GUID: GEhFz6MSOq1AaYb4yEM3AOpUwlOAVVj8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfXwUiQ28VKM+p+
 pkvdcnsx1QAnnkIUs19rAjV69RLW4xKvYfY7LbMdWfA0a1fqa0q9VeztdalY12WtCQ0KceiMS9Y
 cVSBtfeb6YF/S3sAT+CXbNGUOeZ1w1kuLtMsI64rIq79tTA16PygFNjRf35R4pVe+24MYbr+Djz
 nPr16l2HP7HydGMk68BZ4xIjfTWZkPYo7GFiz0jaz1OXh0SOBa1vIUsU0rCvf5f1puAdGqkwiz0
 4+axPK+xNS1K9p6oSBXWyGCcMAcKoQVmoqqMdLRTbZHpmZg7+gTSvuVBHRAumOMX3Y9sk+x++30
 QyMllqGQcsAJYS7S9wb97O89qLrKgyH20OU38eQQIBNbkeYai1R3iT3Qci2PKP8lTl7TzUh2nkd
 fojJXm49M3QMY53fVqDRYdm7OxBtB496jK+G2Hb5TA8d2J+tc51pyPgL/pLYexeY/3vWRHrcOh+
 AaCgGJpRftCoJPgQhkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX4TCk8/O7vs4g
 W5foRjSw/brJ+TCuD9bwtWIBJN0aqy5dLB4mo+uJrv2d/zTmOXd8iPzPVexQFLlDhdJi9V/cIh1
 meEyAMFcT/EMXjd580f3qHLCv+6+VSw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040020
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A CPU coming online never changes the nodes that are already in the FDT,
so add only the node of that CPU. update_crash_fdt() looks up the device
node of the onlined CPU and does nothing if the FDT already has a node of
that name, which is the case when an offlined CPU comes back online. Only
when the node is missing, the crash image is invalidated while the node is
created with fdt_add_subnode() and its properties are copied from the live
device node with fdt_setprop(). All of this is done directly in
update_crash_fdt().

fdt_add_subnode() inserts the node as the first child of /cpus, which is
the same position a node attached to the live device tree takes, so the
FDT keeps the order of the live tree.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 arch/powerpc/kexec/crash.c | 65 +++++++++++++++++++++++++++++++-------
 arch/x86/kernel/crash.c    |  2 +-
 kernel/crash_core.c        | 11 +++++--
 3 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 775895f31037..ca37006bddea 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/libfdt.h>
 #include <linux/memory.h>
+#include <linux/of.h>
 
 #include <asm/processor.h>
 #include <asm/machdep.h>
@@ -584,32 +585,71 @@ static int get_fdt_index(struct kimage *image)
 }
 
 /**
- * update_crash_fdt - updates the cpus node of the crash FDT.
+ * update_crash_fdt - add the node of the onlined CPU to the crash FDT.
  *
  * @image: a pointer to kexec_crash_image
+ * @cpu: the CPU that was onlined
+ *
+ * The node is added as the first child of /cpus, the same position a node
+ * attached to the live device tree takes. Nothing is done if the FDT already
+ * has the node, for example when an offlined CPU comes back.
  */
-static void update_crash_fdt(struct kimage *image)
+static void update_crash_fdt(struct kimage *image, unsigned int cpu)
 {
+	struct device_node *dn;
+	struct property *pp;
 	void *fdt;
-	int fdt_index;
+	int fdt_index, cpus_offset, node_offset;
+
+	dn = of_get_cpu_node(cpu, NULL);
+	if (!dn) {
+		pr_err("No device node found for CPU %u\n", cpu);
+		return;
+	}
 
 	fdt_index = get_fdt_index(image);
 	if (fdt_index < 0) {
 		pr_err("Unable to locate FDT segment.\n");
-		return;
+		goto put;
 	}
 
 	fdt = __va((void *)image->segment[fdt_index].mem);
 
-	/* Temporarily invalidate the crash image while it is replaced */
+	cpus_offset = fdt_path_offset(fdt, "/cpus");
+	if (cpus_offset < 0) {
+		pr_err("Malformed device tree: error reading /cpus node: %s\n",
+		       fdt_strerror(cpus_offset));
+		goto put;
+	}
+
+	/* Node already present, e.g. an offlined CPU came back online */
+	if (fdt_subnode_offset(fdt, cpus_offset, dn->full_name) >= 0)
+		goto put;
+
+	/* Temporarily invalidate the crash image while it is updated */
 	xchg(&kexec_crash_image, NULL);
 
-	/* update FDT to reflect changes in CPU resources */
-	if (update_cpus_node(fdt))
-		pr_err("Failed to update crash FDT");
+	node_offset = fdt_add_subnode(fdt, cpus_offset, dn->full_name);
+	if (node_offset < 0) {
+		pr_err("Unable to add %s subnode: %s\n", dn->full_name,
+		       fdt_strerror(node_offset));
+		goto out;
+	}
 
+	for_each_property_of_node(dn, pp) {
+		int ret = fdt_setprop(fdt, node_offset, pp->name, pp->value, pp->length);
+
+		if (ret < 0) {
+			pr_err("Unable to add %s property: %s\n", pp->name,
+			       fdt_strerror(ret));
+			break;
+		}
+	}
+out:
 	/* The crash image is now valid once again */
 	xchg(&kexec_crash_image, image);
+put:
+	of_node_put(dn);
 }
 
 int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
@@ -625,10 +665,11 @@ int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
  * arch_crash_handle_hotplug_event - Handle crash CPU/Memory hotplug events to update the
  *				     necessary kexec segments based on the hotplug event.
  * @image: a pointer to kexec_crash_image
- * @arg: struct memory_notify handler for memory hotplug case and NULL for CPU hotplug case.
+ * @arg: struct memory_notify handler for memory hotplug case and pointer to the
+ *	 cpu number for CPU hotplug case.
  *
  * Update the kdump image based on the type of hotplug event, represented by image->hp_action.
- * CPU add: Update the FDT segment to include the newly added CPU.
+ * CPU add: Add the node of the newly added CPU to the FDT segment, if missing.
  * CPU remove: No action is needed, with the assumption that it's okay to have offline CPUs
  *	       part of the FDT.
  * Memory add/remove: No action is taken as this is not yet supported.
@@ -636,13 +677,15 @@ int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
 void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 {
 	struct memory_notify *mn;
+	unsigned int cpu;
 
 	switch (image->hp_action) {
 	case KEXEC_CRASH_HP_REMOVE_CPU:
 		return;
 
 	case KEXEC_CRASH_HP_ADD_CPU:
-		update_crash_fdt(image);
+		cpu = *(unsigned int *)arg;
+		update_crash_fdt(image, cpu);
 		break;
 
 	case KEXEC_CRASH_HP_REMOVE_MEMORY:
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e6f23933a6df..1660f26f3a44 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -441,7 +441,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
  * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
  * @image: a pointer to kexec_crash_image
  * @arg: struct memory_notify handler for memory hotplug case and
- *       NULL for CPU hotplug case.
+ *       pointer to the cpu number (unused here) for CPU hotplug case.
  *
  * Prepare the new elfcorehdr and replace the existing elfcorehdr.
  */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d0bd2d0cf899..53d4f2c1760c 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -651,6 +651,9 @@ int crash_check_hotplug_support(void)
  * NR_CPUS and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
  * excluded from SHA verification by default if the architecture
  * supports crash hotplug.
+ *
+ * @arg is a struct memory_notify pointer for memory hotplug events and a
+ * pointer to the unsigned int cpu number for CPU hotplug events.
  */
 static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
 {
@@ -676,10 +679,14 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 		goto out;
 
 	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
-		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		hp_action == KEXEC_CRASH_HP_REMOVE_CPU) {
 		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
-	else
+		/* CPU events are raised with no argument, the CPU number is passed instead */
+		WARN_ON(arg);
+		arg = &cpu;
+	} else {
 		pr_debug("hp_action %u\n", hp_action);
+	}
 
 	/*
 	 * The elfcorehdr_index is set to -1 when the struct kimage
-- 
2.54.0



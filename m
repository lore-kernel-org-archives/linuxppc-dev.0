Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD02760A6F6F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tTASNUZa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWCGq2yT3z2yQl;
	Fri, 20 Nov 2026 22:07:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795172851;
	cv=none; b=NOookwU8s2px0QbMDMCp3lQiDhCxNOdzgDWm9OufRto/0339PxU49Il+bIptJfqkIpAvSIK6+a0rk83+K8MVRDz/lP1wEXn9L13uRdQ2ze8n3L6ZYaylCPhdp8m/4sAB2jREaa0Gvj8z6na8zlgcUpFubvkAN6j7+0FA12goXoFFuJKMs2UHQXVeBnIi3PX693lh0X+re9l7bTMSB4HWbGmhQQ6d4x36TZqI0RGZOBCz9yL+3HYXtH4Fv3UY5sRu1Ra0naDbQJXnlgMMvfsKqnqMHcPFk56hHbuxcUXv2I6fgWUHjAWS/JIC0pIdq5GmahbjqCmtt205zSTjcIiDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795172851; c=relaxed/relaxed;
	bh=krzW8JA5SeSB6AemxYsCZKkogqNig5h2weoDQdwNw4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mG+YY6aoOotRh7l9Ny5CL28UOd6hW0M1oSM0ziY1ZskPUMlqRJT3vKgGTe00mpYwhYxB9h8jpnMo+CLN/f6ybERh0QYExCxp50oPgCZuxaLhN36OTv2EuUV8rdT3Zv5p7A6Ai3karTdAccO2cCyQyrQq236OHAfcJAKCe1/2/qjq4GMQnLs4OGuXFrgpi/Uiw1UfKJzXh8dDaDc70v78UeWE2Komi4AK/h9P6RMd/GYsD8RIbC6GuDmDng5pGCepv1E5I+3aJcLT/Far3IM7crj54jynWK2IVbzTWAzogUjIEBoF28StfxPEYXoB3na8BWdHqu+5LRnKKAE968+jwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tTASNUZa; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tTASNUZa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWCGn6j8Lz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 22:07:29 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAuL862860346;
	Fri, 20 Nov 2026 11:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=krzW8JA5SeSB6AemxYsCZKkogqNig5h2weoDQdwNw
	4A=; b=tTASNUZaNv9A51LgTLbPgk6ksKzTemQKNGTrGbhB9jgb8pTAsWVxN3nY8
	D1UydHi0Iwignraedr6zEHs4LN7RncfAk+ds9KwwgcwiKrs+B73HZN9UtrsvC6yb
	SgTNrql834GksGXSquFI60YJyGPvvnUrhD7uye2ZTMQlrO5Yl48az+DU6jfRd0ad
	lM6UmfuedcEz9PvOHVy4vUhBqVj8CqOW9lbaczoINQdDGE2WWimLs+3C/fujJfyz
	DReQEHtQp3v7kY144JGjJpDk3DuIWlUCrgeJqsmSuhyz0euKbz4yDvnNIGkMpQJq
	GeWwriD22clR5yo2uce6TpPYNtw1g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x7k5f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 11:07:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAo0wY1107116;
	Fri, 20 Nov 2026 11:07:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb5kqug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 11:07:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AKB6uFP47120844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 11:06:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 455C720049;
	Fri, 20 Nov 2026 11:06:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A42C2004B;
	Fri, 20 Nov 2026 11:06:52 +0000 (GMT)
Received: from li-4c4c4544-0042-3610-8056-b8c04f473234.ibmuc.com (unknown [9.67.110.43])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 11:06:52 +0000 (GMT)
From: Jyoti Gupta <jyoti@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, npiggin@gmail.com, chleroy@kernel.org,
        sshegde@linux.ibm.com, oss@buserror.net,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v3] powerpc: Fix missing of_node_put() calls
Date: Fri, 20 Nov 2026 16:36:48 +0530
Message-ID: <20261120110648.333973-1-jyoti@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-ORIG-GUID: FDJKcnjv-pk4DzVUcFJWBBu9ZEwd9A-6
X-Proofpoint-GUID: _cGq5DBCNG19CXJeZdJnPC_XNNEkdRfz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfX7+4AQnUGyIRl
 u26c+92N2e86U2MWMLQwfVUrDC1nBerYnV4uAqWwavS0mfbQ2wSKRaTT3n64i7iAQboF7W51H+w
 PxiTSMe3Ofxk1rrWSnGvycO+6SaqY20JQZfhwdX6atjjQwGssRnbjySa9XagzCJzR1UJjiqXBH1
 48f2S/vSg2xeps1a2dwwwnSkTQ6e13SOT+t3PuHaLkwKApMviAQTVhF3GsgQT9m6EleMPuzBx6k
 4R92htZz0rz4COdFgM38xNQ7XG6lZxH68kisGNk396wsCMe51vKufm9TKIOdg38qF/DAuglQw12
 YsNamqpiVFmri6Vf5mZEpMygb9/TA2eC+SX+jxTd8ytaETScg1onC/EpB5t9AAb94/NrB5ymYNI
 +88Mo9i/GXNxgsvi/y8uAXBr8gNgW2hzprlJupln5AeZYcdLQBJGnMGjyRKoImK29QCebxbjuz6
 LL03LDTVR5MqRidKE0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfXzfsyu3wmaEqu
 pb+psj0pjlKnQ1FxNK+Tdk/ZrFedDIgNJI2Dx+/yu8eO17H7BKHDY18Dsh0VEJpG/3ASIALMonG
 enXL0e9FkBWVFpmSo7WIXu18/JUs+/c=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6b0029d5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=QYYVrC4li8cYjS31S2QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200043
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Several PowerPC code paths acquire device tree node references but fail
to drop them on error paths, early exits.

Add the missing of_node_put() calls across PowerPC platform to ensure
proper device node reference counting.

These changes prevent device node reference leaks and improve overall
resource management in PowerPC code.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
---
v2 -> v3:
 - powermac/pci.c: Dropped __maybe_unused from the ht declaration in
   pmac_pci_init(), as ht is now used on both PPC32 and PPC64.
 - kexec/file_load_64.c: Use "goto out" for the -EOVERFLOW case in
   add_usable_mem_property() so the common of_node_put() cleanup is used,
   instead of adding a separate of_node_put() before the return.
 - Link to v2 - https://lore.kernel.org/all/20261119075827.45823-1-jyoti@linux.ibm.com/

v1 -> v2:
 - Rebased onto latest upstream.
 - Dropped the powermac/smp.c hunk: there is no leak there. The loop
   iterator drops cc on continue/advance and the existing code puts it
   before the break, so the added of_node_put() calls were a double put.
 - Added Suggested-by tag.
 - Link to v1 - https://lore.kernel.org/all/20260930182304.341123-1-jyoti@linux.ibm.com/
---
 arch/powerpc/kexec/file_load_64.c            | 3 ++-
 arch/powerpc/platforms/44x/iss4xx.c          | 2 ++
 arch/powerpc/platforms/44x/warp.c            | 1 +
 arch/powerpc/platforms/85xx/mpc85xx_8259.c   | 1 +
 arch/powerpc/platforms/86xx/pic.c            | 1 +
 arch/powerpc/platforms/pasemi/setup.c        | 1 +
 arch/powerpc/platforms/powermac/pci.c        | 3 ++-
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 4 ++--
 8 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index bd80c5fb1b1f..328554fe064e 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -204,7 +204,8 @@ static int add_usable_mem_property(void *fdt, struct device_node *dn,
 	if (snprintf(path, NODE_PATH_LEN, "%pOF", dn) > (NODE_PATH_LEN - 1)) {
 		pr_err("Buffer (%d) too small for memory node: %pOF\n",
 		       NODE_PATH_LEN, dn);
-		return -EOVERFLOW;
+		ret = -EOVERFLOW;
+		goto out;
 	}
 	kexec_dprintk("Memory node path: %s\n", path);
 
diff --git a/arch/powerpc/platforms/44x/iss4xx.c b/arch/powerpc/platforms/44x/iss4xx.c
index ef883d97fe15..ef92b4656d17 100644
--- a/arch/powerpc/platforms/44x/iss4xx.c
+++ b/arch/powerpc/platforms/44x/iss4xx.c
@@ -74,6 +74,8 @@ static void __init iss4xx_init_irq(void)
 #endif
 	} else
 		panic("Unrecognized top level interrupt controller");
+
+	of_node_put(np);
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index 6f674f86dc85..49afd60b1c30 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -183,6 +183,7 @@ static int pika_setup_leds(void)
 				printk(KERN_ERR __FILE__ ": Failed to get %s led gpio: %d\n",
 				       led->name, error);
 				of_node_put(child);
+				of_node_put(np);
 				goto err_cleanup_pins;
 			}
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_8259.c b/arch/powerpc/platforms/85xx/mpc85xx_8259.c
index cb00d596ad80..9b7283038892 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_8259.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_8259.c
@@ -52,6 +52,7 @@ void __init mpc85xx_8259_init(void)
 	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
 	if (!cascade_irq) {
 		pr_err("i8259: Failed to map cascade interrupt\n");
+		of_node_put(cascade_node);
 		return;
 	}
 
diff --git a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
index 9ca36de23532..4cbcc16b1009 100644
--- a/arch/powerpc/platforms/86xx/pic.c
+++ b/arch/powerpc/platforms/86xx/pic.c
@@ -58,6 +58,7 @@ void __init mpc86xx_init_irq(void)
 	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
 	if (!cascade_irq) {
 		printk(KERN_ERR "Failed to map cascade interrupt\n");
+		of_node_put(cascade_node);
 		return;
 	}
 
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 7a961f2a228f..a82855752e58 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -272,6 +272,7 @@ static __init void pas_init_IRQ(void)
 	opprop = of_get_property(root, "platform-open-pic", &opplen);
 	if (!opprop) {
 		pr_err("No platform-open-pic property.\n");
+		of_node_put(mpic_node);
 		of_node_put(root);
 		return;
 	}
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index d71359b5331c..114def2e8043 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -903,7 +903,7 @@ static int pmac_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
 void __init pmac_pci_init(void)
 {
 	struct device_node *np, *root;
-	struct device_node *ht __maybe_unused = NULL;
+	struct device_node *ht = NULL;
 
 	pci_set_flags(PCI_CAN_SKIP_ISA_ALIGN);
 
@@ -938,6 +938,7 @@ void __init pmac_pci_init(void)
 	/* pmac_check_ht_link(); */
 
 #else /* CONFIG_PPC64 */
+	of_node_put(ht);
 	init_p2pbridge();
 	init_second_ohare();
 	fixup_nec_usb2();
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index bc6926dbf148..c4f7348aa035 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -637,16 +637,16 @@ static unsigned int pseries_cpuhp_cache_use_count(const struct device_node *cach
 
 	for_each_of_cpu_node(dn) {
 		tn = of_find_next_cache_node(dn);
-		of_node_put(tn);
 		if (tn == cachedn)
 			use_count++;
+		of_node_put(tn);
 	}
 
 	for_each_node_by_type(dn, "cache") {
 		tn = of_find_next_cache_node(dn);
-		of_node_put(tn);
 		if (tn == cachedn)
 			use_count++;
+		of_node_put(tn);
 	}
 
 	return use_count;
-- 
2.55.0



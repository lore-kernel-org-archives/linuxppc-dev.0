Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D3606A325
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JLxFFiFR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVW7d3wnQz2y0B;
	Thu, 19 Nov 2026 18:58:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795075133;
	cv=none; b=IAgSxrBMQjbon1JigbkVFZFGxv3i5t/ghXXTMJLQV0WQJMJ/ojsUjI2RkKz3q3/YSiqEUUbSHkF+fqUDZZPHN3b+4cgjpHCkcWmwSe6hT7dIQslcopNDJTu65feb6UtrtV73y+fgLGBZSQjed+kGcsFJZtJR6KKES4wE4Tc/+fxJrx3uyJS/h4CeqoCS+/bJEUfy29qtq5J59aS1HYzTWIGOhIYFUdQBPPZwHR3gY2RTzojVmtakD3+ufFPyAPcEgeScjmA3jrKrR7JsVDtd6eF3E1vKZP7/sL3Ee82SWy6yBceKs4LbemyoTiaAenc6NOXmJqrQ8yAt0QLrGoIyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795075133; c=relaxed/relaxed;
	bh=QRg3IAfY/gb2uCjRQtKhpGvavtxNYWqAbO6Z4z+vmCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAwmHn7KAFiZcSGQBduM0/b4AQBTlHtCRvb3G9nWCQXueM4Su7U/Yl+xLzXf/BHsugPvDCeZTjOW3Cq/xu0qlH8n6Ep0ed5a2b2reFBgGpyIuheK8U4KcSSmZYnhFejHrffs/6BJ/5E7ynTIjhECgPQDH8Jc8xfA2/77znJhyLYanbl8nCMC0+0dk8FbpHGABJJ6YpZUMqEqeMU+6M8hx1x+4asjnTZux+5ek3z5D0odzpX3LuXBYaaoWy//E5z+iVbfPimQRwskIlAn2ivOPiEjd3sJx05xxCIgXSrLMn3n6aa/K7trqjh3OyNoOa9sRDBddqW2m1VhUMQJETo0rQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JLxFFiFR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JLxFFiFR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVW7c2prsz2xlk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 18:58:51 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6uZk62236096;
	Thu, 19 Nov 2026 07:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QRg3IAfY/gb2uCjRQtKhpGvavtxNYWqAbO6Z4z+vm
	Cc=; b=JLxFFiFR0DV/csFDY7PovnoQbt/OxFvTNZaOFmC90RUd5lU+99rS40b71
	euUKokVoIjCcPVijgIGrS95ftr297Zvsp9ouBTTXokr6m98IuaipKeiS/VfM7w6g
	PgR25xyaBvsEzr2kFiXYmTQfSbWpfzDoC6KML1mn8CscKYduvQlPZNh32YMKLoRi
	85S4h/V7XiKGVMmNYHw2fRCpR3zf4vm+EwXZrjHScuWY31wlLbZOcVAnZ18lipH5
	a5hL4aNnl80+yoILOEkyWHQZW56UC0+QPtraf3fqjAArYaGnHWqxh5V7j1Og66Fy
	LqQmYn7cPtmdQzPrA1K/XNWqdGeJw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vy736-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 07:58:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ75Bg63327265;
	Thu, 19 Nov 2026 07:58:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb5cc9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 07:58:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ7wYkn51839292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 07:58:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7E1920040;
	Thu, 19 Nov 2026 07:58:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D42C02004B;
	Thu, 19 Nov 2026 07:58:30 +0000 (GMT)
Received: from li-4c4c4544-0042-3610-8056-b8c04f473234.ibmuc.com (unknown [9.67.189.13])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 07:58:30 +0000 (GMT)
From: Jyoti Gupta <jyoti@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, oss@buserror.net,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2] powerpc: Fix missing of_node_put() calls
Date: Thu, 19 Nov 2026 13:28:27 +0530
Message-ID: <20261119075827.45823-1-jyoti@linux.ibm.com>
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
X-Proofpoint-GUID: mf6LIfeMcoyRap1Vhkc4_SCVVhgoDrHB
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afeac30 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=BbdIejFhxMrvHznRc9oA:9
X-Proofpoint-ORIG-GUID: LQX2FtGkBLjQee61M-VYezkSEFJBV5HL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMSBTYWx0ZWRfX8XoiVyIIkEKs
 ZUr0C9DRfM9Z/FujgoShxR+Nj3Rlmk2X/+GRC6acd2R+hMtfUsCSARVUOpzv0tg1uMtdUP2spEv
 VmFs2ce5es46slFJt+tMXBnsbFSa/Qc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMSBTYWx0ZWRfX8G3k/Sf4/WUd
 0IUUGbkznd5ncdh2SlqtgnktK947LewWk5hjUpLLrmyAkJLvdel+cqBX6PESe8BZt1Rw7Jo1kIR
 D+CkynQCqlQXK9ETZA7fx7//Y8uZwku12bUhd8JVgkOcK9OuB8H5nNRxRDt5hTPEOOEWgpme1mD
 f3opwrXRfWVKXym2AIR8egg6HKpXkajK1u7iD8xT3MfDF1ALN+rAmQyf6dsoX6kQ683EAVPRSsz
 vyeGfMVT93aZKpxkG5+GzvZSXfj5pX6Rxoh/YeNRV+n6s1nW02Hr1cqqYOovpAM/cgj6aJcqQY9
 7Ac/GL67O9jL/i55qIzH20/aNLrNKXvurGXLbEa4URsRi/rRmQkveq6O8zR1y2pvq/ZlDJuKRNK
 Y3vHfkjpS+zzelxyFGR04FEH1omFj/4PizPYQAayT/pvELEtR5OVprPPoQeXlo8df16uqZi6Qeo
 DykGyTUx27EvM5qyUDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190031
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
Changelog:
v1 -> v2:
 - Rebased onto latest upstream.
 - Dropped the powermac/smp.c hunk: there is no leak there. The loop
  iterator drops cc on continue/advance and the existing code puts it
  before the break, so the added of_node_put() calls were a double put.
 - Added Suggested-by tag.
 - Link to v1 - https://lore.kernel.org/all/20260930182304.341123-1-jyoti@linux.ibm.com/
---
 arch/powerpc/kexec/file_load_64.c            | 1 +
 arch/powerpc/platforms/44x/iss4xx.c          | 2 ++
 arch/powerpc/platforms/44x/warp.c            | 1 +
 arch/powerpc/platforms/85xx/mpc85xx_8259.c   | 1 +
 arch/powerpc/platforms/86xx/pic.c            | 1 +
 arch/powerpc/platforms/pasemi/setup.c        | 1 +
 arch/powerpc/platforms/powermac/pci.c        | 1 +
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 4 ++--
 8 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index bd80c5fb1b1f..8d4d6a51c046 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -204,6 +204,7 @@ static int add_usable_mem_property(void *fdt, struct device_node *dn,
 	if (snprintf(path, NODE_PATH_LEN, "%pOF", dn) > (NODE_PATH_LEN - 1)) {
 		pr_err("Buffer (%d) too small for memory node: %pOF\n",
 		       NODE_PATH_LEN, dn);
+		of_node_put(dn);
 		return -EOVERFLOW;
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
index d71359b5331c..8bc56a70b4c8 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
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



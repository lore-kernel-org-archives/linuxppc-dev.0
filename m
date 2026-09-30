Return-Path: <linuxppc-dev+bounces-28600-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10747CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 18:23:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw3MT46jhz2y8d;
	Thu, 01 Oct 2026 04:23:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790792613;
	cv=none; b=mKPgfuwxqoIg57ZXerlkj6Zc0dB3UrIrAbmw/jjknz0Kf383m543FYdGTKYo+cCGxr0TnuQVIVG1x7a7eTcPRb7HyOZBGy4iFz/mNxxQjxM7WLbVEey0roKZ+GWvKW7x8BhtIXAfVaYO/Kdzgg2U5RKqkPgzgRbBkE3ppfRS1uJeqJB7hmfR0dQU02g/6kMwM47pZSQm5S6ULuFU1ErBOvtJHpjTzRiM10R0SMlLpCmajUD8eCVCLTrv2o8cLDJXwQAgM1cUxtb1/rPGSQYFknLaLSDNE4QMlef20sWc7cwSn52pbTWVpkq59ITHzgde+BxbHnVOvLekVsA8R55THA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790792613; c=relaxed/relaxed;
	bh=4lDtT9e2B4ygPzVeJL6Honx3atIMWjwoykdDvY+qJ/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dO4injboxb2y+l3XmQl25p8iTsxAvUhEFYstrYyvhoxxFFdRcpXSTJmJnJbde9pOprKZyElxVDO2sOD6SG3vBlGJEtw4APmWfy+28xelzPrM3BBGtPpv/t+wrGyb7xcQBS/doNeF0hxXldaERedJ6ADr7N28/7x2+oruosLzwX5PFTFa9j47QBrJu+69VpN0SaCYjladp7XRjcWJt4gXn9uWpw6gEg7oyrtuz/Wb7TXnKx8nPqWAEZsRoxONWFCmGr3pp9KN9oFh7U1nvMv9v1B3jVu89uMCskHxuYntuIHgcFBdE4hd1cLJsgua/9BG6HFZAdxKuS1xOSCkKkKf6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g4PS0lOl; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g4PS0lOl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw3MS2rYJz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 04:23:31 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UI5hWK3675277;
	Wed, 30 Sep 2026 18:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4lDtT9e2B4ygPzVeJL6Honx3atIMWjwoykdDvY+qJ
	/c=; b=g4PS0lOlEwLMkUitUT3vQCFx2GuC0ebIf5b6T4Nb7V0Iju7fAjvNumz4y
	J6WvsQO4NboatI4hp1SDyIU0JpcZdtnqP9zR7uTE09RK9YQnBWhrtNmVBDQYzaZ8
	x+m4OIkw9aDq2XYN1xhE6h4JzItsc25yAD24eaiLpS3SZtfD1hF+K2NnNidOuftw
	wKQNJrHOEAEwCpA4NfaFZFaXKOu/6EzrGxCOHEeoWcBEhkgLFqfv69LXs0h2ygfu
	EhaBIatMUfR/IZUfGfc8PgwHWafkdIwgltIakObst0H+rquYR/PbYiHTQ+06M4Bu
	Fk9rH2VX7KrMZ0ZOd1LtejOHkKZ3w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5erj1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 18:23:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UHlXSx3874838;
	Wed, 30 Sep 2026 18:23:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23n0mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 18:23:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UINIVH35258640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 18:23:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66FCD20043;
	Wed, 30 Sep 2026 18:23:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F02620040;
	Wed, 30 Sep 2026 18:23:14 +0000 (GMT)
Received: from li-4c4c4544-0042-3610-8056-b8c04f473234.ibmuc.com (unknown [9.67.31.86])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 18:23:13 +0000 (GMT)
From: Jyoti Gupta <jyoti@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        sourabhjain@linux.ibm.com
Subject: [PATCH] powerpc: Fix missing of_node_put() calls
Date: Wed, 30 Sep 2026 23:53:04 +0530
Message-ID: <20260930182304.341123-1-jyoti@linux.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MyBTYWx0ZWRfX0gBPopShWzE9
 ePAP55fgqayFeffeMm/jGtETKlWl6TGoCloqARItCDFVXrvt8pf1+H08cdVmRP8QvrwXEXhrWK9
 aB7f66spbacgs2qBs9vbQUYwSOVJqzI=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abd539b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=PfflLTzKXcKNkTfC-jwA:9
X-Proofpoint-GUID: UsPXpCuSBJIzH0WSv5d7ufNEGOFruKpW
X-Proofpoint-ORIG-GUID: uMZzzIk9ydLY67LF369F_JH2Gsh55rdM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MyBTYWx0ZWRfX8wWehAKyej4B
 hn3B+Gh+lID/bQuQ+RjtPEI7sx13o1HCwrpR9kPeY0ZKjmJQU4iiFI6OHmxOdonDo6JB5/ty8XN
 SWqNtG6qPeXI3RMx1/+6L6BlBXXqnIeoSdo/xCupKUF8NwpZLnqPPhc14Ya+U6jS9T0BZHFvPc/
 nrsev7dO493m+spDmxMuTGO1rs+sX/eYNEo1qDSkYm77T41YabtXAc/vf3INbl8b0voEVIKI0vr
 nBwGiGEmXKtBfPdBjifpktc/dTjjp9v/3tPvXnZGlz6c1A2/HAxD3CysB+DwmId4YrEkPYzfF83
 Kjb0YySjtmt1aRToA+LwgmXVqmHguI5CZWEBpzHhgytL+vyylaA2uAaHBxdyyTRMaDVjdumBjpO
 Yv9XNWcMr9zgUJeeX1RRSqnJ3bO2Wh0NtPKLi4R9K83vhvO/IMDUEEjNIOJ1gRJzQBngCctEqXD
 GnoJWzESLFSrWrwP6QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300073

Several PowerPC code paths acquire device tree node references but fail
to drop them on error paths, early exits.

Add the missing of_node_put() calls across PowerPC platform to ensure
proper device node reference counting.

These changes prevent device node reference leaks and improve overall
resource management in PowerPC code.

Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
---
 arch/powerpc/kexec/file_load_64.c            | 1 +
 arch/powerpc/platforms/44x/iss4xx.c          | 2 ++
 arch/powerpc/platforms/44x/warp.c            | 1 +
 arch/powerpc/platforms/85xx/mpc85xx_8259.c   | 1 +
 arch/powerpc/platforms/86xx/pic.c            | 1 +
 arch/powerpc/platforms/pasemi/setup.c        | 1 +
 arch/powerpc/platforms/powermac/pci.c        | 1 +
 arch/powerpc/platforms/powermac/smp.c        | 2 ++
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 4 ++--
 9 files changed, 12 insertions(+), 2 deletions(-)

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
index 45792ecd5dfd..b016e27b20ee 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -274,6 +274,7 @@ static __init void pas_init_IRQ(void)
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
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 88e92af8acf9..82c5f49576c5 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -591,11 +591,13 @@ static void __init smp_core99_setup_i2c_hwsync(int ncpus)
 				pmac_tb_freeze = smp_core99_cypress_tb_freeze;
 				name = "Cypress";
 			}
+			of_node_put(cc);
 			break;
 		case 0xd4:
 			pmac_tb_freeze = smp_core99_pulsar_tb_freeze;
 			pmac_tb_pulsar_addr = 0xd4;
 			name = "Pulsar";
+			of_node_put(cc);
 			break;
 		}
 		if (pmac_tb_freeze != NULL) {
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



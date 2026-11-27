Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8995606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U8UGgBm4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbcdK5Hl8z3bdQ;
	Sat, 28 Nov 2026 02:23:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795793029;
	cv=none; b=Cwgppcj4Uq4IOCw+zoaxcY0kDnLgQqFjMpYJ/ZW0DlZgXk8sv5xBbVGCaQepMi6+wHzIfcKTiTH+OXMiQk3RDl6nh7v9nkQAYdD7Ip3kzCZiu/x5Vx74CWmiSEJ6kCkHLwBKZTDSHlBFXLIpv8C6VghVsXkzMOU1xhxB4UHJuV3prunprlxpK8C4gFWf292fsfyA8k8clYjBr2lkNRBl/1SM4HAFpeaVvdHvVNmvnFTsrsdI1EefNXBDfJaSpg2CaCgEbUF/6mAt43QUG2zccKaKzg2ZCiG3+VIh2lN9OmXpxZ9GHVJWOM9moe2D8BkCARZpbnkaMRRMQfe2A9Lwig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795793029; c=relaxed/relaxed;
	bh=hqqhgE433KcSZ8vgV5OOGPKLcNxG6zV5BKSl6fHyFZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mc5vebRj7SOD1+sNE2/H6c1YqQvdhbLAhE6wwk688ErZ9sBHxysIldUB0s/WRZIGbQqxiBKwrq++fNkMewOMwfkl8ErMLup7dMYBn4gaP6zJycDQl3xaVSDMctER/RzDdnkHxfYO8s6YpcscCpcvJq/gTcDPu75ctTedSbM3MPADHVdmFL1E92JJtJNRdyr8r8KKavh9Tw0FCNSethQvQK97pW1Ur7Nx8dp6zLXrQ6IeDo036WUkDk8t4aR66OoAb+xHzcVEN+SLC/hspw4To6Cd7nIgIDHV9GB8QcA7Wjq9AijB2Nr2gShhRAkzbSGvLJUuZUy9WcG1lQAvIerEfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U8UGgBm4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U8UGgBm4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbcdK0cxKz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 02:23:48 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4You3419270;
	Fri, 27 Nov 2026 15:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hqqhgE433KcSZ8vgV
	5OOGPKLcNxG6zV5BKSl6fHyFZ0=; b=U8UGgBm4njhILtVXyZOblzYP3zSft6tkZ
	eomMNAGWnUh/dkvetRw7VzKjCoGqk5c+ODmhk7IUzKkz/XsSqLKcVSeERZiWvoRW
	6qGs/bMe2MXcZaIgQCmYJ9UpiFHQsZLXIGfD5JBUnnlONEZqWlDicn0K4zfXdqgu
	NqPkjtjYU1EL5aqZRp12p9WHzGgxwj/wDH3WV1yjU+xEIPP4RC0zLftbpUvzFPCt
	tkcM2N1tX5XcectwiYUCFnFEEciddYN9xg3963msDFUOz6gdwH8XGbzBVpozEKk1
	qMLjEseiklNd8G4n3qopznVgeLcmt7pz6cZBnzm1+MWm+skahL2FQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fapffh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:23:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4EYq3998998;
	Fri, 27 Nov 2026 15:23:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6x3h2mrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:23:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARFNIT434669028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:23:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9BAF2005A;
	Fri, 27 Nov 2026 15:23:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B8DF20040;
	Fri, 27 Nov 2026 15:23:12 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.16.105])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:23:12 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu, ritesh.list@gmail.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        johan@kernel.org, sudeep.holla@kernel.org, peterz@infradead.org,
        tglx@kernel.org, kprateek.nayak@amd.com, srikar@linux.ibm.com
Subject: [PATCH v2 4/6] powerpc: Set CPU device OF node before generic cacheinfo setup
Date: Fri, 27 Nov 2026 20:52:40 +0530
Message-ID: <20261127152242.306333-5-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127152242.306333-1-sshegde@linux.ibm.com>
References: <20261127152242.306333-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX3jlhhuU5fUWB
 qsGuKePw8eq2xuPaYLln27pGnoERstTp55RzpdHLkD6qsGQoZvqPVFrq3ln3VsdaDs3W+S9oFpR
 eiW5gFVO2HzneahEK3fIfDZPxlZAgllB0sFOsMANoRoUTPv3ghZ0RMQJalJl1l/mWGJxEzxoQ3W
 hRzXJpvQJlsApBthQtqPlbsTqw0+ypZNPsof+d66M0P8TlBa+GBlS7IGSPE53wGCMc5NmnXNcgS
 jnBliY4KKN+CBZiak3LG9fVE3zjdlUX+C+yP13EWb9aMTh+qHdmxkPXzdk2Q4prbJJOsf1Q7F0Y
 y5+D1BQHOl5rUgmF2eU8h9c7JbG3Cg3T9mjPQXPRbW5HmO7xQvk3IS+S267+Oy/ZS1coti4wi3e
 Wnrzvb/dNdg5N/4T59pcLncaqTlIQDW8bwOODwIV/0j60xo/dbwXMXLqisUBbjpdAYY6LXKX85Q
 9HYjCYP60JBgmUJnvpg==
X-Proofpoint-ORIG-GUID: 7AGcOsGJijxzZNrVmpMf0-G-SBN85-nW
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b09a06c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=3ijWfzhErC_hVeATpmQA:9
X-Proofpoint-GUID: JVKfY-Y3P_StBsRMRWj5CzSe4ylmDv0e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX/JAYUQTsZRVm
 Z8vLzfZIPdbBwV3MfQPn4iL9d3PL+kAt+plv1wdyfCl4DlT+nDWBt92+6bUgWPBsKdHt4Vf1gXz
 0kcBxLK0ZSi49WtP+QkGtpW750KRly0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270060
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PowerPC currently associates a CPU device with its device-tree node from
register_cpu_online(), which runs in the CPUHP_AP_ONLINE_DYN range.

Generic cacheinfo runs earlier at CPUHP_AP_BASE_CACHEINFO_ONLINE. For a
CPU added through pSeries DLPAR, the CPU device already exists but its
of_node is still NULL. Consequently, of_cpu_device_node_get() cannot find
the CPU node and generic cacheinfo prevents the CPU from coming online.

Add an explicit PowerPC CPU hotplug state immediately before
CPUHP_AP_BASE_CACHEINFO_ONLINE and move the CPU-device OF-node association
there. Keep the remaining PowerPC sysfs setup at its existing dynamic
state.

This also provides the correct teardown ordering: generic cacheinfo is
removed before PowerPC releases the CPU device's OF-node reference.

[Both draft changelog and code are written by LLM under guidance]
Assisted-by: LLM
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/sysfs.c | 51 ++++++++++++++++++++++++++++++++-----
 include/linux/cpuhotplug.h  |  1 +
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 2100c5e2c821..092312163b35 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -834,6 +834,40 @@ static void remove_idle_spurr_file(struct device *s)
 #define remove_idle_spurr_file(s)
 #endif /* CONFIG_PPC_PSERIES */
 
+static int register_cpu_of_node(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	if (!dev)
+		return -ENODEV;
+
+	/*
+	 * CPUs present at boot already acquire this reference from
+	 * register_cpu(). DLPAR-added and re-onlined CPUs may not have
+	 * the OF node associated with the CPU device yet.
+	 */
+	if (!dev->of_node)
+		dev->of_node = of_get_cpu_node(cpu, NULL);
+
+	if (!dev->of_node)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int unregister_cpu_of_node(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	if (!dev)
+		return 0;
+
+	of_node_put(dev->of_node);
+	dev->of_node = NULL;
+
+	return 0;
+}
+
 static int register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -841,10 +875,6 @@ static int register_cpu_online(unsigned int cpu)
 	struct device_attribute *attrs, *pmc_attrs;
 	int i, nattrs;
 
-	/* For cpus present at boot a reference was already grabbed in register_cpu() */
-	if (!s->of_node)
-		s->of_node = of_get_cpu_node(cpu, NULL);
-
 #ifdef CONFIG_PPC64
 	if (cpu_has_feature(CPU_FTR_SMT))
 		device_create_file(s, &dev_attr_smt_snooze_delay);
@@ -1025,8 +1055,6 @@ static int unregister_cpu_online(unsigned int cpu)
 	}
 #endif
 	cacheinfo_cpu_offline(cpu);
-	of_node_put(s->of_node);
-	s->of_node = NULL;
 	return 0;
 }
 #else /* !CONFIG_HOTPLUG_CPU */
@@ -1173,6 +1201,17 @@ static int __init topology_init(void)
 			device_create_file(&c->dev, &dev_attr_physical_id);
 		}
 	}
+
+	/*
+	 * This must precede generic cacheinfo so
+	 * of_cpu_device_node_get() can use cpu_dev->of_node.
+	 */
+	r = cpuhp_setup_state_nocalls(CPUHP_AP_POWERPC_OF_NODE_ONLINE,
+			       "powerpc/of_node:online",
+			       register_cpu_of_node,
+			       unregister_cpu_of_node);
+	WARN_ON(r < 0);
+
 	r = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powerpc/topology:online",
 			      register_cpu_online, unregister_cpu_online);
 	WARN_ON(r < 0);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 1b6dba159bb2..617ad3cde57f 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -231,6 +231,7 @@ enum cpuhp_state {
 	CPUHP_AP_RANDOM_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_KTHREADS_ONLINE,
+	CPUHP_AP_POWERPC_OF_NODE_ONLINE,
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 40,
-- 
2.52.0



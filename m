Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DDE606A32C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h3gUdEPt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbcdG61N2z2xxr;
	Sat, 28 Nov 2026 02:23:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795793026;
	cv=none; b=OJT6OY2kpRSjeMs3TOLDvqboxVzIWBrOpf1qj78JhbpXmTPR6nMgyctVf1EMyMQWJv5JxqRo953wQJgqsjmqqq5/PAzDKvizkgons1j+xGdquiXZJAY/l2eu8lCFpB09Ply5wqdUwdE+xzSnLiUGuObFq4OEAZOAvVzi1SQI3fIZpBZLsrXcmvyAcwoanH4F+8UtlWRv1NqAP2a0/qwc/+8voPdGiEE6EjWoEuZkrg0cVTPRkKMOgQTEtJzHtdqvtdr6r/1p8hJhD8AL4s64oUgwMs4XD3EGZz6nc80D12Ym3oz+ulYqCfeYNNfollf7V7JjXHXN9lP3ad2ilH6Gqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795793026; c=relaxed/relaxed;
	bh=5PX1wQTdRoDg0yAoax+7j7TUy9xWGa4FD/FQYy+b9uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qmzqw8WRTl4Msr9nKv9MfeNXSuvyvolwVb2i0Dn7JkX2Ov3RNgMGUIFega8oL8s6JwKTvGxdrVMrjTW34rWwESG3uDxRJRT1T8Qmleobw80NTigED6QyBOcDeC5yatqU2x9SJhSx55dk4HeYkhoR7z7E0PGTml1O8/ZW1BRiALMKM58mivOuuzxoidEMIZVD4bqAtVeqY0hJ93tqtSUGGwIWH9HlECajY4O8xekh7AeJvK3hmpvispaSvZ3Ksv26eFWnq1ms7GYcZxFfaw79PY4fwVQRtP55n1ow9I5ztP86mwiAOwKpU9LFjzuWJ7s6ILjic3ayWGc/nSfknyolAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h3gUdEPt; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h3gUdEPt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbcdF5pvnz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 02:23:45 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4Tsm1649968;
	Fri, 27 Nov 2026 15:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5PX1wQTdRoDg0yAoa
	x+7j7TUy9xWGa4FD/FQYy+b9uY=; b=h3gUdEPtoywsmqHXp3SqbzRs6yyncHGDp
	wJHIthnH1+Fs4qsmyzxcM1kXvI/6xHqnjRlUpSc5nApyqv1cip8qHkR68+xMbkN9
	qezqIClSMHVWNqlO0g2jloGfrtweub9v5GK+8AVUbv49weK9WYRXpooDmG80qINb
	YZYyHrPLHEHQUO+cjIWZYLV8L78WiUvqH9t3dp71AB6QgFeJ7oipGPXEINMoCo3J
	YaHp9QA57Kw44XK8A4hSIcdXtCGKbdb9pm0pd3yi7vjcdS6cdVRGSEuIMHlJypf8
	MMLKFiX6hM/rEQnW/y3jA9Y/ZHJWEKwqBv1ftUW1+PXZr3oZPXtng==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3pek1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:23:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4JgZ861635;
	Fri, 27 Nov 2026 15:23:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6mjg4jwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:23:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARFNCes48759268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:23:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14ECB2004E;
	Fri, 27 Nov 2026 15:23:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C86620040;
	Fri, 27 Nov 2026 15:23:06 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.16.105])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:23:06 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu, ritesh.list@gmail.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        johan@kernel.org, sudeep.holla@kernel.org, peterz@infradead.org,
        tglx@kernel.org, kprateek.nayak@amd.com, srikar@linux.ibm.com
Subject: [PATCH v2 3/6] cacheinfo: Add firmware topology replacement helpers
Date: Fri, 27 Nov 2026 20:52:39 +0530
Message-ID: <20261127152242.306333-4-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b09a068 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=rSIkQzNedsi14obMgc0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfXz5sgT3UCb7e0
 SlPRj896F6ciMpkZUTr+lLjkKeM+l/LUxXaAFA8UojQZza6qQDM4vXuuUSMmnHoYHiiFsqsVIff
 8vg1XkCEZAc9T8d/y3DPVmsgznR5oZI=
X-Proofpoint-ORIG-GUID: 4akP-zJErddTyA4BksneN_UrAfT0V6gB
X-Proofpoint-GUID: -oesA-471Pwbgw5jE8-CIC_vAvF9K19F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX+zls6nZygE/n
 520trzqiGlxiihwyy8KX+VDeqm19YYJS7e+pl6VyTtfiJLtlkeebFETSixGBkcgLVvtVPfTeuSO
 9PZkJG9bmksKD4NX7PHEKfZuaY35FYq7EO6zCMyLiLX7tIFz6Ttp+qJsXBhbCCRP83M7GO6IFyI
 foIUSSAHqv2nTb/wSM/d0xPEqYShQaBS5YhSSIi0k+Tqvypqwe+8eEp+2TbU+VF3qvkoYhKHDdr
 UzpCqlCuNR6xyBf+jvFDXU1BShnymOgjgB/spWB4LJCMztVczD60zrFFBDxqPKF3wH5/FNcrt05
 O2Vvbce1Pb30f7CxO2nYB4URbpf95W2twaRpHSGI7h2sje/etTDFs6YFrO9zKrprf15XdvuK+2z
 MkgOuMhGEjjW6elIsr/k2QlCCz/SSPOLQ6VbONwcaQkBhul5MJCQDvDb0qt9igRUrxqDPBW0hbH
 Nyxan3HyLtGnurAdY7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270060
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Generic cacheinfo normally retains cache leaves when a CPU is taken offline.
This permits the information to be reused when the CPU is brought online again
and the firmware topology has not changed.

Some platforms can instead detach or replace the firmware nodes referenced by
the retained leaves. Retaining cacheinfo in that case also retains stale
firmware tokens, cache IDs and cache properties.

Add cacheinfo_invalidate_cpu() to discard retained cacheinfo for DLPAR CPU
remove which is to be called after normal cacheinfo CPU hotplug teardown
completed and before its firmware nodes are detached.

Also add cacheinfo_teardown_all() and cacheinfo_rebuild_all() for platforms
that replace the complete firmware cache topology while CPUs remain online.

The destructive helpers require the CPU hotplug lock to be held. Platform
code that replaces firmware topology must hold CPU hotplug write lock.
This excludes readers protected by cpus_read_lock() while the per-CPU leaf
arrays are freed and rebuilt.

If rebuilding any online CPU fails, remove the hierarchy already rebuilt
for rebuilt CPUs, discard any partially initialized state and clear the
cacheinfo-derived scheduler and page-allocator state. This is better than
leaving inconsistent state. However if an any CPU is onlined later
belonging that cpu_map, then values may remain inflated until next full
rebuild.

[Both draft changelog and code are written by LLM under guidance]
Assisted-by: LLM
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/base/cacheinfo.c  | 125 ++++++++++++++++++++++++++++++++++++++
 include/linux/cacheinfo.h |   3 +
 2 files changed, 128 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 4a23377e9312..cbeb4805ef19 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -1120,6 +1120,131 @@ static int cacheinfo_cpu_pre_down(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * Clear the cached values before destroying the info_list.
+ * The CPU must have completed cacheinfo_cpu_pre_down()
+ *
+ * Freeing info_list also discards retained firmware tokens, cache IDs
+ * and cache properties. A subsequent online operation must discover
+ * cacheinfo from the current firmware topology.
+ */
+static void cacheinfo_reset_cpu(unsigned int cpu)
+{
+	struct cpu_cacheinfo *ci = ci_cacheinfo(cpu);
+
+	ci->num_levels = 0;
+	ci->num_leaves = 0;
+	ci->per_cpu_data_slice_size = 0;
+	ci->cpu_map_populated = false;
+	ci->early_ci_levels = false;
+
+	kfree(ci->info_list);
+	ci->info_list = NULL;
+}
+
+/*
+ * Discard retained cacheinfo for an offline CPU before detaching firmware
+ * nodes referenced by its cache leaves.
+ *
+ * The CPU must have completed cacheinfo_cpu_pre_down(), so its cache devices
+ * and sharing-map membership are no longer present. The caller must hold the
+ * CPU hotplug write lock.
+ */
+void cacheinfo_invalidate_cpu(unsigned int cpu)
+{
+	lockdep_assert_cpus_held();
+
+	if (WARN_ON_ONCE(cpu_online(cpu)))
+		return;
+
+	cacheinfo_reset_cpu(cpu);
+	setup_pcp_cacheinfo(cpu);
+}
+
+/*
+ * Remove cacheinfo before replacing the complete firmware cache topology.
+ * The caller must hold the CPU hotplug write lock to stop any concurrent
+ * readers for cacheinfo.
+ */
+void cacheinfo_teardown_all(void)
+{
+	unsigned int cpu;
+
+	lockdep_assert_cpus_held();
+
+	for_each_online_cpu(cpu) {
+		if (!ci_cacheinfo(cpu)->info_list)
+			continue;
+
+		cacheinfo_cpu_pre_down(cpu);
+	}
+
+	/* Offline CPUs may retain leaves allocated while previously online. */
+	for_each_possible_cpu(cpu)
+		cacheinfo_reset_cpu(cpu);
+
+	/*
+	 * Clear all derived state after removing the complete hierarchy.
+	 * Corresponding cacheinfo_rebuild_all will build those states.
+	 */
+	for_each_online_cpu(cpu)
+		setup_pcp_cacheinfo(cpu);
+
+	sched_update_llc_bytes(cpu_online_mask);
+}
+
+/*
+ * Rebuild cacheinfo after replacing the complete firmware cache topology.
+ * The caller must hold the CPU hotplug write lock.
+ */
+int cacheinfo_rebuild_all(void)
+{
+	unsigned int cpu, failed_cpu;
+	cpumask_var_t rebuilt;
+	int ret;
+
+	lockdep_assert_cpus_held();
+
+	if (!zalloc_cpumask_var(&rebuilt, GFP_KERNEL))
+		return -ENOMEM;
+
+	for_each_online_cpu(cpu) {
+		ret = cacheinfo_cpu_online(cpu);
+		if (ret) {
+			failed_cpu = cpu;
+			pr_err("cache creation failed for CPU: %d ret: %d\n",
+			       failed_cpu, ret);
+			goto rollback;
+		}
+
+		cpumask_set_cpu(cpu, rebuilt);
+	}
+
+	free_cpumask_var(rebuilt);
+	return 0;
+
+rollback:
+	/*
+	 * Remove active state only for CPUs that completed the online path.
+	 * Then discard all allocations, including partial failed-CPU state.
+	 */
+	pr_err("clearing cache entries for CPUs: %*pbl\n", cpumask_pr_args(rebuilt));
+	for_each_cpu(cpu, rebuilt) {
+		cacheinfo_cpu_pre_down(cpu);
+		cacheinfo_reset_cpu(cpu);
+	}
+
+	cacheinfo_reset_cpu(failed_cpu);
+
+	/* Clear all derived states */
+	for_each_online_cpu(cpu)
+		setup_pcp_cacheinfo(cpu);
+
+	sched_update_llc_bytes(cpu_online_mask);
+	free_cpumask_var(rebuilt);
+	return ret;
+}
+
 static int __init cacheinfo_sysfs_init(void)
 {
 	return cpuhp_setup_state(CPUHP_AP_BASE_CACHEINFO_ONLINE,
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index d3557a1b464b..2892df92fc24 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -94,6 +94,9 @@ struct cacheinfo *get_cpu_cacheinfo_llc(unsigned int cpu);
 int fetch_cache_info(unsigned int cpu);
 int detect_cache_attributes(unsigned int cpu);
 int cacheinfo_get_arch_id(unsigned int cpu, unsigned int level, unsigned int *id);
+void cacheinfo_invalidate_cpu(unsigned int cpu);
+void cacheinfo_teardown_all(void);
+int cacheinfo_rebuild_all(void);
 #ifndef CONFIG_ACPI_PPTT
 /*
  * acpi_get_cache_info() is only called on ACPI enabled
-- 
2.52.0



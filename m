Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE06606A333
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Da4ME3gN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV6hX6gzQz2y8m;
	Thu, 19 Nov 2026 03:37:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795019852;
	cv=none; b=ZDAbIz/Q7JQlljkkwf4M8zzfVP49euw9ptLUC/bvXjOC3xHNXQHhnu0twKAL5ZHB1AeQ1j8kd8rEzBQ4LBZLkEzBjtPAK29wNUxvsX8+XFDsOygPy8Hm9BewSlLSLP5C5RMcFtP89seKIWbLIWG3x5GnzUBXng+ZY2snJwRxGYVgzmX5WS+wIzggICYts6RLh20+UcSkyni0PA1Zxph4fzHBrBTq1+6lP7xz6T6I4RUvVcgMN+lpvmwPtdVoXkW6v67j7QansL9zn3T43eDlvhP/ROqi6/j01zbFEqQo1k2OibICEFNJCM9wd8s9fmyd7zClTwN1jbXckLhTJ2M24A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795019852; c=relaxed/relaxed;
	bh=IQkSVCRpKXlz2wAUUW6oVrrYgE18ROiSv0y8Fi8zF2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGzrs2e5pMzYoLUnvn5H9huhbDnldxrLOhb9F1rjwWHFbjIgULzs8GRPEF/u9coYBkDyoZ9yXMlQ5etu6Txvx4N/9GqnQzJfila7Mt+mXBk2tZQPPSbataKukUPVtwWRJ5CWKPKHiPoT+6iV6nF7ja7MSKXobU15XQpnBh/Oe2qCFGpWhmXGP66nEK+5CqVADzwIv+Yn3gOXU49OiyGMC+Ncs9mWRc45CyBdZG7VJ5q9PW0Op45JUgrSLSZ/tm6OdAlj3LGsq3U3GoDrE0rLoCMQPhCRzyLRT2lC3UfRPQPnuCqvBdpkkqQilSL3PFNN0A4cQgpv8+PxK7akPlR8xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Da4ME3gN; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Da4ME3gN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV6hX0nHJz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 03:37:31 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQUMu1196083;
	Wed, 18 Nov 2026 16:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IQkSVCRpKXlz2wAUU
	W6oVrrYgE18ROiSv0y8Fi8zF2g=; b=Da4ME3gNSp4vPJcGyS0t5I3eDyTCcMG/F
	ywaSMKKm4ylZcRoaV7mW1kerk+zHWEYNFqkPP8pzzrDKWy3iIsv6utTI4IqvrY/q
	jkIlCi4ibOj8uLZuWiXUTKsv8sXKMTsaa2S+L6mvI64bMXFy9vlbo9eWAsMw6NHs
	80QXNuJ+8pmGT4MQQY9vXdB5S2X94ifZ09NvMlTndvR5lcPTp0iUmiEDVWVuhKVy
	7d1j+NL/WZCwq9+9KT77UhTKEtHQp9aYKGxzbh0Y25SiIZ4lOdIYuT3PIQ2kzvZi
	Wy322Isa/OJ8kDqsHHekSsO2neq/BlRsobUerMo6ZbNeC2SsXiD8A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wubu6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 16:37:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDZ4ft3470745;
	Wed, 18 Nov 2026 16:37:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt95m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 16:37:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIGbCZf40501592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 16:37:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D4C72004E;
	Wed, 18 Nov 2026 16:37:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEA2A20040;
	Wed, 18 Nov 2026 16:37:07 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.19.105])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 16:37:07 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        johan@kernel.org, sudeep.holla@kernel.org, ritesh.list@gmail.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com
Subject: [PATCH 5/5] sched/topology: Remove stale comment around llc_bytes on powerpc
Date: Wed, 18 Nov 2026 22:06:39 +0530
Message-ID: <20261118163639.890546-6-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118163639.890546-1-sshegde@linux.ibm.com>
References: <20261118163639.890546-1-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: m6nDFlsq9S7iVvEI9LtZRjpWRtnbxPEQ
X-Proofpoint-GUID: 2fZ_eomm9B5EjOoJmwjzgtGQ9yzyBNtE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2NSBTYWx0ZWRfX3Duo12XLtzmH
 4Z/VPjRV9xXGmjDXqp6Rh1gFMZ3mKa7fYN/L/v2msqwNqeBxe3zlW6TYiTQp9I2vT9yUe9//ChC
 8B7Z3pL7sexFnKKeQenGpknbcrYU9TLQlArCAS+Pqs7caFa/QHJQo1qUsjoVjKugppcKzY66Lt+
 A/RL/Q0c5TCfI6fSGa4N1U1tfyeZRfBq+pGBaLJPgS8TwYtc3u/X4agyJxg4oeG/B7YQic1oCE5
 yNhMmw5m3yIOLFHhYR+PSlIVzGMf4ipM3lXv3KVGRr47vaELEjS7nnlcCQDE+/KjySZxHPIFhME
 oqSEVf4eAy8kWRIjzEfkOsyn0MwEYTiD74tnU2bLId/7j+A9hQAR/NwyddWhoNq5Fyk35Ub6GqY
 HjvXYjrjhfEgMCBSZKFVPg//UUTiDFFqfTgiKRUmNHY7YLSx88R7X1i7cTsBbVv4s6IKiO+uPEw
 ShmJlXH6TdOH58pRnaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2NSBTYWx0ZWRfX02BjtLqNfM9F
 D/1brfC6CSnbkelFWgGJp4+o4mYho3T7uhOmKXrf/RAz9ylL8TDrFklXLqIpKwSdnbjbm8N2S5Y
 B2oV7dElpQ15eJWeCykTwuEkiWaobt8=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afdd43d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Do6pITyv6I5m7piumJAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180065
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PowerPC now populates generic cacheinfo, allowing
get_effective_llc_bytes() to obtain the LLC size.

Remove the comment stating that get_effective_llc_bytes() always
returns zero on PowerPC.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/topology.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99878da03bce..6d4e4a32bc4e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1001,13 +1001,6 @@ void sched_cache_active_set(void)
  * Update the bottom sched_domain's llc_bytes for @cpus sharing a physical
  * LLC. Called from cacheinfo_cpu_online() or
  * cacheinfo_cpu_pre_down() with cpu hotplug lock held.
- *
- * Note: get_effective_llc_bytes() returns 0 on PowerPC.
- * thus cache aware scheduling is disabled on PowerPC for
- * now. PowerPC does not use the generic cacheinfo framework --
- * it has its own cacheinfo with a separate struct cache hierarchy
- * and does not populates the per-CPU struct cpu_cacheinfo array
- * that get_cpu_cacheinfo_llc() reads.
  */
 void sched_update_llc_bytes(const struct cpumask *cpus)
 {
-- 
2.54.0



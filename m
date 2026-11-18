Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C87606A334
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HIuA3dON
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV6hP69J1z2y8p;
	Thu, 19 Nov 2026 03:37:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795019845;
	cv=none; b=i+73o4vwfIFwbTo23AEty58COWAJ7WgiOaIK4DQqGeZKFeWXX6AUFbD6eNCMOjD/ya0mw6SJNLZc+/U25bw3qWADi5MPy+K4qs/IiYckNyrRFHi8DnGF5Yu1x/40Bv/m2Nw2EU8l9/Dw7luqtMNFasYscwRdGIeVs7uKPUii6DjNWrtcNA4nnRT1/xtyoYFd0mLp2P9zOeKPXoQl8oAiZzGQh5XkLTrt/1x9oqF6NsghrM/rDMigY2oK70vv7S7xuFNSKzolfx3qMsX7goSkoEQyaklnfoDJPj28aE6EXevAoEfrBys6krzGPND6EZkJLuMyw0WJC34mI67ax5VG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795019845; c=relaxed/relaxed;
	bh=86r960kb6LeoshNhZijnc3e2OUzCW6Xb2ZgpanVD/rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0a5+KdatUxDnEHZo7v1nrcaBzw0y50m22Ww5DMkFx7/NLCXt+eyP4efRdYzLtDhHgzRPMCMIk7+80AOwuV54ckQ0AEKSjLGOUgzdBPTbIfJHzd4Obwd/E7W3fNOKxDfbO/U4fdrgZhtUWsaSblXhSuVaiV81ospig/QlLrJ2kbaxHra/xxHA33Vn+B1FgbxB7yUIWLkk7wnAw716xW5s7CsxfkbOSEW0pQvHWJAsZFFxk5xZYtleYSEbTjDTvX8A/NUgjX2YSKDFa9m8wlmnbtlgH6UuVQeBqIjYUzZ52q4qFlQQQ6M+8fWvx0/5tj9hvxx1zi64E4crwufGH+kOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HIuA3dON; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HIuA3dON;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV6hN0pLZz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 03:37:23 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQNEZ1373572;
	Wed, 18 Nov 2026 16:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=86r960kb6LeoshNhZ
	ijnc3e2OUzCW6Xb2ZgpanVD/rE=; b=HIuA3dON8kYNItdtP07ST75tGpDlLt5sf
	Bhvs7qSbJDVgUhM5Iz1F0gW0GTB0q6Mp5iTAv5bauMImLbdX9ImYYHer+NVDAWZq
	itj2DgRN+58YNRCT0CIwZ9/VkZhJG+Juqnv49Z/AcPN7NMmBCnsYI57qXEvBiLHb
	Y3mOPfepb9cFPs+D2GeLJbOXYxJ/+Nbes5HfjOcH8EQ1f+uuuIZbRlv5GGnfbYSu
	oBODxuTGduu6q3Cpq6nmZb2gMxvzO40G/4mkXMWf5pAFLiSxJWJJMgNyzH0EV6U6
	hZ2hiPb2KquSYssDxtQuy6mpuZ9Sj6Ayq7ASKQMN/MxUWjYzFKK5w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nbehc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 16:37:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDYtdD3470648;
	Wed, 18 Nov 2026 16:37:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt95ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 16:37:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIGb77m45482306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 16:37:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71E622004F;
	Wed, 18 Nov 2026 16:37:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1989020040;
	Wed, 18 Nov 2026 16:37:03 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.19.105])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 16:37:02 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        johan@kernel.org, sudeep.holla@kernel.org, ritesh.list@gmail.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com
Subject: [PATCH 4/5] powerpc/cacheinfo: Move to generic cacheinfo
Date: Wed, 18 Nov 2026 22:06:38 +0530
Message-ID: <20261118163639.890546-5-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2NSBTYWx0ZWRfX82FV8sw8BrH/
 trKLD3h9sT9F4284BoJ6X+thz0eB/9OHXtck9EvlOlE1sVsNm2VVxzf7CBHpsWcd8y+taX7aM+K
 nYDw2dKlGbz0hEzkGAz0UCkzc8nK9n+lT0y7fEmhoaLayt234Oj1/iyxR8dj8N4tD7dY6EN0CUK
 utcZ1/+2d5k8l+gWav6DMz5hY7gn3Tb5Z5otZheqCO3Q0ZpiUiWGXL0x5RfqP1jT0dXNgni+HlS
 7UD3lztQUtTo4XNEdByDtWh6Sn/op7627wpoWxH6H3hsS/GXrOK2bvfm6BCUy7nh2zQBaIcPu3c
 rDCcBTU6PSpl3iJ37yxD55zHF4mRIOURNvxKwngNAeo0eP2mKBgssGhOTo9FNNqIAruVIe/1FBM
 7q1Y4oA4X1kSYkD49aCOqe7geAIGPJvIiuoZfIBUYnusQUvdWkl+eT+eQyFtyB31OgR8lweqfft
 cPUY0ntoNNRIy8dGpqg==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afdd439 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=UWglTA-AMCiAyZkb63kA:9
X-Proofpoint-GUID: OGjv1Yq2nTVVtv2lkB5F4BdAJgehYmCY
X-Proofpoint-ORIG-GUID: D9_G8MzRFEKtR7AoyRzLaVej3nBnzKgI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2NSBTYWx0ZWRfXwUptP4WrzFQu
 t8XTufN5rWg6xaEyREFFhynaWmU6UsmgJEL1BwWSs8EX9k+Ge/KeRcPer1jz+XGOoiOZsVa54Qw
 +NxY67cC+q8awGZQvuoDs8X1YG4xffg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180065
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PowerPC maintains an architecture-specific implementation of the CPU
cache sysfs interface. Replace it with the generic cacheinfo
infrastructure.

PowerPC requires some architecture-specific handling when identifying
hardware cache instances. On Power11, one firmware CPU node can represent
eight threads and refer to one L2 and L3 cache-node chain. However, the
ibm,thread-groups property divides those threads into two cache-sharing
groups, for example:

  0,2,4,6
  1,3,5,7

The firmware node alone therefore cannot distinguish the two hardware
cache instances. Implement cacheinfo_get_arch_id() using the PowerPC
thread-group masks and use the first CPU in each mask as the cache ID.
This gives the two groups distinct IDs while assigning the same ID to all
CPUs that share a cache.

Initialize the generic cache leaves by walking the firmware cache chain.
A node with cache-unified produces one unified leaf. Other nodes produce
separate data and instruction leaves. Generic cacheinfo then populates
the size, line size, number of sets, associativity, firmware token and
shared CPU map.

The existing PowerPC cache sysfs attributes retain their values. Generic
cacheinfo additionally exposes the standard cache id attribute. The IDs
can be sparse because they are derived from the first CPU in each
thread-group mask, but CPUs sharing a cache have the same ID and distinct
cache instances have different IDs.

Remove the PowerPC-specific sysfs and CPU-hotplug handling. Update
pSeries mobility to use the generic cacheinfo teardown and rebuild
helpers.

On a dedicated Power11 LPAR, the generic implementation preserves the
existing L1 data, L1 instruction, L2 and L3 sizes, associativity, set
counts and shared CPU maps. The two SMT4 groups continue to appear as
separate cache instances.

[Both draft changelog and code are written by LLM]
Assisted-by: LLM
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/cacheinfo.c           | 994 +++-------------------
 arch/powerpc/kernel/cacheinfo.h           |  13 -
 arch/powerpc/kernel/sysfs.c               |   3 -
 arch/powerpc/platforms/pseries/mobility.c |   2 +-
 4 files changed, 96 insertions(+), 916 deletions(-)
 delete mode 100644 arch/powerpc/kernel/cacheinfo.h

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index cb0933061006..f3046c7c56d3 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -1,955 +1,151 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Processor cache information made available to userspace via sysfs;
- * intended to be compatible with x86 intel_cacheinfo implementation.
+ * PowerPC cacheinfo support using generic cacheinfo
+ *
+ * Copyright 2008,2026 IBM Corporation
  *
- * Copyright 2008 IBM Corporation
  * Author: Nathan Lynch
+ * Author: Shrikanth Hegde
  */
 
-#define pr_fmt(fmt) "cacheinfo: " fmt
-
-#include <linux/cpu.h>
+#include <linux/cacheinfo.h>
 #include <linux/cpumask.h>
-#include <linux/kernel.h>
-#include <linux/kobject.h>
-#include <linux/list.h>
-#include <linux/notifier.h>
+#include <linux/errno.h>
 #include <linux/of.h>
 #include <linux/percpu.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
+
 #include <asm/cputhreads.h>
 #include <asm/smp.h>
 
-#include "cacheinfo.h"
-
-/* per-cpu object for tracking:
- * - a "cache" kobject for the top-level directory
- * - a list of "index" objects representing the cpu's local cache hierarchy
- */
-struct cache_dir {
-	struct kobject *kobj; /* bare (not embedded) kobject for cache
-			       * directory */
-	struct cache_index_dir *index; /* list of index objects */
-};
-
-/* "index" object: each cpu's cache directory has an index
- * subdirectory corresponding to a cache object associated with the
- * cpu.  This object's lifetime is managed via the embedded kobject.
- */
-struct cache_index_dir {
-	struct kobject kobj;
-	struct cache_index_dir *next; /* next index in parent directory */
-	struct cache *cache;
-};
-
-/* Template for determining which OF properties to query for a given
- * cache type */
-struct cache_type_info {
-	const char *name;
-	const char *size_prop;
-
-	/* Allow for both [di]-cache-line-size and
-	 * [di]-cache-block-size properties.  According to the PowerPC
-	 * Processor binding, -line-size should be provided if it
-	 * differs from the cache block size (that which is operated
-	 * on by cache instructions), so we look for -line-size first.
-	 * See cache_get_line_size(). */
-
-	const char *line_size_props[2];
-	const char *nr_sets_prop;
-};
-
-/* These are used to index the cache_type_info array. */
-#define CACHE_TYPE_UNIFIED     0 /* cache-size, cache-block-size, etc. */
-#define CACHE_TYPE_UNIFIED_D   1 /* d-cache-size, d-cache-block-size, etc */
-#define CACHE_TYPE_INSTRUCTION 2
-#define CACHE_TYPE_DATA        3
-
-static const struct cache_type_info cache_type_info[] = {
-	{
-		/* Embedded systems that use cache-size, cache-block-size,
-		 * etc. for the Unified (typically L2) cache. */
-		.name            = "Unified",
-		.size_prop       = "cache-size",
-		.line_size_props = { "cache-line-size",
-				     "cache-block-size", },
-		.nr_sets_prop    = "cache-sets",
-	},
-	{
-		/* PowerPC Processor binding says the [di]-cache-*
-		 * must be equal on unified caches, so just use
-		 * d-cache properties. */
-		.name            = "Unified",
-		.size_prop       = "d-cache-size",
-		.line_size_props = { "d-cache-line-size",
-				     "d-cache-block-size", },
-		.nr_sets_prop    = "d-cache-sets",
-	},
-	{
-		.name            = "Instruction",
-		.size_prop       = "i-cache-size",
-		.line_size_props = { "i-cache-line-size",
-				     "i-cache-block-size", },
-		.nr_sets_prop    = "i-cache-sets",
-	},
-	{
-		.name            = "Data",
-		.size_prop       = "d-cache-size",
-		.line_size_props = { "d-cache-line-size",
-				     "d-cache-block-size", },
-		.nr_sets_prop    = "d-cache-sets",
-	},
-};
-
-/* Cache object: each instance of this corresponds to a distinct cache
- * in the system.  There are separate objects for Harvard caches: one
- * each for instruction and data, and each refers to the same OF node.
- * The refcount of the OF node is elevated for the lifetime of the
- * cache object.  A cache object is released when its shared_cpu_map
- * is cleared (see cache_cpu_clear).
- *
- * A cache object is on two lists: an unsorted global list
- * (cache_list) of cache objects; and a singly-linked list
- * representing the local cache hierarchy, which is ordered by level
- * (e.g. L1d -> L1i -> L2 -> L3).
- */
-struct cache {
-	struct device_node *ofnode;    /* OF node for this cache, may be cpu */
-	struct cpumask shared_cpu_map; /* online CPUs using this cache */
-	int type;                      /* split cache disambiguation */
-	int level;                     /* level not explicit in device tree */
-	int group_id;                  /* id of the group of threads that share this cache */
-	struct list_head list;         /* global list of cache objects */
-	struct cache *next_local;      /* next cache of >= level */
-};
-
-static DEFINE_PER_CPU(struct cache_dir *, cache_dir_pcpu);
-
-/* traversal/modification of this list occurs only at cpu hotplug time;
- * access is serialized by cpu hotplug locking
- */
-static LIST_HEAD(cache_list);
-
-static struct cache_index_dir *kobj_to_cache_index_dir(struct kobject *k)
-{
-	return container_of(k, struct cache_index_dir, kobj);
-}
-
-static const char *cache_type_string(const struct cache *cache)
-{
-	return cache_type_info[cache->type].name;
-}
-
-static void cache_init(struct cache *cache, int type, int level,
-		       struct device_node *ofnode, int group_id)
-{
-	cache->type = type;
-	cache->level = level;
-	cache->ofnode = of_node_get(ofnode);
-	cache->group_id = group_id;
-	INIT_LIST_HEAD(&cache->list);
-	list_add(&cache->list, &cache_list);
-}
-
-static struct cache *new_cache(int type, int level,
-			       struct device_node *ofnode, int group_id)
-{
-	struct cache *cache;
-
-	cache = kzalloc_obj(*cache);
-	if (cache)
-		cache_init(cache, type, level, ofnode, group_id);
-
-	return cache;
-}
-
-static void release_cache_debugcheck(struct cache *cache)
-{
-	struct cache *iter;
-
-	list_for_each_entry(iter, &cache_list, list)
-		WARN_ONCE(iter->next_local == cache,
-			  "cache for %pOFP(%s) refers to cache for %pOFP(%s)\n",
-			  iter->ofnode,
-			  cache_type_string(iter),
-			  cache->ofnode,
-			  cache_type_string(cache));
-}
-
-static void release_cache(struct cache *cache)
-{
-	if (!cache)
-		return;
-
-	pr_debug("freeing L%d %s cache for %pOFP\n", cache->level,
-		 cache_type_string(cache), cache->ofnode);
-
-	release_cache_debugcheck(cache);
-	list_del(&cache->list);
-	of_node_put(cache->ofnode);
-	kfree(cache);
-}
-
-static void cache_cpu_set(struct cache *cache, int cpu)
-{
-	struct cache *next = cache;
-
-	while (next) {
-		WARN_ONCE(cpumask_test_cpu(cpu, &next->shared_cpu_map),
-			  "CPU %i already accounted in %pOFP(%s)\n",
-			  cpu, next->ofnode,
-			  cache_type_string(next));
-		cpumask_set_cpu(cpu, &next->shared_cpu_map);
-		next = next->next_local;
-	}
-}
-
-static int cache_size(const struct cache *cache, unsigned int *ret)
-{
-	const char *propname;
-	const __be32 *cache_size;
-
-	propname = cache_type_info[cache->type].size_prop;
-
-	cache_size = of_get_property(cache->ofnode, propname, NULL);
-	if (!cache_size)
-		return -ENODEV;
-
-	*ret = of_read_number(cache_size, 1);
-	return 0;
-}
-
-static int cache_size_kb(const struct cache *cache, unsigned int *ret)
-{
-	unsigned int size;
-
-	if (cache_size(cache, &size))
-		return -ENODEV;
-
-	*ret = size / 1024;
-	return 0;
-}
-
-/* not cache_line_size() because that's a macro in include/linux/cache.h */
-static int cache_get_line_size(const struct cache *cache, unsigned int *ret)
-{
-	const __be32 *line_size;
-	int i, lim;
-
-	lim = ARRAY_SIZE(cache_type_info[cache->type].line_size_props);
-
-	for (i = 0; i < lim; i++) {
-		const char *propname;
-
-		propname = cache_type_info[cache->type].line_size_props[i];
-		line_size = of_get_property(cache->ofnode, propname, NULL);
-		if (line_size)
-			break;
-	}
-
-	if (!line_size)
-		return -ENODEV;
-
-	*ret = of_read_number(line_size, 1);
-	return 0;
-}
-
-static int cache_nr_sets(const struct cache *cache, unsigned int *ret)
-{
-	const char *propname;
-	const __be32 *nr_sets;
-
-	propname = cache_type_info[cache->type].nr_sets_prop;
-
-	nr_sets = of_get_property(cache->ofnode, propname, NULL);
-	if (!nr_sets)
-		return -ENODEV;
-
-	*ret = of_read_number(nr_sets, 1);
-	return 0;
-}
-
-static int cache_associativity(const struct cache *cache, unsigned int *ret)
-{
-	unsigned int line_size;
-	unsigned int nr_sets;
-	unsigned int size;
-
-	if (cache_nr_sets(cache, &nr_sets))
-		goto err;
-
-	/* If the cache is fully associative, there is no need to
-	 * check the other properties.
-	 */
-	if (nr_sets == 1) {
-		*ret = 0;
-		return 0;
-	}
-
-	if (cache_get_line_size(cache, &line_size))
-		goto err;
-	if (cache_size(cache, &size))
-		goto err;
-
-	if (!(nr_sets > 0 && size > 0 && line_size > 0))
-		goto err;
-
-	*ret = (size / nr_sets) / line_size;
-	return 0;
-err:
-	return -ENODEV;
-}
-
-/* helper for dealing with split caches */
-static struct cache *cache_find_first_sibling(struct cache *cache)
-{
-	struct cache *iter;
-
-	if (cache->type == CACHE_TYPE_UNIFIED ||
-	    cache->type == CACHE_TYPE_UNIFIED_D)
-		return cache;
-
-	list_for_each_entry(iter, &cache_list, list)
-		if (iter->ofnode == cache->ofnode &&
-		    iter->group_id == cache->group_id &&
-		    iter->next_local == cache)
-			return iter;
-
-	return cache;
-}
-
-/* return the first cache on a local list matching node and thread-group id */
-static struct cache *cache_lookup_by_node_group(const struct device_node *node,
-						int group_id)
-{
-	struct cache *cache = NULL;
-	struct cache *iter;
-
-	list_for_each_entry(iter, &cache_list, list) {
-		if (iter->ofnode != node ||
-		    iter->group_id != group_id)
-			continue;
-		cache = cache_find_first_sibling(iter);
-		break;
-	}
-
-	return cache;
-}
-
-static bool cache_node_is_unified(const struct device_node *np)
-{
-	return of_get_property(np, "cache-unified", NULL);
-}
-
 /*
- * Unified caches can have two different sets of tags.  Most embedded
- * use cache-size, etc. for the unified cache size, but open firmware systems
- * use d-cache-size, etc.   Check on initialization for which type we have, and
- * return the appropriate structure type.  Assume it's embedded if it isn't
- * open firmware.  If it's yet a 3rd type, then there will be missing entries
- * in /sys/devices/system/cpu/cpu0/cache/index2/, and this code will need
- * to be extended further.
+ * A firmware CPU node can represent multiple hardware cache groups.
+ * Use the first logical CPU in the corresponding thread-group mask as
+ * the identifier of that cache instance.
  */
-static int cache_is_unified_d(const struct device_node *np)
-{
-	return of_get_property(np,
-		cache_type_info[CACHE_TYPE_UNIFIED_D].size_prop, NULL) ?
-		CACHE_TYPE_UNIFIED_D : CACHE_TYPE_UNIFIED;
-}
-
-static struct cache *cache_do_one_devnode_unified(struct device_node *node, int group_id,
-						  int level)
-{
-	pr_debug("creating L%d ucache for %pOFP\n", level, node);
-
-	return new_cache(cache_is_unified_d(node), level, node, group_id);
-}
-
-static struct cache *cache_do_one_devnode_split(struct device_node *node, int group_id,
-						int level)
-{
-	struct cache *dcache, *icache;
-
-	pr_debug("creating L%d dcache and icache for %pOFP\n", level,
-		 node);
-
-	dcache = new_cache(CACHE_TYPE_DATA, level, node, group_id);
-	icache = new_cache(CACHE_TYPE_INSTRUCTION, level, node, group_id);
-
-	if (!dcache || !icache)
-		goto err;
-
-	dcache->next_local = icache;
-
-	return dcache;
-err:
-	release_cache(dcache);
-	release_cache(icache);
-	return NULL;
-}
-
-static struct cache *cache_do_one_devnode(struct device_node *node, int group_id, int level)
-{
-	struct cache *cache;
-
-	if (cache_node_is_unified(node))
-		cache = cache_do_one_devnode_unified(node, group_id, level);
-	else
-		cache = cache_do_one_devnode_split(node, group_id, level);
-
-	return cache;
-}
-
-static struct cache *cache_lookup_or_instantiate(struct device_node *node,
-						 int group_id,
-						 int level)
-{
-	struct cache *cache;
-
-	cache = cache_lookup_by_node_group(node, group_id);
-
-	WARN_ONCE(cache && cache->level != level,
-		  "cache level mismatch on lookup (got %d, expected %d)\n",
-		  cache->level, level);
-
-	if (!cache)
-		cache = cache_do_one_devnode(node, group_id, level);
-
-	return cache;
-}
-
-static void link_cache_lists(struct cache *smaller, struct cache *bigger)
-{
-	while (smaller->next_local) {
-		if (smaller->next_local == bigger)
-			return; /* already linked */
-		smaller = smaller->next_local;
-	}
-
-	smaller->next_local = bigger;
-
-	/*
-	 * The cache->next_local list sorts by level ascending:
-	 * L1d -> L1i -> L2 -> L3 ...
-	 */
-	WARN_ONCE((smaller->level == 1 && bigger->level > 2) ||
-		  (smaller->level > 1 && bigger->level != smaller->level + 1),
-		  "linking L%i cache %pOFP to L%i cache %pOFP; skipped a level?\n",
-		  smaller->level, smaller->ofnode, bigger->level, bigger->ofnode);
-}
-
-static void do_subsidiary_caches_debugcheck(struct cache *cache)
+int cacheinfo_get_arch_id(unsigned int cpu, unsigned int level,
+			  unsigned int *id)
 {
-	WARN_ONCE(cache->level != 1,
-		  "instantiating cache chain from L%d %s cache for "
-		  "%pOFP instead of an L1\n", cache->level,
-		  cache_type_string(cache), cache->ofnode);
-	WARN_ONCE(!of_node_is_type(cache->ofnode, "cpu"),
-		  "instantiating cache chain from node %pOFP of type '%s' "
-		  "instead of a cpu node\n", cache->ofnode,
-		  of_node_get_device_type(cache->ofnode));
-}
+	const struct cpumask *mask = NULL;
 
-/*
- * If sub-groups of threads in a core containing @cpu_id share the
- * L@level-cache (information obtained via "ibm,thread-groups"
- * device-tree property), then we identify the group by the first
- * thread-sibling in the group. We define this to be the group-id.
- *
- * In the absence of any thread-group information for L@level-cache,
- * this function returns -1.
- */
-static int get_group_id(unsigned int cpu_id, int level)
-{
 	if (has_big_cores && level == 1)
-		return cpumask_first(per_cpu(thread_group_l1_cache_map,
-					     cpu_id));
+		mask = per_cpu(thread_group_l1_cache_map, cpu);
 	else if (thread_group_shares_l2 && level == 2)
-		return cpumask_first(per_cpu(thread_group_l2_cache_map,
-					     cpu_id));
+		mask = per_cpu(thread_group_l2_cache_map, cpu);
 	else if (thread_group_shares_l3 && level == 3)
-		return cpumask_first(per_cpu(thread_group_l3_cache_map,
-					     cpu_id));
-	return -1;
-}
-
-static void do_subsidiary_caches(struct cache *cache, unsigned int cpu_id)
-{
-	struct device_node *subcache_node;
-	int level = cache->level;
+		mask = per_cpu(thread_group_l3_cache_map, cpu);
 
-	do_subsidiary_caches_debugcheck(cache);
+	if (!mask || cpumask_empty(mask))
+		return -ENOENT;
 
-	while ((subcache_node = of_find_next_cache_node(cache->ofnode))) {
-		struct cache *subcache;
-		int group_id;
-
-		level++;
-		group_id = get_group_id(cpu_id, level);
-		subcache = cache_lookup_or_instantiate(subcache_node, group_id, level);
-		of_node_put(subcache_node);
-		if (!subcache)
-			break;
-
-		link_cache_lists(cache, subcache);
-		cache = subcache;
-	}
-}
+	*id = cpumask_first(mask);
+	if (*id >= nr_cpu_ids)
+		return -ENOENT;
 
-static struct cache *cache_chain_instantiate(unsigned int cpu_id)
-{
-	struct device_node *cpu_node;
-	struct cache *cpu_cache = NULL;
-	int group_id;
-
-	pr_debug("creating cache object(s) for CPU %i\n", cpu_id);
-
-	cpu_node = of_get_cpu_node(cpu_id, NULL);
-	WARN_ONCE(!cpu_node, "no OF node found for CPU %i\n", cpu_id);
-	if (!cpu_node)
-		goto out;
-
-	group_id = get_group_id(cpu_id, 1);
-
-	cpu_cache = cache_lookup_or_instantiate(cpu_node, group_id, 1);
-	if (!cpu_cache)
-		goto out;
-
-	do_subsidiary_caches(cpu_cache, cpu_id);
-
-	cache_cpu_set(cpu_cache, cpu_id);
-out:
-	of_node_put(cpu_node);
-
-	return cpu_cache;
-}
-
-static struct cache_dir *cacheinfo_create_cache_dir(unsigned int cpu_id)
-{
-	struct cache_dir *cache_dir;
-	struct device *dev;
-	struct kobject *kobj = NULL;
-
-	dev = get_cpu_device(cpu_id);
-	WARN_ONCE(!dev, "no dev for CPU %i\n", cpu_id);
-	if (!dev)
-		goto err;
-
-	kobj = kobject_create_and_add("cache", &dev->kobj);
-	if (!kobj)
-		goto err;
-
-	cache_dir = kzalloc_obj(*cache_dir);
-	if (!cache_dir)
-		goto err;
-
-	cache_dir->kobj = kobj;
-
-	WARN_ON_ONCE(per_cpu(cache_dir_pcpu, cpu_id) != NULL);
-
-	per_cpu(cache_dir_pcpu, cpu_id) = cache_dir;
-
-	return cache_dir;
-err:
-	kobject_put(kobj);
-	return NULL;
-}
-
-static void cache_index_release(struct kobject *kobj)
-{
-	struct cache_index_dir *index;
-
-	index = kobj_to_cache_index_dir(kobj);
-
-	pr_debug("freeing index directory for L%d %s cache\n",
-		 index->cache->level, cache_type_string(index->cache));
-
-	kfree(index);
-}
-
-static ssize_t cache_index_show(struct kobject *k, struct attribute *attr, char *buf)
-{
-	struct kobj_attribute *kobj_attr;
-
-	kobj_attr = container_of(attr, struct kobj_attribute, attr);
-
-	return kobj_attr->show(k, kobj_attr, buf);
-}
-
-static struct cache *index_kobj_to_cache(struct kobject *k)
-{
-	struct cache_index_dir *index;
-
-	index = kobj_to_cache_index_dir(k);
-
-	return index->cache;
-}
-
-static ssize_t size_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	unsigned int size_kb;
-	struct cache *cache;
-
-	cache = index_kobj_to_cache(k);
-
-	if (cache_size_kb(cache, &size_kb))
-		return -ENODEV;
-
-	return sysfs_emit(buf, "%uK\n", size_kb);
-}
-
-static struct kobj_attribute cache_size_attr =
-	__ATTR(size, 0444, size_show, NULL);
-
-
-static ssize_t line_size_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	unsigned int line_size;
-	struct cache *cache;
-
-	cache = index_kobj_to_cache(k);
-
-	if (cache_get_line_size(cache, &line_size))
-		return -ENODEV;
-
-	return sysfs_emit(buf, "%u\n", line_size);
-}
-
-static struct kobj_attribute cache_line_size_attr =
-	__ATTR(coherency_line_size, 0444, line_size_show, NULL);
-
-static ssize_t nr_sets_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	unsigned int nr_sets;
-	struct cache *cache;
-
-	cache = index_kobj_to_cache(k);
-
-	if (cache_nr_sets(cache, &nr_sets))
-		return -ENODEV;
-
-	return sysfs_emit(buf, "%u\n", nr_sets);
-}
-
-static struct kobj_attribute cache_nr_sets_attr =
-	__ATTR(number_of_sets, 0444, nr_sets_show, NULL);
-
-static ssize_t associativity_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	unsigned int associativity;
-	struct cache *cache;
-
-	cache = index_kobj_to_cache(k);
-
-	if (cache_associativity(cache, &associativity))
-		return -ENODEV;
-
-	return sysfs_emit(buf, "%u\n", associativity);
-}
-
-static struct kobj_attribute cache_assoc_attr =
-	__ATTR(ways_of_associativity, 0444, associativity_show, NULL);
-
-static ssize_t type_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	struct cache *cache;
-
-	cache = index_kobj_to_cache(k);
-
-	return sysfs_emit(buf, "%s\n", cache_type_string(cache));
-}
-
-static struct kobj_attribute cache_type_attr =
-	__ATTR(type, 0444, type_show, NULL);
-
-static ssize_t level_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	struct cache_index_dir *index;
-	struct cache *cache;
-
-	index = kobj_to_cache_index_dir(k);
-	cache = index->cache;
-
-	return sysfs_emit(buf, "%d\n", cache->level);
-}
-
-static struct kobj_attribute cache_level_attr =
-	__ATTR(level, 0444, level_show, NULL);
-
-static ssize_t
-show_shared_cpumap(struct kobject *k, struct kobj_attribute *attr, char *buf, bool list)
-{
-	struct cache_index_dir *index;
-	struct cache *cache;
-	const struct cpumask *mask;
-
-	index = kobj_to_cache_index_dir(k);
-	cache = index->cache;
-
-	mask = &cache->shared_cpu_map;
-
-	return sysfs_emit(buf, list ? "%*pbl\n" : "%*pb\n",
-			  cpumask_pr_args(mask));
-}
-
-static ssize_t shared_cpu_map_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
-{
-	return show_shared_cpumap(k, attr, buf, false);
+	return 0;
 }
 
-static ssize_t shared_cpu_list_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
+static void powerpc_cache_leaf_init(struct cacheinfo *leaf,
+				    unsigned int level,
+				    enum cache_type type)
 {
-	return show_shared_cpumap(k, attr, buf, true);
+	leaf->level = level;
+	leaf->type = type;
 }
 
-static struct kobj_attribute cache_shared_cpu_map_attr =
-	__ATTR(shared_cpu_map, 0444, shared_cpu_map_show, NULL);
-
-static struct kobj_attribute cache_shared_cpu_list_attr =
-	__ATTR(shared_cpu_list, 0444, shared_cpu_list_show, NULL);
-
-/* Attributes which should always be created -- the kobject/sysfs core
- * does this automatically via kobj_type->default_groups.  This is the
- * minimum data required to uniquely identify a cache.
- */
-static struct attribute *cache_index_default_attrs[] = {
-	&cache_type_attr.attr,
-	&cache_level_attr.attr,
-	&cache_shared_cpu_map_attr.attr,
-	&cache_shared_cpu_list_attr.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(cache_index_default);
-
-/* Attributes which should be created if the cache device node has the
- * right properties -- see cacheinfo_create_index_opt_attrs
+/*
+ * A node carrying cache-unified represents one unified cache leaf.
+ * Other nodes represent separate data and instruction cache leaves.
+ *
+ * Cache property availability does not determine whether a leaf
+ * exists. Missing optional properties are handled by generic
+ * cacheinfo.
  */
-static struct kobj_attribute *cache_index_opt_attrs[] = {
-	&cache_size_attr,
-	&cache_line_size_attr,
-	&cache_nr_sets_attr,
-	&cache_assoc_attr,
-};
-
-static const struct sysfs_ops cache_index_ops = {
-	.show = cache_index_show,
-};
-
-static const struct kobj_type cache_index_type = {
-	.release = cache_index_release,
-	.sysfs_ops = &cache_index_ops,
-	.default_groups = cache_index_default_groups,
-};
-
-static void cacheinfo_create_index_opt_attrs(struct cache_index_dir *dir)
+static unsigned int powerpc_cache_leaves(struct device_node *np)
 {
-	const char *cache_type;
-	struct cache *cache;
-	char *buf;
-	int i;
-
-	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return;
-
-	cache = dir->cache;
-	cache_type = cache_type_string(cache);
-
-	/* We don't want to create an attribute that can't provide a
-	 * meaningful value.  Check the return value of each optional
-	 * attribute's ->show method before registering the
-	 * attribute.
-	 */
-	for (i = 0; i < ARRAY_SIZE(cache_index_opt_attrs); i++) {
-		struct kobj_attribute *attr;
-		ssize_t rc;
-
-		attr = cache_index_opt_attrs[i];
-
-		rc = attr->show(&dir->kobj, attr, buf);
-		if (rc <= 0) {
-			pr_debug("not creating %s attribute for "
-				 "%pOFP(%s) (rc = %zd)\n",
-				 attr->attr.name, cache->ofnode,
-				 cache_type, rc);
-			continue;
-		}
-		if (sysfs_create_file(&dir->kobj, &attr->attr))
-			pr_debug("could not create %s attribute for %pOFP(%s)\n",
-				 attr->attr.name, cache->ofnode, cache_type);
-	}
-
-	kfree(buf);
+	return of_property_read_bool(np, "cache-unified") ? 1 : 2;
 }
 
-static void cacheinfo_create_index_dir(struct cache *cache, int index,
-				       struct cache_dir *cache_dir)
+int init_cache_level(unsigned int cpu)
 {
-	struct cache_index_dir *index_dir;
-	int rc;
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
+	struct device_node *next;
+	struct device_node *np;
+	unsigned int leaves = 0;
+	unsigned int levels = 0;
 
-	index_dir = kzalloc_obj(*index_dir);
-	if (!index_dir)
-		return;
+	np = of_cpu_device_node_get(cpu);
+	if (!np)
+		return -ENOENT;
 
-	index_dir->cache = cache;
-
-	rc = kobject_init_and_add(&index_dir->kobj, &cache_index_type,
-				  cache_dir->kobj, "index%d", index);
-	if (rc) {
-		kobject_put(&index_dir->kobj);
-		return;
-	}
+	for (;;) {
+		leaves += powerpc_cache_leaves(np);
+		levels++;
 
-	index_dir->next = cache_dir->index;
-	cache_dir->index = index_dir;
+		next = of_find_next_cache_node(np);
+		of_node_put(np);
+		np = next;
 
-	cacheinfo_create_index_opt_attrs(index_dir);
-}
-
-static void cacheinfo_sysfs_populate(unsigned int cpu_id,
-				     struct cache *cache_list)
-{
-	struct cache_dir *cache_dir;
-	struct cache *cache;
-	int index = 0;
-
-	cache_dir = cacheinfo_create_cache_dir(cpu_id);
-	if (!cache_dir)
-		return;
-
-	cache = cache_list;
-	while (cache) {
-		cacheinfo_create_index_dir(cache, index, cache_dir);
-		index++;
-		cache = cache->next_local;
+		if (!np)
+			break;
 	}
-}
 
-void cacheinfo_cpu_online(unsigned int cpu_id)
-{
-	struct cache *cache;
+	if (!leaves)
+		return -ENOENT;
 
-	cache = cache_chain_instantiate(cpu_id);
-	if (!cache)
-		return;
+	ci->num_levels = levels;
+	ci->num_leaves = leaves;
 
-	cacheinfo_sysfs_populate(cpu_id, cache);
-}
-
-/* functions needed to remove cache entry for cpu offline or suspend/resume */
-
-#if (defined(CONFIG_PPC_PSERIES) && defined(CONFIG_SUSPEND)) || \
-    defined(CONFIG_HOTPLUG_CPU)
-
-static struct cache *cache_lookup_by_cpu(unsigned int cpu_id)
-{
-	struct device_node *cpu_node;
-	struct cache *cache;
-	int group_id;
-
-	cpu_node = of_get_cpu_node(cpu_id, NULL);
-	WARN_ONCE(!cpu_node, "no OF node found for CPU %i\n", cpu_id);
-	if (!cpu_node)
-		return NULL;
-
-	group_id = get_group_id(cpu_id, 1);
-	cache = cache_lookup_by_node_group(cpu_node, group_id);
-	of_node_put(cpu_node);
-
-	return cache;
-}
-
-static void remove_index_dirs(struct cache_dir *cache_dir)
-{
-	struct cache_index_dir *index;
-
-	index = cache_dir->index;
-
-	while (index) {
-		struct cache_index_dir *next;
-
-		next = index->next;
-		kobject_put(&index->kobj);
-		index = next;
-	}
+	return 0;
 }
 
-static void remove_cache_dir(struct cache_dir *cache_dir)
+int populate_cache_leaves(unsigned int cpu)
 {
-	remove_index_dirs(cache_dir);
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *leaf = ci->info_list;
+	struct device_node *next;
+	struct device_node *np;
+	unsigned int index = 0;
+	unsigned int level = 1;
 
-	/* Remove cache dir from sysfs */
-	kobject_del(cache_dir->kobj);
+	np = of_cpu_device_node_get(cpu);
+	if (!np)
+		return -ENOENT;
 
-	kobject_put(cache_dir->kobj);
+	for (;;) {
+		bool unified = of_property_read_bool(np, "cache-unified");
 
-	kfree(cache_dir);
-}
+		if (unified) {
+			if (index >= ci->num_leaves)
+				goto err;
 
-static void cache_cpu_clear(struct cache *cache, int cpu)
-{
-	while (cache) {
-		struct cache *next = cache->next_local;
+			powerpc_cache_leaf_init(&leaf[index++], level,
+						CACHE_TYPE_UNIFIED);
+		} else {
+			if (index + 1 >= ci->num_leaves)
+				goto err;
 
-		WARN_ONCE(!cpumask_test_cpu(cpu, &cache->shared_cpu_map),
-			  "CPU %i not accounted in %pOFP(%s)\n",
-			  cpu, cache->ofnode,
-			  cache_type_string(cache));
+			powerpc_cache_leaf_init(&leaf[index++], level,
+						CACHE_TYPE_DATA);
+			powerpc_cache_leaf_init(&leaf[index++], level,
+						CACHE_TYPE_INST);
+		}
 
-		cpumask_clear_cpu(cpu, &cache->shared_cpu_map);
+		next = of_find_next_cache_node(np);
+		of_node_put(np);
+		np = next;
 
-		/* Release the cache object if all the cpus using it
-		 * are offline */
-		if (cpumask_empty(&cache->shared_cpu_map))
-			release_cache(cache);
+		if (!np)
+			break;
 
-		cache = next;
+		level++;
 	}
-}
-
-void cacheinfo_cpu_offline(unsigned int cpu_id)
-{
-	struct cache_dir *cache_dir;
-	struct cache *cache;
-
-	/* Prevent userspace from seeing inconsistent state - remove
-	 * the sysfs hierarchy first */
-	cache_dir = per_cpu(cache_dir_pcpu, cpu_id);
-
-	/* careful, sysfs population may have failed */
-	if (cache_dir)
-		remove_cache_dir(cache_dir);
-
-	per_cpu(cache_dir_pcpu, cpu_id) = NULL;
-
-	/* clear the CPU's bit in its cache chain, possibly freeing
-	 * cache objects */
-	cache = cache_lookup_by_cpu(cpu_id);
-	if (cache)
-		cache_cpu_clear(cache, cpu_id);
-}
 
-void cacheinfo_teardown(void)
-{
-	unsigned int cpu;
-
-	lockdep_assert_cpus_held();
+	if (index != ci->num_leaves)
+		return -EINVAL;
 
-	for_each_online_cpu(cpu)
-		cacheinfo_cpu_offline(cpu);
-}
-
-void cacheinfo_rebuild(void)
-{
-	unsigned int cpu;
-
-	lockdep_assert_cpus_held();
+	return 0;
 
-	for_each_online_cpu(cpu)
-		cacheinfo_cpu_online(cpu);
+err:
+	of_node_put(np);
+	return -EINVAL;
 }
-
-#endif /* (CONFIG_PPC_PSERIES && CONFIG_SUSPEND) || CONFIG_HOTPLUG_CPU */
diff --git a/arch/powerpc/kernel/cacheinfo.h b/arch/powerpc/kernel/cacheinfo.h
deleted file mode 100644
index 52bd3fc6642d..000000000000
--- a/arch/powerpc/kernel/cacheinfo.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _PPC_CACHEINFO_H
-#define _PPC_CACHEINFO_H
-
-/* These are just hooks for sysfs.c to use. */
-extern void cacheinfo_cpu_online(unsigned int cpu_id);
-extern void cacheinfo_cpu_offline(unsigned int cpu_id);
-
-/* Allow migration/suspend to tear down and rebuild the hierarchy. */
-extern void cacheinfo_teardown(void);
-extern void cacheinfo_rebuild(void);
-
-#endif /* _PPC_CACHEINFO_H */
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 2100c5e2c821..519e0a75f30c 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -24,7 +24,6 @@
 #include <asm/idle.h>
 #include <asm/svm.h>
 
-#include "cacheinfo.h"
 #include "setup.h"
 
 #ifdef CONFIG_PPC64
@@ -928,7 +927,6 @@ static int register_cpu_online(unsigned int cpu)
 		device_create_file(s, &dev_attr_altivec_idle_wait_time);
 	}
 #endif
-	cacheinfo_cpu_online(cpu);
 	return 0;
 }
 
@@ -1024,7 +1022,6 @@ static int unregister_cpu_online(unsigned int cpu)
 		device_remove_file(s, &dev_attr_altivec_idle_wait_time);
 	}
 #endif
-	cacheinfo_cpu_offline(cpu);
 	of_node_put(s->of_node);
 	s->of_node = NULL;
 	return 0;
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index b5c2abd12432..8b7f0ce107a6 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) "mobility: " fmt
 
+#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/kobject.h>
@@ -29,7 +30,6 @@
 #include "pseries.h"
 #include "vas.h"	/* vas_migration_handler() */
 #include "papr-hvpipe.h"	/* hvpipe_migration_handler() */
-#include "../../kernel/cacheinfo.h"
 
 static struct kobject *mobility_kobj;
 
-- 
2.54.0



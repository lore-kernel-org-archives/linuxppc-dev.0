Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F1E606A324
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OOYyrnWo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbcd41krPz2xPb;
	Sat, 28 Nov 2026 02:23:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795793016;
	cv=none; b=Uu1rIoZ2SKktwY6jSb8NyBTqe90/TJ3BiPbARhwp4/HrKZ8YUCUs7cdZbeaHqHKKqObzdZ3m0IQxuoraEoFNq+Agrt7KD7lsx6cv9m22piNkS3AqgAFYJnthEakBRtZuZamEjXdjmVcWVy5UAs3juCUSa9o4DctA8sMZfv6a2bVF39fYSZD6HjMqhFjpKj6kXXQz7nvDSi05Kq7Rg1Y7cHLMXU7nmvRT2sZ4azIRNCr3Wj4Hx0M3hmy6scxKhSjU5WaeU6ecRwq110+QmMD/KfTakVaynCS7C1bVsxOPlAM6nkxjwee7ghyOq9Yd+WtHNr1oNq7hltYeDgUCNuwjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795793016; c=relaxed/relaxed;
	bh=JjEWTfCSXoDP61H7fMsjhbrtYMgCKQELqcke6a5fZC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=El/04kUTWbrN53kmG6++KHshHQ2rBlN/ZYjQgegtmn2/Nlup3BLnIwebsorwtC+eccDZvZxPRziJKP2u1z+HRG06DDzf1nBPpiuy9U3cfCSpRW806TyLmERR3FvSnjcWND/ZFKrK7g8ck6aYP7uska7TQk8WE+Qgv4J6IO7tVz2E06FC2XFTNEl8diVz4IFEqUVb08oocVZhErA5XJhyZrLxSAxR+RRaQKZSJ6nYW5Du999tBLLyvAXwkufCZ9MhTyCDaobdP1BWgvQKuZo0VFTt0hk5kMFqqgtdSvMIsraM+f7GdgLt82OOzVDVXxPFAzaWW1csEi4Ae0Ovj1qKkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OOYyrnWo; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OOYyrnWo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbcd25lSTz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 02:23:34 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4eVO3234319;
	Fri, 27 Nov 2026 15:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JjEWTfCSXoDP61H7fMsjhbrtYMgCKQELqcke6a5fZ
	C4=; b=OOYyrnWoM/XawP71YyCPZOPSRBH0ZbkbggVbZrG8QmArWOssvsteX9clk
	kGDjNA78QuZDWeIda7W+m/EsGbZfI/OFidhOlNqSJBAx3d2iTSujFRSD7Yv4HXd7
	E1v1uaw9c3tLgdRfTNHnTDLQXNs+KSRnN4QAHyQnL9+pp8Kzc+K29Dd7Psqn5GlQ
	I252j0/tVfdK5UuLuWk4oUHv/DUFqJRjbrufPRmEUj5F2RE7rW+TnCX6Vm5SkEsJ
	S7047IOJYr+9VKv2HFmeWO+JDPrUdRjNmF5D7sU43CoVSiMfDpkfAgMB1QfLt2Qe
	Cea+1A0cmVcA1mkkwWAQOkWfaztYg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvnpkr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:22:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4IqE3893132;
	Fri, 27 Nov 2026 15:22:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6uccu3xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:22:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARFMreB36176260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:22:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1DA02004E;
	Fri, 27 Nov 2026 15:22:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEB2C20040;
	Fri, 27 Nov 2026 15:22:47 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.16.105])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:22:47 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu, ritesh.list@gmail.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        johan@kernel.org, sudeep.holla@kernel.org, peterz@infradead.org,
        tglx@kernel.org, kprateek.nayak@amd.com, srikar@linux.ibm.com
Subject: [PATCH v2 0/6] cacheinfo, powerpc, sched: Move powerpc to generic cacheinfo
Date: Fri, 27 Nov 2026 20:52:36 +0530
Message-ID: <20261127152242.306333-1-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b09a053 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7CQSdrXTAAAA:8 a=E3HGokiD75dCrADgIB4A:9 a=Vxmtnl_E_bksehYqCbjh:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX9Y9wcaK6Ervy
 zjjBn1pQGy/zFask8QPU5q0uiq4CaKx30mdhthjeFl1w26y1+Dl2TxLhkJBGuspagoKMNbMqYVh
 Q00xoIxSRUB95Q6xzCO7B8YRZ/v2dWQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX+EV6YLwEvEva
 8qON9OjlFLCz4kXV/hgfVzJ7+VcOa8JsgIxVcvnObmIE1ASS3VEKAuXcRj+ngsu71N7Cmg/h3yn
 e8R+wF7n91XZCsvPMT2feDUfE0GLATBWXX5L9Z0NAdZyWZYamHVn1jUyCGfjF5yutXybNBLNw1v
 +jJ9rKTpjDEgnVnb0GgbzkUtJ1g84GFtxLS6GJEmLIbccnCrXNNZiDsviNCdDiw06PkHfqXsNAA
 ZdqIbQEf3Y+0YCXl5vFeIfmsOrbPWR/1Scepclou7eOMIR0J8vOQrNU6eJ+x1sINY+e+OdPiCLP
 TUwWGRcR/3vU76GNmGstwqPf8O0VRObEm7jklYEOeeV+JDmm6l12gdEOS6Iz4HMmkAK4bqgSzz6
 bQ34Rb1jE6q8llCWqktxUwxJWo8zX5vi1TVDVZj8kxHBlkJM0GMTVdUeDa2+V/IoxJ2+KSZHZOr
 nuMILb/vT9BrnabT19w==
X-Proofpoint-ORIG-GUID: Ike8deZNp8OXbg6A5h0ra5q0jP34957S
X-Proofpoint-GUID: pZLmlU4KSl5gZEk33xNljkNcANPHz8x4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270060
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is another attempt to move PowerPC to the generic cacheinfo
framework and is a spiritual successor to the earlier work from Sudeep
Holla [1].

Current motivation came from enabling Cache Aware Scheduling on
PowerPC with an llc_override kernel parameter [2]. The scheduler obtains
the effective LLC capacity through get_effective_llc_bytes(), which uses
generic cacheinfo. Since PowerPC maintains a separate cacheinfo
implementation and does not populate struct cpu_cacheinfo, llc_bytes is
zero and the byte-capacity check effectively disables cache-aware
placement once a process has a visible memory footprint.

Rather than adding an architecture-specific fallback for the physical
LLC size and sharing information, this series moves PowerPC to generic
cacheinfo. This also removes the separate PowerPC implementation of the
cache sysfs interface. If move to generic cacheinfo is contentious due
to new extentions, I am afraid we might have to fallback to
arch_llc_bytes kind of hooks.

Since many don't read past this, Note that, I have tested this series 
on PowerVM LPAR (Dedicated and Shared) and PowerNV (Power9). I think
there may be corner cases of error handling where consumers may have
stale info. Also Please test this on your powerpc platform if it has
different device tree quirks. 

Applies cleanly on:
powerpc/master at c44104f3642d ("Merge tag 'drm-fixes-2026-11-21' of https://gitlab.freedesktop.org/drm/kernel")
powerpc/next at b6a9fa34ce41 ("Linux 7.4-rc4")
tip/sched/core at c47af8566706 ("selftests/sched: Add a test for stuck forced idle under core scheduling")

PowerPC move needs a few extensions.
===================================
1. PowerPC firmware cache node does not always identify one
   hardware cache instance. On Power11, one firmware CPU node can represent
   eight threads, while ibm,thread-groups divides those threads into two
   SMT4 cache-sharing groups. The series therefore allows an architecture
   to provide a cache ID derived from its physical cache-sharing topology.

2. PowerPC device trees commonly describe unified caches using
   d-cache-* properties. Generic cacheinfo is extended to read those
   properties while retaining CACHE_TYPE_UNIFIED for the resulting leaf.


The more involved part is preserving pSeries LPM and DLPAR behavior.
====================================================================
3. The existing PowerPC implementation owns references to its firmware
   cache nodes and destroys and recreates the cache objects when the
   firmware topology changes. Generic cacheinfo normally retains its
   per-CPU leaf allocations across CPU offline and online operations.
   That behavior is appropriate for ordinary hotplug, but not when LPM
   replaces the firmware cache topology or DLPAR detaches a CPU and its
   cache nodes.

   This series adds explicit helpers to tear down and rebuild the complete
   generic cacheinfo hierarchy. These destructive operations run under the
   CPU hotplug write lock, excluding CPU hotplug readers while the old
   cacheinfo generationis replaced. Normal generic CPU hotplug behavior
   remains unchanged.

4. Moving cache discovery to the generic CPUHP callback also exposed an
   ordering issue for DLPAR-added CPUs. PowerPC previously associated
   cpu_dev->of_node and initialized its private cacheinfo from the same
   late dynamic CPUHP callback. Generic cacheinfo runs earlier at
   CPUHP_AP_BASE_CACHEINFO_ONLINE. For a DLPAR-added CPU, the CPU device
   already exists at that point, but its of_node is still NULL, causing
   generic cache discovery to fail.

   An explicit PowerPC CPUHP state is added immediately before
   CPUHP_AP_BASE_CACHEINFO_ONLINE. The resulting ordering is:
          PowerPC associates cpu_dev->of_node
          generic cacheinfo initializes the cache hierarchy
          PowerPC creates the remaining CPU sysfs attributes

   CPU offline runs these callbacks in reverse order, ensuring that generic
   cacheinfo is removed before PowerPC releases the OF-node reference.

The series was tested on dedicated and shared Power11 LPARs.
the existing cache sysfs values and hierarchy are preserved.
Generic cacheinfo provides id and uevent in addition.

The testcases are covered and marked as success if cache values are
preserved.
===================================================================

  - Normal boot on dedicated LPARs		- Success
  - Normal boot on shared LPARs			- Success
  - Normal boot with lockdep on dedicated	- Success
  - CPU Hotplug (Dedicated and Shared LPAR)	- Success
  - CPU Hotplug with lockdep			- Success 
  - LPM cacheinfo teardown and rebuild		- Not tested
  - DLPAR CPU remove and add			- Success
  - DLPAR CPU remove and add with lockdep	- Success
  - DLPAR add logical CPUs not present at boot	- Success
  - DLPAR reuse free CPUid from different node	- Success
  - Normal boot on PowerNV			- Success
  - CPU hotplug on PowerNV			- Success

Script used for validation is here:
https://lore.kernel.org/all/d76a72b5-e489-47fe-81bd-a3bf5935c209@linux.ibm.com/
It is effectively checking for:
- Is cache hierarchy/values are same.
- comparing online,offline,possibe,preset masks.
- lscpu topology without id.

I have requested for the LPM test. Since I am on leave for next two
weeks, wanted to send this out. Once I hear from LPM test, I will update
the thread.

Moving PowerPC to generic cacheinfo also supplies the physical LLC size
and sharing information required by get_effective_llc_bytes().
llc_override series[2] will use this information to scale the physical cache
capacity to MC or package scope. In addition this also gives right
information for page allocator.

[1] https://lore.kernel.org/all/1424715500-21725-1-git-send-email-sudeep.holla@arm.com/#t
v1: [2] https://lore.kernel.org/all/20261023131646.2907938-1-sshegde@linux.ibm.com/

v1 -> v2:
=========
  - Add full cacheinfo teardown and transactional rebuild handling for
    firmware topology replacement. Avoiding build failure.
  - Hold the CPU hotplug write lock while replacing cacheinfo during
    pSeries LPM.
  - Add an ordered PowerPC CPUHP state before generic cacheinfo to make
    cpu_dev->of_node available for DLPAR-added CPUs.
  - Clean up the caches/derived states after DLPAR remove.
  - Clean up the caches/derived states after DLPAR add failure

Shrikanth Hegde (6):
  cacheinfo: Allow architectures to provide custom cache IDs
  cacheinfo: Support unified caches described by d-cache properties
  cacheinfo: Add firmware topology replacement helpers
  powerpc: Set CPU device OF node before generic cacheinfo setup
  powerpc/cacheinfo: Move to generic cacheinfo
  sched/topology: Remove stale comment around llc_bytes on powerpc

 arch/powerpc/kernel/cacheinfo.c              | 994 ++-----------------
 arch/powerpc/kernel/cacheinfo.h              |  13 -
 arch/powerpc/kernel/sysfs.c                  |  54 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  35 +
 arch/powerpc/platforms/pseries/mobility.c    |  17 +-
 drivers/base/cacheinfo.c                     | 192 +++-
 include/linux/cacheinfo.h                    |   4 +
 include/linux/cpuhotplug.h                   |   1 +
 kernel/sched/topology.c                      |  11 +-
 9 files changed, 368 insertions(+), 953 deletions(-)
 delete mode 100644 arch/powerpc/kernel/cacheinfo.h

-- 
2.52.0



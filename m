Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94A606A32C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XD6QQy8A
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTQw11GGFz2xqJ;
	Wed, 18 Nov 2026 00:45:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794923105;
	cv=none; b=NsfvKSH7C/dqUJWKSSomx0+RNIOTLMCPmsVEjfwafPPzRxk9soNIN2JAPodR2yyXgARHomb8l5Xj7orSMKm16IpId8P7Gi+S1LrJtagN0qzdG1o+JlLfwRdV2XAkE73iZ1uSSlRK5Wp/ptVzOrRs2pHVkFKYa45ZGYL3jbZ9e3fAw+t50/Z1kz+r501rECbW8kbuMOfr3moDPkybn81U4ybIE2VI6jGdjJlI9EIiiP0Q35tiXADGhvrbX3YPR0xrfurPYj2K1zRmTvgHqDQ4u3OI5wPQHLYnDPKRBXc8zjxcd4dydZUBcdmfWz1oMFLjr40wKdrTrTjIabF371MbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794923105; c=relaxed/relaxed;
	bh=eZNVDS6q0NfN6+NY2xd78fw62hbEIwwz7kQ91FTBqqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=khOUx6go9qUQ2AykgJfj5hfsG0rx6r8KAYOoB0HJKthUbxUgTz5y6d5MDfu/GBw0kHqySukoilQIAgFJNzmCjlYz6rG4gVpMQ+7iSvRYQX35q/oGdUHKoMTzJ0UsNoHcDBLZydSKDhcVnWdKtqrYXdy2SgiKrxXNUp4ByPzYXKCaVy266PwdFgRmmsPP50eLeKvqkQ5cIukSkRSWfP9htHfyBO6Lux2R7KnkJQgR6cnBBnH6qoXNIs1khtkw0eEEg2eM5GKtK6XiKlUiBG6KeoYSZf98wvorPiY4KjoCkfsAb/AZ8mXKfm2zQnuO9BewuA+KXM97hX8tWTQVinXatg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XD6QQy8A; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XD6QQy8A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTQw02rVTz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 00:45:04 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHBwkXs1090276;
	Tue, 17 Nov 2026 13:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=eZNVDS6q0NfN6+NY2xd78fw62hbEIwwz7kQ91FTBq
	qM=; b=XD6QQy8AR4+iJ9a+hpi9aZVpXv/dK9B4ZoNyRb6K16ezzoU/5Pa2vmRl9
	xvl5xN/kEb7O6MfX0/UBBUDAxw8yR+9q2cClExcrKTRvbjkmLQdbH9tfu/20lq3e
	u1bVPdNumriaRLS1iYG0biXHX25BCf5sxuT059T+RcXfYjxsWDfeyu82qe8GPoqa
	aewMmHMGcOKEQYB4tc+53bupNo6VNdwtH7jRaquddZIiSu8QgxYFfQqaX117wMJI
	n5NBxSG8A/Qf7JL2Ois44JfskqVXZZhubczcGuUk0MbqC45Rsag+KfuhtjncpcXD
	GEWn2WDhDM0WLGDn9ZXLP3sIaMA1g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxe2dapq2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 13:05:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC5tvG3508340;
	Tue, 17 Nov 2026 13:05:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067nbq36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 13:05:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHD5JBM41288110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 13:05:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBEEB2004D;
	Tue, 17 Nov 2026 13:05:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF53020043;
	Tue, 17 Nov 2026 13:05:17 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.bl1-in.ibm.com (unknown [9.123.6.5])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 13:05:17 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] powerpc/configs: Add debug configs for debugging
Date: Tue, 17 Nov 2026 18:35:06 +0530
Message-ID: <20261117130508.521098-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfXzBQ2PZFsAabn
 PNYya2AaPp/rjEN+p7L6JlPAuHvuxRWUnzIIjuJQ4RTLJWAcVmUexx09FYV+5WZuytPjuCJuLTC
 YIOnkPOu3o9mAORfDOeSfJ1ijnmJqso=
X-Proofpoint-GUID: ARr3seC0vuXes4kwESziE1Ag1RD6adLM
X-Proofpoint-ORIG-GUID: NIj0rEFKGqpn0gZvp1hkGlAb46FxCDuw
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6afc5116 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=mCzZ1jakd0CJncQrlMgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX13ZGYetzVpc4
 6A5cz7mGhDtN1Z7kZIWRI3NbtqxH8+zxbAoZQrHzbZ1UiDVz4nZRV/EJGhLxtLtZh6Uxi9r+fM9
 m3kHjkUqRja86VxKvyvsp5drQeT2w6dw5SZZ2963p7ixCn0ox7PCFI8VdbLffFSFtGwKWEundcu
 /om1Nt2yX/M0KDpppxkRVrbpzBYcCcfcQ50CjDb4DP4jcyzEq8xTtekqh3TgYJPUxbuBLWlWuSw
 5I+TuKAa6GwIlHjyxTVBeBTLvFyUQxSNtOT26zaEk4jtWVy0wTGzDtoqKXbg2gtmUzIOsnjhAcu
 kthiqSbiY4pBk9jKMIsGtjKx0uqYptd4K1LzN8DjqvhTftgLnQcuqk5M8EhdRn+EpwZOFh65CAi
 RRGxbNyJintQEqCfueHTr4i2k/65/MiwCKMAwCmfZSl8uB/shpFWcPShc3qdX9yf2x1hbvm3lkZ
 kJ+hZtzZC6NkjPBOVqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170051
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Kernel has multiple config options to run extra validation checks that
can help catch bugs. Define new configs for major subsystems to
make it easy to enable the debug config options for a given area. Also
add some common debug config options to existing debug.config for use in
CI testing.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v3:
1. Avoid merging the debug configs with defconfig (Shrikanth)

v2:
1. Split the enablement of configs into pseries and powernv configs
(self)

 arch/powerpc/configs/debug.config        | 11 +++++++++++
 arch/powerpc/configs/locks_debug.config  | 13 +++++++++++++
 arch/powerpc/configs/lockup_debug.config |  4 ++++
 arch/powerpc/configs/mm_debug.config     | 24 ++++++++++++++++++++++++
 4 files changed, 52 insertions(+)
 create mode 100644 arch/powerpc/configs/locks_debug.config
 create mode 100644 arch/powerpc/configs/lockup_debug.config
 create mode 100644 arch/powerpc/configs/mm_debug.config

diff --git a/arch/powerpc/configs/debug.config b/arch/powerpc/configs/debug.config
index bcc1fcf25e10..6bbca575a27c 100644
--- a/arch/powerpc/configs/debug.config
+++ b/arch/powerpc/configs/debug.config
@@ -3,3 +3,14 @@ CONFIG_PPC_IRQ_SOFT_MASK_DEBUG=y
 CONFIG_PPC_KUAP_DEBUG=y
 CONFIG_PPC_RFI_SRR_DEBUG=y
 CONFIG_SCOM_DEBUGFS=y
+CONFIG_EXPERT=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_PROVE_RCU=y
+CONFIG_KASAN=y
+CONFIG_UBSAN=y
+CONFIG_DEBUG_PAGEALLOC=y
+CONFIG_DEBUG_VM=y
+CONFIG_DEBUG_OBJECTS=y
+CONFIG_DEBUG_KMEMLEAK=y
+CONFIG_DEBUG_STACKOVERFLOW=y
+
diff --git a/arch/powerpc/configs/locks_debug.config b/arch/powerpc/configs/locks_debug.config
new file mode 100644
index 000000000000..b2cb23de75db
--- /dev/null
+++ b/arch/powerpc/configs/locks_debug.config
@@ -0,0 +1,13 @@
+CONFIG_EXPERT=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_RT_MUTEXES=y
+CONFIG_DEBUG_RWSEMS=y
+CONFIG_PROVE_RAW_LOCK_NESTING=y
+CONFIG_RCU_EXPERT=y
+CONFIG_PROVE_RCU=y
+CONFIG_RCU_TRACE=y
diff --git a/arch/powerpc/configs/lockup_debug.config b/arch/powerpc/configs/lockup_debug.config
new file mode 100644
index 000000000000..ad0a79abf60f
--- /dev/null
+++ b/arch/powerpc/configs/lockup_debug.config
@@ -0,0 +1,4 @@
+CONFIG_EXPERT=y
+CONFIG_WQ_WATCHDOG=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_PANIC_ON_OOPS=y
diff --git a/arch/powerpc/configs/mm_debug.config b/arch/powerpc/configs/mm_debug.config
new file mode 100644
index 000000000000..0e88eb983536
--- /dev/null
+++ b/arch/powerpc/configs/mm_debug.config
@@ -0,0 +1,24 @@
+CONFIG_EXPERT=y
+CONFIG_DEBUG_PAGEALLOC=y
+CONFIG_DEBUG_SLAB=y
+CONFIG_KASAN=y
+CONFIG_KFENCE=y
+CONFIG_KMSAN=y
+CONFIG_DEBUG_KMEMLEAK=y
+CONFIG_DEBUG_VM=y
+CONFIG_DEBUG_VIRTUAL=y
+CONFIG_DEBUG_OBJECTS=y
+CONFIG_DEBUG_OBJECTS_FREE=y
+CONFIG_DEBUG_OBJECTS_TIMERS=y
+CONFIG_DEBUG_OBJECTS_WORK=y
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
+CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
+CONFIG_SCHED_STACK_END_CHECK=y
+CONFIG_DEBUG_VM_MAPLE_TREE=y
+CONFIG_DEBUG_VM_RB=y
+CONFIG_DEBUG_VM_PGFLAGS=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_DEBUG_PER_CPU_MAPS=y
+CONFIG_DEBUG_KMAP_LOCAL=y
+CONFIG_DEBUG_HIGHMEM=y
+CONFIG_DEBUG_STACKOVERFLOW=y
-- 
2.56.0



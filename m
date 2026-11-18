Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F8606A339
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jVddyxAL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV9Fn5jwmz2xMt;
	Thu, 19 Nov 2026 05:33:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795026781;
	cv=none; b=mtPaapYpjqef5KwlYzRYSDFi/hGMMWFCuqFlzdrwlu2qkeGmUJjDoIvYCOuUZ+OZMBKL9cH1TgGE+OiQjZ/F2ysAPXbgtqwFOhLaXFZgWdW+OIBLqHebAntNBLzb3OyowVDG+F/sNGetYJneydgwiF2beMNSDiSmR5JbxbpKmSie9ZpbGOMHms++0tt77tmV/F1EDlXQJDyWmPKyxXj5WXNKMWUhxgmJQXU3TGJ290WWS4DVMHUwwkRNy3NaxShRf2HDe7MG6Uw1u+zbebgWXwbCapZz8cUfTtAlAt+EOfcQVJ8hDeV7ToxDhL/3jjhLwHTlFCThEC7AAEkavyZEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795026781; c=relaxed/relaxed;
	bh=rhEN0h7wX2c8+mVN5T2q/8hdxoSKBQZF1DPC1+vTOL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oU//CZYTqZ010V3Bf/F1LgDVD8xZmGnXADE+4V9YqXJagbXvp4lQavnA32FdojF42sHDQnxaws+MijNqUc2x0VIbb+5AmAHTpCGB93LIXNsgF4SIR4NBwtvyBbIRWl439tbCa8LTRujhOK9qtJJs2edyKUY2PlSXVl7kMxqRyRzKe1HwpfsMHp65Ypg2LvYGteBivODdIaHVk2+GzvzGVclw4hXTuAs0+XxoJsoUCRFkk0OlpPFlp7cxpGCK0gR/8ZL4mTH8HMuQ6Yyo/iLh59eE7wKW0aQtm0AluidghMiTb3mHyDZIb+Br+ISGh0A3uT8dYrc++W4kedZwwsHK6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jVddyxAL; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jVddyxAL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV9Fm72w1z2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 05:33:00 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIHPwu2077471;
	Wed, 18 Nov 2026 18:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=rhEN0h7wX2c8+mVN5T2q/8hdxoSK
	BQZF1DPC1+vTOL4=; b=jVddyxALvzL/c5K2zFqAji+Zyrs7C+BQB3lcWn4yBqd2
	+qriZLansAV8er08U+RIxN+ndkplbrJ1CUGE9yf6kvqu7lHPcfMJ8fOt4A1KlEec
	kFj0VvHXSvRPX+Bpsvbl0zgNIKUvftwuB9Pmu5fhjReBL2MbN9N+2rqold9NrUGf
	pOpHfCJQ7AZ8kv1u6hIYifMdtJ0+ynwu1nluJUkVnLjZq+LnOcHPcwoYLYQ7uZrF
	LzgGR6m6YEpxA8cb6O0uCmV6BYUI6WXn12XO3dn9Mxh3q3IFtlyfzWA7UklswEP+
	DkoDYl/j2gDAykAnQhOB126DKS4icN6gBXf5IYM1yw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rm0x8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 18:32:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIHK3T03429607;
	Wed, 18 Nov 2026 18:32:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02juhau6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 18:32:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIIWkZs28377350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 18:32:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC3202004B;
	Wed, 18 Nov 2026 18:32:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4239E20043;
	Wed, 18 Nov 2026 18:32:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.19.69])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 18:32:43 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Vincent Donnefort <vdonnefort@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v5] ring-buffer: Do not check si_mem_available() before deferred init completes
Date: Thu, 19 Nov 2026 00:02:35 +0530
Message-ID: <20261118183235.63310-1-amachhiw@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: UoNsp9KWx-lIKmVcQS8oRuIY9Bxh663p
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afdef54 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=TAdDoJc28zNiS-eFyzwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3MyBTYWx0ZWRfX6xos6IAaNQhP
 BlSiuJhmSXzFi/6ZDuVDrWH70Vc2Zb16jqNhiJLgoq/pwX0dzPtKJt8VHins2xknSrA3NVqTFE1
 iGgI1XqH9rSyluG6FE7pyQnCOr1b1xw=
X-Proofpoint-ORIG-GUID: 7Zi_ebJ6DCZ_bAp5rDfkW3mCgJgcv37y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3MyBTYWx0ZWRfX3Fgejk2yJ4oI
 Ms64VVCgf4dYSfKPP7NkQbhjz5xj9VOzLFbpA/sMvrMsbwWEbltUTqzx4V1wVq/GjDdrQc/MvOL
 M2eEXKIgfCwcVhZybH+/NA8xFDbSvupUa5x4mYwrXO/Msrj+lgnKE64zoBXonUdq3MGqA99SOVj
 oTJB+1Pq/k9vi7D6zrrdn8PDXMzoFJTTEYenfY9Kbk616x7AH4pBFOUeh95Nl6y/cevHFGMO0J8
 voxsF11pruZIDyHzDuuXqL9d9aDqeopxtFZjwlOYpzmY+6gL0ZdOEB1eRTCbtysgOAxieMkrhDE
 8DMY5p6RENpazt1KachLQZG2SRSRSSDsOd/w/C14JkKBhvJvoFDadkfxIqfR8asNnq3RxccJY67
 jWAX3yo7eLI3GDKO5JV6KCo9qK+5jb353QxpPQwmGnbztygzW8vGmGzy5/yC9Dy+J/JdzWBu2sM
 kQb7CPfKrf+HsjqA+jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180073
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With CONFIG_DEFERRED_STRUCT_PAGE_INIT=y, only about one memory section
per node is initialized early in boot (16 MiB on powerpc).  The rest is
initialized on demand by deferred_grow_zone() when an allocation would
otherwise fail, or later by page_alloc_init_late().

Until then NR_FREE_PAGES can be close to zero, because early allocations
(SLUB, vmalloc, ftrace records) use up the first section.
si_mem_available() is derived from NR_FREE_PAGES, so it under-reports.

__rb_allocate_pages() returns -ENOMEM when si_mem_available() is below
the requested size.  This check wrongly fails the buffers allocated for
the boot CPU in early_trace_init() and for secondary CPUs in smp_init(),
both of which run before page_alloc_init_late().  The resulting boot log
shows:

  ERROR: Failed to allocate trace buffer
  ERROR: tracer: failed to allocate ring buffer!

Skip the check until SYSTEM_FREEING_INITMEM on
CONFIG_DEFERRED_STRUCT_PAGE_INIT kernels.  The allocation itself still
fails if memory really is short.

This is the second half of the fix for the early boot crash reported on
ppc64le KVM guests.  Commit b3b974008388 ("tracing: Do not initialize
tracefs work if tracing is disabled") stopped the NULL pointer
dereference in __find_event_file() that followed the failed allocation.
This patch fixes the allocation failure itself.

Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
Cc: stable@vger.kernel.org
Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes since v4:
 - v4: https://lore.kernel.org/all/20261023145459.47516-1-amachhiw@linux.ibm.com/
 - Rewrote commit message for clarity and conciseness (Vincent, Steven).
 - Structure the deferred init check using if/else with unlikely() (Steven).
 - Added Vincent's R-b.

Changes since v3:
 - v3: https://lore.kernel.org/all/20261022181817.49717-1-amachhiw@linux.ibm.com
 - Replace #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT / #else / #endif with
   IS_ENABLED() + i = LONG_MAX to avoid duplicating the threshold check.
   (Vincent Donnefort)
 - Trim the in-code comment to one sentence. (Vincent Donnefort)

Changes since v2:
 - v2: https://lore.kernel.org/all/20261016134247.70722-1-amachhiw@linux.ibm.com
 - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefort;
   update threshold to i < (nr_pages << subbuf_order). (Michal Suchánek)

Changes since v1:
 - v1: https://lore.kernel.org/all/20261009163557.88467-1-amachhiw@linux.ibm.com
 - Extend the guard to cover SYSTEM_SCHEDULING as well: smp_init() calls
   trace_rb_cpu_prepare() -> __rb_allocate_pages() before page_alloc_init_late()
   completes, so the false negative window spans both SYSTEM_BOOTING and
   SYSTEM_SCHEDULING. Use system_state >= SYSTEM_FREEING_INITMEM as the correct
   boundary. (Sashiko, Vincent Donnefort)
 - Wrap in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT to preserve the original
   check unchanged on non-deferred kernels. (Vincent Donnefort)
 - Drop Tested-by: guard condition changed, requesting fresh test.

 kernel/trace/ring_buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 75cd8df23c1b..98e8a02b7c43 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2468,8 +2468,17 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		 * memory. It may not be accurate. But we don't care, we just want
 		 * to prevent doing any allocation when it is obvious that it is
 		 * not going to succeed.
+		 *
+		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available()
+		 * will reflect the actual available memory only after
+		 * SYSTEM_FREEING_INITMEM.
 		 */
-		i = si_mem_available();
+		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
+		    unlikely(system_state < SYSTEM_FREEING_INITMEM))
+			i = LONG_MAX;
+		else
+			i = si_mem_available();
+
 		if (i < (nr_pages << subbuf_order))
 			return -ENOMEM;
 

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
-- 
2.54.0 (Apple Git-157)



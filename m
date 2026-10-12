Return-Path: <linuxppc-dev+bounces-29254-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23CACA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 10:21:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3D5Q6GVXz2xwP;
	Mon, 12 Oct 2026 21:21:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791800474;
	cv=none; b=WZz3MHa4rs3Np7KOGXt/8TzPY7iWEMbJXCXAlMjcJ6ssweMqnC66omAWpwC+NRweMPeg+P7y32gT4yGW3H0rh6O2NlOKRJGJeqybbBpEvOlfqd1fR7x6NCgQilF2IaZoCD2OwGUHPXUHDBKlD3IPQGVgaYEaRWvZBK4BtHTbi8JDeDx+h8Sud3G1hylYJuaa2fjxeq7a5rRdVsVLLWkh2FYKNRuwQxHHSVlxQ4dRZ09ZCDW0enFE01ipL3920Evbka6igDmuvpO1c8ml7/MQXRmSENDEcWVnIDSK7jaenLA3IDWbCcDyMKCYFwmPU3j77h99hsjuv4zh1xmp0IMdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791800474; c=relaxed/relaxed;
	bh=c95G4KxZ6cl5u72quowdJTGYkNL0ORaKXbpr0mG51j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJFce4jhNotmvI/IxAi1aWGw2f1MuvILtlYQnie1Kh6cCsWlozRGnc+Y8XaMGCiq3gl+Ga9NfXp+sI5Ju+Hlszs2Vr9ufSLECqZ+6ACHG6m+pbq46yEkOOstsx4HK0jQYPYbwwBFSXh5gS3CwjSVqO7/rm8K8BBepmDCJkDfp7GS2TXsBvUtnivovItlRI9u1Z5KDPQWTmcbYSDkc48gKWL4i3PIqnlA21zPgcOla6B0UpMq4+1ZSEjRLOpxzareXwHhKER1wzVb+BpOZTOGkx2i791SzPvjD7bRN2YA7g4P66ksY7kQtG1G5XM6RMS8z7NonrfR2dPH4ZIuwt0NGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PMtqUUJM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PMtqUUJM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3D5P1hG6z2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 21:21:12 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iIH84052991;
	Mon, 12 Oct 2026 10:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=c95G4KxZ6cl5u72quowdJTGYkNL0ORaKXbpr0mG51
	j4=; b=PMtqUUJMekSB8kCfYWardMeBtalhc8ssQDvphRNXumux48w+v9oANpPmA
	voQfWSl7aQmSp5BMVpia8NKA1Ly81nbsdYpHLpkGADkAY6osdJGw4e5D2+X87oAe
	pBdvacaUOgssAsD7Y0kKt6ICrYecfW9+N1HFM6CTuho8lZp/vJQOXsmzrd7fqc6j
	0j16jV5HfFQbXhG4QlgaPZMQ2eLiTHoptcviSlwx29s39g9/1LXhwsS69yLeVt4/
	/muuxlb9RJvnjbdilrJcYQWBn/1cQmjF7ysuLx2UZR176kBfg8cUJUCmKaV3Aadq
	bmJHI08Hj/rFN05v+Cp6fQcjeA7JQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug8b9j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:20:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8YvSB978624;
	Mon, 12 Oct 2026 10:20:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vmt5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:20:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CAKjK751184112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 10:20:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59BCA2004B;
	Mon, 12 Oct 2026 10:20:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E75320040;
	Mon, 12 Oct 2026 10:20:40 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.215.77])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 10:20:39 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, srikar@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au
Subject: [PATCH 0/4] powerpc/topology: Introduce llc_override debugfs
Date: Mon, 12 Oct 2026 15:50:33 +0530
Message-ID: <20261012102037.2477378-1-sshegde@linux.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6accb482 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=9aXuTUKiNQtxuYXcZg0A:9
X-Proofpoint-GUID: gnwYH9TzgC3V4jKcSNiwsyCPxreFJygc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MCBTYWx0ZWRfX4DYzfQ7oVGo/
 dq+F57dIiJTt2HFlE7PZWLI9e5LslpVGzQ+Rh0jsZwttMeMz+1yQeTOd1bMXFIZIyXahEboi2qN
 qbU+q+eIWily9pHymIuium1kou3V3NqfyqIi3ckqJSWfVvSKAoBxWclwUJK/19NOuakUaA4xj7d
 dEHICpbjoyVNIrDpsILd0W1y9S+fpqvMnnUTf8PaBINO+KOZwqyNyvDBpHlt8lUsKzUQvAPOXFj
 amymT6X57pTkhWqfDOFNJmnIwQPC5fR0ombvlCcd2238THkgVn3MnoSNlYgHkXRgFyrw4snosPu
 pC3qX98QqDHHrdawQoFkdtqAV0yCRr6chYA9BjPFwIxdXbxb3ue3ck1l9dpa0T5p9ts9ATaQQYb
 FQA9+eAoUQA3O7dCjaH1wgQwDOrfEgK/2oexOzDt6OkUKcG+jja8Z6Bf63ZqNuUpWeePZaG3ik2
 xyg9wy1gNKUuhVGDcEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MCBTYWx0ZWRfX0EiZ7uRanKY2
 kuRFOuUF1mJwQIPnJJnF48NCn7hE4Zsh3Al+FJ9KTTZEvu3/eP2qxcdOZiEsyGzVhxpJT64NrpD
 jSPd4mE7Lkukbh+04VkroUIpJrX/p6I=
X-Proofpoint-ORIG-GUID: iFngqR5CeSxiZdNXZThmZ6qB8mGQ-4xL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120040

There is a new feature in scheduler called as Cache Aware Scheduling [1].
It tries to keep related tasks within the same LLC domain while
keeping the system reasonably balanced.

Cache Aware Scheduling assumes that the scheduler LLC domain is large enough
to be a useful placement target. This is true on many systems where an LLC spans
several cores, but not on PowerPC systems where the scheduler-visible LLC is at
the SMT level. In that case, sd_llc_size is effectively the SMT width.

This becomes visible in the capacity check:
        return !fits_capacity((mm->sc_stat.nr_running_avg * cpu_smt_num_threads),
                              scale * per_cpu(sd_llc_size, cpu));

As a result, Cache aware scheduling may be enabled but has no room to operate.

Hence provide a debugfs option to set LLC at specific domain so that
one can try experiment their workload with cache aware scheduling.
This also provides ways to explore it on system with SMT=4 to see if
there are any opportunities to improve or uncover bugs if there is any.

Note it is a debug option and it is recommended to keep it disabled.
There is no performance guarantees across different values.

[1]: https://lore.kernel.org/all/cover.1778703694.git.tim.c.chen@linux.intel.com/

Tim, Chenyu, Peter,
Are there any selftest or patches which is used for
functional validation of cache aware scheduling?
per-LLC occupancy in /proc/{PID}/schedstat may not tell the full
story when there are multiple processes and multiple LLC's.

Atleast for functional verification, we might need one if there is
not one already. The reason being,
- At present, we may need a custom workload. hackbench/schbench are
  wakeup intensive and typically bail out even before load balance.
- stress-ng is per process. So doesn't get cache aware scheduling.
- A selftest could spwan specific number of threads till llc size etc
  and ensure packing happens till core_count(llc_size) by default.
  This could also be used for tunable verfifications.
- Provide an ability to observe how much of the workload was contained
  within the LLC due to cache aware scheduling or number of load
  balances stopped due to preferred llc.

These are some initial thoughts I had. If it sounds ok, I can try to add
a new selftest/kunit test. 

Shrikanth Hegde (4):
  powerpc/topology: Introduce llc_override debug knob
  powerpc/topology: Add docs for llc_override
  powerpc/topology: Update mc/pkg flags based on llc_override
  powerpc/topology: Rebuild sched domains on llc_override change

 Documentation/arch/powerpc/index.rst    |   1 +
 Documentation/arch/powerpc/topology.rst |  27 +++++
 arch/powerpc/kernel/smp.c               | 128 +++++++++++++++++++++++-
 3 files changed, 151 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/arch/powerpc/topology.rst

-- 
2.52.0



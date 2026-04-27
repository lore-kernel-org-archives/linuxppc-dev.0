Return-Path: <linuxppc-dev+bounces-20153-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9277FFF885E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 10:02:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3zdh27Vcz2xcD;
	Mon, 27 Apr 2026 20:02:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777284168;
	cv=none; b=YHsO7dBXL/e2JQr3Hun7qkoSbJYKzJ2CBj/HJYafTwopKuI3d6MfrfCqsFr8hd0a6nXfWNYJLSbu1kP8E322NsJ5a2Cck09cFikCyAWMfz/fsCg7KGc3cDyaaqy4v70Aa59QuYZ//SpxK81uDrKOxuLFbniBHdA7NV9fB/X00V/dpSe7R+9CIgOdK5a7ZWlrz56mlO+D+yh0iVphju9XYuctH8HVLamWzPTNQhnRe4X1q/EbCZvl1Bv09Rwrx89Nk8NJ21ni1qgt28alV6s6LEUkMCnhvlpoxWkx+ww0NbvZvC+yDthvEzBKLGew4v80vWK5U4c020kZC7HgW8ukYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777284168; c=relaxed/relaxed;
	bh=Znih/pJeOJMi8TAnvU9tkRa6JIl4Kdte8FUXQ8cFhuE=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=d9g0Pzx5RTErWoLHIHafjQKK0FmTykrEUTGC4LpQ9YOxv5m+Oft+b4BFywMoU9yyZkKLG/dvutrjy/4OoGbehP8Xhz6lBQdJ3XYl3c1IOfpvYs7FwTk5ubw3oUMzguichrl7FhIt1oCe7paE00HABuHE4WYAJoah4Q6tzFjlVnZpm2zw0jHelcmsC7nx3aF1ZfZcnt+I+PHe8Vivuyx0BU2QnZet/jNkFm6dYvf/Rv7FEoLvhNu6I1rv3FOHKTtqGHtohgYLnt7UE78dCrNziSqHzWW1RtllSFec4H0FEKayKqybb4f4OVKESsy/3AFfOAjVjQhStF24PbTqOYktjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nMBTnbEn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nMBTnbEn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3zdg2pwBz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 20:02:46 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QLjOUD2819432;
	Mon, 27 Apr 2026 10:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Znih/pJeOJMi8TAnvU9tkRa6JIl4
	Kdte8FUXQ8cFhuE=; b=nMBTnbEnuw3zjSXKfF6PRTx5/4iHacMVBtJpi5rXph1C
	lVKWebdZXPJZfRUr+QluVYIsmLEXh2ZmYL+R878YoajciytK84S7zvi81Cm5wEeO
	HtQC/O+1VISCfEkwjsyTSUcoYtQW2OwfJp8Epp5mjOUxKq5SFpsdk9/Ho+jOZmlp
	UikHyiFC1RpM/t2EcRuULN26h6wdt0ZBgV8y9QXBUuXmgx6g9Ane0lE5G3kkb1jK
	CYPAqIAZ/krbj1mjy+kysAht5Yip+f9lons5mQGEz9NcSDKIH+tTTCBUbdaDgbtO
	ZPTGXAd3YXWzxOfRxkqH60Ip5vRei6X90vUREbbHPg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9qyrd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 10:02:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R9rnuo011538;
	Mon, 27 Apr 2026 10:02:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9eh4jar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 10:02:40 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RA2e7n25821850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 10:02:40 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E862658054;
	Mon, 27 Apr 2026 10:02:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55F6E5805C;
	Mon, 27 Apr 2026 10:02:37 +0000 (GMT)
Received: from [9.123.0.247] (unknown [9.123.0.247])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 10:02:37 +0000 (GMT)
Message-ID: <97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com>
Date: Mon, 27 Apr 2026 15:32:35 +0530
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
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, RCU <rcu@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [mainline][BUG] Observed Workqueue lockups on offline CPUs.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: kfY6-BHPr3iX7WqKtuE3bxPj1S_bGaaT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwNCBTYWx0ZWRfXyXMO7hDysoE5
 waVy5FmzEGg7FWtav++P/4k0TCYd/XwrLpORS5Z7SOBI/F5Z2zS7ISfokRCsOD94/3or0WHUe/e
 m5sfAIejdAgI6sZSFAehzmXBxt8cbnGLz54Hl/Cr/XYfyq4X+xtCGE/mLDIXxHdJ3WmwN0Q+tQ+
 FNvCAutH1YfPtHz+uRxxsnQXpw13UTnL0ndIa3EY5J7+DKmz2B3YGL5ZmfMoRcG1RjCFIQk7+9p
 SMKYsNXiQaha2tvP+k0c/uLt5joXIQuS5Knq3ikg6isYaxxuZtTKAb/xI6cUxq4MYU9ci/ZzlOQ
 8e4zL0psS0kZgXzgItVOhvmnS9uTjGXTxRWzFxmnVEO3HfMxjGrSS762p39eWi3IASUdg/2k8HW
 MbHoyRI+qlTltQUYnUiOJhMMn83cikp+jQRSsp/dAZvOr+0ZlziAcv3K6H3y88BxTqzuQj52MDY
 zqS3ZpKtix6Rxo8eZZg==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69ef3442 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=zxL4xWjsNMRmpE90RzwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0v7www1rMIWq9_xkwRN5gMHCmV8llu_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270104

Hi Paul,

I've been testing the latest upstream kernel on a PowerPC system and 
encountered workqueue lockup issues that I've bisected to commit 
61bbcfb50514 ("srcu: Push srcu_node allocation to GP when non-preemptible").
After booting, I'm seeing workqueue lockup warnings for CPUs 81-96, 
which are offline on my system. The workqueues remain stuck for over 237 
seconds:

[  243.309302][    C0] BUG: workqueue lockup - pool cpus=81 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309311][    C0] BUG: workqueue lockup - pool cpus=82 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309318][    C0] BUG: workqueue lockup - pool cpus=83 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309326][    C0] BUG: workqueue lockup - pool cpus=84 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309333][    C0] BUG: workqueue lockup - pool cpus=85 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309341][    C0] BUG: workqueue lockup - pool cpus=86 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309348][    C0] BUG: workqueue lockup - pool cpus=87 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309355][    C0] BUG: workqueue lockup - pool cpus=88 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309363][    C0] BUG: workqueue lockup - pool cpus=89 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309370][    C0] BUG: workqueue lockup - pool cpus=90 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309377][    C0] BUG: workqueue lockup - pool cpus=91 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309384][    C0] BUG: workqueue lockup - pool cpus=92 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309392][    C0] BUG: workqueue lockup - pool cpus=93 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309399][    C0] BUG: workqueue lockup - pool cpus=94 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309406][    C0] BUG: workqueue lockup - pool cpus=95 node=0 
flags=0x4 nice=0 stuck for 237s!
[  243.309413][    C0] BUG: workqueue lockup - pool cpus=96 node=0 
flags=0x4 nice=0 stuck for 237s!

Git bisect identified this as the first bad commit:

commit 61bbcfb50514a8a94e035a7349697a3790ab4783
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Mar 20 20:29:20 2026 -0700

     srcu: Push srcu_node allocation to GP when non-preemptible

     When the srcutree.convert_to_big and srcutree.big_cpu_lim kernel boot
     parameters specify initialization-time allocation of the srcu_node
     tree for statically allocated srcu_struct structures (for example, in
     DEFINE_SRCU() at build time instead of init_srcu_struct() at runtime),
     init_srcu_struct_nodes() will attempt to dynamically allocate this tree
     at the first run-time update-side use of this srcu_struct structure,
     but while holding a raw spinlock. Because the memory allocator can
     acquire non-raw spinlocks, this can result in lockdep splats.

     This commit therefore uses the same SRCU_SIZE_ALLOC trick that is used
     when the first run-time update-side use of this srcu_struct structure
     happens before srcu_init() is called. The actual allocation then takes
     place from workqueue context at the ends of upcoming SRCU grace 
periods.

     [boqun: Adjust the sha1 of the Fixes tag]

     Fixes: 175b45ed343a ("srcu: Use raw spinlocks so call_srcu() can be 
used under preempt_disable()")
     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
     Signed-off-by: Boqun Feng <boqun@kernel.org>

  kernel/rcu/srcutree.c | 7 +++++--
  1 file changed, 5 insertions(+), 2 deletions(-)

Reverting this commit resolves the issue.

The problem appears to be that the workqueue is attempting to execute on 
offline CPUs. The commit moves SRCU node allocation to workqueue context 
to avoid lockdep issues with memory allocation under raw spinlocks, 
which makes sense. However, it seems the workqueue scheduling doesn't 
properly account for CPU online/offline state in this code path.

My test environment:
- Architecture: PowerPC
- Kernel version: Latest upstream (7.1-rc1)
- CPUs 81-96 are offline at boot time

I suspect the issue might be related to:
1. Workqueue not checking CPU online status before scheduling SRCU 
allocation work
2. Missing CPU hotplug awareness in the new workqueue-based allocation path
3. Possible race condition with CPU hotplug events

Would it make sense to use queue_work_on() with explicit online CPU 
selection, or add CPU hotplug handlers for this workqueue? I'm not 
deeply familiar with the workqueue internals, so I might be missing 
something.
Please let me know if you need any additional details or if you'd like 
me to test any patches.

If you happen to fix the above issue, then please add below tag.
Reported-by: Samir M <samir@linux.ibm.com>


Thanks,
Samir


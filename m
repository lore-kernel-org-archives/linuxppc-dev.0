Return-Path: <linuxppc-dev+bounces-23921-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9EBC44507
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 09:22:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwqHs24VZz3c9w;
	Thu, 09 Jul 2026 19:22:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783588969;
	cv=none; b=Da7HLYruMYQWhUYoxMAwQeJN08igtg87VBtOhjuE02TVVg2yOayeC5R4QZnx//09yLHWkOpB3ytpcBWf9UmmabPADSO18U20gEvDgeOCjD9c/q6ZZrAsFKjvX/I43ULDF2LzKVgaZi0ZxUsUsuG1Usj2e0irMuOeG0kTlHxdTxGXJMJTB2938NrzPonede78f5KXBN4lTLjmmT+i/hUC+Ca0ol7MDPrj8IjR59wYrsMRlZyROSobw8QHYXL94YRlxvqCr2SMQ3UgAtSjcU/UYSx2DaQR3f143fxrnuU1QryyAotR9DwhsnRnIkz+/q1PaOg23cPHbfNjr/E1pZd7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783588969; c=relaxed/relaxed;
	bh=NeGSAqmHSFJGag8Wz2XVtFVnQa6VcSKrL4Vi7h0zPaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FRmZGSKg7R29ulGg5PvyBvidwaxQKZ1u/ZJcO88raLTpJt6Kjnh9lBSsVD2F1EsA3h5qQH6WCBNmgQkEFJuE9OjyCoV13G4MXcFxvfa0tDHxBjpCrPkCO3NZZxhitpyvwrzFHDrYsoyS2jP1/TsVu02zlKgso0VzRqnHQzOR/hSeyAxD4LEZ5Ih3oBmiF5bTne1/CnKfxT0aQJxG/3OjYBHq9AdrmwCceDlwvgXLcwDClwPcYQG9sftwRpbWCX3xjm/OQVQQfijuhKlMCSbZGCpWcrxlf0zNn5lH5lU4/nEcYg2g7iMmG3TGT15GUVQZV4rioTjii5j35g60OTJePQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tSqABjlT; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tSqABjlT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwqHq6Fyjz3c8C
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 19:22:47 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696IJUM479889;
	Thu, 9 Jul 2026 09:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=NeGSAqmHSFJGag8Wz2XVtFVnQa6V
	cSKrL4Vi7h0zPaY=; b=tSqABjlTAXZBBFwukegP6Lnv/DdI72k8FW+HcN4QwJSZ
	MMUYTP4HNU5tKn006a2YtwxrZshgw84PjXMQcCM9fcH5twqQeA94DTVz95XHasqd
	v1+JGrjTxOLW+x4l2k/VfadINIwKDMLnALVX1QsQNI45Ob8dLqWCbbEH98PBT52R
	hEMcOE4+kMNbZbDcvKFCT18mdnGzBovUWFJCfhkU6PLUs5iAd4iAugXAd3f9RXGw
	1SX4urAx7QzC656phE3lKX4IKBkJKyFk+zrqGhgPY2t8dUaeWN77ylYI3yBtSpAh
	vUWsjMii54A6lxJYlyEqyCzAnoZ2VfgU/kNVvL0uSg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt18qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:22:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6699JcB9005126;
	Thu, 9 Jul 2026 09:22:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqcp63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:22:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6699MQub56033772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 09:22:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C198E2004D;
	Thu,  9 Jul 2026 09:22:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 002C820040;
	Thu,  9 Jul 2026 09:22:22 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.2.84])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 09:22:22 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: peterz@infradead.org, frederic@kernel.org, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v4 0/2] KVM: powerpc: Use generic xfer to guest work function
Date: Thu,  9 Jul 2026 14:51:38 +0530
Message-ID: <20260709092140.1753715-2-vishalc@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: c5QV_cyQGKsdlNi-IjG1_4omYRWjXuKq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfX4UCUFG+KiNsw
 nz8fglEGzjRu/1OiMufAkircPFLm3HkQXQirMgknzEhbB+cwwfrHLFyqKr2QNxkzIvO8mm59t1Q
 cl+itvYMewr9SMwpVrhZk/qgAAQeYHw=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4f6857 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mPUdJBykSDeI_Y7d1aUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RNeLL5rzdFstpBDJ_3NNbXXOc5fgknlX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfXwI4gTRrwQrcf
 IQqhav6Fhm8EwVyhexyM2izqjw07d07j4xK4pIdiRan/HgT+/r0cNUE43QS8iFlR3Z3T7IUbGrv
 vgNrQUVQo2WNABC7gXH2z/sCxi/4ANKJfSaLQqA2HpYTz5m19soSs7PvZ+kcZ01u/gNK+5jnkq9
 sDVv6YoNYxKncsll+nqHDt3sYf1dD1PraSWNu0umCOR/sfDzm22OGxWzliiXMtAXXlfkdn0clKT
 UrZjngevaZ2909gA/J5uZTtrxwqxmhN/rfHBk6JkjxNZk1eIBou7+4SUvGABd5bznupieJZBGbr
 rfm/CQVMJ+jzde8y/KIl+qCYnhmnHyB6d1hprwn16dnANhvBspP3QqydQvLblyugHy6iPJ2uO+B
 a8jPhUXa282dgnmhSi8qXCIATxuLpMHgUj5iyZVRYkR4NIBaxtl+kfiY2j9wH7jwlCu8833xuCF
 UUhsq+Vp27M6wdddISQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090089

This series fixes a KVM scheduling bug on Book3S HV where a guest VM
under a cpu.max bandwidth limit can run arbitrarily past its quota and
then appear frozen for minutes afterwards. 

== Problem ==

Since commit 2cd571245b43 ("sched/fair: Add related data structure for
task based throttle"), merged in v6.18, CFS bandwidth throttling no
longer dequeues a task directly. Instead it queues a task_work item via
task_work_add(..., TWA_RESUME), sets TIF_NOTIFY_RESUME, and relies on
that work running on the return path to actually dequeue the task.

The powerpc KVM run loops only test TIF_SIGPENDING and TIF_NEED_RESCHED
before re-entering the guest; TIF_NOTIFY_RESUME is never checked. For a
CPU-bound guest that generates few KVM exits back to userspace, the vCPU
thread never returns to user mode, so the deferred throttle task_work
never runs. The guest keeps running unchecked while its
runtime_remaining goes increasingly negative, and once it finally does
exit to userspace it is legitimately throttled for minutes while the
accrued debt is repaid at the bandwidth-timer replenishment rate.

The generic xfer-to-guest-mode infrastructure (commit 935ace2fb5cc,
"entry: Provide infrastructure for work before transitioning to guest
mode") exists precisely to handle this kind of work before each guest
entry. A full trace-backed root-cause analysis was posted with v1 [2].

== Fix ==

Opt powerpc KVM into VIRT_XFER_TO_GUEST_WORK and use the generic
xfer_to_guest_mode helpers to check for and handle pending guest-mode
work (reschedule, signals, and TIF_NOTIFY_RESUME task_work such as the
deferred CFS throttle) on every guest re-entry:

- Book3S HV: both run loops — kvmhv_run_single_vcpu() for POWER9+ and
  kvmppc_run_vcpu() for pre-POWER9.
- Book3S PR and BookE: the common kvmppc_prepare_to_enter(), which
  likewise only checked need_resched()/signal_pending().

== Changes from v3 ==
- BookE: add local_irq_disable() before hard_irq_disable() on the emulated
  MTMSR[WE] path so lockdep's irq-tracing state is resynced, fixing a
  lockdep_assert_irqs_disabled() splat in the following
  xfer_to_guest_mode_prepare(). (Reported by Sashiko AI review)

== Changes from v2 ==
- Add xfer_to_guest_mode_prepare() check for pending rcuog wakeup before
  entering guest
- While at it patch all exit points for kvmhv_run_single_vcpu() via
  done label matching the corresponding trace_kvmppc_run_vcpu_enter()
  with trace_kvmppc_run_vcpu_exit() tracepoint. (Reported by Sashiko AI
  review)
- Include posix cpu timer enablement patch by Shrikanth as part of this
  series

== Changes from v1 ==
- Extend the fix beyond Book3S HV to the shared powerpc KVM entry path:
  also convert the common kvmppc_prepare_to_enter() used by Book3S PR
  and BookE. (Shrikanth Hegde)
- Move "select VIRT_XFER_TO_GUEST_WORK" from KVM_BOOK3S_64_HV up to the
  common "config KVM" so every powerpc KVM variant gets the
  infrastructure.
- Drop the redundant signal_pending() recheck and its sigpend label in
  kvmhv_run_single_vcpu(); xfer_to_guest_mode_work_pending() is a
  superset of it.
- Preserve the E500 CONFIG_KVM_EXIT_TIMING histogram on the signal path
  via an explicit kvmppc_set_exit_type(SIGNAL_EXITS).

[1] https://lore.kernel.org/all/20250421102837.78515-2-sshegde@linux.ibm.com/
[2] https://lore.kernel.org/all/20260626105449.2897924-2-vishalc@linux.ibm.com/

Shrikanth Hegde (1):
  powerpc: enable to run posix cpu timers in task context

Vishal Chourasia (1):
  KVM: powerpc: Use generic xfer to guest work function

 arch/powerpc/Kconfig         |  1 +
 arch/powerpc/kvm/Kconfig     |  1 +
 arch/powerpc/kvm/book3s_hv.c | 39 +++++++++++++++++++++++-------------
 arch/powerpc/kvm/booke.c     |  1 +
 arch/powerpc/kvm/powerpc.c   | 37 +++++++++++++++++++++++++---------
 5 files changed, 56 insertions(+), 23 deletions(-)

-- 
2.54.0



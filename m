Return-Path: <linuxppc-dev+bounces-23317-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DCDC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:31:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gr7r44mLFz2ygG;
	Thu, 02 Jul 2026 04:31:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782930660;
	cv=none; b=Y5BZg3Oyq0aZ855FJRYnYdI4xend4zjkZKQ8vU6ruXeeKtEudXjzv7IJnvt8DiN3ohKUYNrgY4PqSlON7aH3Pgc+oQPwRx8kuoEcQ6EelHg2ovJNX468ytzSFg0Hhzi/mwhg78sQz+dTeGTFuVdTm7WhNVfu+N5hdPFsIXeNYUmsWnrwymf7HgwRLYmDZRXxQiTjKpHDAtocqkPbdMvVIxzXrfhrESm8vQC/31V1M0J4Z3q7XN3ipJDzOdSaY6C3zZpz+ph+PRimlbEnIoEzAoo13c83NGSNv06dkDNyDEQ+MQItsw4eLP9xumFXeQ3WKvdq7UvsVfA0nCjuBIpHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782930660; c=relaxed/relaxed;
	bh=8Ri0qkLy2UgR6ESWzyJ+UkDfa9RR52HfnvZ0KvP1KSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B6FUwnesKo4Xa68G5cpqO/X1xr9wlvPu+IdRc1r1OsmPpqsEWgYrTfad+QIdWZZQTIg34zfrxsGOGlJZeV+1TY/AhEOgJMr7BU6tv6n4dPfnKlmY36M4W6ez+xb7VkuLkgo5OkWx9d2mz6BzOnuCuFyT1BzG41y6CMXGAXocRVclzupxJAj0efsz2tuZUKZp1+H4n0VOmohUhlRf6gO73GDbqDwUXA7ku0fVbCGi1Uqc5xrONdUdvyXk4wonx1DByFmp2UvG1fWtxiaylgPA7MWMJgDfV19TpUFpN9Ox6F4GHvCCYwWriQ7SE4OsamAuW2frld+NcdQpw/+sSWXNEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pMsJfioO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pMsJfioO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gr7r35RNhz2yfs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 04:30:59 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GmsPU1456114;
	Wed, 1 Jul 2026 18:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=8Ri0qkLy2UgR6ESWzyJ+UkDfa9RR
	52HfnvZ0KvP1KSw=; b=pMsJfioO25DD5xxVqc38DNBr5hFHatudXHyce+CHuqpN
	rTxF+SDFeeKp07Mu6AhgPWBrpntVz6oGTxfsSG754HLEmiSZ535yunnrjNyGR+28
	IjR0r+KaD662Xm9z8cBjjuFCB1Ton//c8plCQMwZtKuSAqJWJp08kneL8EmryiMs
	I4LrCZLRBcNO9DonvQfe+ADFDGemAIuZTY13U8EvgByPSqmYVgbWuASJOUgvJdPr
	jhETKGemg8z7ojoNQwuEYnyvF75kDHGF9XJxpwHWJAHXFjMGKJKUl7ImB/IQ1xUB
	KJE1djAG93P3gQhbv1PceD98YF4sbhV66wmE8eb+lg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe64tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:30:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661I4hpE018051;
	Wed, 1 Jul 2026 18:30:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2ggff4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:30:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661IUjtF48562458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 18:30:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC0D220043;
	Wed,  1 Jul 2026 18:30:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65F2320040;
	Wed,  1 Jul 2026 18:30:42 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.23.199])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 18:30:42 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        sshegde@linux.ibm.com, amachhiw@linux.ibm.com, vaibhav@linux.ibm.com,
        harshpb@linux.ibm.com, gautam@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v2 0/1] KVM: powerpc: Use generic xfer to guest work function
Date: Thu,  2 Jul 2026 00:00:26 +0530
Message-ID: <20260701183030.3610451-1-vishalc@linux.ibm.com>
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
X-Proofpoint-GUID: uDQMCFHyWAx2gw7K9hK4STPvoHOFRcrk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5NiBTYWx0ZWRfX+A/lR9BmxxHE
 CcpCyTCsLpHjq/Xb/2WfqgnBIQv/aaXDw1Lok859hdwn5rkJHLSKskYSzODfMl9Qr6t+5DIsO36
 Qm4V9ZDYOlNNYfKvZ6sWTs1NLBH5u0I=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a455cda cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=dzg3fVpTFLiGrQa8HyEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5NiBTYWx0ZWRfX9rHmRngBfNJk
 dPwtaVZ+n9QK84R1gRqbjMq4Ju1rK58ub2/CgSLJVHoeN2tRbr3hvq/4OK7HNi6Ul631b8Z4se9
 u/Pedw/BazEa0IPAHqsLPa1rFVkkp2L3eYNQMZWWtJuFew05DPymumdeJ5bXbPcxJyz4HfEWHnF
 eek/m79J27uQgfeOdXPYRPpcKfLHWjPJXBClLhc3pmTJXWHIchrdZxIdIrE16euNWALSP5RcBJw
 SBdEdK5hRuZUoS66YtGdbJl3giCeYzUF3AxUnvRh61arGebIQGoCgKCHNPqhbXvAPoA9yZiCsB+
 6YvQ8mt6ixLp3QIbZ3j5nxb0YBZwE3tYHv8Jdg12/5JDFRmU0NHULiKt3oQF5bP4KGW48tH+Asa
 BFe8E5xPEBtytXa+QaELsQqP+3CdHcFELAeVXgQ4SB1ruuN87W3MC0oQ96y/KJG/uP3YskK2sgK
 O6D8hThTDmmD1bWOMQA==
X-Proofpoint-ORIG-GUID: xBD_hczw7YhhrLTLjYhRiBprNdDIns71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010196

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

== Changes from v1 ==

- Extend the fix beyond Book3S HV to the shared powerpc KVM entry path:
  also convert the common kvmppc_prepare_to_enter() used by Book3S PR
  and BookE. (Shrikanth Shegde)
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

Vishal Chourasia (1):
  KVM: powerpc: Use generic xfer to guest work function

 arch/powerpc/kvm/Kconfig     |  1 +
 arch/powerpc/kvm/book3s_hv.c | 64 ++++++++++++++++++++++++++++--------
 arch/powerpc/kvm/powerpc.c   | 34 ++++++++++++++-----
 3 files changed, 77 insertions(+), 22 deletions(-)

-- 
2.54.0



Return-Path: <linuxppc-dev+bounces-28639-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF43CA5FB3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 10:03:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwSCD4jjjz2yYf;
	Thu, 01 Oct 2026 20:02:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790848968;
	cv=none; b=ourwakQZvL+Iu5wwPh7kow0zBOCUvq16E+LoFbfcLPNGLRwsiPEZBGQ7VoqwQlUjOyCgmTok4n+DiSHiu85bS1l79jHY4rU2Z6/hsSgcYR4FkrGA5zhLs+PSBxdEA2x8BXaxv9+cU0UwYa37pATQRiTUhfyVKrxHV6/AqdHhIRJGKfJ3lXnkNf2VcqWUKhUsvQLSFCzdN8TmrhgSnS1KRv05FygSEP1iJAmDOar4NLn98iN9o3d9Z0/qTKHjG9F6phXCPVAEGVJDzKolYxpD6aBbETzilz0KzvMnTux8NsDeFCbiuATx6wCggt96ZhM+K2VfzccPv+Qdg2UN5BZuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790848968; c=relaxed/relaxed;
	bh=K3Uo/15GS8lKICWuYMlump9m/ajQMVBXyHw361IpxFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IM0IDr9Dyl6iElUiGp53Y1OI1jtFTKwfAue10cxcBUa/5ychDeqnKyviRrGROUOhRzpb/u4TX35rv55mDJv9BCK2RpLqaga1s93Lga4/UfjGqCpDmKdoX4zi7ijhOYjC1i/dVKw6QpJS4qpijPMRNxNxcgoEUIac5zHn7znK8R0ujkgZnEAQhHYU32LK3kh5vxERVVWxXBG7+RC3oniWfbh617+zBdripNCaAEuXm1mVTn5o0HH6wwi8b3Qr7cQ/db8yYbZqIJYSWkLY/CwvSuSCu0gRA7QwgA3VWNC2xmhVaBvXJq9N8LukyXtDs5Ug3GpIAkmlEUH8BRs47uuRwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q/HIUVzF; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q/HIUVzF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwSCC5v9gz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 20:02:47 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175UQ24040713;
	Thu, 1 Oct 2026 10:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=K3Uo/15GS8lKICWuY
	Mlump9m/ajQMVBXyHw361IpxFo=; b=q/HIUVzFbdW8aAmgyyorih6+Fpsy+DbjJ
	rG2xFu0whpiy9SOoKnkxvmeCrrxrou3fuC46W7mMfDuuBQbsNgMAHU29xfg33rpc
	38PcMsTU5nY4Jnq4Xg1krR8nKCgtyhAj83rjAlt6ea2dmI+tOjkZXIIRrRDdBErN
	893FdwE89Ul6PSXTYE8BpkfW2yXszEYUUEppc96jle9jWNVBJd0IjOt/uKllDwtw
	ENjwx0AMrdSnGVl76ONbePXg1Xi044hpOxR0LOgAvSWVdE+n5tEPo4WSfsK9ClPl
	qrWw4/CUyk51NwB1MnpEv5VpLylBfZQt30RnY3LPvEoZu91oqSKVg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fehbbd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:02:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172sTS3460482;
	Thu, 1 Oct 2026 10:02:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4petq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:02:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691A2Whv42009052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:02:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EEC520065;
	Thu,  1 Oct 2026 10:02:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF3442005A;
	Thu,  1 Oct 2026 10:02:29 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.bl1-in.ibm.com (unknown [9.123.6.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:02:29 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, harshpb@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3/3] KVM: PPC: Book3s HV: Take SRCU read lock around kvmppc_h_page_init() call
Date: Thu,  1 Oct 2026 15:32:06 +0530
Message-ID: <20261001100208.1271628-4-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001100208.1271628-1-gautam@linux.ibm.com>
References: <20261001100208.1271628-1-gautam@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe2fbd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8qrm3ZJ1U5mLyAqmLJwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzOCBTYWx0ZWRfX5NbiIP+Uzu88
 e+koKIfHsxtqtXb4BSctPqfcJMV9FktTrk2ik6fbR+wAranjKTSjFjG4kmo+6akTrziNo4+KVJr
 y6sI7LgTifPgPws2L1T4n80RnEofvbs=
X-Proofpoint-ORIG-GUID: aOKvqtGv9dMW_m-51a8aQoqB094QNt_V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzOCBTYWx0ZWRfX1D63T4Vs6CVU
 jd0hu29OwKIJJNjXmMz81wF0qTEyu+2NEdKlNLS4GKotwp5O5Ln3D0lOul0Paq/rwwORuP/9UNl
 VItvnNNiaIqOT7TJEsp5WyIIvv+rGjCoDwJuqqWWQUKIdn2Jocw5bUnnZoQMvxGwvuYLtiZECsY
 txyJ5SlNROG3TXR23W95pz0pVSwwgoZb8XXYOCKMEUzv0AHf2JVKRPi3ohzcgdAmUFrjWFgPdvJ
 8SMH1Io0eS5skHqxzaLxGENAV3v3xiRkgmQPrwz+Q1Z5nRgoHjhQNP9Ow3uX4kfAXQME/AcVw8t
 oJhc2FU1hwpqj5G4FiqBzlqJ4gtKYKHnaETsGxYzslKsCA7a13BQ/dRS/GYJ6bsHvvTkxdsbB9W
 sqwHWuma9pYqSKAM8/59NCOvOeIZku6jMu4RFHtlSoW1lhpeTxIYDpo8ey0smRBl/HZf/+SsWFA
 PqG7OLjhFsZjJWV7gSw==
X-Proofpoint-GUID: Mfc3wQlrzT1o662RsgRmb8ENhuArzc-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010038

Since there is no srcu read lock around kvmppc_h_page_init(), a
"suspicious rcu_dereference_check() usage" can be triggered by running
host linux with CONFIG_PROVE_RCU=y and the following code in the guest:

plpar_hcall_norets(H_PAGE_INIT, H_ZERO_PAGE, phys_addr, 0);

 =============================
 WARNING: suspicious RCU usage
 7.0.0-dirty #227 Not tainted
 -----------------------------
./include/linux/kvm_host.h:1074 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by qemu-system-ppc/2093:
 #0: c000000354197ab0 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x10c/0xaf0

stack backtrace:
CPU: 30 UID: 0 PID: 2093 Comm: qemu-system-ppc Not tainted 7.0.0-dirty #227 PREEMPT(full)
Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.60 (NH1060_158) hv:phyp pSeries
Call Trace:
[c00000033e1bf430] [c000000001b3dbd4] dump_stack_lvl+0xc8/0x130 (unreliable)
[c00000033e1bf470] [c0000000003da964] lockdep_rcu_suspicious+0x1f4/0x290
[c00000033e1bf520] [c000000000231424] gfn_to_memslot+0x1b4/0x1c0
[c00000033e1bf560] [c00000000023637c] kvm_clear_guest+0x9c/0x110
[c00000033e1bf5c0] [c0000000002714a4] kvmppc_h_page_init+0x160/0x1a0
[c00000033e1bf610] [c00000000026c040] kvmppc_pseries_do_hcall+0x1930/0x1940
[c00000033e1bf6d0] [c00000000026fb18] kvmppc_vcpu_run_hv+0x268/0x800
[c00000033e1bf7a0] [c000000000246b30] kvmppc_vcpu_run+0x30/0x50
[c00000033e1bf7c0] [c000000000241ed4] kvm_arch_vcpu_ioctl_run+0x364/0x530
[c00000033e1bf860] [c00000000022b870] kvm_vcpu_ioctl+0x1b0/0xaf0
[c00000033e1bfa50] [c0000000009b4514] sys_ioctl+0x144/0x190
[c00000033e1bfab0] [c000000000034330] system_call_exception+0x170/0x370
[c00000033e1bfe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec

Fix this by taking a srcu read lock around kvmppc_h_page_init().

Fixes: 2d34d1c3bbfd ("KVM: PPC: Book3S HV: Implement virtual mode H_PAGE_INIT handler")
Cc: stable@vger.kernel.org # 5.2+
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index dbac3573b2c8..8678a93bac51 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1386,9 +1386,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 			ret = kvmhv_copy_tofrom_guest_nested(vcpu);
 		break;
 	case H_PAGE_INIT:
+		kvm_vcpu_srcu_read_lock(vcpu);
 		ret = kvmppc_h_page_init(vcpu, kvmppc_get_gpr(vcpu, 4),
 					 kvmppc_get_gpr(vcpu, 5),
 					 kvmppc_get_gpr(vcpu, 6));
+		kvm_vcpu_srcu_read_unlock(vcpu);
 		break;
 	case H_SVM_PAGE_IN:
 		ret = H_UNSUPPORTED;
-- 
2.52.0



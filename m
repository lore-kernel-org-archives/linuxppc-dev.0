Return-Path: <linuxppc-dev+bounces-27570-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD6AC982CF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 13:01:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlwrC401Qz2y7Y;
	Thu, 17 Sep 2026 23:01:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789650107;
	cv=none; b=HkBFIqZmATReTp4YbPgifqDtstHl6F1QKg9IWrvgsI2LBfmmctxN48DkY+tz3mn66a0pljenzCxgKt+FamcHGKT4PtPLG7jpv+C5tqnOTtBuDL0vyyFnTt+PZU1hxUgUWszQWV0EiXOxrbZzC2D2VzZOr+sLtb6vKYC45FJoVrqVNiSz/XufD1QcV1A/IntACwpMD5sK0j7vtDLHwODeQDOjo6XbPvK2Uv8XzE9VSAs0EWTfpkBL+DgrhlGvDB+XqtwNc+Qiy2pi6nphEBXgYjPhOJdPdprotenDLa0NVjmYNadzXiIY/KyhbZSeog0vZBoRgsPgOChWCZgkgW0tKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789650107; c=relaxed/relaxed;
	bh=AQRHdCj16TrrSWnTpDkc5vju0kVOTBDHRDpVkj/3P68=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=iCLqHHrIOEBDbQ9U0vVsaDUUXjYnRhya4zNRZMpi7R77EZ7vcY2uzs2lqBATgQTrXi8+BO22PyQJCKR5+T6qbLTYnRVi7WS4CwkZSxLbbHCaoyphYqjJC0DioD/1e+uF3W++F7jo9D1JCubvjTkNdbHD43qcEFaK6RfX4LpGih+Zbnvp/BJp44vUyNUbvAJnr6f5sfAZQcS3t/grsI2/He9WJrDhkW1/LmfgNS5ySrIP6c5NdGQAZJh+2OME/PQy5ECd4hcEM5b3yPy/WfbVwrC3NTgz8sdlUxCaCwQjnyYKR5T+MLN0vCwVwVapDyj9xlN+Ko/cF26qvr472ohG8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=faopFsgs; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=faopFsgs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlwrB4LGmz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 23:01:46 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HA1mKc2233185;
	Thu, 17 Sep 2026 13:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=AQRHdCj16TrrSWnTpDkc5vju0kVO
	TBDHRDpVkj/3P68=; b=faopFsgssE2R4TjJZGlgfZ9Eo5zejWBuU77fTXX6Y4VG
	SoeIFOze/vQXWRFDviMgy20w90pqpnpfK0iDhRT4+z319N3jMJnvE9MxgNw4KO7g
	P+euljUmx50zWZTpO7Ui8Nf4TLKqh0VgCFGP9A1CcmxJyqFaAiavZfWvPuD6Vn/O
	xO+aknNRBAahpjibVmlT9iNPvJrXZvhz/VBYbYdpKABBCFY/D4g/iGt1xTwER281
	DdFP9YSqZ8u6QODosjx9uL2pQJlyJIynb7xAvc4AOWRCX0HG+DdISVlfMOlA+HkV
	h15xSXxJLU4fB36oIl+3mYIsjatmsStrnI97+Ik3Ww==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv9xuv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 13:01:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9aQTe2917878;
	Thu, 17 Sep 2026 13:01:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa2c88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 13:01:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HD1C8f26804966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 13:01:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C786C5804B;
	Thu, 17 Sep 2026 13:01:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF53958055;
	Thu, 17 Sep 2026 13:01:07 +0000 (GMT)
Received: from [9.61.254.151] (unknown [9.61.254.151])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 13:01:06 +0000 (GMT)
Message-ID: <ff563467-0bab-43ec-a46c-a4167bc12473@linux.ibm.com>
Date: Thu, 17 Sep 2026 18:31:05 +0530
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
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [BUG] audit/powerpc: WARNING at kernel/auditsc.c:1995
 (__audit_syscall_entry) during BPF kselftests (test_progs)
To: bpf <bpf@vger.kernel.org>, linux-audit@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Hari Bathini
 <hbathini@linux.ibm.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, andrii@kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>, yonghong.song@linux.dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE4MyBTYWx0ZWRfX0QIezHWiHvC+
 BY7RobCZ1EYyaQaMvJnDTCvJbgJIpEjEhahYLqCSptQ4CMHmURBpGUluC+EFXAW826jz7lYJ7zO
 72l4G9XBwMZHcZMlHwl+gVDM0glM9nA=
X-Proofpoint-ORIG-GUID: dDb9bDCqeeVpholIL9CyhPLpVpNXttAg
X-Proofpoint-GUID: H9eSEgusvn-ggINNNpd_KqmaZkHQXlgH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE4MyBTYWx0ZWRfX1rw5eKB02r71
 geZY9W/oRl1wDmhSu4ktB3/Y4IfxMUN9SNtLAShjTQRoR5EnqXbXiOR/105S/CDaNYOuMCoy45o
 RmWn1GczyXKphoDDcysNJEIiiCEWipbNYZFizSRGxSGREib5q2DO5z15YuymIIBrlRsg7LomCEh
 Pm5ICmuFJ0Ik773tJ6PjJ9+A8Mxi9Jy654TeEl9+8HzeF/wrJbbfee+1ax08BUZFIW6usQ0P89G
 52QVGZHrw4KCWpIOvXuMJrbT83D7R3dIA8XD/WzhEGuSgZAgalATmmBcgIsjEHKOnagCcHj/U5N
 WVk/EcTP15re6DK59hpTWbjUdsQQoz13j9hREFwIFzt4/ga1NuYBiBRZz/kMpBckT2j8bzB12Ro
 qzzooZONrl8naiWaIJZ0SuKYQi8JTWYX626V9j0uwbD31LzHtxoK3eRtXe9v+mEaZH8L3hgW/Kn
 onKVxLLRY8xn/kg//GQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aabe49a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=CKLhZi6Pc96QUMOnJ7kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170183

Hi all,

IBM CI has reported a kernel warning triggered in 
__audit_syscall_entry() on a PowerPC 64 (ppc64le, POWER9 pSeries guest) 
system while running the BPF kselftest suite (test_progs).

Environment:


Kernel version: 7.3.0-rc3-g238650ef6c7c (PREEMPT)
Architecture: ppc64le (POWER9 - IBM,8375-42A pSeries / phyp)
Workload: BPF selftests (tools/testing/selftests/bpf/test_progs)


Problem Description:


During syscall entry processing (system_call_exception -> 
syscall_enter_audit -> __audit_syscall_entry), the kernel hit 
WARN_ON(context->context != AUDIT_CTX_UNUSED) at kernel/auditsc.c:1995, 
indicating that the task's audit context was not reset to 
AUDIT_CTX_UNUSED prior to entering the new syscall.

Trace:


[ 1371.387510] ------------[ cut here ]------------
[ 1371.387528] WARNING: kernel/auditsc.c:1995 at 
__audit_syscall_entry+0x50/0x1b0, CPU#17: test_progs/49616
[ 1371.387539] Modules linked in: dm_verity(E) dm_bufio(E) 
reed_solomon(E) livepatch_sample(EK) tun(E) vrf(E) 8021q(E) garp(E) 
mrp(E) stp(E) llc(E) veth(E) bonding(E) tls(E) rfkill(E) nft_fib_inet(E) 
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) 
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) 
nft_chain_nat(E) hvcs(E) hvcserver(E) pseries_rng(E) vmx_crypto(E) sg(E) 
drm(E) fuse(E) drm_panel_orientation_quirks(E) xfs(E) sr_mod(E) 
nvme_tcp(E) sd_mod(E) cdrom(E) nvme_fabrics(E) nvme_core(E) ibmvscsi(E) 
ibmveth(E) scsi_transport_srp(E) dm_mirror(E) dm_region_hash(E) 
dm_log(E) dm_mod(E) [last unloaded: bpf_test_modorder_x(OE)]
[ 1371.387607] CPU: 17 UID: 0 PID: 49616 Comm: test_progs Tainted: G    
        OE K     7.3.0-rc3-g238650ef6c7c #1 PREEMPT
[ 1371.387616] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [K]=LIVEPATCH
[ 1371.387620] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
[ 1371.387626] NIP:  c0000000003e70d0 LR: c000000000352080 CTR: 
c00000000000cf00
[ 1371.387631] REGS: c00000000beafaa0 TRAP: 0700   Tainted: G      OE K  
     (7.3.0-rc3-g238650ef6c7c)
[ 1371.387637] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
48002824  XER: 20040084
[ 1371.387650] CFAR: c00000000035207c IRQMASK: 0
                GPR00: c000000000034958 c00000000beafd40 
c0000000020eb200 c0000000345f4800
                GPR04: 00007fffe2a31184 0000000000000081 
000000007fffffff 0000000000000000
                GPR08: 0000000000000000 0000000000000001 
0000000000000001 00000000000000dd
                GPR12: 0000000000000000 c00000002e99b300 
0000000000000000 0000000000000000
                GPR16: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR20: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR24: 0000000000000000 0000000000000000 
0000000000000000 c0000000345f4800
                GPR28: 0000000000000000 00000000000000dd 
00000000000000dd c000000138e0c000
[ 1371.387710] NIP [c0000000003e70d0] __audit_syscall_entry+0x50/0x1b0
[ 1371.387715] LR [c000000000352080] syscall_enter_audit+0x90/0xd0
[ 1371.387722] Call Trace:
[ 1371.387725] [c00000000beafd40] [c000000000937050] 
selinux_task_getpgid+0x80/0xa0 (unreliable)
[ 1371.387735] [c00000000beafda0] [c00000000beafde0] 0xc00000000beafde0
[ 1371.387741] [c00000000beafe00] [c000000000034958] 
system_call_exception+0x448/0x480
[ 1371.387749] [c00000000beafe50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[ 1371.387757] ---- interrupt: 3000 at 0x7fffab74cbf0


Please let me know if additional logs, config, or repro details are needed.

Regards,

Venkat.



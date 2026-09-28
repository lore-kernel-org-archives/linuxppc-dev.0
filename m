Return-Path: <linuxppc-dev+bounces-28374-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EEFC98328
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 06:13:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htWFb22Ljz30Vj;
	Mon, 28 Sep 2026 16:13:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790575987;
	cv=none; b=C/4mn7vnig3655fMQIlMFg/+IqjYzok7YWMXtWgDhOIKlXfBwXd5ChtXPN+vnA24NaW+uLJDB7uJapuqkHZnRolCEgEqeoVc5cuLB1U1h2SZQSvPVIPIlPbbtJEsncv6UmQGcJ6eBw5gOG5ahFcVmZ77GTx6FR+KmPmzFkanPhcpFeKwdMTyp+ZG7+kcGjogxuLtf2Vwu9/Gf5GOvX/T5B0hFqeIjO626xazYRVNR6O0pzNYRpx1fmwA7O9yZwUlzMUpl8SqdmT/fmZCcldppBRNGLbOlYDy26NlMpSpgf/GtFAOUga7QtXmvkKm4p9DU9agMVUNBCsdZ/l1+glk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790575987; c=relaxed/relaxed;
	bh=Opf9IQ3f3K2i0tq+D1k6onNvQgU/EnLloVK/XP18k9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZwb1EAeUZEaPUZWySMhdYaN2GKKW1YJEALJyosuYzLLAXVlxSC5jJ9yrSir9+TAg6/W6dMpbi72Y9qXGY71p08MEBFduccXMVBFoR7od62oJpMk3nMJIYRZkj3hFkRCyU4F2zlxRm9S8YpJ9Xw9g7AZgtvnLQPKObCUvZVNN+cIIqBHR1jTHWFRrs64Hbn+bJXMN0Qqdb5kp5iCqlZ8QOHl0R9UBRuk87mu4nPSS3YQOmzFuqtDVlMZgQ59fwO1cqyhpu792GZzGHilNFRcRKpg+eSqTx7HNUctBsg3DmWkKsd0Iu6dVT1jXMUU2MpDyd4GR5drpHqslY7HnkOw6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DVZ+3+H0; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DVZ+3+H0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htWFY62brz30Vd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 16:13:05 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RGM7X5263759;
	Mon, 28 Sep 2026 06:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Opf9IQ
	3f3K2i0tq+D1k6onNvQgU/EnLloVK/XP18k9o=; b=DVZ+3+H0mCfT1HRr+lKM97
	73PilpD0GPYOLne6eBrhRhwyFkZtGrLSnk3RFtsit2BNHX+ZNpDNnRIebSTIBg19
	dVn1KHx5WTdovvGJXA6Q8OSXanh7Oy+BvVz6ckqiJ27SNZsCsxKZ5eqxv/f4gErP
	rgtc5/4OR120acWKL8yQkr1gDccUC1BIDM8F/o51rr5YPmxMUqARVl2Uq6a1kNEq
	8RTpM3gen6N7S631BHBybmlF/9kl7c00ia2U9ra5ztgPg1zdpDAzUox9uwX9BSm6
	Ti+P+Jg4nZsKiCt4i9x1fJZfOy5UX+Y+3usZPMvpbpxhMOsHD+FgBF5uRQfp4+EQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j4ypyn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 06:13:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S50Dw9879799;
	Mon, 28 Sep 2026 06:13:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxtkg3se8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 06:13:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S6D0OE46268794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 06:13:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EAFB2004B;
	Mon, 28 Sep 2026 06:13:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6204C20043;
	Mon, 28 Sep 2026 06:12:59 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Sep 2026 06:12:59 +0000 (GMT)
Date: Mon, 28 Sep 2026 11:43:10 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
Subject: Re: early boot crash in init_tracer_tracefs
Message-ID: <20260928111234.faec09f7-8d-amachhiw@linux.ibm.com>
Mail-Followup-To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
References: <arYskzbiaNzBR9MD@kunlun.suse.cz>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arYskzbiaNzBR9MD@kunlun.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfXyGGRtujx7SQq
 82jnS00PGnOrsDaV3VsfCMopZ78i3GXFEz0wxUJ/ZRqYtvVLmxeENDhyS9rOBLq7JpMYyIOag99
 3tnlbbgQEg6KEpZt5L0dW3tTGsF9svY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfX6wisBiEdzSIt
 oUsAXJ+hC/hDaq5Pg+a1dTkNe4GBKnnoBgXay4hh4kuvbNiEMnDmTEOJyoTZpzkw46YQLNcE5og
 PObY0Yvtrg7Mj77FAi6qoQ5GYlmxFn0VGZ4dZCjXqlrBqVL7d4MiOR1sHGuX7ZeTUFaZcTWO1EJ
 wc5bgjs84w2jJWh4w1rWPRLCehNq3AtUrMlGkDMtayL/GHifbgd4DUoKupsacSSrCocTWIpaay8
 Cqqw58n7wnnPzkvC9wZTX6uzOENch9rLblFmZCCRxMBN4iPf/c2kiUBajGyezLWISLFTFzg/9Ed
 PzZBiV02KJhIREqXlKI0UwPzLU9Re25YiNW3FbXU9DLn7xy5pxIoqY+WYxZnRhCOFTHKLvo40eh
 BuScK1eOF/hqny9DX8k02RypaFfX8o8InCGAGTKn22QJ8GBYQx9JMc4f/Uhykw86++ealETJ1M9
 XwJvUbHzBUDdRqvQv4w==
X-Proofpoint-GUID: QqncuQ0xra7N7AxkjkcVqUszrwH3_IkI
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6aba056e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=VLc2VSdLAAAA:20 a=YLHbHz9oOkY--1DRpckA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: QqncuQ0xra7N7AxkjkcVqUszrwH3_IkI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280024

Hi Michal,

Thanks for the report.  We have been looking at the crash and have some findings
and follow-up questions.

On 2026/09/25 10:10 AM, Michal Suchánek wrote:
> Hello,
> 
> There appears to be a regression between
> 
> Linux 6.19.12
> https://github.com/openSUSE/kernel/tree/7a15f44a1b293702f2b6a93f8fe792ab46d2cb3d
> https://github.com/openSUSE/kernel-source/blob/9f6830f/config/ppc64le/default
> 
> 
> Linux 7.0.12
> https://github.com/openSUSE/kernel/tree/4c9922875554ec191166ba6c0145f12d8ff9d4fc
> https://github.com/openSUSE/kernel-source/blob/2ebf0bc/config/ppc64le/default
> 
> With 7.0 being the first kernel version that forces preemtion it was
> suspected that perhaps this is due to preemption but same result with
> 6.19, same config + PREEMPT=y, and 7.0, same config. That is preemption
> does not make any difference, the code change between 6.19 and 7.0 does.
> 
> The crash happens about 50% of the time when booting the kernel as
> NestedV2 KVM guest. Bisection did not lead to anything. Changing config
> such as disabling some code that could not possibly get used (drm,
> sound, hid) makes the problem unreproducible. As the bisection descends
> into some fairly old revisions it is possible that due to code changes
> the problem becomes too difficult to reproduce.
> 
> There was recently a fix posted for preemtion in ftrace code but it does
> not help.
> 
> It is possible to save the memory from qemu after the failed boot but
> crash tool refuses to open it because of SMP mismatch between the dump
> and vmlinux.
> 
> Any idea how to futher diagnose this problem?
> 
> Thanks
> 
> Michal
> 
> Typical boot log when the problem is seen:
> 
> SLOF **********************************************************************
> QEMU Starting
>  Build Date = Aug 13 2026 14:47:36
>  FW Version = abuild@OBS release 20230918
>  Press "s" to enter Open Firmware.
> 
> Populating /vdevice methods
> Populating /vdevice/vty@30000000
> Populating /vdevice/nvram@71000000
> Populating /pci@800000020000000
> Loading Linux 7.0.12-1.g2ebf0bc-default ...
> Loading initial ramdisk ...                
> OF stdout device is: /vdevice/vty@30000000
> Preparing to boot Linux version 7.0.12-1.g2ebf0bc-default (geeko@buildhost) (gcc (SUSE Linux) 15.3.0, GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.45.0.20251103-4) #1 SMP PREEMPT_DYNAMIC Mon Jun 15 08:39:32 UTC 2026 (2ebf0bc)
> Detected machine type: 0000000000000101
> command line: BOOT_IMAGE=/boot/vmlinux-7.0.12-1.g2ebf0bc-default root=UUID=304c7f07-efbb-1070-2f27-accd935ec088 rw quiet systemd.show_status=1 security=selinux selinux=1
> Max number of cores passed to firmware: 8192 (NR_CPUS = 8192)
> Calling ibm,client-architecture-support... done
> memory layout at init:
>   memory_limit : 0000000000000000 (16 MB aligned)
>   alloc_bottom : 00000000066b0000
>   alloc_top    : 0000000030000000
>   alloc_top_hi : 0000003e00000000
>   rmo_top      : 0000000030000000
>   ram_top      : 0000003e00000000
> instantiating rtas at 0x000000002fff0000... done
> prom_hold_cpus: skipped
> copying OF device tree...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x00000000066c0000 -> 0x00000000066c0bec
> Device tree struct  0x00000000066d0000 -> 0x00000000066f0000
> Quiescing Open Firmware ...
> Booting Linux via __start() @ 0x0000000000250000 ...
> [    0.000000][    T0] ERROR: Failed to allocate trace buffer
> [    0.000000][    T0] ERROR: tracer: failed to allocate ring buffer!
> Linux ppc64le
> #1 SMP PREEMPT_D[    0.285758][  T673] BUG: Kernel NULL pointer dereference on read at 0x00000010
> [    0.285877][  T673] Faulting instruction address: 0xc000000000485bd0
> [    0.285903][    T1] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
> [    0.285954][  T673] Oops: Kernel access of bad area, sig: 7 [#1]
> [    0.286133][  T673] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> [    0.286240][  T673] Modules linked in:
> [    0.286288][  T673] CPU: 15 UID: 0 PID: 673 Comm: kworker/u531:0 Not tainted 7.0.12-1.g2ebf0bc-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  cf0846124d7853fab338aeae87203b36cac18419
> [    0.286527][  T673] Hardware name: IBM pSeries (emulated by qemu) Power11 (architected) 0x820200 0xf000007 of:SLOF,HEAD hv:linux,kvm pSeries
> [    0.286739][  T673] Workqueue: trace_init_wq tracer_init_tracefs_work_func
> [    0.286818][  T673] NIP:  c000000000485bd0 LR: c000000000448864 CTR: c0000000005a3420
> [    0.286906][  T673] REGS: c00000000a7a7960 TRAP: 0300   Not tainted  (7.0.12-1.g2ebf0bc-default)
> [    0.287014][  T673] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44088404  XER: 00000000
> [    0.287122][  T673] CFAR: c000000000448860 DAR: 0000000000000010 DSISR: 00080000 IRQMASK: 0 
> [    0.287122][  T673] GPR00: c000000000448864 c00000000a7a7c00 c000000001f38100 c000000002a5c098 
> [    0.287122][  T673] GPR04: c0000000017dc5f0 c0000000017dc5e8 000000000000001f 0000000000000064 
> [    0.287122][  T673] GPR08: c0000000017dc628 00000000000005f0 00000000000005e8 0000000084000404 
> [    0.287122][  T673] GPR12: c0000000005a3420 c000003dfff43d80 c0000000018e5600 c0000000018e54f0 
> [    0.287122][  T673] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [    0.287122][  T673] GPR20: c0000000013ec418 c0000000013ef6d8 c0000000017dc5a0 c0000000017dc590 
> [    0.287122][  T673] GPR24: c000000001825330 c0000000017dc628 c000000014b52a05 0000000000000000 
> [    0.287122][  T673] GPR28: c0000000017dc5e8 0000000000000000 c0000000017dc5f0 c000000002a5e008 
> [    0.287970][  T673] NIP [c000000000485bd0] __find_event_file+0x70/0x3c0
> [    0.288046][  T673] LR [c000000000448864] init_tracer_tracefs+0x274/0xc80
> [    0.288122][  T673] Call Trace:
> [    0.288167][  T673] [c00000000a7a7c00] [c00000000a7a7c60] 0xc00000000a7a7c60 (unreliable)
> [    0.288258][  T673] [c00000000a7a7c60] [c000000000448864] init_tracer_tracefs+0x274/0xc80
> [    0.288348][  T673] [c00000000a7a7dc0] [c00000000203fcf0] tracer_init_tracefs_work_func+0x50/0x320
> [    0.288452][  T673] [c00000000a7a7e50] [c0000000002620e8] process_one_work+0x1e8/0x5c0
> [    0.288541][  T673] [c00000000a7a7f10] [c00000000026309c] worker_thread+0x1dc/0x3d0
> [    0.288630][  T673] [c00000000a7a7f90] [c00000000026fa34] kthread+0x194/0x1b0
> [    0.288721][  T673] [c00000000a7a7fe0] [c00000000000de58] start_kernel_thread+0x14/0x18
> [    0.288810][  T673] Code: fb410030 fb810040 fba10048 7cbc2b78 3ba00000 fbc10050 7d194378 7c9e2378 2e2a0fc0 2da90fc0 f8010070 60420000 <e93b0010> 81490058 e8890018 714a0208 
> [    0.289001][  T673] ---[ end trace 0000000000000000 ]---

What we know so far:

The immediate crash is a NULL pointer dereference in __find_event_file() called
from init_tracer_tracefs().  When allocate_trace_buffers() fails at early boot
(ERROR: tracer: failed to allocate ring buffer!), it returns via the error path
leaving tracing_disabled = 1 and global_trace.array_buffer.buffer = NULL.
However tracer_init_tracefs_work_func is queued onto trace_init_wq
unconditionally with no check for whether the ring buffer allocation succeeded,
so it runs anyway and crashes dereferencing a NULL pointer at offset 0x10.

The fix for the should be crash is:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e4a490d3d08c..93845281e906 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9287,6 +9287,8 @@ static struct notifier_block trace_module_nb = {
 
 static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 {
+       if (tracing_disabled)
+               return;
 
        event_trace_init();

However that only fixes the symptom.  The underlying question is why
allocate_trace_buffers() fails at all, and we don't have enough information to
determine that yet.

While I'm trying to recreate this problem locally, could you please share the
following information in the meanwhile?

The early kernel boot messages we need to diagnose the allocation failure are
being swallowed by quiet boot — your log jumps from SLOF straight to the error.

1. Could you boot the crashing guest with "quiet" removed from the kernel
   command line and share the full boot log when the problem recreates. We
   specifically need the lines:

	Partition configured for N cpus.
	rcu: restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=N.
	percpu: Embedded ...
	Memory: .../... available

2. How many vCPUs did you assign to the NestedV2 guest?

3. What are the L1 host specs — total CPUs and total RAM on the host machine?

4. How much RAM did you assign to the guest?  I can see ram_top = 0x3e00000000 =
   248 GB from your log — is that correct?

5. Is the problem reproducible on upstream Linux?  Trying the same guest config
   with a mainline kernel would help determine whether this is a SUSE-specific
   patch or config issue, or something present in upstream as well.  If you
   haven't tried upstream yet, that would be a useful data point.

Thanks
Amit


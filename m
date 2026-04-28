Return-Path: <linuxppc-dev+bounces-20238-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CF1FF8868
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 12:19:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4fcM6QHMz2xlt;
	Tue, 28 Apr 2026 22:18:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777378739;
	cv=none; b=gJ6q+KtZvJ1joMasHUIXJANXi1SzRPIe/XPdU+dRHM9lGr6TA2B+qOJK3vOCZwBtncOsRf4+S7krepeHHnxlfsDijQ59od+3qrY2XjLAcfH3LWyFb4NgATnk2SXErtaVzUGgLDdJaf7CynXDkCijUiHyT24vAqYjGb0LX3embt6wYhjBHeRb2LkRlJ1Xs10wyUeuanJaIG3TNtr41RJbQ1GWd1FoF2MwtIojtIVP3BsTzkhQDsWNmzRdZJd4XDtr/Win8iRtx+Umqo60mKIqUqXT3YuB6/ckcUqxwScCnHk/KZ3zD268UxCpC3VoxBqlaKeJMwSPLgoOBRtnRVmsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777378739; c=relaxed/relaxed;
	bh=ns66PVEBMY2cCcQ5tn/Wl9fb0b+mZmOx7OUI5+Hcz28=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=oQOP1IkkbudeafBvI9Y2j6bN4AaJHcHsEnsQCNmqbvups+caBExMdwl227uA4tOOUKHMTw5+IoVHHtIv2v5mlcGfeQbqNNRPgqQcd6oFuC8CyGHrh8bxXfTZt8AudWYSeVtkmcoJ/6jUkaF2QzBId88bJ8MykH21SM0iqaUTXsQD4YIj7i3AUKp0zDmM2qXUE031v6ebTWQQCOoz/KMZ26+zaR2XM0332Ygq1q4FRL4YuNRhNUhhzPmem5Ss2GQHOih/Ycwd9cMGUBngB7dNN+5Qppu7BTpx4uht9q6f38LR0qHbnqGsUGUd+jxtZmwpBx+Yc9kzBpDX32SRt/8vgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CsxBTICK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CsxBTICK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4fcL6xkSz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 22:18:58 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RJ0HZQ1285119;
	Tue, 28 Apr 2026 12:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ns66PVEBMY2cCcQ5tn/Wl9fb0b+m
	ZmOx7OUI5+Hcz28=; b=CsxBTICKtuPSfjjm5nW8ikq4mqi0qe1cw0bwFmG78XT7
	HUaAptutAG3GPqQc6e00+TRpyDe29nPIcJxHTwfv2V7ZRfA/5PzXm2u4sTwq2u7x
	/ilonJIv2wkrMPGSVU+S51YXyDjhDiqhCIc0EGMppI1i49zEuIRcPMv4cfDv1eOH
	nPfhZ1Kfq9uxQltLclbDxGv5XO5ddpVLLW2o8fWd1F/NDvun8Nx3yF+GfQvkLTsE
	/q6T/5edp5qoA2Bb+g5k5AStKzuK9Mu4T7K6N//N4Wj5EAme5ROZtqj6yGimq2p7
	6Ek46B0dfKAZ1huHmYB4KiinEClLlto39Ky+9b3kmg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vc5hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 12:18:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SCIQKv001278;
	Tue, 28 Apr 2026 12:18:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq9qec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 12:18:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SCIrCd27591340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 12:18:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D01558043;
	Tue, 28 Apr 2026 12:18:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 496E258059;
	Tue, 28 Apr 2026 12:18:52 +0000 (GMT)
Received: from [9.123.2.184] (unknown [9.123.2.184])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 12:18:51 +0000 (GMT)
Message-ID: <364996ce-aba2-4213-8d20-7dd481b43fe6@linux.ibm.com>
Date: Tue, 28 Apr 2026 17:48:50 +0530
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
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: =?UTF-8?Q?=5Bmainline=5D_powerpc/TM=3A_Unexpected_TM_Bad_Thing_duri?=
 =?UTF-8?Q?ng_core_dump_on_POWER9_=287=2E1=E2=80=91rc1=29?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f0a5af cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=5KLPUuaC_9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=VnNF1IyMAAAA:8 a=5b1FnkXZSelmGUUzsP8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3XRmEqX01s88E83D_D03v24aQdYNbroG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExMyBTYWx0ZWRfXyfcjaqErZWwz
 5ugKyvnX6xJfW4xZzrIr3G0Xw2J82PcFrqU+lcjOyfYCLNq9BKPeKTEC/2y1d2Pfy5MF9etaofe
 xcgSQSWaw/6eI4Mt/iWt1jLYLsH/WTnERkX9r0MYLdPpHwpP/MDlAO+aWFNnRN6yxHtvXjctfAb
 dVkwmSjpnsuwpBBaoiuukKmdyP5oB4NM6Ez7HqzjHIHaNiynQTYMxQgyu1AEcHjJbwASqrrORgx
 fyi3TZjMnMT1E6oqAIPb3kk6/LR2yGm3pHHYEejcsvtmxELmFlOWNAnHNyu+Wa0BNonUdgqbTHY
 7j52liC3uXntWe8MbeFEn/WCzPXgKhVEc1PxQ0k6kdKyN007wNnX4kezOZWW7kOVUs77C9w5GwF
 FpQsit6BSErCqmYcwd/kbUjbaVFsm/JT23n3OSDq/WxCw1kL934bdo932C7gawpX/g58cUMpgj0
 AKSR2O+/COyNgvQQh/w==
X-Proofpoint-GUID: 3XRmEqX01s88E83D_D03v24aQdYNbroG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280113

Greetings!!

IBM CI has reported a kernel crash while running 
selftests/powerpc/signal on a POWER9 pSeries system.

I attempted to reproduce this issue manually, but was not successful so far.

Below are the details of the crash as reported by CI.

Crash Details:

[ 9798.880148] Unexpected TM Bad Thing exception at c00000000000dbac
                (msr 0x8000000302a03031) tm_scratch=800000010280b033
[ 9798.880160] Oops: Unrecoverable exception, sig: 6 [#1]
[ 9798.880165] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=8192 NUMA pSeries
[ 9798.880173] Modules linked in: nvram(E) rpadlpar_io(E) rpaphp(E) ...
[ 9798.880233] CPU: 8 UID: 0 PID: 1039530 Comm: sigfuz
                Tainted: G            E       7.1.0-rc1 #1 PREEMPT
[ 9798.880245] Hardware name: IBM,8375-42A POWER9 (architected)
                hv:phyp pSeries
[ 9798.880251] NIP:  c00000000000dbac LR: 0000000010001e58
[ 9798.880262] MSR:  8000000302a03031 <SF,VEC,VSX,FP,ME,IR,DR,LE,TM[SE]>


Call Trace:


NIP [c00000000000dbac] interrupt_return_srr_kernel+0x15c/0x18c
Call Trace:
  tm_reclaim_thread
  flush_tmregs_to_thread
  vsr_get
  regset_get_alloc
  fill_thread_core_info.isra.0
  fill_note_info
  elf_core_dump
  coredump_write
  do_coredump
  vfs_coredump
  get_signal
  do_signal
  do_notify_resume
  interrupt_exit_user_prepare_main
  interrupt_exit_user_prepare
  interrupt_return_srr_user


Please let me know if further details are required.


If you happen to fix this issue, please add below tag.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.




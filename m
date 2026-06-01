Return-Path: <linuxppc-dev+bounces-21782-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCD2CD6E56
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:16:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTSyN2HQyz2xmV;
	Mon, 01 Jun 2026 19:16:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780305404;
	cv=none; b=hi6u9gRPPTkS6aSNe9FlA3CvrGGKfiREzJFsW/7oJIHPf93p24p2Ub+pHvDQYmEUYmq9qdhDorHqMc/7+Frlc29Uv+jUsm7yGFC9T1bV17Pz5+h7eOQ4Ryy2Cauh+U6xTFnrrWZyBquPd0SSAc2dGqpJi0keBu7aWlJDVe5oWQlQsAnFVSuChOitCHz9B/Il9wUrx2i7S64G+ywv9ueBfr8xZP64Mw5HlBTbECa042q4GWOOr0qNkd2+MXdsorydHL8ZCP+U/4fXjPo+nk7TKsY+4cI+XgYPQRdWbQ4QHUl7rn2VG7P2mLWtug8kTOmUZUlSrVfrXJ1B+WzxalKv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780305404; c=relaxed/relaxed;
	bh=a/ycVyQjuAv2y1mKMPGt6QcAdh4p+/k3TfFs3Y406vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQL2aNNGFNDyGS7SFJSFF0xCoK3H2jUueK0WK+/hr+KGrkb38J9uxTDSrUe55jkB0/Glr9khpK5vI/PX3BoPwbiPE5OfKHukDud+A8y6dn5CyQ2BRe2Ai+wY8mVNqRm0T/CbkVtV/ZsXduukcVP+ZVM4se9L446TGnTOa8ROY02Z/5Toxb18thlAFyIQB9NeMiAO3AQO9jdlcxTUOLzcQp5kOQE2SR42KsrKAiVg7N49Zj9psd2cq+MebnweMjoD2n02WmachHOvJFwi4VqPquSTYOExvcjG21NxfsjE3CTMUlxhq3TXdUf4sVKejnMj+KCBYEX4l4WSBwgDT4HFmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ScfyuFFR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ScfyuFFR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTSyL6RJVz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 19:16:42 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VLGTdc085385;
	Mon, 1 Jun 2026 09:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a/ycVy
	QjuAv2y1mKMPGt6QcAdh4p+/k3TfFs3Y406vI=; b=ScfyuFFRix67Hi7vU+3oTW
	XighkrfSoc4Cju0e42t4GI8UX+H6kj0cqiiULCZ2LbmnXERw7Y3iaaTPXe6hTVLc
	Pxxdzevugomp1Zdf0d/OGlcyzAWmlmnvOT08+Ya1j5kx4X/GRdr0x48bJ+6vqljc
	hf2T7unDFXqc9igiO6+Fo0Jqm9fJ18n+V2YMMsxknkKHe1VlyXHG8lwZBRc3Tlv9
	qP1Dmy+YnxZxauNfY95xuTE4a9ghFYdtqPsjpEyz8G2UU499+CFlmq3E+LCRdMHA
	bMPvUQI77m9hsVu60xndmXv5KAfKORPfw9xV5TGdIArliovodirplXvXoiaDiXtQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpadypps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 09:16:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65199FE7015698;
	Mon, 1 Jun 2026 09:16:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvng4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 09:16:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6519GRkD50397538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 09:16:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1D8A2004B;
	Mon,  1 Jun 2026 09:16:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2225320043;
	Mon,  1 Jun 2026 09:16:25 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 09:16:24 +0000 (GMT)
Message-ID: <2f8c3d75-de2c-48bf-bd05-46b816d55c69@linux.ibm.com>
Date: Mon, 1 Jun 2026 14:46:24 +0530
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
Subject: Re: [linux-next20260529] kernel BUG at kernel/sched/core.c:7512!
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srikar Dronamraju
 <srikar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1d4def cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=MOXgsU-1MZsgqN46v8YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ckjTMxoUwkLA0CuP0bdespoYdhlwuX4l
X-Proofpoint-ORIG-GUID: upWfRYD4QUYHq4eldDYmwbKhho2zQjNJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5MSBTYWx0ZWRfXyDCIjMjnzxdH
 gTP7/OF/7KT6EIyUSVSx7DQSnFVWX3HqBKEng2AgLQCw5rsktpowNbiLg7TU7awM2UYwxltRcqg
 5m1T8DrQrNUNPRCCkSnzTeTpbtU/1ZnbHPlE3dyvgg5X92RXqqROZd0BYBRliFHydlJteLjhmQo
 nLj72HuqQD2FtoZtZVuN7atUAX4yBRTXagVvCakr+J4MuC4U9O+vPWr5VpDkfFndfCEi4lrRqAm
 eBji08L187kEMi/9Y1Mh8Vm30Dhn8Sq3kYjY3QOhS42aiCOdFGxi4C4AMhFOaKYznb7fWRiwdWw
 mUja0Mm5ou7iNMCoBuXWazohFAX27l+Vi2R7MqUuSCBTfXOsB29Ex2MzJqtxKwDGFHcdWR0SFz9
 j1QwIvKSRCEc8juTVJoZ6HKLhQ6ZMQYQLHz/qBfnAStn8Ua6Nc+NBJ4Qipbk0oMnQrPxDfzVSWu
 4J8RB+zxbF0syEz0yPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010091

Hi Venkat. Thanks for the report.

+ mukesh, ritesh

On 6/1/26 12:11 PM, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> 
> I hit a kernel BUG on a linux-next kernel running on ppc64le (Power11 
> LPAR). The issue was observed once in CI (Avocado tests) and I haven’t 
> been able to reproduce it reliably yet.
> 

Can you run with lockdep and see if you can hit it?

> Architecture: ppc64le (Power11, pSeries)
> Kernel: 7.1.0-rc5-next-20260529
> Config: PREEMPT(lazy)
> CPUs: large system (NR_CPUS=8192)
> 

This is with GENERIC_ENTRY.

> 
> So far, I have not reproduced the crash, but I am trying to stress 
> similar conditions using:
> 
> parallel read workloads (fio / dd)
> memory pressure
> 
> 
> Traces:
> 
>   (5/8) /home/upstreamci/avocado-fvt-wrapper/tests/avocado-misc-tests/ 
> cpu/ppc64_cpu_test.py:PPC64Test.test_smt_loop;run-run_type- 
> upstream-9cfe: STARTED
> [ 1885.176400] crash hp: kexec_trylock() failed, kdump image may be 
> inaccurate
> [ 1885.296164] crash hp: kexec_trylock() failed, kdump image may be 
> inaccurate
> [ 1885.386120] crash hp: kexec_trylock() failed, kdump image may be 
> inaccurate
> [ 1885.556134] crash hp: kexec_trylock() failed, kdump image may be 
> inaccurate
> [ 1886.576119] crash hp: kexec_trylock() failed, kdump image may be 
> inaccurate
> [ 1886.806060] crash hp: kexec_trylock() failed, kdump image may be 
> inaccurate
> [ 1887.026051] crash hp: kexec_trylock() failed, kdump image may be 
> inaccurate
> [ 1887.456075] ------------[ cut here ]------------
> [ 1887.456101] kernel BUG at kernel/sched/core.c:7512!
> [ 1887.456107] Oops: Exception in kernel mode, sig: 5 [#1]
> [ 1887.456111] LE PAGE_SIZE=4K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> [ 1887.456116] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 
> nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bonding 
> tls ip_set rfkill nf_tables fsdev_dax kmem device_dax pseries_rng 
> vmx_crypto dax_pmem fuse ext4 crc16 mbcache jbd2 sd_mod nd_pmem papr_scm 
> sg libnvdimm ibmvscsi ibmveth scsi_transport_srp pseries_wdt
> [ 1887.456173] CPU: 28 UID: 0 PID: 85305 Comm: kexec Not tainted 7.1.0- 
> rc5-next-20260529 #1 PREEMPT(lazy)
> [ 1887.456180] Hardware name: IBM,9080-HEX Power11 (architected) 
> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [ 1887.456185] NIP:  c0000000013a8e8c LR: c0000000003483bc CTR: 
> 0000000000000000
> [ 1887.456190] REGS: c000000069f03070 TRAP: 0700   Not tainted (7.1.0- 
> rc5-next-20260529)
> [ 1887.456195] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
> 24428222  XER: 0000005a
> [ 1887.456208] CFAR: c0000000003483b8 IRQMASK: 0
> [ 1887.456208] GPR00: c0000000003483bc c000000069f03330 c000000001a82100 
> c000000069f033e0
> [ 1887.456208] GPR04: 0000000000000000 0000000000000001 0000000000000001 
> c000000006dd3b00
> [ 1887.456208] GPR08: ffffffffffffff00 0000000000000001 0000000000000000 
> 0000000024428220
> [ 1887.456208] GPR12: 0000000000000300 c000000effdbef00 0000000000000000 
> 0000000000000000
> [ 1887.456208] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 1887.456208] GPR20: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 1887.456208] GPR24: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 1887.456208] GPR28: 0000000000000000 0000000000000000 0000000000000000 
> c000000069f033e0
> [ 1887.456265] NIP [c0000000013a8e8c] preempt_schedule_irq+0x44/0x118
> [ 1887.456274] LR [c0000000003483bc] 
> dynamic_irqentry_exit_cond_resched+0x40/0x1a4
> [ 1887.456282] Call Trace:
> [ 1887.456284] [c000000069f03360] [c0000000003483bc] 
> dynamic_irqentry_exit_cond_resched+0x40/0x1a4
> [ 1887.456291] [c000000069f03380] [c00000000014f3bc] 
> do_page_fault+0xc0/0x104
> [ 1887.456298] [c000000069f033b0] [c000000000008be0] 
> data_access_common_virt+0x210/0x220
> [ 1887.456306] ---- interrupt: 300 at __copy_tofrom_user_base+0xac/0x5a4
> [ 1887.456313] NIP:  c00000000017fc38 LR: c000000000aaa684 CTR: 
> 0000000000000000
> [ 1887.456317] REGS: c000000069f033e0 TRAP: 0300   Not tainted (7.1.0- 
> rc5-next-20260529)
> [ 1887.456322] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
> 24428220  XER: 2004005a
> [ 1887.456334] CFAR: c00000000017fc34 DAR: 00003fff879a8000 DSISR: 
> 42000000 IRQMASK: 0
> [ 1887.456334] GPR00: 0000000000000000 c000000069f036a0 c000000001a82100 
> 00003fff879a8000
> [ 1887.456334] GPR04: c0000000bb314ff0 0000000000001000 69f0000606480600 
> 0200c4080368f028
> [ 1887.456334] GPR08: 09036af00005d9c4 0600000200e80803 0000000000000000 
> 0000000000000030
> [ 1887.456334] GPR12: 0000000000000040 c000000effdbef00 0000000000000000 
> 000000000000000e
> [ 1887.456334] GPR16: 0000000004a00000 000000000000001f c000000069f038a0 
> c00000006e73e500
> [ 1887.456334] GPR20: c00000006f0ff6a8 0000000000000000 c00000006f0ff540 
> 0000000000000001
> [ 1887.456334] GPR24: 000000001816ce60 c0000000bb314000 c000000002e48730 
> c000000069f03a30
> [ 1887.456334] GPR28: c0000000bb314000 00003fff879a7010 0000000000000010 
> 0000000000001000
> [ 1887.456393] NIP [c00000000017fc38] __copy_tofrom_user_base+0xac/0x5a4
> [ 1887.456399] LR [c000000000aaa684] raw_copy_to_user+0x12c/0x314
> [ 1887.456405] ---- interrupt: 300
> [ 1887.456408] [c000000069f036a0] [c000000000aaa5f4] 
> raw_copy_to_user+0x9c/0x314 (unreliable)
> [ 1887.456416] [c000000069f036e0] [c000000000aacd08] 
> _copy_to_iter+0xe4/0x79c
> [ 1887.456423] [c000000069f037a0] [c000000000ab01ec] 
> copy_page_to_iter+0xd4/0x1a4
> [ 1887.456429] [c000000069f037f0] [c0000000005ddc34] 
> filemap_read+0x420/0x4f0
> [ 1887.456436] [c000000069f039c0] [c0080000043443e0] 
> ext4_file_read_iter+0x78/0x31c [ext4]
> [ 1887.456517] [c000000069f03a10] [c000000000796498] vfs_read+0x2a8/0x3c8
> [ 1887.456524] [c000000069f03ac0] [c00000000079726c] ksys_read+0x88/0x140
> [ 1887.456530] [c000000069f03b10] [c000000000032f98] 
> system_call_exception+0x198/0x4e0
> [ 1887.456537] [c000000069f03e30] [c00000000000d05c] 
> system_call_vectored_common+0x15c/0x2ec
> [ 1887.456544] ---- interrupt: 3000 at 0x3fff9b133cf4
> [ 1887.456549] NIP:  00003fff9b133cf4 LR: 00003fff9b133cf4 CTR: 
> 0000000000000000
> [ 1887.456554] REGS: c000000069f03e60 TRAP: 3000   Not tainted (7.1.0- 
> rc5-next-20260529)
> [ 1887.456558] MSR:  800000000000f033 <SF,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 
> 44424402  XER: 00000000
> [ 1887.456572] IRQMASK: 0
> [ 1887.456572] GPR00: 0000000000000003 00003fffe5fb4190 0000000105087f00 
> 0000000000000003
> [ 1887.456572] GPR04: 00003fff82e93010 000000001816ce60 0000000000000022 
> 0000000000000000
> [ 1887.456572] GPR08: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 1887.456572] GPR12: 0000000000000000 00003fff9b4cd860 000000010507f588 
> 0000000000000000
> [ 1887.456572] GPR16: ffffffffffffffff 0000000000000000 0000000000000006 
> 0000000000000000
> [ 1887.456572] GPR20: 0000000000000001 00003fff9b23039c 00003fff9b2303a0 
> 00003fffe5fb5ee7
> [ 1887.456572] GPR24: 0000000000000000 0000000000000000 00003fffe5fb5ee7 
> 00003fffe5fb42d0
> [ 1887.456572] GPR28: 0000000000000003 00003fff82e93010 000000001816ce60 
> 0000000000000000
> [ 1887.456626] NIP [00003fff9b133cf4] 0x3fff9b133cf4
> [ 1887.456630] LR [00003fff9b133cf4] 0x3fff9b133cf4
> [ 1887.456634] ---- interrupt: 3000
> [ 1887.456637] Code: fbe1fff8 e92d0128 f8010010 f821ffd1 81490000 
> 39200001 2c0a0000 40820014 892d0152 552907fe 7d290034 5529d97e 
> <0b090000> 60000000 3bc00000 ebed0128
> [ 1887.456657] ---[ end trace 0000000000000000 ]---
> 
> 
> If you happen to fix this, please add below tag.
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> 

Ritesh, Mukesh, Is below possible scenario?

do_page_fault seems to enable irq's in the interrupt handler?
is that expected? if so, one might see

-- do_page_fault (enter kernel mode)
    -- enables interrupts
    -- gets interrupt - Sets need_resched.
       -- irqentry_exit - Sees it is kernel mode. Just checks preempt count
			 and calls preempt_schedule_irq, which catches both
			 preempt_count and !irqs_disabled. Hence the panic?

Should do_page_fault do preempt_disable when it enables the interrupts?


Return-Path: <linuxppc-dev+bounces-21775-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D75CD6E4C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 06:41:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTPWg3Wtdz2yRG;
	Mon, 01 Jun 2026 16:41:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780296111;
	cv=none; b=AcBj/zFJ9z+JlMzNVPPPTDKS6TLrY4Y+MyVmXTsbLmk3Fspq26DwRei+2ecankYK0gl2C8xvfBW+bmjneOwPRTl4NHG7AgMrfbXJSWZZGS5xpE+J3rAMwZ+dXV6NCmLyM5m5nEdE+cHIl+gsamToX8bEeMQgCGa5saCxRE4vAr5djSc86YTH43Ji75Iuw/XYDyknyaFvwjWTi11fPheDn4ksSwq7d6C5y44U2WrfigY7+TlvpS9vbtEfhJyTQMqLWxO4zxAt8S5qK+ADrn7HLBMLNDjblsCIsAzO+cmeqMcEQZT6bQ4OcgqF9MndFZuNgC8qrMtHhrkh38Srwc25RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780296111; c=relaxed/relaxed;
	bh=rLZYyhorBa6/BWrdpzhAXnHPpZ2aAokD2Uye6As/2Rg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=aNXt+B+C518Mz8rrOg1I516BiCmydHhcnHd2jtB2PHrEhnlGFyQOmmKI3B80y+WoMZFAcJe7ZFobm8ndBkF49shnPzqNkH3St05MD0VOyIYx9NdgPUrBDgYdOZKsptlm/YWA5usnfreT9Sb7/al5xXCHC3HT0ImHRcZfGuhxkG6iCZP71Y5NJh7eF1YkypwBiGKCbQzGgdpyMzPeEXzQStMXekE/QwpZJ0/aIawmYpU4I4OJQSNb0ARqSWli54TTVK79ClneLKnE6+IBTtQbQ71NztnwhIkiV2B0XSSqGb6IPespzYvr5FkgaCYOAtKsPa6IGP1sOb6kYEWp5H96vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MfRsN5cQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MfRsN5cQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTPWf5fwrz2xMW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 16:41:50 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6512hsKI1957750;
	Mon, 1 Jun 2026 06:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=rLZYyhorBa6/BWrdpzhAXnHPpZ2a
	AokD2Uye6As/2Rg=; b=MfRsN5cQSOF66Un3VLGjiO6Cp4YdSHj9TiyxofuFJj5n
	H+UW2fkencgBQdCuemAhiya5bOe9Dc8BabVNmAAOWNcwc923nW5FU57kE/Yfr1gR
	UlFBfOyji/rRhZdKNvhonYN0cGcfKfrBkWD+ZpVXFk4T0UozuRkEwHg6VeOM+wh0
	g509eXiDP4zAbVNNAn7XPJ8Akanp7p91atEp9EvdquBLmrdUIjVmiIOEMaS1lBr9
	R5rwCeKR59m5wBJFD6JIWE5PlrpwAOODpD/boPaMTY+OM8XgtlCkRK9RqjAFxqqh
	7zFMJ1B5MrPpU9C+JxxJyJ7IvP9lKsJYbSXEd4aUNw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4q92e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 06:41:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6516dRuB008026;
	Mon, 1 Jun 2026 06:41:40 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqh4nwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 06:41:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6516fdGe29295156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 06:41:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AA0B58052;
	Mon,  1 Jun 2026 06:41:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B41658045;
	Mon,  1 Jun 2026 06:41:37 +0000 (GMT)
Received: from [9.61.253.231] (unknown [9.61.253.231])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 06:41:36 +0000 (GMT)
Message-ID: <7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com>
Date: Mon, 1 Jun 2026 12:11:35 +0530
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
To: Peter Zijlstra <peterz@infradead.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [linux-next20260529] kernel BUG at kernel/sched/core.c:7512!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: otx7JFqF4fqSkFEeQJynhFCCsmC2hxzu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA2NCBTYWx0ZWRfX5dBN7iA/4Xbo
 TQUinhcKAYoclPOBZbCnh5aXnWaE5iLAvjr1zmD7eU8vaImjx8bBEmJkLeBhiq2SWLorjOOlVFy
 LAj9cVa1DqTPCHuDt2uNSZedyAfVKMKtP5Qn/cGnptq0WefmNIt2votvOLiZIi4KkvYUsWhGUKQ
 dHyNOHQGu1/6HFM4zccpp3QMapPQHRf2keuFpPdvKXGLWeS/IhlI4A4ybNLiTvlhJGQImScAJtC
 PUpWz5IPLNCjJwX+UpuhHt4cAu0NGyxDAbAYEH/jDfhAfQL+Kxv04ppVDMJaRznIhGLfBrb9r4T
 buhC+7CAOEyJfMJ2rEY07b8BD57M/GOml5OZkx2vDoXNwT4gRJOJu4g4QEqYnipxyLOpnQycGEU
 ODDfiKHPHHQGT1zJBIUNbH6f/cra7U8m0VGMfFy0afZI7CCoq9cuOBWECgOAQSaRmQIXhUGupxt
 E2VFn7uotZDn21ZBhnw==
X-Proofpoint-ORIG-GUID: otx7JFqF4fqSkFEeQJynhFCCsmC2hxzu
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1d29a5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=3UE5MhFMSRA6oSl8e3oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010064

Greetings!!!


I hit a kernel BUG on a linux-next kernel running on ppc64le (Power11 
LPAR). The issue was observed once in CI (Avocado tests) and I haven’t 
been able to reproduce it reliably yet.

Architecture: ppc64le (Power11, pSeries)
Kernel: 7.1.0-rc5-next-20260529
Config: PREEMPT(lazy)
CPUs: large system (NR_CPUS=8192)


So far, I have not reproduced the crash, but I am trying to stress 
similar conditions using:

parallel read workloads (fio / dd)
memory pressure


Traces:

  (5/8) 
/home/upstreamci/avocado-fvt-wrapper/tests/avocado-misc-tests/cpu/ppc64_cpu_test.py:PPC64Test.test_smt_loop;run-run_type-upstream-9cfe: 
STARTED
[ 1885.176400] crash hp: kexec_trylock() failed, kdump image may be 
inaccurate
[ 1885.296164] crash hp: kexec_trylock() failed, kdump image may be 
inaccurate
[ 1885.386120] crash hp: kexec_trylock() failed, kdump image may be 
inaccurate
[ 1885.556134] crash hp: kexec_trylock() failed, kdump image may be 
inaccurate
[ 1886.576119] crash hp: kexec_trylock() failed, kdump image may be 
inaccurate
[ 1886.806060] crash hp: kexec_trylock() failed, kdump image may be 
inaccurate
[ 1887.026051] crash hp: kexec_trylock() failed, kdump image may be 
inaccurate
[ 1887.456075] ------------[ cut here ]------------
[ 1887.456101] kernel BUG at kernel/sched/core.c:7512!
[ 1887.456107] Oops: Exception in kernel mode, sig: 5 [#1]
[ 1887.456111] LE PAGE_SIZE=4K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[ 1887.456116] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bonding 
tls ip_set rfkill nf_tables fsdev_dax kmem device_dax pseries_rng 
vmx_crypto dax_pmem fuse ext4 crc16 mbcache jbd2 sd_mod nd_pmem papr_scm 
sg libnvdimm ibmvscsi ibmveth scsi_transport_srp pseries_wdt
[ 1887.456173] CPU: 28 UID: 0 PID: 85305 Comm: kexec Not tainted 
7.1.0-rc5-next-20260529 #1 PREEMPT(lazy)
[ 1887.456180] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[ 1887.456185] NIP:  c0000000013a8e8c LR: c0000000003483bc CTR: 
0000000000000000
[ 1887.456190] REGS: c000000069f03070 TRAP: 0700   Not tainted 
(7.1.0-rc5-next-20260529)
[ 1887.456195] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
24428222  XER: 0000005a
[ 1887.456208] CFAR: c0000000003483b8 IRQMASK: 0
[ 1887.456208] GPR00: c0000000003483bc c000000069f03330 c000000001a82100 
c000000069f033e0
[ 1887.456208] GPR04: 0000000000000000 0000000000000001 0000000000000001 
c000000006dd3b00
[ 1887.456208] GPR08: ffffffffffffff00 0000000000000001 0000000000000000 
0000000024428220
[ 1887.456208] GPR12: 0000000000000300 c000000effdbef00 0000000000000000 
0000000000000000
[ 1887.456208] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1887.456208] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1887.456208] GPR24: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1887.456208] GPR28: 0000000000000000 0000000000000000 0000000000000000 
c000000069f033e0
[ 1887.456265] NIP [c0000000013a8e8c] preempt_schedule_irq+0x44/0x118
[ 1887.456274] LR [c0000000003483bc] 
dynamic_irqentry_exit_cond_resched+0x40/0x1a4
[ 1887.456282] Call Trace:
[ 1887.456284] [c000000069f03360] [c0000000003483bc] 
dynamic_irqentry_exit_cond_resched+0x40/0x1a4
[ 1887.456291] [c000000069f03380] [c00000000014f3bc] 
do_page_fault+0xc0/0x104
[ 1887.456298] [c000000069f033b0] [c000000000008be0] 
data_access_common_virt+0x210/0x220
[ 1887.456306] ---- interrupt: 300 at __copy_tofrom_user_base+0xac/0x5a4
[ 1887.456313] NIP:  c00000000017fc38 LR: c000000000aaa684 CTR: 
0000000000000000
[ 1887.456317] REGS: c000000069f033e0 TRAP: 0300   Not tainted 
(7.1.0-rc5-next-20260529)
[ 1887.456322] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
24428220  XER: 2004005a
[ 1887.456334] CFAR: c00000000017fc34 DAR: 00003fff879a8000 DSISR: 
42000000 IRQMASK: 0
[ 1887.456334] GPR00: 0000000000000000 c000000069f036a0 c000000001a82100 
00003fff879a8000
[ 1887.456334] GPR04: c0000000bb314ff0 0000000000001000 69f0000606480600 
0200c4080368f028
[ 1887.456334] GPR08: 09036af00005d9c4 0600000200e80803 0000000000000000 
0000000000000030
[ 1887.456334] GPR12: 0000000000000040 c000000effdbef00 0000000000000000 
000000000000000e
[ 1887.456334] GPR16: 0000000004a00000 000000000000001f c000000069f038a0 
c00000006e73e500
[ 1887.456334] GPR20: c00000006f0ff6a8 0000000000000000 c00000006f0ff540 
0000000000000001
[ 1887.456334] GPR24: 000000001816ce60 c0000000bb314000 c000000002e48730 
c000000069f03a30
[ 1887.456334] GPR28: c0000000bb314000 00003fff879a7010 0000000000000010 
0000000000001000
[ 1887.456393] NIP [c00000000017fc38] __copy_tofrom_user_base+0xac/0x5a4
[ 1887.456399] LR [c000000000aaa684] raw_copy_to_user+0x12c/0x314
[ 1887.456405] ---- interrupt: 300
[ 1887.456408] [c000000069f036a0] [c000000000aaa5f4] 
raw_copy_to_user+0x9c/0x314 (unreliable)
[ 1887.456416] [c000000069f036e0] [c000000000aacd08] 
_copy_to_iter+0xe4/0x79c
[ 1887.456423] [c000000069f037a0] [c000000000ab01ec] 
copy_page_to_iter+0xd4/0x1a4
[ 1887.456429] [c000000069f037f0] [c0000000005ddc34] 
filemap_read+0x420/0x4f0
[ 1887.456436] [c000000069f039c0] [c0080000043443e0] 
ext4_file_read_iter+0x78/0x31c [ext4]
[ 1887.456517] [c000000069f03a10] [c000000000796498] vfs_read+0x2a8/0x3c8
[ 1887.456524] [c000000069f03ac0] [c00000000079726c] ksys_read+0x88/0x140
[ 1887.456530] [c000000069f03b10] [c000000000032f98] 
system_call_exception+0x198/0x4e0
[ 1887.456537] [c000000069f03e30] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[ 1887.456544] ---- interrupt: 3000 at 0x3fff9b133cf4
[ 1887.456549] NIP:  00003fff9b133cf4 LR: 00003fff9b133cf4 CTR: 
0000000000000000
[ 1887.456554] REGS: c000000069f03e60 TRAP: 3000   Not tainted 
(7.1.0-rc5-next-20260529)
[ 1887.456558] MSR:  800000000000f033 <SF,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 
44424402  XER: 00000000
[ 1887.456572] IRQMASK: 0
[ 1887.456572] GPR00: 0000000000000003 00003fffe5fb4190 0000000105087f00 
0000000000000003
[ 1887.456572] GPR04: 00003fff82e93010 000000001816ce60 0000000000000022 
0000000000000000
[ 1887.456572] GPR08: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1887.456572] GPR12: 0000000000000000 00003fff9b4cd860 000000010507f588 
0000000000000000
[ 1887.456572] GPR16: ffffffffffffffff 0000000000000000 0000000000000006 
0000000000000000
[ 1887.456572] GPR20: 0000000000000001 00003fff9b23039c 00003fff9b2303a0 
00003fffe5fb5ee7
[ 1887.456572] GPR24: 0000000000000000 0000000000000000 00003fffe5fb5ee7 
00003fffe5fb42d0
[ 1887.456572] GPR28: 0000000000000003 00003fff82e93010 000000001816ce60 
0000000000000000
[ 1887.456626] NIP [00003fff9b133cf4] 0x3fff9b133cf4
[ 1887.456630] LR [00003fff9b133cf4] 0x3fff9b133cf4
[ 1887.456634] ---- interrupt: 3000
[ 1887.456637] Code: fbe1fff8 e92d0128 f8010010 f821ffd1 81490000 
39200001 2c0a0000 40820014 892d0152 552907fe 7d290034 5529d97e 
<0b090000> 60000000 3bc00000 ebed0128
[ 1887.456657] ---[ end trace 0000000000000000 ]---


If you happen to fix this, please add below tag.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.




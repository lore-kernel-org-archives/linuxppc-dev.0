Return-Path: <linuxppc-dev+bounces-28201-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097B0C9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 12:44:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrr4X0Y9lz2yNj;
	Fri, 25 Sep 2026 22:44:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790340267;
	cv=none; b=M09kvcfCR6SSusOJxnCvv+ivNIFH9+WSNE49lVY/CIAiXNKHmwT1bTzAj/jf8kUdlj7f53c2xHOfVnDsEDRjWxqLJfaTw9/UoSMGTsrLqyn41ga67jGv3Pojql7j9ZJ1G5y7YFeleyp1zGrfobId7ONOnET01zo1g7cbK2cKxKdCjnkFJ1Wi+nmq9BRqslP8hrGymcmRKNjIdjsHa9CH4ka0XqGWc+mEoZxJEolQ5/EqsRudT1GH3wq6bCWbV86qq7m6rNcQsHxw1Nvp27ABE4epqZI6Bs1NhFH/Ky65BWi4PBsMDNDyUGS1UUzvyfoz0eiTtKrX6btJ2C5hMQWJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790340267; c=relaxed/relaxed;
	bh=lT/k0sKxE8GBOsNbHUIeaxf5Hwkliwvprm7cekuocYs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=I+TT9i5IBMnmY8OP16WW5ruYxsmmGRCf2DSQU/G6YR/VbjEcqnJA8ZXtNblJ7qICgF8Th2/3KFAn/EUQXgHb9u59pl88UfzfjIb7yBD3Er6GMnLy9bHxO8MZ7TspGraDbtrzUhQPZ+gZ7z9bGcBoldd6E5YlD1bedtwBLpnh1fXBCbx6qyoj9zTTkfRA0y+jlK3qYA5xFljjWI4N+nTw4vjuyRWZCJQbAA7gbi0PmKetwGBqOs7nF3UAXdIwr8GjEkLaVM1k7BI2ixumFkUB5QvEjGr8GZDlomzLv0Sic0YQKl4jDz9rL1RgQ3F423E7BkETIW+RJlvcd70XzgD+4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WDqDZPT4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WDqDZPT4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrr4V6cMFz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 22:44:26 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4Zmpm060711;
	Fri, 25 Sep 2026 12:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=lT/k0sKxE8GBOsNbHUIeaxf5Hwkl
	iwvprm7cekuocYs=; b=WDqDZPT4HbJ5h1qimvsdG1dcaJwBSNmEjKyQfZUcStUq
	yAH+F4TicuFXRd31nlmhlybegVDGfaJqJY5/7Y5tpFMiseOo2KPSMBLyfhb54V8h
	ZNoPYu+lLagaEvDkmSFrcF+lBp2YQGae+TCSTgmlbt26NYcrcgwH1hsCfHjPqo5k
	4iV3krfuhCz/U+1F8AYK4ryW5mwxo1DG9ywEcA7+7dqzXPaKRRPT5RvPpvZazEBi
	J6I7LlYUbwA/S6cXlC0LStl2QT10Evw2LMwxWQG61ogq8HUbCUoNbYkOurq6qBtX
	/lVk6VzU0V+a5kF0HywxLehG+EpYoOFGmlGZDAzbxg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsq03a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:44:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P9m6BJ3248950;
	Fri, 25 Sep 2026 12:44:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt32ake-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:44:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PCiHUe63439192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:44:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D6195803F;
	Fri, 25 Sep 2026 12:44:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8274758056;
	Fri, 25 Sep 2026 12:44:14 +0000 (GMT)
Received: from [9.61.242.145] (unknown [9.61.242.145])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 12:44:14 +0000 (GMT)
Message-ID: <be5b088c-f866-4c7e-9f6e-2898ca2dee82@linux.ibm.com>
Date: Fri, 25 Sep 2026 18:14:12 +0530
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
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, nandinih@linux.ibm.com
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [linux-next20260923] powerpc/TM: Unexpected TM Bad Thing exception
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab66ca4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=H_bSzb3YpO_zdF-jonAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rAr8QZnyEc9iwmA5aXd27tFH_YNqrVCC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfX+26CwAqGwlFI
 SoGAVnzHW60YSfHnVvyGxixPhzgSRapp5ig0AEWMCr1uQoTiAM6iczzjfStdEy53iBu38Ioj8Wd
 VxungLo4gwzWZqfUaIknTb0EZ3btIbYocyJCN235s6dMgrAVK8mMUyHCbx6w7Ohkm1AbCMpQ9qv
 xcncAzLIDXadYEE1Tq9qp8ZwwEwvsaa5AcZTLsV+JzDdMRTn/GN3PZTyPRJ2bwzquH45k9z8mao
 u3oKJMykRIMPmu901KGUKgdjxzrOE3UuyHguudjL/41jGeVD/FijEcwNwr0YqLPuPptU69k7pMW
 pdMBtilPFlA6J7d5Ghm9GVZivfjsk57trTJ7BkePP7NLUkpjN/wfVTvn7ugheg71wfJpjs7wwqc
 CUyrPh8FNi/146hbHeg/DcnEyHnncyJO2ySRhQE3I61KY3grORcEJDsT6NHXi2N6RpozOEvlo6w
 FqEKuSafXoAblivIc3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfXz6HuXBD2JyuX
 wZHK85o3XLTBY8xkMs4Jyu0JF27P2ZyTa37w/6LObflFSqlCDrjCCY442PBCz8R5RPeXtG/oRf8
 rq6HAUtyNbl7JhxtsUayG5r8ypmP7ms=
X-Proofpoint-GUID: rAr8QZnyEc9iwmA5aXd27tFH_YNqrVCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250050

Hello All,

IBM CI has reported following bug on Power9 pseries lpar, while running 
powerpc/signal selftest.

This issue is reported on linux-next tree.



Traces:

[ 2111.590537] Unexpected TM Bad Thing exception at c00000000000dbac 
(msr 0x8000000302a03031) tm_scratch=800000010280b033
[ 2111.590582] Oops: Unrecoverable exception, sig: 6 [#1]
[ 2111.590592] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=8192 NUMA pSeries
[ 2111.590606] Modules linked in: bonding(E) tls(E) rfkill(E) 
nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) 
nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) 
nft_ct(E) nft_chain_nat(E) hvcs(E) hvcserver(E) pseries_rng(E) 
vmx_crypto(E) sg(E) drm(E) fuse(E) drm_panel_orientation_quirks(E) 
xfs(E) nvme_tcp(E) nvme_fabrics(E) nvme_core(E) sr_mod(E) sd_mod(E) 
cdrom(E) ibmvscsi(E) ibmveth(E) scsi_transport_srp(E) dm_mirror(E) 
dm_region_hash(E) dm_log(E) dm_mod(E)
[ 2111.590749] CPU: 17 UID: 0 PID: 994879 Comm: sigfuz Tainted: G       
     E        7.3.0-rc4-next-20260923 #1 PREEMPT
[ 2111.590764] Tainted: [E]=UNSIGNED_MODULE
[ 2111.590771] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
[ 2111.590783] NIP:  c00000000000dbac LR: c0000000007239b4 CTR: 
c0000000007237f0
[ 2111.590793] REGS: c00000002e6d7d60 TRAP: 0700   Tainted: G       E    
      (7.3.0-rc4-next-20260923)
[ 2111.590803] MSR:  8000000302a03031 
<SF,VEC,VSX,FP,ME,IR,DR,LE,TM[SE]>  CR: 88004445  XER: 000000cd
[ 2111.590846] CFAR: c00000000000da68 IRQMASK: 0
[ 2111.590846] PACATMSCRATCH: 800000010280b033
[ 2111.590846] GPR00: c000000000723c1c c000000039a8f410 c00000000212b200 
0000000000500cc2
[ 2111.590846] GPR04: c000000004082c60 ffffffffffffffff c000000039a8f47c 
0000000000000000
[ 2111.590846] GPR08: c000000004082c60 c0000000007237f0 c000000000723780 
6c2f7273752f006f
[ 2111.590846] GPR12: c0000000007b1310 c00000002e99b300 0000000000000000 
0000000000000000
[ 2111.590846] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000003
[ 2111.590846] GPR20: 0000000000000003 0000000000000040 0000000000010000 
c000000039a8f800
[ 2111.590846] GPR24: 0000000000000000 0000000000000040 c00000029fa7de00 
c0000000471cd700
[ 2111.590846] GPR28: 0000000000500cc2 c000000039a8f47c 0000000000000000 
c000000004082c60
[ 2111.590981] NIP [c00000000000dbac] 
interrupt_return_srr_kernel+0x15c/0x18c
[ 2111.591005] LR [c0000000007239b4] alloc_pages_mpol+0x54/0x260
[ 2111.591030] Call Trace:
[ 2111.591037] [c000000039a8f450] [c000000193f76f00] 0xc000000193f76f00
[ 2111.591053] [c000000039a8f4b0] [c000000000723c1c] 
alloc_pages_noprof+0x5c/0xf0
[ 2111.591070] [c000000039a8f4d0] [c0000000007b118c] 
anon_pipe_prefill_and_lock+0x8c/0x210
[ 2111.591086] [c000000039a8f570] [c0000000007b138c] 
anon_pipe_write+0x7c/0x810
[ 2111.591099] [c000000039a8f640] [c00000000079f138] 
__kernel_write_iter+0x128/0x300
[ 2111.591114] [c000000039a8f6c0] [c000000000874638] __dump_emit+0x128/0x250
[ 2111.591130] [c000000039a8f7a0] [c00000000086aa44] 
elf_core_dump+0x244/0x5c0
[ 2111.591145] [c000000039a8f9b0] [c000000000874b50] 
coredump_write+0xd0/0x470
[ 2111.591160] [c000000039a8fa40] [c000000000874fb0] 
do_coredump.constprop.0+0xc0/0x4e0
[ 2111.591175] [c000000039a8fb20] [c000000000875580] 
vfs_coredump+0x1b0/0x300
[ 2111.591188] [c000000039a8fc30] [c000000000256408] get_signal+0x918/0xad0
[ 2111.591209] [c000000039a8fd20] [c000000000021d48] do_signal+0x78/0x330
[ 2111.591226] [c000000039a8fdc0] [c0000000015125a8] 
irqentry_exit+0x358/0x990
[ 2111.591240] [c000000039a8fe20] [c00000000002f714] 
program_check_exception+0xd4/0x100
[ 2111.591253] [c000000039a8fe50] [c000000000009b2c] 
program_check_common_virt+0x3bc/0x3c0
[ 2111.591267] ---- interrupt: 700 at 0x10001e8c
[ 2111.591276] NIP:  0000000010001e8c LR: 0000000010001e74 CTR: 
00007fffb4400590
[ 2111.591286] REGS: c000000039a8fe80 TRAP: 0700   Tainted: G       E    
      (7.3.0-rc4-next-20260923)
[ 2111.591296] MSR:  8000000302a0f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE,TM[SE]>  CR: 22004442 XER: 000000cd
[ 2111.591337] CFAR: 00007fffb44005bc IRQMASK: 0
[ 2111.591337] PACATMSCRATCH: 800000010280b033
[ 2111.591337] GPR00: 0000000010001e74 00007fffb43ad3c0 0000000010027f00 
00000000415e6618
[ 2111.591337] GPR04: 00007fffb43ad384 00007fffb45f004c 00007fffb45f0090 
00007fffb45f0048
[ 2111.591337] GPR08: 0000000082bccc31 00000000415e6618 0000000000000000 
00000000415e6618
[ 2111.591337] GPR12: 00007fffb4400590 00007fffb43b68e0 0000000000000000 
00007fffb43af1e0
[ 2111.591337] GPR16: 0000000000000000 00007fffb43af8e0 0000000000000720 
0000000000000000
[ 2111.591337] GPR20: 0000000000000000 00007fffb46f0000 000000000080e9e0 
00007fffb3ba0000
[ 2111.591337] GPR24: 0000000000000001 00007fffd8d5ecb0 0000000000000000 
00007fffb43ae8f8
[ 2111.591337] GPR28: 000000000000000a 0000000000000000 00000000100201bc 
00000000000f2e3f
[ 2111.591475] NIP [0000000010001e8c] 0x10001e8c
[ 2111.591484] LR [0000000010001e74] 0x10001e74
[ 2111.591492] ---- interrupt: 700
[ 2111.591499] Code: 7c8903a6 7ca103a6 f8010020 e8410040 e8610048 
e8810050 e8a10058 40c6001c 7ccff120 e8c10060 e8010030 e8210038 
<4c000024> 48000000 7ccff120 f92d0080
[ 2111.591549] ---[ end trace 0000000000000000 ]---


If you happen to fix this issue please add below tag.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.




Return-Path: <linuxppc-dev+bounces-28205-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CFDC98321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 14:35:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrtY7596wz2yQl;
	Sat, 26 Sep 2026 00:35:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790346955;
	cv=none; b=eIl2DF7L1QTH5WE0RdwiiV4InI8XBgmXZqb2QUQ9n5Wix7l3P5pwM5z0lVH/FcrGK2341P843DOfePrhefS9hh/ApgfOe1xxOPfMUDZKBUDKnuT9o3/BQfVy+MksfWoO44FBUUqXdeBZT0r9b119c4/uj0PRHQUURqtUVE2RgpaFYGuvYPAGEWBrVhgB+Jn07QSNOJFhKYnX1aCFdeqjULSZ2brxDxzM3qFI86QihIYiKnaEph5Xn4phjkJirFRlq1d/p74Q7gOkS6ZfSrWteQoLzUanBu4WHssdWcyc9m5RUVY7VmvLF+WE6YI4CNMnY7S4qXId8UOzKAWwMaxisw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790346955; c=relaxed/relaxed;
	bh=wacdGz1FFx765iaQBSdnRp5+uhnOeXue3p/ONbwCEaY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CcbPbsJj2IDW4sV7ao8YrzDB8IZG3SszHt6K1d27mclbR/b7Cmhv1OCvJs+WDTz4AyYpPZyiaTZmXgOYSd2PV+H8uuMENxiTaf3gvu5MWsZ7R8aS2coE1WRY7s1HVsG93b8ssGjWp5njf7qPyn0D5ICEejVUPV4VmQgzp404avJDWuuDkv8EyIkM2ZU16YBUDX/X0JtMzFRlXifWPGUI9RuDhCnp7pZKyiKOaYDMxytECdlk77U7+BGPSOfiXU/oBHvtjLUQ25rmF+6Ce+LtUXZwNcLC8eeIuQ5KEcPV4lm+Aim4hRxMUkEtWMyd3tuLfIF9THL7AjonAB+E2lY2Sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=imdsvGZv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=imdsvGZv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrtY61cfJz2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 00:35:53 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aXv2102845;
	Fri, 25 Sep 2026 14:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=wacdGz1FFx765iaQBSdnRp5+uhnO
	eXue3p/ONbwCEaY=; b=imdsvGZvlt1jxejEvPQQ+ufykRlcPWqIDgTgWXhcufEv
	m341Cf7s78erGqN8YFeoRVcO2aYkVlKL6y+MStSy5UnfGCaD9QeH5uUPRUCzKL7R
	S3IaQP0N9/l0bh3m9H4UAbVODG4/J3fBU5T5Gzthp6UCl+SkpwUVwtQYz3Tswf9Y
	ACJw16XKQtqqzKWnsbWy2po2Dv5JgN1miRN3TA7h6oycfMfqc2pGXWdrAQIs5rgw
	Ip7+Ydym6j1gU91clysfF3lstnsCFaHJEd2jn5z0l9kCCTpxDkrm6//TpV2PB68I
	hGkVP2KG2la6ab8Kxf77OOzQl/30fzgR/PBzd1MKmg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvpjhq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 14:35:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA1cq93298414;
	Fri, 25 Sep 2026 14:35:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k2se0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 14:35:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PEZkOb60031348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 14:35:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACBB65805A;
	Fri, 25 Sep 2026 14:35:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CA5258056;
	Fri, 25 Sep 2026 14:35:44 +0000 (GMT)
Received: from [9.61.242.145] (unknown [9.61.242.145])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 14:35:44 +0000 (GMT)
Message-ID: <d4cccba9-ce5c-424b-864c-2248fb0d99e6@linux.ibm.com>
Date: Fri, 25 Sep 2026 20:05:43 +0530
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
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        nandinih@linux.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [BUG] powerpc: unrecoverable exception due to
 arch_local_irq_restore() called in NMI context on Power11
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: di60XduoevU9mIEv7nilN36jqMGmllww
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1OCBTYWx0ZWRfXzcP/x3M5v3IP
 uzpuTIRBHU3Abbsil8tYh4el26SvsxETLgfhMguJuRtSn2CVrAYwokTCOEACGCs36AdGf83jGqU
 hmYOqaoXP1eL1f1AMpV8Ij4C+CMrsRw=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab686c6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=S-y81fhqRhZvH5zLhZwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JpKBIopxW_M7YMfijINCTLsNgotVPFzW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1OCBTYWx0ZWRfXyyQs8MbWpIeV
 ikHJNCHdsVHWz67Ba5P14DP4r5F85D0SffNp+8rdbeZm0j9GtvR0pGSiL3N31ZkiwNx7xRzn8UU
 kjMcsHmBARwbT7L/51bhZzzzoyyyK+fpadYa2DPJLyfKNm65skK6B5UlokBP+HshLdUGklIoxH+
 G7U4cOhRU2XMCJ6DZscXI+HIIS88cT+ZvM9JpGPLMziF2LtzWeA2LIvNDzcKZFaIolsJQJGDG8o
 DNWtTx4QLRzOs1qfjHGaMRBNFfCfoFaHFOKoyOwAwg658O3i+nL11ne7K45dExnd+uF7WC+eHJX
 5otfRZNXg+VWHEFplzmTq9P7OxMLSzxvN1pW5qM1FArZuPJt7JlbI7cAzgiiko8voClJ1/yrtTY
 fctAbYVWD7J3bMJtgB5iFnKLQ1g5jq3CR3hFrzEmo2o0sRKP+2fd0qKmILPr14WlXCKcIyxhwqH
 yii4eUF3JcTbU348Wtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250058

Hello,

IBM CI has reported has reported an unrecoverable kernel exception on 
Power11 pSeries
systems triggered reliably by running a parallel kernel build.


Hardware
--------
IBM,9080-HEX Power11 (architected) 0x820200
hv:phyp pSeries, FW1110.01 (NH1110_069)
32 CPUs, 60GB RAM

Kernel
------
powerpc/linux.git merge branch
commit b0956825c (2026-09-21 "Automatic merge of 'fixes' into merge")

Config
------
CONFIG_PPC_IRQ_SOFT_MASK_DEBUG=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_PPC_WATCHDOG=y
PREEMPT_DYNAMIC (lazy mode)

Reproducer
----------
   make clean && make -j$(nproc)

Triggers within ~120 seconds on a 32-CPU Power11 system.


Symptoms
--------
First, two WARNINGs fire at irq_64.c:217/218:

   [121.124041] WARNING: arch/powerpc/kernel/irq_64.c:217 at
                arch_local_irq_restore+0x290/0x328, CPU#1: make/6861
   [121.124113] LR [c0000000005036d8] trace_hardirqs_on_prepare+0x98/0x150
   [121.124117] Call Trace:
   [121.124120]  trace_hardirqs_on_prepare+0x98/0x150
   [121.124123]  irqentry_nmi_exit+0x12c/0x168
   [121.124128]  soft_nmi_interrupt+0x468/0x6c4
   [121.124131]  soft_nmi_common+0x1b0/0x28c
   [121.124134]  ---- interrupt: 900 at end_real_trampolines+0x0/0x1000

   [121.124184] WARNING: arch/powerpc/kernel/irq_64.c:218 at
                arch_local_irq_restore+0x2a0/0x328, CPU#1: make/6861

Followed by an unrecoverable exception:

[  202.258332] Oops: Exception in kernel mode, sig: 4 [#1]
[  202.258527] LE PAGE_SIZE=4K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[  202.258531] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bonding 
tls ip_set nf_tables rfkill fsdev_dax kmem device_dax pseries_rng 
vmx_crypto dax_pmem fuse ext4 crc16 mbcache jbd2 sd_mod nd_pmem papr_scm 
sg libnvdimm ibmvscsi ibmveth scsi_transport_srp pseries_wdt
[  202.258570] CPU: 2 UID: 0 PID: 1598 Comm: git-remote-http Kdump: 
loaded Tainted: G        W           7.3.0-rc4+ #2 PREEMPT(lazy)
[  202.258576] Tainted: [W]=WARN
[  202.258578] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[  202.258582] NIP:  000000000003e178 LR: c00000000003e174 CTR: 
0000000000000000
[  202.258586] REGS: c000000effc17d60 TRAP: 0700   Tainted: G   W        
     (7.3.0-rc4+)
[  202.258590] MSR:  0000000000081000 <ME>  CR: 00000000 XER: e0017930
[  202.258596] CFAR: c00000000000d158 IRQMASK: 0
GPR00: c000000effc17930 0000000000000000 c000000002252580 c000000002252600
GPR04: c000000effc179a0 c000000effc17a08 c000000effc179e0 0000000000000000
GPR08: c00000000002c254 0000000000000000 0000000000000000 0000000000000000
GPR12: 0000000000000000 c000000effffdf00 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 c000000002267878
GPR20: c000000effc179e0 0000000000000000 0000000000000000 0000000000000001
GPR24: 0000000000000800 0000000000000003 0000000000000000 c000000002259970
GPR28: c000000effc17ba0 0000000000000009 c00000000003dc60 c000000002267878
[  202.258637] NIP [000000000003e178] 0x3e178
[  202.258642] LR [c00000000003e174] arch_local_irq_restore+0x2a4/0x328
[  202.258649] Call Trace:
[  202.258651] [c000000effc17b80] [c000000000023afc] 
show_regs+0x5c/0x1d4 (unreliable)
[  202.258658] [c000000effc17c30] [c00000000002d05c] __die+0x114/0x17c
[  202.258663] [c000000effc17cc0] [c00000000002dd44] die+0x74/0xe4
[  202.258669] [c000000effc17d00] [c000000000031dd0] 
program_check_exception+0x3c/0xf0
[  202.258675] [c000000effc17d30] [c000000000009b2c] 
program_check_common_virt+0x3bc/0x3c0
[  202.258680] ---- interrupt: 700 at 0x3e178
[  202.258683] NIP:  000000000003e178 LR: c00000000003e174 CTR: 
0000000000000000
[  202.258687] REGS: c000000effc17d60 TRAP: 0700   Tainted: G   W        
     (7.3.0-rc4+)
[  202.258690] MSR:  0000000000081000 <ME>  CR: 00000000 XER: e0017930
[  202.258695] CFAR: c00000000000d158 IRQMASK: 0
GPR00: c000000effc17930 0000000000000000 c000000002252580 c000000002252600
GPR04: c000000effc179a0 c000000effc17a08 c000000effc179e0 0000000000000000
GPR08: c00000000002c254 0000000000000000 0000000000000000 0000000000000000
GPR12: 0000000000000000 c000000effffdf00 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 c000000002267878
GPR20: c000000effc179e0 0000000000000000 0000000000000000 0000000000000001
GPR24: 0000000000000800 0000000000000003 0000000000000000 c000000002259970
GPR28: c000000effc17ba0 0000000000000009 c00000000003dc60 c000000002267878
[  202.258735] NIP [000000000003e178] 0x3e178
[  202.258738] LR [c00000000003e174] arch_local_irq_restore+0x2a4/0x328
[  202.258743] ---- interrupt: 700
[  202.258745] Code: 892d0153 2c090000 4082fe30 992d0152 4bfffde0 
60000000 0fe00000 4bfffda0 60000000 60000000 0fe00000 4bfffda0 
<60000000> 60000000 0fe00000 4bfffd9c
[  202.258760] ---[ end trace 0000000000000000 ]---


If you happen to fix this, please add below tag.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.




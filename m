Return-Path: <linuxppc-dev+bounces-27665-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEECFC88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:08:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmNyL65PMz2y2W;
	Fri, 18 Sep 2026 17:08:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789715322;
	cv=none; b=gd6nIeaJ+IkEGXegPNPz79lQH+4HmqfEVGsHZ8K3Sy6L1tGX1iSNLDPD8ypxFKguoa8KCKTOweY5FcieynHEU386BwBWbWf5Y0k+XAQCBWD3SOKkAL0fTvTBXV9i6V90zJNu9e8FA4KGhMO4hEZjYNReBpKWybE7xbgBTmeZq9NWUytsn26EWWQ3MI4pQYNYNDCtHME9VAZQh1x7QDWl3cofght3QDVM0VrOzHUn807wY4EMD4TrMSL0PzOjJ2jkc3LjuQGpbKWuOqhW+z0fQ96H1Mxp8qNsmNTs5kYpyJskQiCStQHONGXU6XOXD6NtfGMzqgBJ+u6NJDBQnKJHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789715322; c=relaxed/relaxed;
	bh=QyiWJeyX40zhG+NrXO8KY9exffT+1DYFLbG5dwgeEfY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BlAMuPoeUufqf/DcU6XXgyf2rWajmkn8KazN+LKV6Oq+5jflJguWypMeEVcSHeN+l22dyKNn+6fEk0DQqNfjcrFCdgh+RpmcJcd+26PI4zRqTvJriIebCYy9qDsFeb520cNjDiitSzAaJVQn7gmhBsa5hb3/uAzhRJAbHoSy07YlxDpXYZd1/X0byBmb4NnF6wozF3cdXnOi0mvQTQlvXphe15pWnoW8HxxCf0dzmnJAOVGe/xpaqmq45IAqI1kipUSj5xaz7kqrHEzvjoD9mGN6qrF6E2XRZIi14kdekKkpYO3FQaq3Xf4RL4tKml3no7/Hl+RGK6H4XO3kXI+24g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V4wInamu; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V4wInamu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmNyK70Vzz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:08:41 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61faI498317;
	Fri, 18 Sep 2026 07:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=QyiWJeyX40zhG+NrXO8KY9exffT+
	1DYFLbG5dwgeEfY=; b=V4wInamuVbWxLjj1/9ej0tPQ54QG4p/aIq3QzvL+jiEG
	6soogRNuvCTwXEiv2bFwz07NtZaoWRTTHvttLJl32m5QkZDITxdTWYGY5v1/XHiI
	stWNMRYJei8u/9wLhLe53bMz/l7p2WvvlfkmYblrkUU1dmmfw26zP234Zj8fchKI
	5FcMJj9GjoZxVA8l/ZVIGom/U5+6jQ8LtzPR1kDrQ1HnvNPCZxIC/wwu/QaWooqK
	+kV/R5CIckK+hJTrncsSPKdgde8CxedRA7nM9VpMQynb8iWlnhnOrRHC0mM8UE/g
	c2DDrS7nW/pAIswpr23KNYAaYb0jmxYULEJRJcAEgw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcve40b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 07:08:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I65GE2196413;
	Fri, 18 Sep 2026 07:08:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjp7py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 07:08:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I78Yln20644464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 07:08:34 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B02958050;
	Fri, 18 Sep 2026 07:08:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5826358045;
	Fri, 18 Sep 2026 07:08:31 +0000 (GMT)
Received: from [9.61.249.200] (unknown [9.61.249.200])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 07:08:30 +0000 (GMT)
Message-ID: <d0d04df2-8d69-4155-81b1-3d3ea2fca14e@linux.ibm.com>
Date: Fri, 18 Sep 2026 12:38:29 +0530
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
To: "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, Liam.Howlett@oracle.com
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [linux-next20260917] BUG: Bad page map in process
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA5NCBTYWx0ZWRfX895lyo2zTBkb
 ZaHql1XFDSCP7aJ1wGMiwXN6FFYtI6WQkxjy9/dXUsgvTb9M3DT7RYMg+17jBbD2WTzYXMt10qt
 QsBknrUjK74eJv6SGMlF/3arRRSuXHE=
X-Proofpoint-ORIG-GUID: nhZ8uAaRH0OylhbcL-v07Wa6WWEnFuJ4
X-Proofpoint-GUID: nhZ8uAaRH0OylhbcL-v07Wa6WWEnFuJ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA5NCBTYWx0ZWRfX5Y1Eo3CxUn17
 qO1khtNF+7VasT4TAK5OnEFOltfENb2uGAvVprbjadqoZs8WWrc/ofbURwo4p47bkTlpyIRIxO9
 3qyBS+tt+HetmfCtNMChTHoSsIXgYi539HBxWpJWRrU0f7pN/cOy62DHX0dGtGz/dpN4aWtVGtX
 nRIaTd3eYlupR5zaTfMDENA0uQxSGAuMgQKS0q1m/R9zk1cad+lr779E1n9ug6Qmjgh7dhNiFJ/
 k7SV/thkJ7cXssbAPC5wdWhDvhtch2PO0jtoRgtk0NJRmIqUx9vkuUaowc7EK/Q1NYn3eJeKl+u
 c+v7uaQeKLrAmjHMR6stYONS9ViTjJqaGpF2CCIlEJhTfZ9nMBPo08u3SogLbfLsfrGKKehXABa
 LUVoNRuG0cqjy01hyCVr4GcYOxNRLxe1s1XRq1P6meF8KZ0AwOFXtI+jwVsKbE0hr7c9Tdalp5P
 FzdU8CYRPXfsEQchcaQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aace373 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=HixBNUViIQCYW3mda3AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180094

Greetings!!!

IBM CI has reported following boot warning on Power11 pseries machine 
running linux-next 7.3.0-rc3-next-20260917.


Traces:

[    4.944846] BUG: Bad page map in process rtas_errd pte:c00000001fff0786
[    4.944850] pgd:8000000064e76009 p4d:8000000064e76009 
pud:8000000064013009 pmd:8000000064011009
[    4.944858] addr:00003fffa9382000 vm_flags:080000fb 
anon_vma:0000000000000000 mapping:c0000000054443a0 index:1fff0
[    4.944865] file:mem fault:0x0 mmap:0x0 mmap_prepare: 
mmap_mem_prepare read_folio:0x0
[    4.944875] CPU: 17 UID: 0 PID: 773 Comm: rtas_errd Not tainted 
7.3.0-rc3-next-20260917 #1 PREEMPT(lazy)
[    4.944877] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[    4.944879] Call Trace:
[    4.944879] [c00000001791b4e0] [c00000000135a92c] 
dump_stack_lvl+0x8c/0xf0 (unreliable)
[    4.944885] [c00000001791b510] [c0000000006708c0] 
print_bad_page_map.part.0.constprop.0+0x18c/0x260
[    4.944887] [c00000001791b5f0] [c000000000674fa4] 
vm_normal_page+0x140/0x17c
[    4.944890] [c00000001791b630] [c00000000067648c] 
zap_present_ptes.constprop.0+0x9c/0x9ac
[    4.944893] [c00000001791b700] [c000000000677038] 
zap_pte_range+0x29c/0x5f4
[    4.944895] [c00000001791b840] [c000000000677500] 
zap_pmd_range.isra.0+0x170/0x310
[    4.944898] [c00000001791b8d0] [c000000000677a00] 
__zap_vma_range+0x360/0x4cc
[    4.944900] [c00000001791b980] [c0000000006780e0] unmap_vmas+0x98/0x1a0
[    4.944903] [c00000001791ba10] [c0000000006b0f68] unmap_region+0x94/0x108
[    4.944905] [c00000001791bad0] [c0000000006b1c7c] 
vms_complete_munmap_vmas+0x11c/0x2c8
[    4.944907] [c00000001791bb60] [c0000000006b273c] 
do_vmi_align_munmap+0x1ac/0x1f8
[    4.944909] [c00000001791bca0] [c0000000006b52c0] __vm_munmap+0xdc/0x1fc
[    4.944911] [c00000001791bd60] [c00000000068b154] sys_munmap+0x28/0x3c
[    4.944913] [c00000001791bd80] [c000000000032150] 
system_call_exception+0x190/0x4b0
[    4.944916] [c00000001791be50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[    4.944919] ---- interrupt: 3000 at 0x3fffa9143754
[    4.944920] NIP:  00003fffa9143754 LR: 00003fffa9143754 CTR: 
0000000000000000
[    4.944922] REGS: c00000001791be80 TRAP: 3000   Not tainted 
(7.3.0-rc3-next-20260917)
[    4.944923] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44002408  XER: 00000000
[    4.944928] IRQMASK: 0
[    4.944928] GPR00: 000000000000005b 00003fffc0a69a20 00003fffa9237d00 
00003fffa9382000
[    4.944928] GPR04: 0000000000001000 0000000000000002 0000000000000000 
0000000000000001
[    4.944928] GPR08: 000000000000001b 0000000000000000 0000000000000000 
0000000000000000
[    4.944928] GPR12: 0000000000000000 00003fffa937f860 0000000000000000 
00003fffa9383550
[    4.944928] GPR16: 0000000000000000 00003fffc0a69cd8 00003fffc0a69ca0 
68746150706d7544
[    4.944928] GPR20: 00003fffc0a69c10 0068746150706d75 636170614364656c 
747365526f747541
[    4.944928] GPR24: 000000013ad9e130 00003fffc0a6a0d8 6d726f6674616c50 
00003fffa92f5ee0
[    4.944928] GPR28: 00003fffa9382000 000000001fff0000 0000000000000009 
0000000000100000
[    4.944945] NIP [00003fffa9143754] 0x3fffa9143754
[    4.944946] LR [00003fffa9143754] 0x3fffa9143754
[    4.944947] ---- interrupt: 3000


If you happen to fix this, please add below tag.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.




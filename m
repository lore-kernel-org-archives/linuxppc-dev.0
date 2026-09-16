Return-Path: <linuxppc-dev+bounces-27473-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07321C88E77
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 08:42:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlC7G2vPFz2ySf;
	Wed, 16 Sep 2026 18:42:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789548138;
	cv=none; b=Pgfiw/GDMkbxh1vNFWXV8bUbV5veaLnirHWzYEXFoUnCdkRQPbt7xagXFeokanBzp+fSi/ZD5jCRp0+G9moGr5OPyxM9+bShA8+vbtFclLPUJ2joqCo7uVVP4Ed/vNLeYAXur3wjtIPECvh1qJ8G9Nw6t3G4Mc32Qbj2Zc6h2umcfbOEv7Z34xVffiywvvRjFqj1THD/qtqdoXXp6jNCkt62M200VRcYyB3mDGJT3SYEJ9cBY1tsAXUswT+++SDwpCKHyhB5RJI0RePA0uDd15tfXuU3h3o9yXAIg2jZINhVeii7PpdyfUKXJ+3F3ym/L3qfeCwYz59C69xScjhWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789548138; c=relaxed/relaxed;
	bh=a+5A2YYn/NJUdT1i2e+yAYX+JA8z/NmN3gfRqXF3Ph0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mj9XArAAoENLuCSqa3Y5m52LmxSIEAuM+QP+4YZRZLdp4R76idNdwAQHOn4I5ogPngvUFgGtK0D2xfDWqu5/lPmerBgHN7zgw/e+npnsHkmDEnjDYBL7Ph3ei98hRzpw6RBr8eBAF45vpTIQ6ymNce7ofobY/YB2PR7gxG2u1SOxdu+3EOxYyjk+xYlfq6uaIbIJG7VzcTrrMgvg4k8us6RE9/FzSmh6FZiYrKqYr/AVdSYV3ZbipjyASvckG4DV4hpBse6oPYouRHuRRRB7sJoRM2IQBjnW5Yr+a3p2VoUE5Bcmn9H1abU5r4xgBB1N1b90LPhE8+T13XAPqsHH9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dt4uN/nM; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dt4uN/nM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlC7D6YlVz2yGT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 18:42:16 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLVu9V1805431;
	Wed, 16 Sep 2026 08:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=a+5A2YYn/NJUdT1i2e+yAYX+JA8z
	/NmN3gfRqXF3Ph0=; b=Dt4uN/nMiUY0aav0mppSdk7Aje6BkKDEfmayI1sYc8Ux
	LRaShKCR5ZEN5m083FV7xiGg57geufiyynYdHv/mc4sgA8PpgVUAay9+7NCZ3EPx
	isdZ0Iu8BlKTwjgXe4VX/ffTUFU8JB1T8TA3QlaNs36RVc+uxWCjBZ2X8IKPlmBO
	hE8tlFjS2Kw6fkxjcr57IVUlvKhI92MR6j9C2B99iBOp31Qm9x6/85lxLreDLRTy
	vCr5Wrwkk/DjuVuf6uhsQWZeCgeXVm7U+sS1icMzgOZvjdo2N4Krp7ETXb4Y7UBi
	0dI8hedHcU0ELatmAk8R5zJGjLOHPsR/fg+InHGcag==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5huhmc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 08:41:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68G7VNkS1354821;
	Wed, 16 Sep 2026 08:41:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d60tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 08:41:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68G8fqNQ12911134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 08:41:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A104A58059;
	Wed, 16 Sep 2026 08:41:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 662DE58063;
	Wed, 16 Sep 2026 08:41:48 +0000 (GMT)
Received: from [9.61.253.212] (unknown [9.61.253.212])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 08:41:48 +0000 (GMT)
Message-ID: <56d51dc6-f597-4cfa-b61c-b6b95d61ab86@linux.ibm.com>
Date: Wed, 16 Sep 2026 14:11:46 +0530
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
To: Hari Bathini <hbathini@linux.ibm.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eduard Zingerman
 <eddyz87@gmail.com>, yonghong.song@linux.dev,
        Alexei Starovoitov <ast@kernel.org>, andrii@kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [BUG] powerpc/bpf: Kernel stack corruption in avc_has_perm() during
 BPF kselftests (test_progs)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExMCBTYWx0ZWRfXxtmIj8RKbqVM
 Gnu5YrEmJxW9lyo2XbqL5CZ7sXcBZKEJXIABjLJgqZtlnEuJjGFrzv1YpnG3/0LqFivCkcYj1pS
 HTTjmptjKG7KbvqJ115dfkTVzhzrezdEX6+bMc10gJIeEvs3Ig4nGzUsSAACnOVWrwNe5/MkUKF
 pmIoo4p/I4n5+7JO2dl4NpHM6bojZwybM3fKhbp2YW6M/MUVVKH9cZ8JlZHWtA8F7Hkcs5dhsCS
 m/DNOBRkpRv20FrIJQddhc3TPuC+q0Xrebg/6dvo1X3d80JVXWRl3ex7GsMB5Lj3IDyQyyWbnD6
 Ykxn2NbqE0A3YTbZgaLXzaMLUNszonp5Cg6W/hIcDImoZjBS7/Cczyf6OwRo7QWI/ptSDAmO84s
 2/T8DGee7lcHnjPW+dZMhbjWMBqgYLqy8ht+VGX2BPcRQgPyiN71u5pSm5fVEqvm5LUl6pQUUUm
 oQ5IQPKILllKH8z1QBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExMCBTYWx0ZWRfX5aeFEelAtDbQ
 JrPfBaERzAnABXuwL6zZr/Q+5UJf8ijophZgn0Gb24kB8wYKMg9ZiGK0yE5Tx/u4b8oIa2ycsfA
 6OfNe9WTdUWBFWFlcQr27ZFRIby6HbY=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aaa5653 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Yb77rMnAWnyX_ecM6KAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: j98Y_b2jO6-Gh9393PrUzOcghDvJkpk8
X-Proofpoint-GUID: xJvvkfB_yyaOFUBVlnp-o2L26sWwbki2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160110

Hello All!!!


IBM CI has reported a kernel panic on PowerPC (ppc64le, POWER9 pSeries 
guest) while running BPF kselftests (test_progs).

Environment:


Kernel version: 7.3.0-rc3-gf6e7b42bf05b (PREEMPT)
Architecture: ppc64le (POWER9 - IBM,8375-42A pSeries / phyp)
Test Suite: Avocado FVT / kselftests 
(tools/testing/selftests/bpf/test_progs)


Traces:

[ 1359.516833] Kernel panic - not syncing: stack-protector: Kernel stack 
is corrupted in: avc_has_perm+0x23c/0x240
[ 1359.516856] CPU: 0 UID: 0 PID: 49806 Comm: test_progs Tainted: G      
      OE K     7.3.0-rc3-gf6e7b42bf05b #1 PREEMPT
[ 1359.516866] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [K]=LIVEPATCH
[ 1359.516870] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
[ 1359.516876] Call Trace:
[ 1359.516880] [c00000011bc67b10] [c0000000014627c0] 
dump_stack_lvl+0x84/0xc0 (unreliable)
[ 1359.516890] [c00000011bc67b40] [c000000000234840] vpanic+0x1b4/0x47c
[ 1359.516897] [c00000011bc67be0] [c000000000234b44] 
do_panic_on_target_cpu+0x0/0x2c
[ 1359.516906] [c00000011bc67c00] [c0000000014f8ce8] 
__stack_chk_fail+0x48/0x60
[ 1359.516913] [c00000011bc67c70] [c00000000092f0bc] 
avc_has_perm+0x23c/0x240
[ 1359.516920] [c00000011bc67d40] [c000000000936fc0] 
selinux_task_getpgid+0x80/0xa0
[ 1359.516927] [c00000011bc67d80] [c000000000920190] 
security_task_getpgid+0x70/0x1c0
[ 1359.516934] [c00000011bc67db0] [c000000000259488] do_getpgid+0xa8/0xf0
[ 1359.516941] [c00000011bc67de0] [c0000000002594f0] sys_getpgid+0x20/0x30
[ 1359.516948] [c00000011bc67e00] [c000000000034670] 
system_call_exception+0x160/0x480
[ 1359.516957] [c00000011bc67e50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec


Please let us know if any further debugging or testing with specific BPF 
JIT options is needed.


Regards,

Venkat.



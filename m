Return-Path: <linuxppc-dev+bounces-27475-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB3FC88E5C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 08:52:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlCMM08kbz2yGT;
	Wed, 16 Sep 2026 18:52:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789548766;
	cv=none; b=o048DCNlJ9frkj/IH/cvUs1lx8BQ3WkBuxsO+jIba08ban1youHNJBW7DrcanDTObFEtFyf7M+pigyoqNbVCJLg6ankZtt2Rq8zsEr93oBtjGU4ndxBjT7ef+TC4PSkkeUCTRu6dZNYe45CO94PzdA6J5ivRp1kLGTj8IKxLqEyZU571WK3VN1U7QmAHRXHp0uUMT4JhHsjFqFOXZBeu6zAB//Uu/NpVdFm7vZypTEOXVn8Ow+2q1AtHW9RhDkVFo0DvLCTZb+g+ijp5ZAgX9yZWPv3bQwvHuYbKkdrVWciNVjYkcfsmtlqcHW2LhiLb0reFrsluA/AUNiQpHhykAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789548766; c=relaxed/relaxed;
	bh=ccl6AblDRT7F5uiHrNKEDS27CmbJ4zJOrBrcGlJisuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTliZ59kbRDbnFsZu1MvSeyAJvVw8pTshb7eqRo6Tb1ju/gvrT8FyoE8iDg3LPswfhIJvJle+BWzZrmyRyttjDVrWeNd+ajGEW5q3iRHrwNSsZWo1Q2sZjJRXQC8wFnOeO+JI44+ZaPNszl1gXoAzVxKABUiBeqQtQvyDzXfnG4A2J9bKCtgdnBuSRkiUSrkVb6DuJjlgspg4dHOYUzozntat2dRf0eqPV2ZQ7j6cpK2/xKJIeuYMF4QrNSIdQ57n8khxk1v6vyl/5qW0PwXAg7VSi1frzynJxmNv2n/juBhMrBR0lIgS1w+7Cgu7lZ4RGaKLlnqqbw3Od14QbwiHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hrtDGEL6; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hrtDGEL6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlCMK6dglz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 18:52:45 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLVecc1951631;
	Wed, 16 Sep 2026 08:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ccl6Ab
	lDRT7F5uiHrNKEDS27CmbJ4zJOrBrcGlJisuA=; b=hrtDGEL6o+VR+XRfhhHqYX
	gYVJTc3CqnwXqmh6NJ8+K3a4YBekGId0bEbW2N1FyP9e0yxFR7yzSHQPqxSHM0IR
	mOdWcMsg9HlfWV+/nkVEcGn3fDMDK5vhdas294u2ufBdji4vcTx4Sb8EZzBDM3Xz
	CAKgIqfgh9ttGrrtgP6AtDMsFxlZXLdpS75pp0Nmayz4TS9mXWEE03idzo6kb9WD
	W/1AOZYXVwWYkpmFP+2eTHzlTq+XB4TJFPQYcQ2Cjbfylp3zej8lWUANV0JvU2CE
	G7mpEh3ZsHXCFyeQCVP8Ruq3wV/5f8oxkGDFzUEvp5t8AFKxk8aFoNTi0x979Y7g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83um9w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 08:52:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68G7e46M389300;
	Wed, 16 Sep 2026 08:52:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxsdhbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 08:52:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68G8qKS549742272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 08:52:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1503520043;
	Wed, 16 Sep 2026 08:52:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E51512004F;
	Wed, 16 Sep 2026 08:52:16 +0000 (GMT)
Received: from [9.124.211.8] (unknown [9.124.211.8])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 08:52:16 +0000 (GMT)
Message-ID: <46508541-55ab-4340-8871-924514ee8d5b@linux.ibm.com>
Date: Wed, 16 Sep 2026 14:22:15 +0530
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
Subject: Re: [BUG] powerpc/bpf: Kernel stack corruption in avc_has_perm()
 during BPF kselftests (test_progs)
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eduard Zingerman
 <eddyz87@gmail.com>, yonghong.song@linux.dev,
        Alexei Starovoitov <ast@kernel.org>, andrii@kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <56d51dc6-f597-4cfa-b61c-b6b95d61ab86@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <56d51dc6-f597-4cfa-b61c-b6b95d61ab86@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExMCBTYWx0ZWRfX85SvrvPSfOMd
 +01q75rsafsdLmXw9Cuv5vcS5oUeflNU37aA2PsJ6iKPDeuHyVWE2+W9aY8M2TUP1N16K/SM23F
 hPi4xWMDaeYXbLgI58AFJoKFQGVUyc7kDKflTKcjZTGdXk1c+JcmeWWUuLMPTRhd499LdjOwMdg
 m1zQwFrqE+c7OG/k/QlzdVSRcO5L15JTmoBr28RzfRZ1DKDxDGNd33Sk16nHB59qpMXPXD1l+hj
 xdnM0tKxzynbU6pN5uZoX7pYLec62PoCbPVuvMPMRHGI47BnJns/fhVWaaEDTukzwA2JdP+aqqy
 TputCIxDFXeswtnmQ5pAK+M1GyFu7VnQqZAeow3gc+DreQrcfXgMuQM3LoZChK2BnkF8A1AQf9O
 XAtB0DZXXybV5pwVDUSlkzgbyz96gw0MuaeEFwR7jPUPolUP/bdzbARLdgCUXZAzyhEcii40yFs
 CE36Z5E1WS6S/cdwQ5w==
X-Proofpoint-ORIG-GUID: aHG0o8l-4_Y4D9r7LWH8I8O8n9cPJ_vt
X-Proofpoint-GUID: fyzoQu-Kdur9Wn_W0C6nqJrwiazL0iUC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExMCBTYWx0ZWRfXwr8pipsY7Kvj
 WN72Hr5zgO7JiFb1TvGJYSdG/MyIpDDtqeb37/KJsI2n6mQ7R2oXEVmfEfsz3Pr+LgPBPz90cBo
 Me1rf6sdVYq+qA9mxlyoaIYx8URQ1Wg=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaa58c9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Oc1KoJq9fdCeQZ6uml4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160110

Hi Venkat.

Thanks for reporting.

On 9/16/26 2:11 PM, Venkat Rao Bagalkote wrote:
> Hello All!!!
> 
> 
> IBM CI has reported a kernel panic on PowerPC (ppc64le, POWER9 pSeries guest) while running BPF kselftests (test_progs).
>

What has changed in CI that it is hitting now?
  
> Environment:
> 

It is very likely same as
https://lore.kernel.org/all/ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com/

> 
> Kernel version: 7.3.0-rc3-gf6e7b42bf05b (PREEMPT)
> Architecture: ppc64le (POWER9 - IBM,8375-42A pSeries / phyp)
> Test Suite: Avocado FVT / kselftests (tools/testing/selftests/bpf/test_progs)
> 
> 
> Traces:
> 
> [ 1359.516833] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: avc_has_perm+0x23c/0x240
> [ 1359.516856] CPU: 0 UID: 0 PID: 49806 Comm: test_progs Tainted: G      OE K     7.3.0-rc3-gf6e7b42bf05b #1 PREEMPT
> [ 1359.516866] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [K]=LIVEPATCH
> [ 1359.516870] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
> [ 1359.516876] Call Trace:
> [ 1359.516880] [c00000011bc67b10] [c0000000014627c0] dump_stack_lvl+0x84/0xc0 (unreliable)
> [ 1359.516890] [c00000011bc67b40] [c000000000234840] vpanic+0x1b4/0x47c
> [ 1359.516897] [c00000011bc67be0] [c000000000234b44] do_panic_on_target_cpu+0x0/0x2c
> [ 1359.516906] [c00000011bc67c00] [c0000000014f8ce8] __stack_chk_fail+0x48/0x60
> [ 1359.516913] [c00000011bc67c70] [c00000000092f0bc] avc_has_perm+0x23c/0x240
> [ 1359.516920] [c00000011bc67d40] [c000000000936fc0] selinux_task_getpgid+0x80/0xa0
> [ 1359.516927] [c00000011bc67d80] [c000000000920190] security_task_getpgid+0x70/0x1c0
> [ 1359.516934] [c00000011bc67db0] [c000000000259488] do_getpgid+0xa8/0xf0
> [ 1359.516941] [c00000011bc67de0] [c0000000002594f0] sys_getpgid+0x20/0x30
> [ 1359.516948] [c00000011bc67e00] [c000000000034670] system_call_exception+0x160/0x480
> [ 1359.516957] [c00000011bc67e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> 
> 
> Please let us know if any further debugging or testing with specific BPF JIT options is needed.
> 
> 
> Regards,
> 
> Venkat.
> 



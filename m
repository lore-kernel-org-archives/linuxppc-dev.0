Return-Path: <linuxppc-dev+bounces-24884-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ED2C53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 11:04:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7whk3TdTz2yhD;
	Mon, 27 Jul 2026 21:04:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785150262;
	cv=none; b=PUPkrhN96KzjLYBtOdNTZ3JidH66jSrC2gjLV4R5RT/aou4BlwTvlUJOa01pNmXmzgwi6Zy085bso3fQ9zKdJ2/1keySELyl2F00cLmmNV2s5wW3DNTzeL2x4P6dpir6cfdRt0d/gnsOuTaJ+YCkC5Q2fAy5Sl06IfJtkHGBCKMhr7em1fJ1ZjejHLHFhk60yVBrHZxZ0tTrBkm6JvfFFw5Is7xmHt18/tzVqodfUaYfWHK407n/x4JDWx46LraDHeUx3ioxu7Lf0kKVUELhgw0XWrJn9sRDIKHXqXf1tUIWlMW4sViHtlcFQL9s1rrtYv+/vEkkU+RIgwVI4IOPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785150262; c=relaxed/relaxed;
	bh=gmdtkjw6AiVL4SgaBLKPo1EH7SMeybBKVIjLN1iIpWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zahxj/MkI+mNWE7SMKfoB5hgXTKHfS/I1efVgZF3UpvIHy4oN/1rPMAyRrnkDj1YED/wOAbb+XAJiezppDtwSSAe2fKGBktRHMdeTiJAhNsynUDP19Y4ixpHGCsxVtcbEpIkzmK3duVRzp8RDn6qDlP18LyTcNksr7yrAgCqYcj9rYPbW5A9kJICOyNIT/aTznEaXMGivkMLaeiHQcRv9m0GEXISrqC1YByJBcrxylDNWWVmCEvnLYMPv8M55fiXN42UcCniRXfeFDC2tMoIiH9NxmGrzPpXfdNp4TiA7ytJ7dHaAn5DEg+HjT409ELFbTNZOzzrNPI0Us7xvJ6uyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RnPANWKb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RnPANWKb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7whj3zhrz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 21:04:21 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAIWsC1956023;
	Mon, 27 Jul 2026 11:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gmdtkj
	w6AiVL4SgaBLKPo1EH7SMeybBKVIjLN1iIpWA=; b=RnPANWKbu8sT1mr2+eaOdR
	oBFaevrBLQHizIZ2urqJXY7mBxlSpMufo872hNSUDsG9ydo5z8meyQopxQboj0nX
	WR3nxQLOtKYeBTABYdOZUZZ6nyvTAV6px4kmoJHFoXbSUQQYTpG2pqi8K4xeaLRg
	vm16ZQr0tdt9DBEZoFFWR2fJ8g4G1zXaHb/SPNrwmAydD5lrJhCp3FkxdIqBTV0X
	2JH3iFIqkci9Mi8Qv4L8c0nvfEzJLlv7MaBbITHMyHK1o9EB7hkY9mDNXHFAzSYY
	+SuyYqMN+TqEx6WU/TsDpKQFW5As+ilbrUfj8Q2M96V/ZW7BAd3NF7Z6ZKpRIuag
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xfm7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 11:03:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RAuFx5022170;
	Mon, 27 Jul 2026 11:03:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq57u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 11:03:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RB3pLo51511584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 11:03:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 128902004B;
	Mon, 27 Jul 2026 11:03:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD16720040;
	Mon, 27 Jul 2026 11:03:48 +0000 (GMT)
Received: from [9.39.23.10] (unknown [9.39.23.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 11:03:48 +0000 (GMT)
Message-ID: <0e9c851c-23c6-4394-82b8-755fc581b0d8@linux.ibm.com>
Date: Mon, 27 Jul 2026 16:33:47 +0530
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
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Jirka Hladky <jhladky@redhat.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com,
        bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <CAE4VaGB-W9i0nNzH=VN9GJr6Dy9R46NtMC3V3ELUxdDhypj8bw@mail.gmail.com>
 <85cb5e0e-feb5-4a54-b7b6-a5f6a053dcda@linux.ibm.com>
 <CAE4VaGArvyKqvysRP_FC39XTLAsiPhGMkR1v3UM4+ykWBHJYyg@mail.gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <CAE4VaGArvyKqvysRP_FC39XTLAsiPhGMkR1v3UM4+ykWBHJYyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: yC4VCmuXTaZo3Iip0fAgxVfG3W_iPsot
X-Proofpoint-ORIG-GUID: ZPUk-LyiqKAndU0R_KzUQvTa1HaUEz_7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwNSBTYWx0ZWRfX4/URNBabP6C8
 mNRiuTmchsD7gJrP5a54VH+1a2LLfM+gHPx0BX1Gtj982r/5WhrrLKl5o+qYOM9s1LMMna8Hcfv
 6YVeTHY4a7g+uirpO7tEjlPjdZvo2NE=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a673b1a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=8vJNx2G_DZO0-mzlBnMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwNSBTYWx0ZWRfX/OToFxf3oaNf
 Womn6635ko7JZr6qBmHnPftg2sMU9kwo9f+gSgeW5Ur1ED3J++rWlowqOO4c3Grzj+B8Ixhyz2K
 9qvw11a/ZBidcxtbtjJziLgueSr40lC4PqOruDMn9H6d5lC2sp2uB5LTWyjazBLbs3GSCXJJ1SU
 gB3Gwbr4aOa0/lfiEHalZ1cq0mA6e4j5NLVy7/VDJHlHFmDaiIB9BRDTJ/mSkmpRrCTLk7uthe0
 anWbMnBpaMlVs809pWp8DW4famifYc8C49PbiF/5nqLj24y/b+Mqmd5tsoOLN8TfjI1Q91gJ3ea
 hDQN4dlB+bv0yduruhlO85bnTpYukeMZXf6FJ7MYUwB/+79p5aVfDoT+d+7sDeGgttTbLiBuwMv
 bQG7X7qLHeNAgw/5cUDJ8bDJFfh8t4Mpa8vdrm7wApNPGzZ2i+G/HaR46XUD+tfykClUJLP+AIJ
 XSM4Esm9rbyihn7Wj8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270105



On 7/27/26 4:29 PM, Jirka Hladky wrote:
> On Mon, Jul 27, 2026 at 12:29 PM Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>> That means comparison is between preempt=voluntary vs preempt=lazy.
>>
>> If you make it full preemption in 6.15 you will likely see similar
>> data as 7.1+. Only on 7.0/7.1 there is force switch to lazy/full.
>> Can you give that a try?
>>
>> If it shows same data, that implies the regression is mainly due to
>> change of preemption modes, rather than the static key stuff.
> 
> Tested on 7.1 by switching the runtime mode via
> /sys/kernel/debug/sched/preempt:
> 
> Mode       kill bogo-ops/sec
> ----       -----------------
> full       57,476
> lazy       56,892
> Delta      ~1% (noise)
> 

What I asked you was to do voluntary vs lazy comparison without
CONFIG_PREEMPT_DYNAMIC.

> The preemption mode (full vs lazy) makes no difference. The regression
> is from CONFIG_PREEMPT_RCU being enabled, not from the choice of
> preemption mode.
> 
> And as Christophe pointed out, it's CONFIG_PREEMPT_DYNAMIC that pulls
> in CONFIG_PREEMPT_RCU, not CONFIG_PREEMPT_LAZY:
> 
>    config PREEMPT_RCU
>          default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> 
> So the chain is: your patch enables HAVE_PREEMPT_DYNAMIC_KEY ->
> CONFIG_PREEMPT_DYNAMIC takes effect -> CONFIG_PREEMPT_RCU=y ->
> expensive rcu_read_lock/unlock on ppc64le.
> 
>> Plus, it may call schedule in lazy/pull preemption.
> 
> The full vs lazy results above suggest extra scheduling is not a
> significant factor here.
> 
>> This seems strange. How come rcu lock/unlock depends on SELinux
>> policy? One should call rcu lock/unlock if they are working with
>> rcu updated fields.
>>
>> Does the policy change itself protected with rcu lock/unlock?
> 
> The rcu_read_lock/unlock calls don't depend on SELinux policy -- they
> are in the SELinux *code path* itself. SELinux uses RCU to protect
> its AVC (Access Vector Cache) lookups. Every call to avc_has_perm()
> takes rcu_read_lock() around the avc_lookup() hash table access.
> 
> When you boot with selinux=0, the SELinux LSM hooks are never called,
> so the AVC code path (and its rcu_read_lock/unlock pairs) is never
> reached. That's why disabling SELinux removes those call sites from
> the hot path.
> 
> The call chain is:
>    sys_kill -> check_kill_permission -> security_task_kill
>      -> selinux_task_kill -> avc_has_perm
>        -> rcu_read_lock()
>        -> avc_lookup()    <-- hash table lookup under RCU protection
>        -> rcu_read_unlock()
> 
> With selinux=0, security_task_kill() is essentially a no-op and none
> of the avc/rcu code runs.
> 
> Jirka
> 



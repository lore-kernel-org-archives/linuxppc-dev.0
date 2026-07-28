Return-Path: <linuxppc-dev+bounces-24919-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F089AC53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 05:28:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8PC71fTjz2yRl;
	Tue, 28 Jul 2026 15:28:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785216531;
	cv=none; b=ifCTEyqh2SmS1zMhWYIZVEUkEOdJoeNtPyIkw6Bpttte34Jrjna5Ecl9RU/jQeFgV8/kpLVAA6WKNlQAPOa61LHvTfuht5mSL37BDDNeLYQffHSQWcjEokuCb4aHNdniuMQIlmVlvKppkZT+ffSvlvcI8cfMosClywmOftYcw+4aeAarz5vTJC8LmEk6B4u7SvLhT9zhOejIYzowM8MfFcbPma1aojCtBSYcj0NkMGpdYJ9YtunXsKWABX8UpNB/BKDrHrX3/iZhFras3hD+ERHGmhr2+XSNbRJq6DjuWmQqaU7M8nEHcihqs1pB5zP9I3DcjSiNX5mK1EQuIPW+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785216531; c=relaxed/relaxed;
	bh=JZDuKCxxhGe5X9194rtk1xCx0lPhtbCTn66oiZzxG+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3/7H74RupB7xgnDo9VAFkMO6hRUtlyLOiu3SHQkODJd20lCEoXMG3x6ulQYeWY3on4m0d5INsOs1ih296OxtTxj24dWVIE2yTMWxhNqwcdGN9lCUsAKomuG71UMI7eNvfnUTmMSpzyPmP5yt0JGDt3GFtVRFOAsdqGklrp888habQsOEFoNPYsMNlm2iemHhdsKGo14tpSR/ag1w8JQlu0im/K3YdyIFqKoBYPjn6fV+LuQ5wlJzEeGmrZoOHTvxXdxS+NhrSbxrLTGukoA23kIllrmMSV/clzBNCfZZ3Si+ESaHcVRSfdlfI0zPql1uW/ExiTFqSCCZaG105divA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X6C/jIWd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X6C/jIWd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8PC570V7z2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 15:28:49 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3lvjm4146693;
	Tue, 28 Jul 2026 05:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JZDuKC
	xxhGe5X9194rtk1xCx0lPhtbCTn66oiZzxG+c=; b=X6C/jIWdEyCgdXWf3vXHCt
	hk2r7OsEFFa92y6XmhR7EKVlQxOiH088xQjqJToz6f782RwNTy2pz8Ryzts51ggI
	v3toNmzwOfV2yD+/uRLq+Oa0P1wDress5c42YczToumy4+cleitJWME2b9Ji1xmi
	340JcgZoxnq40GKE4QkvaMTkdTxgkEjunfCxQISOH3dT0KNUo8hqBW0EqiX7o9c2
	HxGAJVmIab/4MblIqUMu+3btYVDfnwYosXpqk+VKjQUmZlgevzdqlfi1R3VmtoHY
	7A+dm+DFLho2YOgTrdgBMBfQiJ53JuCTj4Q+GAWRJoO3j6JAymPfg9L00qCLUi6A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcu2u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 05:28:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S5QJSj011736;
	Tue, 28 Jul 2026 05:28:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw0jgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 05:28:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S5SBPA52429288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 05:28:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F7D22009C;
	Tue, 28 Jul 2026 05:28:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBF092009B;
	Tue, 28 Jul 2026 05:28:08 +0000 (GMT)
Received: from [9.39.22.42] (unknown [9.39.22.42])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 05:28:08 +0000 (GMT)
Message-ID: <82752e9b-ed94-4253-ac5f-83cd3c91d569@linux.ibm.com>
Date: Tue, 28 Jul 2026 10:57:57 +0530
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
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jirka Hladky <jhladky@redhat.com>, paulmck@kernel.org
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, bigeasy@linutronix.de, will@kernel.org,
        linux-kernel@vger.kernel.org
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <f81777c3-e341-4ec5-8d61-b333d7170b3f@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <f81777c3-e341-4ec5-8d61-b333d7170b3f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: hBgE93ZNsqRvF-25ij7rWseHiwdwSBeE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0NiBTYWx0ZWRfXzrnC3nNPc4Q1
 OFXN8kwSDn+DC7Kp3pZYRiX0i2ZYWGQrUXD3un4psIOyH2/Lsx6jtLk+ar+Ws8c51mlev93kRgI
 PLDowZwbdAtcU5EgIBz5JLLH45wTJes=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a683dee cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=SO7WSshoTcQeaok8jIkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0NiBTYWx0ZWRfX49Gtp2g4calz
 ss+DHzqu+5LGbRee4WsEycxe3ZXZGsY6uayEbvbqNcIE3+XfFyOPADDg1w9PzQRd8CA97KnHSOa
 1LtIamkq4vJejyn3QuZsr6yA1KS02Biu8uUjOpJ6bogfHhunxO0bOY4xOvivEx3gzeHHWB9Lx6B
 FZcpkeTZhfi/PSU1ZOr3jIYBa+FxdwhSZb0/KLOeYL+H37hqSDtcOew8vK9P0pUU9FY+IJyeI3n
 0lype8Ei5z5HV8iRF+H8zTNEWYpqHIukPY7GU/Xn+uHTgBz3sM7xRdbQm052dl+hatSDxz4AKC7
 6WppWd435seySfNWf4SBSsxtGuKhxMYmcaPASDObCd7ii8Bn/fbZyBQYS9QCegt8T7AQhS2tId7
 +1M55UVqFd9Rbh+4OmQ/WENzxNL12Yq/GbPLeVsYrePC5fJOw6eh4Y+FTXQ2WYKPGLCfiK1ERkU
 hR/Is0XS6KmXq3KVKNQ==
X-Proofpoint-GUID: kl1CfFYkLlRSIh86nfEpLcE7rD2OYqzs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280046

Hi Paul, Christophe,

On 7/27/26 11:59 PM, Christophe Leroy (CS GROUP) wrote:
> Hi Shrikanth,
> 

> 
> That's right with CONFIG_PREEMPT_DYNAMIC=y
> 
> With CONFIG_PREEMT_DYNAMIC=n:
> - CONFIG_PREEMPT (full) implies CONFIG_PREEMPT_RCU
> - CONFIG_PREEMPT_LAZY (lazy) doesn't imply CONFIG_PREEMPT_RCU
> 
> because of kernel/rcu/Kconfig,
> 
> config PREEMPT_RCU
>      bool
>      default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>      select TREE_RCU
> 
> Christophe
> 
> 

Right.

Looks like __rcu_read_unlock can set need_resched bit if it find irq were disabled
and rcu_read_unlock_special.s is set. I don't have much clue about it.
So, after seeing __rcu_read_unlock for PREEMPT_RCU I have these concerns now.

In current upstream, lazy is a preemption mode with preempt_enable being a preemptible point,

1. If PREEMPT_LAZY=y and PREEMPT_DYNAMIC=n, then PREEMPT_RCU=n. That seems wrong. It is supposed to
    do the preemption checks, since preempt_count is actual count with lazy preemption.

2. PREEMPT_LAZY=y and PREEMPT_DYNAMIC=n and PREEMPT_LAZY=y and PREEMPT_DYNAMIC=y are supposed
    to be similar w.r.t to performance. Promise of PREEMPT_DYNAMIC was the ability to
    switch at runtime based on the user workload and his/her preference.
    But with  PREEMPT_LAZY=y and PREEMPT_DYNAMIC=y, there is additional cost due to PREEMPT_RCU.
    lazy being the middle ground w.r.t for decent performance, either PREEMPT_RCU should either kick in
    for both cases or bail out for both.

Before 7.0
3. the same concerns would be true to PREEMPT_VOLUNTARY and PREEMPT_NONE with PREEMPT_DYNAMIC=y.
    Those model never wanted a preemption, but PREEMPT_RCU could have forced a need_resched to be
    set. Which is also likely wrong. No?




Return-Path: <linuxppc-dev+bounces-25108-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60102C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 13:02:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9q9350bBz2xnp;
	Thu, 30 Jul 2026 23:01:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785416519;
	cv=none; b=gX8QpiZAHLYzhfxVQhOb84P1uAAdf/VuAHeMgSWX5SeymPhzfA2gK5L0LcrxuM2DMX5LR1PhoAsDS/45gCqbP1pZnnzsQc+DM8FkiGz8UwUUagu0QQjGcasME4QQIvzAKAkAjKP+tGLStXXpNwDpF9Ux3dePsp2kQVA5CzaTxJxUAsNk4AfH3++YjMmF4IOUDaTHKScE7ddmHmAaX6IcY8UlKoUDhKJ9/iKCyaakU7kF4S97HhxuAh5zLW0EaM9zDskGB1ib0H9VqGxVRZpdLv4yot03dAU+ZAJNDYEqgXYW6Qh+KfcYxa1yqtfvLM7ijCq/PGfcLVGUBTXhRg90ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785416519; c=relaxed/relaxed;
	bh=uyU7X76i+e8E7yQqacQR4ragkI1o7raXwMfTxUimAok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdxsWKiz6Z67iVHtMB/S17IfeYgrZsoU9bGqAIO6h9SlSmA+D+7MNo0hGH62qRMx+bUhoRQtJ+fwx632xLzNJAVXcX7xjsJ5cobaQ8I7IB6HZ8oQ5kTNAj1bUFqOsVA7BLfj5/xoM+c1grLyr/DqTt8mhFl+6GneYfKgeBBLM/XFxU2Gn2G9ftr3qjbnnZzP223tPZzyEoBQziDUzDD8U0bDF1UL4kq6fDNagH0YvNOQm7F54Vaf5szjwIhh+URcEDMmPjlKLzTzA1RcSvQp6TuiEkZ3JsB6zHntxNAd12ZNkqmSWZvN8uvrmiR5QYwhJw/mxWTj7hCBQm9VUjYeQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k00RJBpP; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k00RJBpP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9q925zR5z2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 23:01:58 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHofn2638756;
	Thu, 30 Jul 2026 13:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uyU7X7
	6i+e8E7yQqacQR4ragkI1o7raXwMfTxUimAok=; b=k00RJBpP+si9MlLGAkaBvM
	MR5fBk8Y6rjpSwkb3sdS/PKjRDnHcjTMNSzU7dbV9NZR2/ryPxHQMcuu7kHDLZmK
	QWnTW2XwDO8Rg5x0fgfsPDq90UEWNfwft/OU1zEAfHnQdmjL4geG3vt+/dWqDr+W
	lSh5eaCkO7q//CTHTcg4SsLMdX5btrywq9wD0pnPfp+281cohPT9jJZ4/fg3fBlP
	OF1+EQhpPwqjJXHbmCgsFbo/IGzecAGaptgZjkfcTTwYuMAATfWUWf602dLKytaC
	pJRTkTDmsBIXuNEI2cXQfE001UNagIvaJ7v5cxvYKggR3yjK6VSjrfciSLcMZFHA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nxwss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:01:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UCuKuX027349;
	Thu, 30 Jul 2026 13:01:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgk7nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:01:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UD1F9148103786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 13:01:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04E7220067;
	Thu, 30 Jul 2026 13:01:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F33D22004B;
	Thu, 30 Jul 2026 13:01:12 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 13:01:12 +0000 (GMT)
Message-ID: <0152cea9-cce4-4b68-8684-d82fb1c22233@linux.ibm.com>
Date: Thu, 30 Jul 2026 18:31:12 +0530
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
To: paulmck@kernel.org
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jirka Hladky <jhladky@redhat.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com,
        bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <f81777c3-e341-4ec5-8d61-b333d7170b3f@kernel.org>
 <82752e9b-ed94-4253-ac5f-83cd3c91d569@linux.ibm.com>
 <39449915-04f2-4259-a6d9-1a2c1fcf9a63@paulmck-laptop>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <39449915-04f2-4259-a6d9-1a2c1fcf9a63@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfX8Wq770sQaHqY
 f6l7oJfbt3A5ztpiofkFWpT3dX4RN/9CgbTe+CmafCI08fswCC5vSxN9fQIYlZvpTHxX44MnEoL
 vqdhVZvz4TjzTg9emrIZjes7zv24o0E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfX55ClSxLB8gFd
 F78xla6ZxmwNoCfo/e7wwxRWmHbiCsPyeFlwIycL43Ufn9UrnJd9vdyEJC+shbqZz25g4ucuUnv
 HeQeJA+eAXm6FSoEclU8WrGQlHzIO5D1EjT/NKMx8MWxx+D+kO82ohyK3xY6chn2XusLFqU/bAZ
 sui6iud4c5jXF+UFgoZUGjgJUWp5FW5WJa7qSlBt064EC+g2u/A0bAV8SucmZ3yxoGHwinVP5ir
 9BY7OP0EJaIR5Mzw09JwB0Erj3T6XtXuSplAp5wktzdVi+5I1AFZXGMb42pZVsNQOVcXGhTDbIA
 0x4AQjJmEeUcAssG1qaqsHLmT76Gj+R1QS5yFenUsY3AjG4oD+C87QLgdDOuK11kPsNdkMaZl+b
 ipNkM4/9rNYeucjb8mr63DLJUwZ/TnEWUemlzYc1DaJ+znL6pX/0IoQy/3OD+Ss6mWpR/DJkwCO
 qMfqAIdCwNoUDs8Z0aQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6b4b1e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=D4N2UL2RXnNBGA_rMeAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8su5u_VZDGKJMUDr9fMUGkB2baERt-1D
X-Proofpoint-ORIG-GUID: _RwBONXnhhe-unIgu1GbultiCJVDDaP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300096

Hi Paul. Thanks for taking time looking into this.

>> In current upstream, lazy is a preemption mode with preempt_enable being a preemptible point,
>>
>> 1. If PREEMPT_LAZY=y and PREEMPT_DYNAMIC=n, then PREEMPT_RCU=n. That seems wrong. It is supposed to
>>     do the preemption checks, since preempt_count is actual count with lazy preemption.
> 
> Sorry, but no, not wrong at all.  This is the way that it is supposed
> to be.  In this configuration, RCU readers explicitly disable preemption.
> This gets us minimal RCU overhead on architectures such as x86 and arm64
> that have prohibited CONFIG_PREEMPT_NONE and CONFIG_PREEMPT_VOLUNTARY.

This is after 7.0 only right? Before that one could choose even on x86 and arm64 IIUC.
After 7.0, even on powerpc, one cannot choose them anymore.

> Not zero overhead, but minimal overhead given the constraints imposed by
> CONFIG_PREEMPT_LAZY.  This also prevents preemption of RCU readers, which
> is extremely important on datacenter servers that have good and sufficient
> quantities of memory, but which are not well-endowed with memory.
> 
>> 2. PREEMPT_LAZY=y and PREEMPT_DYNAMIC=n and PREEMPT_LAZY=y and PREEMPT_DYNAMIC=y are supposed
>>     to be similar w.r.t to performance.
> 
> RCU never made that promise.  ;-)
> 
> With PREMPT_DYNAMIC=y, RCU has no choice but to be preemptible, at
> least unless and until someone decides to make RCU's preemptibility be
> changeable at runtime (which I do not recommend).  And we really do need
> non-preemptible RCU for server workloads.


most of the distros i see set PREMPT_DYNAMIC=y.
I checked in SLES, RHEL. (I could be wrong here)

> 
> So it is not just that RCU never made that promise, it is that RCU cannot
> reasonably make that promise.
> 
>>                                         Promise of PREEMPT_DYNAMIC was the ability to
>>     switch at runtime based on the user workload and his/her preference.
>>     But with  PREEMPT_LAZY=y and PREEMPT_DYNAMIC=y, there is additional cost due to PREEMPT_RCU.
>>     lazy being the middle ground w.r.t for decent performance, either PREEMPT_RCU should either kick in
>>     for both cases or bail out for both.
> 
> Absolutely not!!!  Please see above.
> 
>> Before 7.0
>> 3. the same concerns would be true to PREEMPT_VOLUNTARY and PREEMPT_NONE with PREEMPT_DYNAMIC=y.
>>     Those model never wanted a preemption, but PREEMPT_RCU could have forced a need_resched to be
>>     set. Which is also likely wrong. No?
> 
> You lost me on this one.  Please give me an explicit sequence of events
> that would cause things to go wrong in this case.

You are right. PREEMPT_RCU may set need_resched. But even then on none/voluntary
schedule will not be called since static keys it cannot.




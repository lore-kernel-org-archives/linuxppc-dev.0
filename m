Return-Path: <linuxppc-dev+bounces-29613-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F65CCCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 21:20:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5yX519dBz2y1W;
	Sat, 17 Oct 2026 08:20:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792185621;
	cv=none; b=ZUp+Y84GntdLFbGJhVZFXPLiffxjfB72gluFxF5SMlQD9SS9HMSlloE/HypN3GnmgnJlg1snlZGU80pHIXGM3sGbNboCN221Geo1PdWRnjWJ0BOoT4pSsN4Vl9OkUE3zL81Sj7wqTKtXzgIu4kw3A4vOgU0GHuzQ5+trqR8ha/yQNJv87SUa1KPEio4DsT7KWisGmc/H4H4eQmRU6q0C2DPrH50W8XTANp9gfYtxLO5QvvdlL/mVxI+SFCdgF6iukhxaLzuDj9rEDuTy/TNeUA5x2q5/J6EtvwdkLqEJZ2jrH32qIwPlJwvOQlQskRoAHRflTFeDjGeNEtB3KEfKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792185621; c=relaxed/relaxed;
	bh=xNPZw3EXSZ4uPiOZfoHoPbFl9PKDY4YhWD1OfoEY5XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzmDQSQiSHgUXkZnpWcu3Syd9JG4avIH/kLGOHV+3hHH4yMF53bt/gX74fcB0dXbIyMZqrc0QbPZw+ekhOxAzwmWotE3rLSN5kA1j/X4hVVgq5wFY6jo4HfZ5kSsGNRs5a2f8dzBQ7T4IdWUIgD7/02ehwye7ivPiViqSkVuDFRI77s6dHO/LzpcjphIuYAMK3/OyPWa0pPW0Pgy+e7oks5K8GCI0l+4ZvLTn+WggM/76+Izd4ljY89fID8saUUYpKRhMMSYk2atzwKBpzYQPX6QV1dvBkdO/lfBrWYUVOwyB9voU4pbK+UbfGZP0Km0ZBsow4UMMrltt7DBjGDsFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EgU4zL2z; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EgU4zL2z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5yX4341lz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 08:20:19 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GJiVVm490428;
	Fri, 16 Oct 2026 21:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xNPZw3
	EXSZ4uPiOZfoHoPbFl9PKDY4YhWD1OfoEY5XM=; b=EgU4zL2z5Z3ACfQgm9YYeA
	1fne1LemoT36UHHAGYYzoZH9vt/JRw9kqpFILWJmG5lR1JugUkgQ4prOEPiHb9oa
	Xzf9AhCkooX9waQTcDUZ5/36erULE3ftofRk+Eyw3m9L4cG5NApO1ObNn2ax6RQ9
	jJVY7m4cgVH/HY6USwIc65cFX9ElOFiDLal8W3O9AGSX0VoLTvXJuCHwK6C9ImaY
	bwnxQBFELop56xFQldWhe3R1MuNO9/iJ6IIx+f8jh91J/mYt0s8lfcT5K38I+niT
	e4B3sgsYW8ctBN4C/QcUkwqlniqMcUM+SwgUJb5T5f0RPpmslSdrzsV2y+oO+8gw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv41jcm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:19:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GJo89t2965759;
	Fri, 16 Oct 2026 21:19:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hbne4sg7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:19:51 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GLJohX32899590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 21:19:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21EA358059;
	Fri, 16 Oct 2026 21:19:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1CE158067;
	Fri, 16 Oct 2026 21:19:46 +0000 (GMT)
Received: from [9.67.103.235] (unknown [9.67.103.235])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 21:19:46 +0000 (GMT)
Message-ID: <de6d786b-fdbd-42f8-b2c9-b175a6a33c69@linux.ibm.com>
Date: Fri, 16 Oct 2026 14:19:46 -0700
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
Subject: Re: [PATCH net-next v4 1/6] ibmvnic: Move long delayed work on
 system_dfl_long_wq
To: Marco Crivellari <marco.crivellari@suse.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Haren Myneni <haren@linux.ibm.com>,
        Rick Lindsley <ricklind@linux.ibm.com>,
        Nick Child <nnac123@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20261012095452.135828-1-marco.crivellari@suse.com>
 <20261012095452.135828-2-marco.crivellari@suse.com>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20261012095452.135828-2-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LGXgFU0TpwWO4Rmjiw6wRlCKA4EQoH_L
X-Proofpoint-ORIG-GUID: TjZICohO1dTAQx0xDC9FPrm7GTarATKr
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6ad294f9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=voM4FWlXAAAA:8 a=iox4zFpeAAAA:8
 a=tkcf6-MeEqR6izG4hBoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=IC2XNlieTeVoXbcui8wp:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4NCBTYWx0ZWRfX0bt0ILkmD9/o
 jTvfNCQLa1mQGB/qU9SmRmSyCy5cu6kye+YCQsWqwlXlzFl5nj/HnIpudSINruK9rVsCdUTSVvy
 /I0QQ5fxZglk3YjzxiKRNLMgy/Yczb8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4NCBTYWx0ZWRfXxB+JlbBJyzI3
 Acx+6yxotE9DfpYHkf7VC14+iL7TU8Hkt15f+nOtqxnd7LARup7oYoSbbqmTh+mD+yqBolAZafH
 yldDBD2tWVkwoWks82qds8rjeJJ9Xtxklko5ODfDfdWcc2BN0gmcE6v/MZKAThuQXlYRBm7p/K9
 bKhLIuUtrfOP/V0bGnxH/NHPuUBCYPDh+DHAvTKzzk3tEFxWD0cYFjGIIFWEKhERFSsZtIMzPfj
 3l4voCqS1xDaESbmSKwkAMQZ7rnEcIYo15yhsMnGDF282GmxBFeYuKBh9N+vyRQbv2CIxpOXoFj
 Z2atUTKMJhOZILSlv0SJQWakYrfyA53cy5MZf2s796AnetRBgL/qgra21Y0d28kxzekHwfaHt7v
 XNqjgbdwOFMczd8sWJ5K684vumk87mkCXJV8uA4MYdRCMGyzBQG/+mYbZzzTUploGq3z0gqTIZx
 8kdTtEk5emp9CPiF64w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160084

On 10/12/26 2:54 AM, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
> 
> The function(s) end up calling __queue_delayed_work(), which set a global
> timer that could fire anywhere, enqueuing the work where the timer fired.
> 
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a single
> CPU.
> 
> Recently, a new unbound workqueue specific for long running work has
> been added:
> 
>      c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
> 
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit from
> scheduler task placement.
> 
> Cc: Haren Myneni <haren@linux.ibm.com>
> Cc: Rick Lindsley <ricklind@linux.ibm.com>
> Cc: Nick Child <nnac123@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>   drivers/net/ethernet/ibm/ibmvnic.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 5a510eed335e..d4c284c8ef43 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -3229,7 +3229,7 @@ static void __ibmvnic_reset(struct work_struct *work)
>   	if (adapter->state == VNIC_PROBING &&
>   	    !wait_for_completion_timeout(&adapter->probe_done, timeout)) {
>   		dev_err(dev, "Reset thread timed out on probe");
> -		queue_delayed_work(system_long_wq,
> +		queue_delayed_work(system_dfl_long_wq,
>   				   &adapter->ibmvnic_delayed_reset,
>   				   IBMVNIC_RESET_DELAY);
>   		return;
> @@ -3267,7 +3267,7 @@ static void __ibmvnic_reset(struct work_struct *work)
>   	spin_lock(&adapter->rwi_lock);
>   	if (!list_empty(&adapter->rwi_list)) {
>   		if (test_and_set_bit_lock(0, &adapter->resetting)) {
> -			queue_delayed_work(system_long_wq,
> +			queue_delayed_work(system_dfl_long_wq,
>   					   &adapter->ibmvnic_delayed_reset,
>   					   IBMVNIC_RESET_DELAY);
>   		} else {
> @@ -3454,7 +3454,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
>   	list_add_tail(&rwi->list, &adapter->rwi_list);
>   	netdev_dbg(adapter->netdev, "Scheduling reset (reason %s)\n",
>   		   reset_reason_to_string(reason));
> -	queue_work(system_long_wq, &adapter->ibmvnic_reset);
> +	queue_work(system_dfl_long_wq, &adapter->ibmvnic_reset);
>   
>   	ret = 0;
>   err:
On 10/12/26 2:54 AM, Marco Crivellari wrote:
 > Currently the code enqueue work items using {queue|mod}_delayed_work(),
 > using system_long_wq. This workqueue should be used when long works are
 > expected and it is a per-cpu workqueue.
 >
 > The function(s) end up calling __queue_delayed_work(), which set a global
 > timer that could fire anywhere, enqueuing the work where the timer fired.
 >
 > Unbound works could benefit from scheduler task placement, to optimize
 > performance and power consumption. Long work shouldn't stick to a single
 > CPU.
 >
 > Recently, a new unbound workqueue specific for long running work has
 > been added:
 >
 >      c116737e972e ("workqueue: Add system_dfl_long_wq for long 
unbound works")
 >
 > Since the workqueue work doesn't rely on per-cpu variables, there is no
 > obvious reason that justify the use of a per-cpu workqueue. So change
 > system_long_wq with system_dfl_long_wq so that the work may benefit from
 > scheduler task placement.
 >
 > Cc: Haren Myneni <haren@linux.ibm.com>
 > Cc: Rick Lindsley <ricklind@linux.ibm.com>
 > Cc: Nick Child <nnac123@linux.ibm.com>
 > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
 > Cc: Michael Ellerman <mpe@ellerman.id.au>
 > Cc: Nicholas Piggin <npiggin@gmail.com>
 > Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
 > Cc: linuxppc-dev@lists.ozlabs.org
 > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
 > ---
 >   drivers/net/ethernet/ibm/ibmvnic.c | 6 +++---
 >   1 file changed, 3 insertions(+), 3 deletions(-)
 >
 > diff --git a/drivers/net/ethernet/ibm/ibmvnic.c 
b/drivers/net/ethernet/ibm/ibmvnic.c
 > index 5a510eed335e..d4c284c8ef43 100644
 > --- a/drivers/net/ethernet/ibm/ibmvnic.c
 > +++ b/drivers/net/ethernet/ibm/ibmvnic.c
 > @@ -3229,7 +3229,7 @@ static void __ibmvnic_reset(struct work_struct 
*work)
 >   	if (adapter->state == VNIC_PROBING &&
 >   	    !wait_for_completion_timeout(&adapter->probe_done, timeout)) {
 >   		dev_err(dev, "Reset thread timed out on probe");
 > -		queue_delayed_work(system_long_wq,
 > +		queue_delayed_work(system_dfl_long_wq,
 >   				   &adapter->ibmvnic_delayed_reset,
 >   				   IBMVNIC_RESET_DELAY);
 >   		return;
 > @@ -3267,7 +3267,7 @@ static void __ibmvnic_reset(struct work_struct 
*work)
 >   	spin_lock(&adapter->rwi_lock);
 >   	if (!list_empty(&adapter->rwi_list)) {
 >   		if (test_and_set_bit_lock(0, &adapter->resetting)) {
 > -			queue_delayed_work(system_long_wq,
 > +			queue_delayed_work(system_dfl_long_wq,
 >   					   &adapter->ibmvnic_delayed_reset,
 >   					   IBMVNIC_RESET_DELAY);
 >   		} else {
 > @@ -3454,7 +3454,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter 
*adapter,
 >   	list_add_tail(&rwi->list, &adapter->rwi_list);
 >   	netdev_dbg(adapter->netdev, "Scheduling reset (reason %s)\n",
 >   		   reset_reason_to_string(reason));
 > -	queue_work(system_long_wq, &adapter->ibmvnic_reset);
 > +	queue_work(system_dfl_long_wq, &adapter->ibmvnic_reset);
 >
 >   	ret = 0;
 >   err:
I walked through the reset path and the conversion looks fine.

All three system_long_wq users move together and there are no
remaining users in the driver. The work items don't rely on per-CPU
state, so system_dfl_long_wq seems appropriate here.

Minor commit message nit: ibmvnic doesn't use mod_delayed_work(), and
one of the conversions is queue_work() rather than delayed work.

Acked-by: Mingming Cao <mmc@linux.ibm.com>


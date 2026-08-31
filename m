Return-Path: <linuxppc-dev+bounces-26336-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DC1C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 19:11:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYdrR4SvWz2xlv;
	Tue, 01 Sep 2026 05:11:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788203479;
	cv=none; b=bvOyPWEhu7IWMU9e5GxgjPzhdWPyBUq3yTA2NF5PZwDleOcUOqKC4BgvkY9BxqBwcSb2d/Fom1TtQeqKlM+LLbQCh16HPVR8aq2yiBtrW3DERVQoYN4Tr/X/LQ6jT2c/sJT7twMNnvrY+AWe/oQ6Wrslt49eTVt57MzZN/+D/T0pnuILQNeHqbC+2JhBpai8laM+qpCXGQ0eNX1Oun+l3U9GUckJaSVVV4hbCp/5jbdUqP6q1LvfXeJLcOgUtZSb3DAel7xIfcThO3NKb8v7NDNsQNJAMq/bRd+9T378FzRo2kx8yVRnre1t5ixfhgDdPigiXXKanDbne7m+H1UQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788203479; c=relaxed/relaxed;
	bh=tDfrXH3FbECqGftHJ31kqIWCcDEg8Crq8mIdsA7x2OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hayJ4K5wSw87fNLac75nSlyGxRwEjrEd+Yeu7wETS/dRqHyr24SajvhfpXOej6jM5AwszsZXuEMa/BzDTQMl4WccF2WQs05FlKXnftruKzTxTUujNkZon3CMT8K3nnZ4U0FFzmNX5UkS1J6CHhnQrYnMHs3cY7cUJDgsVAx5+qLVeqxY7u3xG4Bl3/Oi9qwQA/MMexcWyp3cC/8pTz7eweUmz/aOoskFgRY4u7/clPX7NuX8Fxn9ptM4Wkw0kG5cEGsNZ4OuExQewvAEel43MrPyDMk83/JHe4CeQENA+j+/gBAhNy4R68V1CUzMnnVNYNNIsgUnU4Z4Hi/eQDSTEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RzMMedsz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RzMMedsz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYdrQ3G5kz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 05:11:18 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VIVY8W1234903;
	Mon, 31 Aug 2026 19:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tDfrXH
	3FbECqGftHJ31kqIWCcDEg8Crq8mIdsA7x2OM=; b=RzMMedszMaxMLY14eTqv6D
	NFFgzgkVVaz0sgbMZ718cqKbA1115sqTqH7LM24iBPL/bG2OvGWicuDGg73hkh/P
	aeF3oZOfx14OtoBBB5DOZnc194QncguPSWpUJnpEOKgC9ykRO9IUzUYpwO+Xd0P8
	73r6EWQtkzmRtSi9ovu1GCLO6JwCymR760Qh6LjXEeAHeE+Sg2p+qawcpM8Hp3Mj
	KtRArjVWrwDoEeh32hj2cuT2ETnYM8qBtS4QgHlHMzpAHv7LomGKMuRFPvP3qzpo
	93OLcaDnDQjntY7GqTjqMycsj2bL9qmUqQqDwCDqvdbOD4dg2wogMSVswmUqckxQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r3af4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:11:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VIuK6B019217;
	Mon, 31 Aug 2026 19:11:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq7swt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:11:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VJB4n622676092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 19:11:04 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DAB85805A;
	Mon, 31 Aug 2026 19:11:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E488C5803F;
	Mon, 31 Aug 2026 19:11:00 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 19:11:00 +0000 (GMT)
Message-ID: <243fb549-22d2-407c-8774-d3ade7882958@linux.ibm.com>
Date: Mon, 31 Aug 2026 12:10:59 -0700
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
Subject: Re: [PATCH net-next v5 10/15] ibmveth: Enable multi-queue RX receive
 path
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-11-mmc@linux.ibm.com>
 <20260818014731.3854329-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014731.3854329-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a95d1cd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=XooLvho-Rdvj1YGKgw8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfXxRYBeDlQnKPY
 oUTmkbRjYX1OCvSPWbdvWzjqLA6rn8OzJKFGKlQ5UgCLWvTiErtEtXtEhkvYiLHmM7vfLAW56cr
 0b0a3OtDcyAMnuqD5TUd6VVJdmqW5CBl843AcfbAQE6R2zQqq08pM9ya5ffvlUc57GUDDJY7ED2
 W9fLglhK9ieFEikZ4IQg2MyrJY+5dolJqAZloUXufRATuBbBf8uHaksCKyBqN6SLXOj5xobVyPs
 dFo3XfevmrJJ9Acf+y2h93uHpq/o5Ri1PbZ+VzkIYuT8LNT825f2zfd0IhYmtilio4cBKVPRoRx
 WZDCyiPrkNivy52PqwW7/IsmfR983L6eSA1QS7YZmzHdtnjAkvD6s/rFtD2Wntq9lQ+77h6l3Kx
 +MCyY/dwDclWL5Wk/bno0yUc52u/3g77uuxpsvxWbCXZ1V843zRs1SAoUbCcRtw8bzv7p+GhgvK
 ooTThSzP3mTTVAvfafw==
X-Proofpoint-GUID: 06V3egbzBvywCpXM9uIg2ohWi_W3gDLa
X-Proofpoint-ORIG-GUID: hAaaq8i1j8Dp1JRD6mY19Ngba1PmW9UQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfX1JvDXKh4dTW1
 amva9EjKE0l6f6+oLU4DWolH5hhCQtGBCGE7lI3jiFJZGdFn6bmB0elJr0Izk8ew3yth+icQZFx
 zSmkUcUCeGA9isQq6YAFScPxRpPQd6g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310164


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Enable multi-queue RX receive path
>
> This turns on the multi-queue RX path when firmware reports
> IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT, registering subordinate queues via
> H_REG_LOGICAL_LAN_QUEUE and wiring per-queue IRQs and NAPI instances. It
> also reworks open()/close() to walk every live RX queue, adds an
> mq_fallback latch, and refreshes the VIO CMO entitlement at probe.
>
> A few questions below.
>
> Regarding this part of the changelog:
>
>    Up to IBMVETH_MAX_RX_QUEUES (16) remains available via ethtool -L.
>
> [Severity: Low]
> Is that true at this commit?  ibmveth_get_channels() still does:
>
> 	channels->max_rx = netdev->real_num_rx_queues;
> 	channels->rx_count = netdev->real_num_rx_queues;
>
> and ibmveth_set_channels() never reads channels->rx_count, so an
> "ethtool -L <dev> rx N" returns success without changing anything, and 16
> RX queues cannot be requested until the later get_channels/set_channels
> patches land.  Could this sentence move to the patch that actually wires
> rx_count up?
No, not at this commit. get_channels still echoes real_num_rx_queues
and set_channels is still TX-only, so ethtool -L rx N succeeds without
changing RX.

v6 drops that sentence here. Patch 14 is the one that reads
channels->rx_count and calls resize. Patch 12 only reports the counts.
Patch 15 finishes the down-path and caps max_rx once mq_fallback
latches; it does not wire the setter.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 86299c62d4ecf..36f0926711e60 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -503,7 +519,7 @@ static int
>>   ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
>>   {
>>   	struct net_device *netdev = adapter->netdev;
>> -	int i, rc, num = adapter->num_rx_queues;
>> +	int i, rc, num = ibmveth_get_num_rx_queues(adapter);
>>   
>>   	for (i = 0; i < num; i++) {
>>   		if (!adapter->queue_irq[i]) {
> [Severity: Low]
> Now that this function can enable PHYP delivery on several queues, can the
> err_disable_napi rollback leave a queue armed with no handler?
>
> The rollback masks the already-enabled queues and calls synchronize_irq(),
> but synchronize_irq() does not wait for NAPI.  A poll already running for
> one of those queues reaches:
>
> 	if (ibmveth_poll_stopping(netdev, napi))
> 		goto out;
>
> 	rc = ibmveth_enable_irq(adapter, queue_index);
>
> ibmveth_poll_stopping() is "!netif_running(netdev) || napi_disable_pending()",
> and __dev_open() sets __LINK_STATE_START before calling ndo_open, so it is
> false here and the poll re-arms PHYP.  err_disable_napi then does:
>
> 	for (i = 0; i < num; i++)
> 		napi_disable(&adapter->napi[i]);
> 	for (i = 0; i < num; i++) {
> 		if (adapter->queue_irq[i])
> 			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
> 	}
>
> with no second mask pass, whereas ibmveth_cleanup_rx_interrupts()
> deliberately masks again after napi_disable().  Should the rollback follow
> the cleanup pattern and remask after napi_disable()?
Yes. Without a second mask after napi_disable, a poll still running
can re-arm PHYP after the first mask: poll_stopping is false during
open because __LINK_STATE_START is already set.

Already in patch 5: err_disable_napi remasks after napi_disable, same
as cleanup_rx_interrupts. This patch does not add a second rollback.

>> @@ -649,6 +665,24 @@ static bool ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
>>   	return false;
>>   }
>>   
>> +/**
>> + * ibmveth_kick_rx_queue_if_pending - Schedule NAPI if PHYP posted while masked
>> + * @adapter: ibmveth adapter
>> + * @queue_index: RX queue index just unmasked
>> + *
>> + * After enable_irq() / MQ open unmask, descriptors may already be pending
>> + * (buffers were posted while PHYP was masked). Use schedule_rx_queue() so
>> + * PHYP is masked before NAPI runs — napi_schedule() then disable_irq() from
>> + * process context can race a completing poll and leave the queue masked
>> + * with NAPI idle.
>> + */
>> +static void
>> +ibmveth_kick_rx_queue_if_pending(struct ibmveth_adapter *adapter,
>> +				 int queue_index)
>> +{
>> +	if (ibmveth_rxq_pending_buffer(adapter, queue_index))
>> +		ibmveth_schedule_rx_queue(adapter, queue_index);
>> +}
> [Severity: Low]
> Does this commit build on its own?  ibmveth_kick_rx_queue_if_pending() is a
> non-inline static function with no caller anywhere in the tree at this
> commit (open() uses ibmveth_restart_rx_queue() instead), so gcc/clang emit
> "defined but not used", which is fatal with the default CONFIG_WERROR=y.
>
> The first callers appear only in the later incremental resize patch.  Could
> the helper be introduced there instead, to keep this commit bisectable?
Yes. Unused static, fatal under CONFIG_WERROR. First-use: v6 deletes
it here. Patch 14 calls restart_rx_queue() at both sites that would
have used the helper, so there is nothing to move.

> Also, the blank line before the following comment block was dropped:
>
> 	+		ibmveth_schedule_rx_queue(adapter, queue_index);
> 	+}
> 	 /* setup the initial settings for a buffer pool */

Ah, its back now.


>> @@ -963,11 +997,21 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>>    * because there was not a buffer in the buffer list capable of holding
>>    * the frame.
>>    */
>> -static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>> +static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
>> +					int queue_index)
>>   {
>> -	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
>> +	__be64 *p;
>> +	u64 drops;
>> +
>> +	if (queue_index < 0 ||
>> +	    queue_index >= ibmveth_get_num_rx_queues(adapter) ||
>> +	    !adapter->buffer_list_addr[queue_index])
>> +		return;
>> +
>> +	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
>> +	drops = be64_to_cpup(p);
>>   
>> -	adapter->rx_no_buffer = be64_to_cpup(p);
>> +	adapter->rx_no_buffer = drops;
>>   }
> [Severity: Low]
> The function became queue-aware, but the store target is still the single
> adapter-wide field exported by ethtool -S.  With several RX queues, does
> rx_no_buffer end up being "whichever queue ran last", and can it decrease?
>
> Each queue reads its own absolute PHYP page counter and overwrites the same
> scalar, from per-queue replenish paths that hold different replenish_locks,
> plus the lock-free loop added in ibmveth_close():
>
> 	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
> 		ibmveth_update_rx_no_buffer(adapter, i);
>
> The next patch in the series ("ibmveth: Add per-queue RX and TX statistics
> collection") moves this to adapter->rx_qstats[queue_index] with a summing
> helper, so only this intermediate commit reports the wrong value.  Could
> the per-queue slot land together with the queue_index argument?
Yes, last-writer-wins, and it can go backwards when a later queue
stores a smaller PHYP page counter.

The per-queue slot stays in patch 11 with the rest of qstats, next to
the retired-queue carry so one queue owns both. Not here: this patch
is the MQ switch.
>> @@ -1033,6 +1077,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>>   		dev_err_ratelimited(&adapter->netdev->dev,
>>   				    "MQ buffer add H_FUNCTION (q=%d, batch=%u), reset\n",
>>   				    queue_index, fail.batch);
>> +		adapter->mq_fallback = true;
>>   		schedule_work(&adapter->work);
>>   	}
> [Severity: High]
> This isn't a bug introduced by this patch, but it adds another producer of
> adapter->work while ibmveth_remove() still cancels the work before the
> interface is unregistered:
>
> 	cancel_work_sync(&adapter->work);
> 	...
> 	unregister_netdev(netdev);
> 	free_netdev(netdev);
>
> Can this sequence use freed memory?
>
> CPU0 (rmmod / DLPAR remove)
>    ibmveth_remove()
>      cancel_work_sync(&adapter->work);   /* returns */
>
> CPU1 (NAPI poll)
>    ibmveth_replenish_task()
>      adapter->mq_fallback = true;
>      schedule_work(&adapter->work);      /* re-queued */
>
> CPU0
>      unregister_netdev(netdev);          /* holds RTNL */
>      free_netdev(netdev);                /* frees adapter + work_struct */
>
> The queued ibmveth_reset() blocks in rtnl_lock() while unregister_netdev()
> runs, then derives adapter via container_of() on the freed work_struct and
> touches adapter->netdev.  Would unregistering/quiescing first and calling
> cancel_work_sync() after be safer?
Yes, UAF at this commit: cancel returns, poll can schedule_work
again, then unregister/free runs while the worker still takes RTNL
and container_of on the freed work_struct.

Unregister first, then cancel_work_sync, is the right order. Patch 11
does that, and gates the worker on NETREG_REGISTERED so a reset that
is already past cancel cannot close/open after unregister. This patch
only adds the extra schedule_work producers.
>> @@ -1052,6 +1097,30 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>>   				     fail.filled, fail.lpar_rc, fail.batch);
>>   }
>>   
>> +/**
>> + * ibmveth_restart_rx_queue - Post buffers and ensure Q can take RX
>> + * @adapter: ibmveth adapter
>> + * @qindex: RX queue index
>> + *
>> + * SQ open leaves PHYP masked until the first poll. If schedule_prep fails,
>> + * NAPI never runs and the queue stays masked (TX OK, RX/ARP dead) until
>> + * reload. Replenish first so an enable_irq fallback can actually deliver.
>> + * Also used after every open (SQ and MQ) and after scale-down so a
>> + * queue is not left idle+masked.
>> + */
>> +static void ibmveth_restart_rx_queue(struct ibmveth_adapter *adapter,
>> +				     int qindex)
>> +{
>> +	int rc;
>> +
>> +	ibmveth_replenish_task(adapter, qindex);
>> +	if (ibmveth_schedule_rx_queue(adapter, qindex))
>> +		return;
>> +
>> +	rc = ibmveth_enable_irq(adapter, qindex);
>> +	WARN_ON(rc);
>> +}
> [Severity: Medium]
> The enable_irq() fallback here is reached exactly when
> napi_schedule_prep() failed, i.e. when a poll for that queue is already
> scheduled or running.  In MQ mode ibmveth_setup_rx_interrupts() has already
> unmasked PHYP before open() calls this helper, so a frame can arrive first:
>
>    ibmveth_interrupt(q)
>      ibmveth_schedule_rx_queue(q)   /* masks PHYP, schedules NAPI */
>
>    ibmveth_open()
>      ibmveth_restart_rx_queue(adapter, q)
>        napi_schedule_prep() == false
>        ibmveth_enable_irq(adapter, q);   /* re-arms PHYP mid-poll */
>
> Since ibmveth_schedule_rx_queue() masks PHYP only inside the successful
> prep branch:
>
> 	if (napi_schedule_prep(napi)) {
> 		rc = ibmveth_disable_irq(adapter, qindex);
> 		WARN_ON(rc);
> 		__napi_schedule(napi);
> 		return true;
> 	}
> 	return false;
>
> can the handler still quiesce the source afterwards?  Each subsequent
> interrupt returns IRQ_HANDLED without masking and sets NAPI_STATE_MISSED,
> so napi_complete_done() keeps returning false and the queue stays unmasked
> while traffic flows, giving an interrupt per frame on that queue.
>
> Related: this WARN_ON(rc) treats a failed unmask hcall as advisory, while
> ibmveth_poll() treats the same failure as a hardware-state problem:
>
> 	rc = ibmveth_enable_irq(adapter, queue_index);
> 	if (rc) {
> 		netdev_err(...);
> 		schedule_work(&adapter->work);
> 		goto out;
> 	}
>
> Should the two paths handle the failure the same way?
>
> Also, the comment says the helper is used "after scale-down", but no
> scale-down caller exists at this commit; that path arrives with the later
> resize patch.
No, later IRQs cannot quiet the source once the enable_irq fallback
has run: prep fails again, there is no mask, and you get IRQ_HANDLED
plus NAPI_STATE_MISSED until poll finishes.

That is the path we want. Mask-on-prep-fail raced poll and left RX
dead in the lab (TX still OK). enable-on-prep-fail stays. Storm
control is STOP plus poll no-rearm, not mask-on-fail.

The two enable_irq failures should not do the same thing. Poll is the
live path after complete_done; a failed unmask there is hardware-state
and schedules reset. restart_rx_queue is open/scale kickstart only;
scheduling reset from there nests close/open mid-open. v6 drops the
WARN_ON; the helper already logs the firmware rc.

The scale-down phrase is still in the kdoc. First caller is patch 14,
and it uses this same helper, so the comment is the helper's job at

the tip rather than a second function.


>
> [ ... ]
>
>> @@ -1556,10 +1757,12 @@ static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
>>    * @adapter: ibmveth adapter structure
>>    * @mac_address: MAC address for device registration
>>    *
>> - * Registers queue 0 via ibmveth_register_logical_lan(). Subordinate queue
>> - * registration is added when multi-queue RX is enabled.
>> + * Registers queue 0 via ibmveth_register_logical_lan(), then subordinate
>> + * queues 1..N when multi-queue mode is enabled.
>>    *
>> - * Return: 0 on success, -ENONET if queue 0 registration fails
>> + * Return: 0 on success, -ENONET if queue 0 registration fails,
>> + *         -EOPNOTSUPP if firmware rejects a subordinate queue (H_FUNCTION;
>> + *         caller latches mq_fallback), -EIO on other subordinate failures
> [Severity: Low]
> The kernel-doc says the caller latches mq_fallback, but the function body
> does it itself and ibmveth_open() only propagates rc.  Could the wording be
> changed to say this function latches adapter->mq_fallback, so a future
> change does not add a second latch or remove this one?
Yes. v6 says this function latches mq_fallback on -EOPNOTSUPP. open()
only propagates rc.
>> @@ -1592,9 +1796,67 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
>>   		return -ENONET;
>>   	}
>>   
>> +	num = ibmveth_get_num_rx_queues(adapter);
>> +	if (num == 1 || !adapter->multi_queue) {
>> +		netdev_dbg(netdev,
>> +			   "registered 1 RX queue with hypervisor (single-queue mode)\n");
>> +		return 0;
>> +	}
>> +
>> +	netdev_dbg(netdev, "Registering %d subordinate queues (1-%d)\n",
>> +		   num - 1, num - 1);
>> +
>> +	for (i = 1; i < num; i++) {
>> +		rc = ibmveth_register_single_rx_queue(adapter, i);
>> +		if (rc) {
>> +			/* Firmware MQ gone: fall back to SQ on next open. */
>> +			if (rc == -EOPNOTSUPP)
>> +				adapter->mq_fallback = true;
>> +			goto err_unregister;
>> +		}
>> +	}
> [Severity: High]
> Who performs the "next open" that consumes the latched mq_fallback?
>
> The only automatic recovery path is the reset work:
>
>    ibmveth_reset()
>      rtnl_lock();
>      dev_close(adapter->netdev);
>      dev_open(adapter->netdev, NULL);   /* return value discarded */
>      rtnl_unlock();
>
> If firmware stops honouring H_REG_LOGICAL_LAN_QUEUE (the LPM case the code
> comment describes), that dev_open() fails with -EOPNOTSUPP, mq_fallback is
> set, nothing looks at the error, and no further open is attempted.  Does
> the interface then stay administratively up but dead until an administrator
> runs ifdown/ifup, even though the driver already knows the single-queue
> retry would succeed?
>
> Would retrying single-queue inside open(), or re-arming the reset work when
> dev_open() fails, match the intent stated in the changelog?
apply_mq_fallback() runs at the start of open. The next successful
ndo_open consumes the latch, from admin ifdown/ifup or from reset's
dev_open when that open succeeds.

Yes: if reset's dev_open fails with -EOPNOTSUPP, the latch stays set,
the return is discarded, and the interface can stay administratively
up but dead until ifdown/ifup. Single-queue was not applied on that
failed open.

No retry inside open(), and reset does not re-arm when that
dev_open() fails. That is the "next open drops to SQ" rule, not a
retry loop.

> [ ... ]
>
>> @@ -2732,23 +3019,35 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
>>   
>>   	adapter = netdev_priv(netdev);
>>   
>> -	ret = IBMVETH_BUFF_LIST_SIZE + IBMVETH_FILT_LIST_SIZE;
>> +	/* One buffer list page per RX queue; filter list is shared. */
>> +	ret = IBMVETH_BUFF_LIST_SIZE * ibmveth_get_num_rx_queues(adapter) +
>> +	      IBMVETH_FILT_LIST_SIZE;
>>   	ret += IOMMU_PAGE_ALIGN(netdev->mtu, tbl);
>>   	/* add size of mapped tx buffers */
>>   	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);
> [Severity: Medium]
> This is a pre-existing shortfall rather than something this patch created,
> but since the function is being rewritten and its result now becomes the
> probe-time CMO request, should the TX term scale with the TX queue count?
>
> ibmveth_alloc_tx_resources() maps one long-term buffer per TX queue:
>
> 	for (i = 0; i < netdev->real_num_tx_queues; i++) {
> 		if (ibmveth_allocate_tx_ltb(adapter, i))
> 			goto err_free_ltbs;
> 	}
>
> with real_num_tx_queues defaulting to min(nr_cpus, 8), while the accounting
> above adds exactly one IBMVETH_MAX_TX_BUF_SIZE.  Can the requested
> entitlement be short by up to 7 x 64KB, so that dma_map_single() in
> ibmveth_allocate_tx_ltb() fails at open on an entitlement-constrained
> partition?  vio_cmo_set_dev_desired() returns void, so the shortfall is
> silent.
Yes. One IBMVETH_MAX_TX_BUF_SIZE against up to eight mapped LTBs can
be short by 7×64KB; vio_cmo_set_dev_desired() is void, so the
shortfall is silent and dma_map_single() can fail at open.

Not in this patch. TX-term scaling is on the cover leftovers list
with the rest of the CMO refresh.

> [ ... ]
>
>> @@ -2895,16 +3206,29 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   		netdev->features |= NETIF_F_FRAGLIST;
>>   	}
>>   
>> -	/* Initialize queue count - always 1 for now */
>> -	adapter->multi_queue = 0;
>> -	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
>> +	if (ret == H_SUCCESS &&
>> +	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
>> +		adapter->multi_queue = 1;
>> +		ibmveth_publish_num_rx_queues(adapter,
>> +					      min(num_online_cpus(),
>> +						  IBMVETH_DEFAULT_QUEUES));
>> +		netdev_dbg(netdev, "RX multi queue mode enabled: %d queues\n",
>> +			   ibmveth_get_num_rx_queues(adapter));
>> +	} else {
>> +		adapter->multi_queue = 0;
>> +		ibmveth_publish_num_rx_queues(adapter,
>> +					      IBMVETH_DEFAULT_RX_QUEUES);
>> +	}
> [Severity: Medium]
> Activating several RX NAPI instances makes a number of adapter-wide
> counters multi-writer.  Can these lose increments?
>
> ibmveth_replenish_task() bumps a shared counter outside any lock:
>
> 	adapter->replenish_task_cycles++;
>
> 	spin_lock_irqsave(&rxq->replenish_lock, flags);
>
> and ibmveth_replenish_buffer_pool() updates shared counters under only the
> queue-local lock:
>
> 	adapter->replenish_add_buff_success += filled;
>
> Per-queue replenish_locks give no mutual exclusion between different
> queues, so plain read-modify-write on replenish_task_cycles,
> replenish_add_buff_success/failure, replenish_no_mem and
> hcall_stats.add_bufs_queue races.  At this commit rx_invalid_buffer,
> rx_large_packets and netdev->stats.rx_packets/rx_bytes are in the same
> situation; the following qstats patch moves those to per-queue storage, but
> the replenish counters remain shared through the end of the series.  Should
> they get per-queue slots as well?
Yes. Plain u64 RMW can lose increments: replenish_task_cycles is
outside any lock, and per-queue replenish_locks do not serialise
different queues.

Patch 11 moves replenish_* into the per-queue structs as plain u64,
summed on the existing adapter-wide keys. Pools are already per
queue, so that matches the lock. The eight hypercall counters are
gone (patch 7); they are not ethtool keys. No atomics.

>> @@ -2922,25 +3246,62 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   
>>   	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>>   		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
>> -		int error;
>>   
>>   		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
>>   					 pool_count[i], pool_size[i],
>>   					 pool_active[i]);
>> -		error = kobject_init_and_add(kobj, &ktype_veth_pool,
>> -					     &dev->dev.kobj, "pool%d", i);
>> -		if (!error)
>> -			kobject_uevent(kobj, KOBJ_ADD);
>> +		rc = kobject_init_and_add(kobj, &ktype_veth_pool,
>> +					  &dev->dev.kobj, "pool%d", i);
>> +		if (rc) {
>> +			dev_err(&dev->dev,
>> +				"failed to create pool%d kobject: %d\n", i, rc);
>> +			/* init_and_add takes a ref even on failure */
>> +			kobject_put(kobj);
>> +			ibmveth_put_pool_kobjs(adapter, pools_ready);
>> +			dev_set_drvdata(&dev->dev, NULL);
>> +			free_netdev(netdev);
>> +			return rc;
>> +		}
>> +
>> +		pools_ready++;
>> +		kobject_uevent(kobj, KOBJ_ADD);
>>   	}
> [Severity: Low]
> This is a pre-existing problem being repaired rather than a new one, but
> propagating kobject_init_and_add() failure and putting already-created pool
> kobjects before free_netdev() is a standalone fix for probe error handling
> that predates the MQ work.  Could it be split into its own patch with a
> Fixes: tag so it can be backported independently of this feature?
Yes, pre-existing, and it predates MQ. The put-before-free stays in
this series so a bisect does not leak. probe_cleanup lands in patch
11. Happy to send a standalone to net the same way as the reopen
unwind, if you would rather pick it up that way.

> [Severity: Medium]
> This isn't a bug introduced by this patch either (ibmveth_remove() already
> does kobject_put() followed by free_netdev()), but the pattern is now
> replicated in four new probe error paths.  Can these free memory that a
> deferred kobject release still uses?
>
> ktype_veth_pool has no release callback:
>
> 	static const struct kobj_type ktype_veth_pool = {
> 		.release        = NULL,
> 		.sysfs_ops      = &veth_pool_ops,
> 		.default_groups = veth_pool_groups,
> 	};
>
> and the kobjects live inside netdev_priv().  With
> CONFIG_DEBUG_KOBJECT_RELEASE=y, kobject_release() in lib/kobject.c does not
> clean up synchronously:
>
> 	unsigned long delay = HZ + HZ * get_random_u32_below(4);
> 	...
> 	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
>
> 	schedule_delayed_work(&kobj->release, delay);
>
> The delayed_work lives inside the kobject, so free_netdev() right after
> kobject_put() leaves a queued work item in freed memory and
> kobject_delayed_cleanup() dereferences a freed kobj 1-5 seconds later.
> Would a no-op .release for ktype_veth_pool, or deferring free_netdev()
> until the kobjects are really gone, avoid that?
Yes. With CONFIG_DEBUG_KOBJECT_RELEASE=y, kobject_put() then
free_netdev() can touch freed memory: the delayed_work lives inside
the kobject in netdev_priv(). This patch copies the same pattern onto
the probe error paths.

A no-op .release or deferring free_netdev() would close it. Not in
this series; it is on the cover leftovers list.

>> +	/*
>> +	 * VIO CMO entitlement was set before probe (netdev NULL → default).
>> +	 * Recompute now that num_rx_queues and pool 0 metadata are known.
>> +	 */
>> +	if (firmware_has_feature(FW_FEATURE_CMO))
>> +		vio_cmo_set_dev_desired(dev, ibmveth_get_desired_dma(dev));
>> +
>>   	rc = netif_set_real_num_tx_queues(netdev, min(num_online_cpus(),
>>   						      IBMVETH_DEFAULT_QUEUES));
>>   	if (rc) {
>>   		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
>>   			   rc);
>> +		ibmveth_put_pool_kobjs(adapter, pools_ready);
>> +		dev_set_drvdata(&dev->dev, NULL);
>>   		free_netdev(netdev);
>>   		return rc;
>>   	}
> [ ... ]
>
> Cross-instance finding from sashiko-gemini (91dce8e1ae8c5dfd96a2db94571e030c1951674452013e31a94e2df21bfc801b):
> [Severity: Medium]
> Missing `smp_rmb()` in `ibmveth_get_num_rx_queues` allows out-of-order reads of uninitialized queue data.
v6 publishes with smp_store_release() and the getter uses
smp_load_acquire(), instead of smp_wmb() plus WRITE_ONCE / READ_ONCE.

That is the pair. No extra smp_rmb().

Thanks,

Mingming



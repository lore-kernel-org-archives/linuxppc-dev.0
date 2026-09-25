Return-Path: <linuxppc-dev+bounces-28178-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26408C98306
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:49:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrhBk5z8Kz2y2J;
	Fri, 25 Sep 2026 16:49:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790318958;
	cv=none; b=oHTE8Qe2EWtvxJf8g2rPonC+a1urH2F7dwLpb5l04PYdDo8T2cwa9eEBlrkFVsqOaurof/8EgltSljovtMzdGgcu/tJh1T07H6lDtU5hRVe23EVXXzCVGvb9d5nafBxMNauR/veFHJwZ4ZcXuOPzDbXDHaSUGADi+v8MbPeJu3/i3rUDMZSejaiss9NsX6H4SbAyEfOSZg8w09+cT2gzHKTLhU7emOSpIabiZRGHp3Efhz2DbSmyWfBmwfwy3RILtMMaVn3bI6S3asT5DOIX55eOWYqmWeFHUs5/BRIlbRujbamNVF2LRCHKFLPOd/PI3W4gq0q4aZtEh9qTmeZpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790318958; c=relaxed/relaxed;
	bh=k/xe+ULOLZjYDf8Cpv5Sa1oCJ54GSHNH9o5UNzMhgQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4RbenjGbg0Gz0WhJKIncf30w+sv4UiHeNy+82EgEl//7PKw8WpMvrOf0Y02kC5ua3CR5a/tj13YZgXLRmMFQmP3sNW7IiDg+YvnmWRNyDCwiQcBSPRu2KkSkLeCur0D85VtbkNnZs9/OdinCKhHJr9mpBq5woDnCJfGyQs/vBynaKXQDjJyvnrgnIoBa6ZaXspkRVzBDXCVi0dTsjnd5pegHx3uOxSYnAp7rQiN/4ADLNsjSzijTKkAvFLsKu5C0kyTXk3nKQ3yMRfGQtIV+Yds3hH8uIvH2pOQha6sT658f7zv1K807Y/VqhKiHDhxM3qHvRKeZyg/+LnEmIi7og==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HFiboCVZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HFiboCVZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrhBj2pXBz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 16:49:17 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4ahnh4105127;
	Fri, 25 Sep 2026 06:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k/xe+U
	LOLZjYDf8Cpv5Sa1oCJ54GSHNH9o5UNzMhgQI=; b=HFiboCVZx8/sRzBOb0/aPw
	LmT5Blwf5ek0lwm97QVo8i0Glra4KUe4yEywi/wCIrIQPnGzUFxLlqm1GkcObRRV
	LBV6fDixLNnzTdqFO8lykCNG5o9oeB0IEe6tzNdmE4DSMExgdgLc+TG+NEKPhb4B
	26InQ9y6cjFX68NGnp4OchX0A7x/yaicQE4vXaP339+Ze8Oa8AoypO+Az4p1/T0A
	bnQFlYlpEQrqQ1SU6iv2VJ8LQhRMF2HsNRevK6/ILY79Wn/h4nWP1l2MadnpN4YB
	qB1yb580aZ2N/H/QjTfQMDPTXGea7aihnz2fcX9qPR7dOUGGkuo0wrlsReZhXgqQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1vtej-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:49:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lhMo3245047;
	Fri, 25 Sep 2026 06:49:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu91a2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:49:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P6n0xV56492470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:49:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36C9358063;
	Fri, 25 Sep 2026 06:49:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75F925804B;
	Fri, 25 Sep 2026 06:48:57 +0000 (GMT)
Received: from [9.67.88.81] (unknown [9.67.88.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 06:48:57 +0000 (GMT)
Message-ID: <e7242d1f-6cad-4a81-8a29-839e11fafa72@linux.ibm.com>
Date: Thu, 24 Sep 2026 23:48:56 -0700
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
Subject: Re: [net-next,v6,10/15] ibmveth: Enable multi-queue RX receive path
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <7b633af89ff450338246520b40737c5819319234.1788102125.git.mmc@linux.ibm.com>
 <178845904035.3394541.12032685320275695105@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <178845904035.3394541.12032685320275695105@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: tYRIndHetbjBgeSxZf5mctiavlEikvrT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfX3wYtvWo239lF
 yc7fMKpZ8ODc0E1bOyFGQsTYH9HqIctpGqicuiJPQ4HvvY0jjNFZ5vb6APVHcohdjnbRlHhBbuE
 DXnx2TK5JJaaWLIH/fmf8uYthGgfBbVFKxWfLWNegxM0EojZXN1o8bPTpwPIRFacMmh64op69Zu
 lLefuTqlncPJxj2a9lzVM1XJ4GMDQVHoWrZEx4BHF6MSEt0uWk8fVq3PnVs8qyQ3LnzOD23O2tE
 ZM3RnYFG+DjiPrGkhwq/LsC6Z2zc8dv8fiz4AtMNUK09u0WfyMXZu9dPWo9MuK8iXDlB9Vh/GL0
 GTL8VNcKC2l7dxrP4UxXcDeOwVqaSqzdaC26lHZtBeAHiTALSqTjH9IDdc7jaMYTSL+vB+44WcO
 wx3Hb8F5uiarzc6GcvJNu/9TzxBxmrXxvCCvg3nwL8EotvW+ec7AlM3UqN21UM9V42UKXSZ1xTo
 4kf1Q02oC3B9785CnSA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab6195f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=RqQaUHGD_TMBZryktfQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfXxtR5u6cr2csG
 CBKLNcPzC4cp4hd/LmiVMie0iUD9Ve5cg7mCJJQIEpgiC5DMy/Ua9y6/tjXBrwk24AU+khwn3dE
 Muq7LjoIobSsT1OedZI7VT2TfutyhZc=
X-Proofpoint-GUID: dAXyYYzuqCi0Jdljb7faGiIu7bwAUb42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250026

Thanks for the review feedback.

On 9/3/26 11:10 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 11 potential
> issue(s) to consider:
>
> Critical: 0 · High: 1 (2) · Medium: 4 · Low: 6
>
> - [High] In multi-queue mode ibmveth_setup_rx_interrupts() already
>    unmasks the PHYP interrupt for every live RX queue, and ibmveth_open()…
> - [Medium] Adapter-wide RX counters are not converted to per-queue
>    storage while this commit enables up to min(nr_cpus,8) live RX queues:…
> - [Medium] ibmveth_apply_mq_fallback() publishes adapter->num_rx_queues =
>    1 at the top of ibmveth_open() but deliberately leaves…
> - [Medium] ibmveth_open() now runs ibmveth_replenish_task() for every
>    queue, and that function can queue reset work…
> - [Medium] The new probe error paths call kobject_put() on the pool
>    kobjects, which are embedded in struct ibmveth_adapter inside…
> - [Low] ibmveth_get_channels() begins advertising max_rx/rx_count > 1 (up
>    to min(num_online_cpus(), IBMVETH_DEFAULT_QUEUES)) while its peer…
> - [Low] Probe enables min(num_online_cpus(), IBMVETH_DEFAULT_QUEUES) RX
>    queues whenever the firmware MQ bit is present; each queue clones…
> - [Low] The commit message itself states that this commit ships known-
>    wrong statistics and new schedule_work() producers whose remove-path…
> - [Low] The pool sysfs kobject creation loop in ibmveth_probe() changes
>    from 'ignore kobject_init_and_add() failure and continue probing' to…
> - [Low] The ibmveth_setup_rx_interrupts() kernel-doc still describes the
>    pre-MQ open sequence: "Single-queue open leaves PHYP masked here and…
> - [Low] ibmveth_register_single_rx_queue() logs a signed `long lpar_rc`
>    with the unsigned conversion "rc=0x%lx".
>
> Pre-existing issues:
> - [High] This commit makes the MQ reset producer live
>    (adapter->multi_queue was hardcoded 0 before) and adds a new…
> - [High] ibmveth_poll_controller() now replenishes and schedules every
>    published RX queue instead of only queue 0, multiplying the exposure…
>
> --
>
> ibmveth: Enable multi-queue RX receive path
>
> This turns on the multi-queue RX path when firmware advertises
> IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT, raises IBMVETH_MAX_RX_QUEUES from 1
> to 16, and wires subordinate queue registration, IRQ setup and per-queue
> replenish into open()/close().  Probe now selects min(num_online_cpus(),
> IBMVETH_DEFAULT_QUEUES) RX queues and refreshes the VIO CMO entitlement.
>
> A few questions on the commit message first.
>
> [Severity: Low]
> The changelog says:
>
>      Two things are knowingly left for patch 11. RX counters are racy:
>      adapter->rx_no_buffer is assigned rather than summed from one queue's
>      buffer-list page, so it reports whichever queue replenished last and
>      can go backwards, while rx_packets, rx_bytes, rx_invalid_buffer and
>      rx_large_packets are plain read-modify-writes now reached from several
>      NAPI instances at once, so they can lose counts
>
> and:
>
>      This commit also adds schedule_work() producers, and the remove-path
>      unregister / cancel_work_sync reorder and reset reg_state gate that
>      make them safe land there too.
>
> Would it be preferable to reorder so the counter conversion and the
> remove-path fix precede the commit that makes the MQ path live, rather
> than shipping an intermediate commit that is documented as incorrect in
> those two respects?
>
> The same paragraph documents a third, unrelated change:
>
>      On probe failure after pool kobjects were created, put them before
>      free_netdev(). The leak is pre-existing and unrelated to multi-queue,
>      so a standalone version also goes to net; the probe_cleanup helper
>      lands in patch 11.
>
> Since this is described as unrelated and is being posted separately, could
> it be dropped from this patch instead of open-coded on four error paths
> here and then replaced by a helper later in the series?
The remove-path fix (unregister_netdev then cancel_work_sync)
and the NETREG_REGISTERED gate are folded into this patch,
alongside the buffer-add H_FUNCTION reset producer.

The counter conversion stays in Patch 11: we keep activation in
this patch so all MQ bring-up logic is exercised together at
this commit, and explicitly document the transient counter race
resolved in Patch 11. If you prefer a Prepare/Enable split to
keep intermediate counters strictly race-free, we can separate
activation if requested.

The pool kobject puts stay here: dropping them
leaks on probe fail until Patch 11 extracts
probe_cleanup. That is not the unwind
standalone (Fixes: d43732ce021f). v7 waits
for release before free_netdev().
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index f726d1e3f0b11..2e8896ea5af2e 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -992,11 +1014,21 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
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
>>   
>> -	adapter->rx_no_buffer = be64_to_cpup(p);
>> +	if (queue_index < 0 ||
>> +	    queue_index >= ibmveth_get_num_rx_queues(adapter) ||
>> +	    !adapter->buffer_list_addr[queue_index])
>> +		return;
>> +
>> +	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
>> +	drops = be64_to_cpup(p);
>> +
>> +	adapter->rx_no_buffer = drops;
>>   }
> [Severity: Medium]
> ibmveth_update_rx_no_buffer() now takes a queue index but still ends in a
> plain assignment to the single adapter-wide field:
>
> 	adapter->rx_no_buffer = drops;
>
> With more than one live queue, does each call simply overwrite the value
> harvested for the previous queue?  In ibmveth_close() the new loop calls it
> for every live queue back to back:
>
> 	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
> 		ibmveth_update_rx_no_buffer(adapter, i);
>
> so the reported counter ends up being whichever queue was visited last, and
> can move backwards between reads.
>
> Similarly, ibmveth_poll_deliver_frame() does unlocked read-modify-writes:
>
> 	netdev->stats.rx_packets++;
> 	netdev->stats.rx_bytes += length;
>
> and the replenish counters (replenish_task_cycles, replenish_add_buff_success
> / _failure, replenish_no_mem) are serialized only by the per-queue
> rx_queue[i].replenish_lock, which does not serialize different queues against
> each other.  Can these lose counts once several NAPI instances run
> concurrently?
Yes, at this commit. Patch 11 already moves replenish_* and
the packet/byte counters to per-queue u64, summed on read.
rx_no_buffer gets a per-queue carry there too.

> The changelog notes that the following patch moves these counters to
> per-queue storage summed on read, which does resolve it; the question is
> whether this intermediate state is worth carrying.
>
>> @@ -1062,6 +1094,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>>   		dev_err_ratelimited(&adapter->netdev->dev,
>>   				    "MQ buffer add H_FUNCTION (q=%d, batch=%u), reset\n",
>>   				    queue_index, fail.batch);
>> +		adapter->mq_fallback = true;
>>   		schedule_work(&adapter->work);
>>   	}
> [Severity: High]
> This isn't a bug introduced by this patch, but this commit makes the reset
> producer reachable for the first time (adapter->multi_queue was hardcoded to
> 0 before) and adds a second schedule_work() site here.
>
> At this commit ibmveth_reset() has no registration-state check:
>
> 	rtnl_lock();
> 	dev_close(adapter->netdev);
> 	dev_open(adapter->netdev, NULL);
> 	rtnl_unlock();
>
> and ibmveth_remove() still runs cancel_work_sync(&adapter->work) before
> unregister_netdev().  If a live queue hits MQ buffer-add H_FUNCTION after
> the cancel, can the requeued work then run dev_close()/dev_open() against a
> netdev that unregister_netdev()/free_netdev() is tearing down?
Folded into this patch: unregister_netdev() moves
ahead of cancel_work_sync(), and ibmveth_reset()
is gated on NETREG_REGISTERED here alongside the
buffer-add H_FUNCTION reset producer. Patch 11
then frees the per-queue statistics arrays between
cancel_work_sync() and free_netdev().
> Both halves are fixed later in this series (ibmveth_remove() is reordered to
> unregister_netdev() before cancel_work_sync(), and ibmveth_reset() gains the
> netdev->reg_state != NETREG_REGISTERED gate), so the exposure is limited to
> this intermediate commit.
>
>> @@ -1081,6 +1114,27 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
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
>> +	ibmveth_replenish_task(adapter, qindex);
>> +	if (ibmveth_schedule_rx_queue(adapter, qindex))
>> +		return;
>> +
>> +	ibmveth_enable_irq(adapter, qindex);
>> +}
> [Severity: High]
> Is the unconditional ibmveth_enable_irq() here safe in multi-queue mode?
>
> ibmveth_schedule_rx_queue() returns false in two different situations:
>
> 	if (napi_schedule_prep(napi)) {
> 		ibmveth_disable_irq(adapter, qindex);
> 		__napi_schedule(napi);
> 		return true;
> 	}
> 	return false;
>
> The second case is "NAPI already claimed", which is exactly what the IRQ
> handler does after it has masked PHYP.  In MQ mode
> ibmveth_setup_rx_interrupts() has already unmasked every queue:
>
> 	if (adapter->multi_queue && num > 1) {
> 		for (i = 0; i < num; i++) {
> 			rc = ibmveth_enable_irq(adapter, i);
>
> so by the time open() runs its restart loop an interrupt may already have
> claimed NAPI and masked the queue.  restart then re-unmasks it under the
> in-flight poll, and when that poll finishes ibmveth_poll() calls
> ibmveth_enable_irq() again on an already-enabled subordinate interrupt.
>
> ibmveth_toggle_irq() folds H_PARAMETER only on the disable side:
>
> 		if (h_rc == H_PARAMETER && !enable) {
> 			dev_warn_ratelimited(...);
> 			return 0;
> 		}
>
> so the redundant enable returns -EIO, and ibmveth_poll() escalates that to
> schedule_work(&adapter->work), i.e. a full dev_close()/dev_open() of an
> otherwise healthy adapter.
>
> Since the PHYP mask/unmask hcalls are not reference counted, should restart
> skip the enable when schedule_rx_queue() failed because NAPI was already
> scheduled, rather than when prep failed for lack of a pending descriptor?
> The same enable-then-restart sequence appears later in the ethtool -L
> scale-up path of ibmveth_resize_rx_queues_incremental():
>
> 	rc = ibmveth_enable_irq(adapter, i);
> 	...
> 	ibmveth_restart_rx_queue(adapter, i);
>
> [ ... ]
It should not skip the enable. When prep fails,
NAPI is already scheduled, so enabling there is
deliberate; masking on that path left the queue
idle and masked.
>> +static int
>> +ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
>> +				 int queue_idx)
>> +{
>> +	struct net_device *netdev = adapter->netdev;
>> +	union ibmveth_buf_desc rxq_desc;
>> +	long lpar_rc;
>> +
>> +	if (WARN_ON(queue_idx < 1 || queue_idx >= IBMVETH_MAX_RX_QUEUES))
>> +		return -EINVAL;
>> +
>> +	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
>> +				    adapter->rx_queue[queue_idx].queue_len;
>> +	rxq_desc.fields.address = adapter->rx_queue[queue_idx].queue_dma;
>> +
>> +	lpar_rc = ibmveth_register_logical_lan_queue(adapter, rxq_desc,
>> +						     queue_idx);
>> +	if (lpar_rc != H_SUCCESS) {
>> +		netdev_err(netdev, "Failed to register queue %d: rc=0x%lx\n",
>> +			   queue_idx, lpar_rc);
> [Severity: Low]
> lpar_rc is a signed long here, and ibmveth_register_logical_lan_queue()
> returns -EINVAL when irq_create_mapping() fails, so that case prints as
> rc=0xffffffffffffffea.  Would %ld (or splitting the errno and hypervisor
> cases) read better?  Note this will not produce a build warning, since the
> signed/unsigned format mismatch is only diagnosed under
> -Wformat-signedness, which the kernel does not enable.
>
> [ ... ]
v7 uses %ld. The hypervisor fail one function
up already prints that way.
>> +static void ibmveth_apply_mq_fallback(struct ibmveth_adapter *adapter)
>> +{
>> +	struct net_device *netdev = adapter->netdev;
>> +
>> +	if (!adapter->mq_fallback)
>> +		return;
>> +
>> +	adapter->mq_fallback = false;
>> +
>> +	if (!adapter->multi_queue && ibmveth_get_num_rx_queues(adapter) == 1)
>> +		return;
>> +
>> +	netdev_warn(netdev,
>> +		    "Falling back to single RX queue (firmware MQ unavailable)\n");
>> +	adapter->multi_queue = false;
>> +	ibmveth_publish_num_rx_queues(adapter, 1);
>> +	/* real_num_rx_queues is set later in open after resources exist. */
> [Severity: Medium]
> Can the two counts be left permanently out of sync here?
>
> ibmveth_apply_mq_fallback() runs at the very top of ibmveth_open() and
> publishes adapter->num_rx_queues = 1, but netdev->real_num_rx_queues is only
> updated further down.  Four failure exits sit in between:
>
> 	ibmveth_alloc_filter_list()
> 	ibmveth_alloc_rx_queues()
> 	ibmveth_alloc_buffer_pools()
> 	ibmveth_register_rx_queues()
> 	...
> 	netif_set_real_num_rx_queues(netdev, ibmveth_get_num_rx_queues(adapter))
>
> If the fallback open fails at any of those (for example -ENOMEM from pool
> allocation, or -ENONET from queue-0 registration), the device stays down with
> adapter->num_rx_queues == 1 while netdev->real_num_rx_queues is still the old
> multi-queue value, so /sys/class/net/ethX/queues/rx-1..7 remain present for
> queues the driver will never drive.
>
> That contradicts the invariant the probe path documents for exactly this
> case:
>
> 	 * alloc_etherdev_mqs() sized real_num_rx_queues to MAX. Match the
> 	 * advertised default (or SQ 1) before register_netdev so down-state
> 	 * readers agree with adapter->num_rx_queues / ethtool -l.
>
> Would it be better to lower real_num_rx_queues in the fallback path itself,
> or to restore the published count on the open failure paths?
real_num is set after the resources exist. If this
open fails first, the old real_num can sit while
num_rx_queues is already 1. The next successful
open calls set_real. The fallback helper only
publishes the count.
>> @@ -1651,6 +1900,8 @@ static int ibmveth_open(struct net_device *netdev)
>>   
>>   	netdev_dbg(netdev, "open starting\n");
>>   
>> +	ibmveth_apply_mq_fallback(adapter);
>> +
>>   	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>>   		rxq_entries += adapter->rx_buff_pool[0][i].size;
>>   
>> @@ -1670,18 +1921,34 @@ static int ibmveth_open(struct net_device *netdev)
>>   	if (rc)
>>   		goto out_free_buffer_pools;
>>   
>> -	rc = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
>> +	rc = netif_set_real_num_rx_queues(netdev,
>> +					  ibmveth_get_num_rx_queues(adapter));
>> +
>>   	if (rc) {
>>   		netdev_err(netdev, "failed to set number of rx queues\n");
>>   		goto out_unregister_queues;
>>   	}
>>   
>> +	/*
>> +	 * Post buffers before setup_rx_interrupts(). MQ setup then unmasks
>> +	 * PHYP; SQ setup leaves PHYP masked. Scheduling NAPI only when a
>> +	 * descriptor is already pending is not enough: after ifdown/up
>> +	 * (RX=8, no -L) NAPI can be idle with nothing pending and the
>> +	 * queue stays dead (TX OK, ARP/RX fail).
>> +	 * restart_rx_queue() replenishes, schedules NAPI, and unmasks if
>> +	 * prep fails.
>> +	 */
>> +	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
>> +		netdev_dbg(netdev, "initial replenish cycle for queue %d\n", i);
>> +		ibmveth_replenish_task(adapter, i);
>> +	}
>> +
>>   	rc = ibmveth_setup_rx_interrupts(adapter);
>>   	if (rc)
>>   		goto out_free_all_queues; /* setup already disposed IRQs */
>>   
>> -	netdev_dbg(netdev, "initial replenish cycle\n");
>> -	ibmveth_schedule_rx_queue(adapter, 0);
>> +	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
>> +		ibmveth_restart_rx_queue(adapter, i);
> [Severity: Medium]
> This replenish loop can queue reset work, and ibmveth_replenish_task()
> returns void, so open() cannot see it:
>
> 	} else if (need_reset == IBMVETH_REPLENISH_RESET_MQ) {
> 		...
> 		adapter->mq_fallback = true;
> 		schedule_work(&adapter->work);
> 	}
>
> If a buffer-add hcall returns H_FUNCTION here and the open then fails at
> ibmveth_setup_rx_interrupts() or ibmveth_alloc_tx_resources(), userspace gets
> an error back from ndo_open and the device is left down, but the pending
> ibmveth_reset() only checks registration state:
>
> 	rtnl_lock();
> 	if (netdev->reg_state != NETREG_REGISTERED) {
> 		rtnl_unlock();
> 		return;
> 	}
>
> 	dev_close(adapter->netdev);
> 	dev_open(adapter->netdev, NULL);
>
> so it brings the interface up anyway a moment later.  Should the reset worker
> also check that the device was successfully opened before reopening it?
No. After a failed open the worker can still
dev_open(); the netdev is registered. mq_fallback
is already latched, so that open comes up
single-queue. That is the H_FUNCTION recovery.
> [Severity: Low]
> This isn't a bug, but the kernel-doc on ibmveth_setup_rx_interrupts() still
> describes the pre-MQ ordering:
>
>   * Single-queue open leaves PHYP masked
>   * here and kicks NAPI afterward (classic path: first poll posts then
>   * enables).
>
> After this change open() posts buffers for every live queue (queue 0
> included, in single-queue mode) before calling setup_rx_interrupts(), and
> ibmveth_restart_rx_queue() posts again, so the "first poll posts" behaviour no
> longer applies to either mode.  Could that comment be refreshed?
v7 refreshes it. Open posts first in both
modes; restart_rx_queue still kicks NAPI
after setup.
>> @@ -1714,6 +1981,7 @@ static int ibmveth_open(struct net_device *netdev)
>>   static int ibmveth_close(struct net_device *netdev)
>>   {
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>> +	int i;
>>   
>>   	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
>>   	 * leave IFF_UP set after a failed reopen.
>> @@ -1734,7 +2002,8 @@ static int ibmveth_close(struct net_device *netdev)
>>   	/* Wait for softirq/poll that already passed shutdown checks. */
>>   	synchronize_net();
>>   
>> -	ibmveth_update_rx_no_buffer(adapter);
>> +	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
>> +		ibmveth_update_rx_no_buffer(adapter, i);
>>   	ibmveth_free_all_queues(adapter);
> [ ... ]
>
>> @@ -2527,6 +2796,7 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
>>   		ibmveth_rx_csum_helper(skb, adapter);
>>   	}
>>   
>> +	skb_record_rx_queue(skb, queue_index);
>>   	napi_gro_receive(napi, skb);
>>   
>>   	netdev->stats.rx_packets++;
> [ ... ]
>
>> @@ -2750,9 +3021,14 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
>>   static void ibmveth_poll_controller(struct net_device *dev)
>>   {
>>   	struct ibmveth_adapter *adapter = netdev_priv(dev);
>> +	unsigned int num = ibmveth_get_num_rx_queues(adapter);
>> +	int i;
>>   
>> -	ibmveth_replenish_task(adapter, 0);
>> -	ibmveth_schedule_rx_queue(adapter, 0);
>> +	for (i = 0; i < num; i++)
>> +		ibmveth_replenish_task(adapter, i);
>> +
>> +	for (i = 0; i < num; i++)
>> +		ibmveth_schedule_rx_queue(adapter, i);
>>   }
>>   #endif
> [Severity: High]
> This is a pre-existing race, not one introduced here, but walking every
> published queue widens it considerably.
>
> The in-driver callers of ibmveth_close() (veth_pool_store(),
> ibmveth_set_csum_offload(), ibmveth_set_tso(), ibmveth_change_mtu()) call
> ndo_stop directly rather than through dev_close(), so
> netpoll_poll_disable() is never called and netif_running() stays true.
> netpoll_poll_dev() can therefore call ndo_poll_controller() while close is
> freeing the pools.
>
> The replenish side samples the pool and then dereferences it:
>
> 		if (pool->active && pool->free_map &&
> 		    (atomic_read(&pool->available) < pool->threshold)) {
> 			rc = ibmveth_replenish_buffer_pool(adapter, pool,
> 							   queue_index, &fail);
>
> while the freeing side takes no replenish_lock at all:
>
> 	kfree(pool->free_map);
> 	pool->free_map = NULL;
>
> Can this access freed free_map[]/skbuff[]/dma_addr[] arrays, and the freed
> buffer-list page in ibmveth_update_rx_no_buffer()?
>
> A later patch in the series adds an "if (!adapter->opened) return;" check to
> ibmveth_poll_controller(), but ibmveth_close() clears opened before it frees
> anything and does not wait for an in-flight poll_controller, so the window
> appears to remain.
Yes, at this commit. Patch 15 already returns if !opened.
That does not wait for an in-flight poll_controller.
close still skips netpoll_poll_disable, and
free_buffer_pool still skips the lock. Those two
stay with shortening irqsave after this series.
>> @@ -2781,23 +3056,35 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
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
>>   
>> +	for (q = 0; q < ibmveth_get_num_rx_queues(adapter); q++) {
>> +		int rxqentries = 1;
>> +
>> +		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> +			struct ibmveth_buff_pool *bpool =
>> +				&adapter->rx_buff_pool[0][i];
>> +
>> +			if (bpool->active)
>> +				ret += bpool->size *
>> +					IOMMU_PAGE_ALIGN(bpool->buff_size, tbl);
>> +			rxqentries += bpool->size;
>> +		}
> [ ... ]
>
>> @@ -2954,16 +3253,30 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   		netdev->features |= NETIF_F_FRAGLIST;
>>   	}
>>   
>> -	/* Initialize queue count - always 1 for now */
>> -	adapter->multi_queue = 0;
>> -	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
>> +	if (ret == H_SUCCESS &&
>> +	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
>> +		adapter->multi_queue = true;
>> +		ibmveth_publish_num_rx_queues(adapter,
>> +					      min(num_online_cpus(),
>> +						  IBMVETH_DEFAULT_QUEUES));
> [ ... ]
>
>> @@ -2981,25 +3294,62 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
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
> [Severity: Medium]
> Can this free the memory the kobjects live in before their cleanup runs?
>
> The pool kobjects are embedded in struct ibmveth_adapter, which is
> netdev_priv(netdev), and ktype_veth_pool has .release = NULL.  With
> CONFIG_DEBUG_KOBJECT_RELEASE=y the last kobject_put() goes to
> kobject_release(), which defers the cleanup:
>
> lib/kobject.c:kobject_release() {
> 	...
> #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> 	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
> 	schedule_delayed_work(&kobj->release, delay);
> 	...
> }
>
> The delayed_work lives inside the kobject, i.e. inside the storage that
> free_netdev() releases immediately on this path (reg_state is
> NETREG_UNINITIALIZED), and the pool%d directories stay published against it
> until the work fires a few seconds later.
>
> The same put-then-free sequence is repeated on the
> netif_set_real_num_tx_queues(), netif_set_real_num_rx_queues() and
> register_netdev() failure paths below, and survives into the later
> ibmveth_probe_cleanup() helper.  The changelog lists "pool kobj vs
> DEBUG_KOBJECT_RELEASE" as a leftover - would adding a real release() with a
> container that outlives the kobjects, or creating them only after the last
> failure point, be the fix?
v7 waits. A real release completes, and last
put waits before free_netdev(). Patch 11
probe_cleanup and remove use that helper.
> [Severity: Low]
> This isn't a bug, but the policy here changes from "ignore
> kobject_init_and_add() failure and keep probing" to "fail the probe", so a
> kernfs name collision or -ENOMEM now leaves the interface unavailable
> instead of merely missing the pool%d tuning knobs.  Checking the return
> value is the right thing to do; could the changelog mention the behaviour
> change, since it currently only describes adding cleanup?
Failing the probe on kobject_init_and_add() is intended.
The commit message already names the puts.
>> +	/*
>> +	 * VIO CMO entitlement was set before probe (netdev NULL, so default).
>> +	 * Recompute now that num_rx_queues and pool 0 metadata are known.
>> +	 */
>> +	if (firmware_has_feature(FW_FEATURE_CMO))
>> +		vio_cmo_set_dev_desired(dev, ibmveth_get_desired_dma(dev));
>> +
> [Severity: Low]
> This isn't a bug, but probe unconditionally selects min(num_online_cpus(),
> IBMVETH_DEFAULT_QUEUES) RX queues whenever the firmware bit is set, and each
> queue clones queue 0's full pool geometry plus its own buffer-list page and
> RX ring.  ibmveth_get_desired_dma() therefore multiplies the desired DMA
> entitlement by num_rx_queues, and vio_cmo_set_dev_desired() returns void, so
> an entitlement request that cannot be granted is not visible here.
>
> On a CMO partition with many CPUs, is defaulting to eight RX queues the
> behaviour you want out of the box, or would defaulting to one and letting
> ethtool -L opt in be safer?  The series does add the runtime opt-out in a
> later patch.
Yes. The default is min(num_online_cpus(), 8), same cap as
TX. ethtool -L can raise or lower it later in the series.

CMO is Power9 and earlier; the MQ firmware bit is
Power11+. Those partitions do not coexist, so this is not a CMO
tradeoff. get_desired_dma() still adds one TX LTB,
but that is only the CMO desired hint. The real
TX LTBs already scale with real_num_tx_queues
(kzalloc + dma_map_single). Those two CMO leftovers
come off the v7 cover. For the same reason v7
drops the probe-time CMO desired refresh; a CMO
partition keeps its single-queue default.
>>   	rc = netif_set_real_num_tx_queues(netdev, min(num_online_cpus(),
>>   						      IBMVETH_DEFAULT_QUEUES));
>>   	if (rc) {
>>   		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
>>   			   rc);
>> +		ibmveth_put_pool_kobjs(adapter, pools_ready);
>> +		dev_set_drvdata(&dev->dev, NULL);
>> +		free_netdev(netdev);
>> +		return rc;
>> +	}
>> +
>> +	/*
>> +	 * alloc_etherdev_mqs() sized real_num_rx_queues to MAX. Match the
>> +	 * advertised default (or SQ 1) before register_netdev so down-state
>> +	 * readers agree with adapter->num_rx_queues / ethtool -l.
>> +	 */
>> +	rc = netif_set_real_num_rx_queues(netdev,
>> +					  ibmveth_get_num_rx_queues(adapter));
> [Severity: Low]
> With real_num_rx_queues now published as up to eight before
> register_netdev(), ibmveth_get_channels() starts reporting max_rx and
> rx_count greater than one:
>
> 	channels->max_rx = netdev->real_num_rx_queues;
> 	channels->rx_count = netdev->real_num_rx_queues;
>
> but ibmveth_set_channels() at this commit only reads channels->tx_count.
> Does "ethtool -L ethX rx 4" then pass the core's max_rx check, get silently
> discarded by the driver and report success?
Yes, at this commit. set_channels only reads
tx_count, so rx 4 is discarded and the call
succeeds. Patch 12 rejects an RX count change
with -EOPNOTSUPP; Patch 14 implements live
resize.

Thanks,
Mingming
> The changelog acknowledges this ("This commit does not implement
> set_channels / rx_count") and patch 14 wires rx_count up, so the question is
> whether the advertisement should wait for the implementation.
>
> [ ... ]
>


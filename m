Return-Path: <linuxppc-dev+bounces-24325-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2324C4450A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 00:33:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1W9j3mghz2yRF;
	Fri, 17 Jul 2026 10:33:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784248425;
	cv=none; b=Y1B8iBipv6RO4P5WCSjPu4FK+6ZvCynj5vGuB3d26DFb5e1jSTVMAdfUu8JkTiglMPUUhkeRiQqbtsQMTC8QTVza+Wiqcmy19VjRKQmhm+2QRNlNx4iIe2B7djKCDvUSS/79wT/kIxLOaqRh80iw5V6pdHaGP6oMiWcy2wveY+shM6UkKoaC+3o0mzEgdd61CprrAuvr2ogOyJD2McbM+Oaj9H/Fqq4+5KdzAHxkReUkGE9xUNql6ZcMyOlifIKMkjGhNoBisqL15Q7k/4CzYev4FmJyFFwyduLgopHv/P4Xg/rcDLhcvm2UlfQoeZMDqUeqC19FElfiIiFgJxbg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784248425; c=relaxed/relaxed;
	bh=cMnhf8zZYUm5dbBNe3vw7k/dV027wRr3L+fwNG0S/J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFsAnQ3buZZyyEpUevOS5TuPX3nS3/76yyGP/x7Ij2xyyf4ht2/Ejkjts7/sQb7Y9T/mM7Y1iw73jRap7mDANmdPq4ZLN6L0JT6nGdEumKOfVaDfEoRYbooPvpMLR038DZPVPjrBQHnfZrM+Dl9Z9M9PFvxSeIFqdSokqtAoOaVBfLs32/OdTstZhXZgxOuP6UrBNPKV1FjLmitplxF8o56r2xuyMGRcD78xxrTm1SzT1ee/2lYwN18B9jq75MoB7Qz7DQxl1VMQCz9sConyfqN+fKIOtLePFw9YQt9sZSBBnh3wBwS1Xc/nhozU2c6mGUNkGxGwe4iBB9ezb6udEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lNcERlU4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lNcERlU4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1W9j188pz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 10:33:44 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNh0Cn451440;
	Fri, 17 Jul 2026 00:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cMnhf8
	zZYUm5dbBNe3vw7k/dV027wRr3L+fwNG0S/J8=; b=lNcERlU4tSAgN4LIOadsPA
	iXmsxeqAW2Nc/uIOAgo8jH526Cg2Sv6BZRg+mTKuL5HJ99qc8PiPJdNiYXBaGalS
	f+4b/wYpmDvq1GjGP2OCmGvFGguQLfRVmTkQkgPq9H/BozAJKOgxebB9jSgoyQWO
	TeLTxNxH3u/U2N8d5AEzGV8tIcVvsodbmFBdBu2u3Xqn21/1cvGftWokIDCythvO
	iQS389n6pkIa6bKxXkcMlMhiN0T3rKGwH/UVJKoizHypzxRqBg3cO8OXJt9dHqJD
	W4CbzHOudnAfT0bP98h49eXzEZUCPZSyTa7fPCinRZWObEQtcWhli5qN33g9IzWg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtktt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 00:33:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H0Jpoq006930;
	Fri, 17 Jul 2026 00:33:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhqd8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 00:33:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H0XW7x34931352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 00:33:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A66258067;
	Fri, 17 Jul 2026 00:33:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71D4058059;
	Fri, 17 Jul 2026 00:33:31 +0000 (GMT)
Received: from [9.61.118.188] (unknown [9.61.118.188])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 00:33:31 +0000 (GMT)
Message-ID: <a36b50e7-5df3-4e9a-bf55-98cb00ba7fde@linux.ibm.com>
Date: Thu, 16 Jul 2026 17:33:30 -0700
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
Subject: Re: [PATCH net-next v3 07/15] ibmveth: Add RX queue
 register/deregister helpers for MQ
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, davemarq@linux.ibm.com
References: <20260706193603.8039-8-mmc@linux.ibm.com>
 <20260714124338.1831986-1-horms@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260714124338.1831986-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 37st7qSYPT2yH3voCG3vHnn9g5WA-bL5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAwMCBTYWx0ZWRfX+xO9/1Zp37Bg
 asemkV/k6c8quRojLUc9fvAk2Wugo9bF8Lc7saDwsnZUkIpSpHS3hwa8oBpQOFvxWxxXuHUJDDN
 bg8aSi71VXrrQYoHjeIk0YlpJp0AOGs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAwMCBTYWx0ZWRfXz0rwPcNX0NrZ
 aZ7wuNaXu+FL+1ug2gfzz2lCPmQUO3uXZgMvtLTZqSpejXWg6Nyod3tkh3k9VFAk39F928uUR4H
 gzVWljrAaAki4TGLrQcpYxGO5dJvLf937fjwFT1/tWJ+zV4sGx2faX+TEvoP3TbqYpe0wUkP0s4
 w7ECnZEOZWrROMtr81yLuB+6YKWKmEf5QHvANYwAy47lDjNkJEuIhu80nQi4Dw1LgQdF8wYImAv
 WX+ts39bXQtKaXGPaxyv3ECU0M/hbfnakeZuQWvgLOEN378wOTY2Gp5D525lrYtfAxiWaXjgZ0a
 VA7IzbqSYd2GJNj+3EbC4EGbapf3Kjuk6B01eYTw1Y55bI46O+oiN+iUHTFbCPJZzQoiMlnJLm1
 7xa9i6lbHMb3ZL+jNlsw0qQI3bcJ4CE2cj8V2yiJDdfnumcQ2z6ipTmgPY6SA7Gg8audtEz6Oxh
 XQT7rfeOliBwr1+ZRCw==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a59785f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=aauaAOzOPfXglxgOek8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: eHmJws6n8cqZpLncZRcbX4ryVd-104ym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170000


On 7/14/26 5:43 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ibmveth: Add RX queue register/deregister helpers for MQ
>
> This patch introduces new helpers to handle RX queue registration and
> deregistration for MQ support. It replaces the single adapter-level
> register/free paradigm with per-queue register calls to the hypervisor,
> fetching queue handles and IRQs. These new paths are only fully exercised
> when multi-queue mode is enabled.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 63b0184c622a4..7fc11a4e1f61d 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>> @@ -401,6 +401,28 @@ ibmveth_dispose_subordinate_irq_mappings(struct ibmveth_adapter *adapter)
> [ ... ]
>> +static int __maybe_unused
>> +ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
>> +{
>> +	struct net_device *netdev = adapter->netdev;
>> +	int i, rc;
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		if (!adapter->queue_irq[i]) {
>> +			netdev_err(netdev, "queue %d has invalid IRQ (0)\n", i);
>> +			rc = -EINVAL;
>> +			goto err_free_irqs;
>> +		}
>> +
>> +		rc = request_irq(adapter->queue_irq[i], ibmveth_interrupt,
>> +				 0, netdev->name, &adapter->napi[i]);
>> +		if (rc) {
>> +			netdev_err(netdev,
>> +				   "request_irq() failed for irq 0x%x queue %d: %d\n",
>> +				   adapter->queue_irq[i], i, rc);
>> +			goto err_free_irqs;
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++)
>> +		napi_enable(&adapter->napi[i]);
> [Severity: Medium]
> Could this sequence race with packet reception during interface bring-up?
> By calling request_irq() before napi_enable(), the hardware interrupt is
> unmasked while the NAPI state is still NAPI_STATE_DISABLE. If an interrupt
> fires in this window, could ibmveth_interrupt() fail to schedule the NAPI
> poll, potentially leading to dropped events or an interrupt storm?
>
> [ ... ]

**

*On the request_irq vs napi_enable ordering: on open, ibmveth_enable_irq()*

*

(h_vio_signal / H_VIOCTL) runs only after napi_enable(), so PHYP should

not deliver in the request_irq→napi_enable window. That matches what

peers like ibmvnic do (NAPI before firmware unmask). I'll keep the

tested open order (request_irq → napi_enable → PHYP enable) in v4.


For teardown, v4 will follows the hard rule "mask PHYP before

napi_disable": scale-down does that, and close/open-fail cleanup does

too via cleanup_rx_interrupts(). Scale-up still does enable_irq before

napi_enable after publish+replenish — I'm leaving that order for this

v4 and can revisit as a follow-up if needed.

*

>> @@ -1136,6 +1176,293 @@ static void __maybe_unused ibmveth_free_rx_qstats(struct ibmveth_adapter *adapte
> [ ... ]
>> +static int
>> +ibmveth_register_logical_lan_queue(struct ibmveth_adapter *adapter,
>> +				   union ibmveth_buf_desc rxq_desc,
>> +				   int queue_index)
>> +{
> [ ... ]
>> +	if (lpar_rc == H_FUNCTION) {
>> +		if (adapter->multi_queue) {
>> +			netdev_info(adapter->netdev,
>> +				    "Multi queue mode not supported by firmware, falling back to single queue\n");
>> +			adapter->multi_queue = 0;
>> +		} else {
>> +			netdev_err(adapter->netdev,
>> +				   "Unexpected H_FUNCTION for queue %d registration (MQ mode already disabled)\n",
>> +				   queue_index);
>> +		}
>> +		return lpar_rc;
> [Severity: Medium]
> Does returning lpar_rc here cause a regression for the single queue fallback?
> Since this error propagates up to ibmveth_register_rx_queues(), it seems it
> will unconditionally jump to err_unregister and fail the interface open
> rather than allowing it to continue with a single queue.
*

Good catch — clearing multi_queue still returned the

error and failed open, so the "falling back to single queue" log was

misleading. In v4 I'll treat subordinate H_FUNCTION as a hard error:

honest H_FUNCTION-specific netdev_err, then the existing generic logs,

without clearing multi_queue or claiming fallback.

*
>> +	}
>> +
>> +	if (try_again) {
>> +		try_again = 0;
>> +		goto retry;
> [Severity: Low]
> Does this retry loop provide any benefit? Unlike the primary queue which
> calls h_free_logical_lan() before retrying to clear stale state, this
> jumps back to retry the exact same hypercall with the exact same arguments,
> which seems like it will immediately fail again.
*

The subordinate try_again path was indeed empty logic. Queue 0 retries

only after h_free_logical_lan() clears stale PHYP state (kexec). The

subqueue path retried the same H_REG_LOGICAL_LAN_QUEUE with the same

args and no free, so the second attempt could not succeed for any reason

we implemented — and H_FUNCTION already returned before the retry.

In v4 I'll drop that blind retry and report the failure once per queue.

*
>> +	}
> [ ... ]
>> +static int
>> +ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
>> +{
> [ ... ]
>> +	for (i = 1; i < adapter->num_rx_queues; i++) {
>> +		rc = ibmveth_register_single_rx_queue(adapter, i, mac_address);
>> +		if (rc) {
>> +			if (!adapter->queue_handle[i] || !adapter->queue_irq[i]) {
>> +				netdev_err(netdev,
>> +					   "Invalid hypervisor return for queue %d: handle=0x%llx irq=%u\n",
>> +					   i, adapter->queue_handle[i],
>> +					   adapter->queue_irq[i]);
>> +			}
> [Severity: Low]
> Is this validation check placed correctly? Because it sits inside the
> if (rc) error block, it will log "Invalid hypervisor return" whenever
> registration fails normally (e.g., due to resource constraints). It appears
> the hypervisor is not expected to populate the handle and irq on failure.

**

*Good catch. on ordinary register failure handle/irq are still zero, so*

*

that caller message falsely claimed an invalid hypervisor return and

duplicated ibmveth_register_single_rx_queue() (which already logs the

hcall rc). In v4 I'll drop that extra log at the caller.


Thanks for the reviewing!

Mingming

*

>
>> +			goto err_unregister;
>> +		}
>> +	}


Return-Path: <linuxppc-dev+bounces-28167-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C3BC9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:21:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrgZh5YNXz2y8d;
	Fri, 25 Sep 2026 16:21:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790317292;
	cv=none; b=l1ed+TTCu1LQyMuooTpZnLjc1VOX1uRDr6r6N1guP79w0Zg2/V/40RpHsWSxylljFQ35GliSvTj7jAspqmG3cUqUYatpUwF0XZE5B27p3IvfBdCQVgGodhyucrqRphfuRcuIW2BUNW9IyfZmB2hUzmyJYOtuCawFoJNC5lCOZlr+d0r8trRCev322JSAk+nxheqqQMurMWuA9XHs8iwspXYTWj73XNR79KEfH/FEjj1uK7oz7KY0fI5vRrGB+V8WmBjbcYHzk1u6XJaC/4eqhDp3Ypo9JGW9wbl+TdJ6XCz4cwm4sIkIIxp4Y9X9N1Zw/vcE/w0Ox5cLXaTAOTcNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790317292; c=relaxed/relaxed;
	bh=RD6Dz60pf3Vscu0Gv6nxPH0e0W+8RgbTfyqmmb1onrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLx6Trn/7o6hJydpg/tLy/ewTaO1FiztUDZtSaLF/uUlu6/z5QDk4GtzQXMIcz+Q7dQcQWWEbl+NKVEdC1EZkZe/lt2uHJBXRzkF/KgQDNV4MWkffVrdPB8Fxwkod/LsCUWVoNh3zIKhtC+Byk64wijkVDhRGJS78QU+Mo7Jbluc5Is0ABL7P2xgaQhF31sGeqfpHJkTqqh0heDF4lD+bJQuiVXvRBdWf5X0PZChCeYCrqTunYpiXdqavMfRqZ2KdXPa2oQFkRdXkUkqKeWNw30+1BqAqgv3dvIYSWkGMcwjWDyw7eM6cv8g/Ujyq7ENFJcOzltTXzg56J293FWD7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L9SdG1Qv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L9SdG1Qv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrgZg532Hz2y21
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 16:21:31 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4adT72393916;
	Fri, 25 Sep 2026 06:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RD6Dz6
	0pf3Vscu0Gv6nxPH0e0W+8RgbTfyqmmb1onrY=; b=L9SdG1Qv1DpD9UJUw1XOzU
	iNyHNOpZXyaymMlDA8qHYRsKlan4nhY8XaxYfFlRRX2oZ6EnLAhSMtl8kGfDJruD
	UYdHwt/DG7qqoMMj1P7K0jzR/zUHQIWlMDk7p3ElkA3UK8mnrFoieygBZwaU0Xer
	b0enrSPEhaSm7yaX4vuTbyXB87spog8xQvIgPbApCB8F0Urgr9tGReKUcofPw3NO
	fWCNlZtn8hJ3Z8NbufoKli78RHuW6oZOmws0MZpqzrgaYb0shdDZXedlZXgIojr2
	ChsaQmiuAhAbiiZD1VOoRazHb2f0Pu/RXV/uYEBugS0t3qe65XdagFKWeb6BvgUw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske25h8a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:21:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lWue3298377;
	Fri, 25 Sep 2026 06:21:20 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k1bhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:21:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P6LIj065667342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:21:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 697E358063;
	Fri, 25 Sep 2026 06:21:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C7EF58055;
	Fri, 25 Sep 2026 06:21:15 +0000 (GMT)
Received: from [9.67.88.81] (unknown [9.67.88.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 06:21:15 +0000 (GMT)
Message-ID: <6415b44b-a525-4412-b200-8bfb4d43b82e@linux.ibm.com>
Date: Thu, 24 Sep 2026 23:21:14 -0700
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
Subject: Re: [net-next,v6,05/15] ibmveth: Refactor RX interrupt control for MQ
 RX queues
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <8f989bb564874f041ac9648d871c6ff3e3014bb9.1788102125.git.mmc@linux.ibm.com>
 <178845903415.3394541.17814919508760286151@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <178845903415.3394541.17814919508760286151@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pQ3X9Tnj8yvFBmpVecjTVE_hw9QVAntf
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab612e2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=IwI5MloAIRWKGrjTFRYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX/Qyp8GfdKQeh
 GGyVZcKaxDGoO3iPmD2we7OWr+sRp9VXmx9JbUXA42OTxVNrx7vdX91DMXKHE+wLe1jSnCQwzr7
 C1Y0wD/pe/fQULZd+M7FgFYZMQcCX3g=
X-Proofpoint-GUID: KGv4-5ShYRU6dyKbATJdRBgZ0VeoBKLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX3JBSBZ9w/q/n
 G19LXyb2oyUGpq8CWCQ2uyLzUW6LN6WHzkj/PmNoF96ca9wK6xlK7D1TDO4CT/21txVIsRfg+Bh
 kLP1geSc8/myKKy60IfguTYn2kpbUJ/GZEOiOEJMzgrJ3PV1wIXDu08bhIUyGhWRLM6RXDiM6Ja
 QaTFZ5pjGZoTLn5Ar4+EckMHCK4zdnKmXVLWA/NsBOT2sGgHvmvyCLY/rBgIl0Haq3APi30BD/V
 WmYZYn+usNGUmAgLM3KBbLLU1rG7m/701VnsbPGoAPQzOWjgK8vA+3GusSHjioLTF5KFYXCA2dL
 /eQmiOEcSKkI3l7Uzin7/VHc46fUTENMRGF3OuUUhhUs2u1Vn05tVKTPdvtDM+fP9cCs88QKqvx
 c0YK/Xp4cbuLg3fb0NLlbrzSLXEktDDNMgLiyZDnlEPow2ai4lHCXhXNMKbr5AR0JudZN2i7qq8
 zfoQeJXWeUS6i/GdCBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250024

Hi, Thanks for the view.

On 9/3/26 11:10 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 (1) · Medium: 3 · Low: 2
>
> - [Medium] A user-triggerable rtnl hang fix is bundled into a 400-line
>    refactor with an incorrect justification for omitting a Fixes: tag.
> - [Medium] ibmveth_poll() re-arms the PHYP interrupt
>    (ibmveth_enable_irq(), ibmveth.c:2123) only *after*…
> - [Medium] Teardown frees Linux IRQ handlers (and, on the MQ paths,
>    disposes subordinate virq mappings) without ensuring PHYP delivery was…
> - [Low] Two permanent behavioural changes to ibmveth_close() are absent
>    from the commit message: (a) ibmveth_update_rx_no_buffer() is moved…
> - [Low] Claimed: ibmveth_schedule_rx_queue()'s kernel-doc documents an
>    out-of-range index as an ordinary `return false`, while the body…
>
> Pre-existing issues:
> - [High] Claimed: on the ibmveth_alloc_buffer_pools() failure path,
>    ibmveth_open() jumps to out_free_tx_ltb without h_free_logical_lan(),…
>
> --
>
> ibmveth: Refactor RX interrupt control for MQ RX queues
>
> This patch introduces queue-indexed RX interrupt helpers (toggle/enable/
> disable, setup/cleanup, schedule) and wires them into open(), close(),
> poll(), the IRQ handler and the process-context RX kick sites. It also adds
> two new adapter flags, opened and rx_irq_setup, that gate close/cleanup
> work. Runtime behaviour stays single-queue.
>
> A few questions below.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 37a6d13e603ea..335712faaa42a 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -338,6 +340,320 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
>>   	}
>>   }
>>   
>> +/**
>> + * ibmveth_toggle_irq - Common helper to enable/disable queue interrupts
> [ ... ]
>
>> +		/*
>> +		 * H_PARAMETER is ambiguous (already in requested state vs bad
>> +		 * args). Fold only on disable as an idempotent mask. On enable
>> +		 * keep it an error so a stuck-masked queue stays visible to
>> +		 * poll/resize recovery.
>> +		 */
>> +		if (h_rc == H_PARAMETER && !enable) {
>> +			dev_warn_ratelimited(&adapter->netdev->dev,
>> +					     "H_VIOCTL %s IRQ returned H_PARAMETER for queue %d (hwirq=%lu)\n",
>> +					     action, queue_index, hwirq);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	if (h_rc) {
>> +		dev_err_ratelimited(&adapter->netdev->dev,
>> +				    "Failed to %s IRQ for queue %d, rc=0x%lx\n",
>> +				    action, queue_index, h_rc);
>> +		return -EIO;
>> +	}
>> +	return 0;
>> +}
> [ ... ]
>
>> +static int
>> +ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
>> +{
> [ ... ]
>
>> +	if (adapter->multi_queue && num > 1) {
>> +		for (i = 0; i < num; i++) {
>> +			rc = ibmveth_enable_irq(adapter, i);
>> +			if (rc) {
>> +				netdev_err(netdev,
>> +					   "Failed to enable IRQ for queue %d, rc=%d\n",
>> +					   i, rc);
>> +				for (; i >= 0; i--) {
>> +					ibmveth_disable_irq(adapter, i);
>> +					synchronize_irq(adapter->queue_irq[i]);
>> +				}
>> +				rc = -EIO;
>> +				goto err_disable_napi;
>> +			}
>> +		}
>> +	}
> [ ... ]
>
>> +err_disable_napi:
>> +	/* STOP: remask after napi_disable; an in-flight poll can re-arm. */
>> +	for (i = 0; i < num; i++)
>> +		napi_disable(&adapter->napi[i]);
>> +	for (i = 0; i < num; i++) {
>> +		if (!adapter->queue_irq[i])
>> +			continue;
>> +		ibmveth_disable_irq(adapter, i);
>> +		synchronize_irq(adapter->queue_irq[i]);
>> +	}
>> +	for (i = 0; i < num; i++) {
>> +		if (adapter->queue_irq[i])
>> +			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
>> +	}
>> +	goto err_dispose_mappings;
> [ ... ]
>
>> +static void
>> +ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
>> +{
>> +	int i;
>> +
>> +	if (!adapter->rx_irq_setup)
>> +		return;
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		if (!adapter->queue_irq[i])
>> +			continue;
>> +		ibmveth_disable_irq(adapter, i);
>> +		synchronize_irq(adapter->queue_irq[i]);
>> +	}
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++)
>> +		napi_disable(&adapter->napi[i]);
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		if (!adapter->queue_irq[i])
>> +			continue;
>> +		ibmveth_disable_irq(adapter, i);
>> +		synchronize_irq(adapter->queue_irq[i]);
>> +	}
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		if (adapter->queue_irq[i])
>> +			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
>> +	}
> [Severity: Medium]
> The commit message says cleanup "remasks and synchronizes again after it
> because an in-flight poll can re-arm". Does the second remask really close
> that window?
>
> ibmveth_poll() re-arms only after NAPI ownership has already been dropped:
>
> 	if (!napi_complete_done(napi, frames_processed))
> 		goto out;
> 	...
> 	rc = ibmveth_enable_irq(adapter, 0);
>
> napi_disable() waits for NAPIF_STATE_SCHED / NAPIF_STATE_NPSVC to clear, not
> for the poll function to return, so this interleaving looks possible:
>
> CPU1 (softirq)                    CPU0 (ibmveth_close)
> ibmveth_poll()
>    napi_complete_done()
>      /* SCHED cleared */
>    <delayed>
>                                    ibmveth_cleanup_rx_interrupts()
>                                      disable_irq + synchronize_irq
>                                      napi_disable()  /* returns at once */
>                                      disable_irq + synchronize_irq
>                                      free_irq()
>    ibmveth_enable_irq(adapter, 0)
> That leaves PHYP delivery unmasked on a queue with no handler installed
> until h_free_logical_lan() runs. The synchronize_net() added in close()
> runs after free_irq(), so it cannot cover this either, and the
> err_disable_napi path above has the same shape.
No — not that window. napi_disable() only waits for
SCHED to clear, not for poll to return, so after
napi_complete_done() it can return at once. The
second remask then runs, and enable_irq can still
land after both remasks and after free_irq. PHYP
comes back up with no handler. synchronize_net()
is after free_irq, so it does not cover this
either. The second remask only catches a re-arm
that lands before it. v7 drops that overclaim from
the commit message.
> The ordering is unchanged at the end of the series; the poll_stopping()
> check added later is passed by CPU1 before CPU0 sets the teardown state.
> Would arming the interrupt before napi_complete_done(), or gating the arm
> on a teardown flag ordered with the mask, work better here?
The arm stays after napi_complete_done. Moving it
before would re-enable PHYP while this poll still
owns NAPI.

Patch 9 adds a stopping check after complete
(napi_disable pending, or the device is down).
That skips enable_irq when cleanup has already
started. It is not ordered with the PHYP mask,
and it does not close the hole if poll already
passed that check before napi_disable. I am
leaving that in Patch 9 rather than inverting
poll here. This teardown sequence pre-dates MQ,
and completely closing the late enable requires a
poll/teardown handshake (or an RCU grace period
before free_irq) across the driver, which is listed
under Known leftovers in the cover letter.
> [Severity: Medium]
> Both ibmveth_disable_irq() calls in this function discard their return
> value, and free_irq() below then runs unconditionally. In close(),
> h_free_logical_lan() now runs after free_irq(), where the baseline freed
> the LAN first and only then removed the handler.
>
> If the mask hcall did not take effect, can PHYP deliver an interrupt in the
> interval between free_irq() and h_free_logical_lan(), with no handler
> installed? synchronize_irq() only drains a handler that is already running;
> it does not stop the hypervisor source.
Yes. We ask PHYP to mask, then free_irq even if
that hcall failed, so a delivery can still land
before h_free. synchronize_irq only waits for a
handler that is already running.

> Related: ibmveth_toggle_irq() folds H_PARAMETER into success on the disable
> path, while its own comment says H_PARAMETER may mean bad arguments rather
> than "already in requested state", so teardown can treat a rejected mask as
> a completed one. The MQ rollback loop in ibmveth_setup_rx_interrupts() has
> the same unchecked-remask-then-free_irq pattern. I could not demonstrate
> these hcalls failing in practice, so this one may be theoretical.

I am keeping free_irq before h_free in this 15,
after we have issued the mask, because I do not
want ndo_stop to fail on a disable hcall. As you
said, this one may be theoretical.
>> +
>> +	ibmveth_dispose_subordinate_irq_mappings(adapter);
>> +
>> +	/* Queue 0 uses netdev->irq; leave queue_irq[0] for next open. */
>> +	adapter->rx_irq_setup = false;
>> +}
>> +
>> +/**
>> + * ibmveth_schedule_rx_queue - Mask PHYP IRQ and schedule NAPI for one RX queue
>> + * @adapter: ibmveth adapter structure
>> + * @qindex: RX queue index
>> + *
>> + * Shared by the IRQ handler and process-context kick sites (open, resume,
>> + * pool sysfs, poll_controller).
>> + *
>> + * Return: true if napi_schedule_prep() succeeded and NAPI was scheduled.
>> + * Mask is attempted in that case; a failed disable_irq() is logged by the
>> + * helper and does not change the return (queue may still be unmasked).
>> + * false if the index is out of range or prep failed (including NAPI
>> + * already scheduled).
>> + */
>> +static bool ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
>> +				      int qindex)
>> +{
>> +	struct napi_struct *napi = &adapter->napi[qindex];
>> +
>> +	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
>> +		return false;
> [Severity: Low]
> This isn't a bug, but the kdoc and the body disagree. The kdoc describes an
> out-of-range index as an ordinary return:
>
> 	 * false if the index is out of range or prep failed (including NAPI
> 	 * already scheduled).
>
> while the body splats on it. ibmveth_interrupt() documents the opposite for
> the same condition:
>
> 	/*
> 	 * Quiet on out-of-range: teardown can leave a residual IRQ after the
> 	 * live count drops. Do not WARN-storm; return IRQ_NONE until free_irq.
> 	 */
>
> A later patch in the series changes this helper to WARN only on qindex < 0
> and to return false quietly when qindex is past the live queue count. Could
> that form be used from the start?
>
> The napi pointer is also formed from qindex before the range check; it is
> never dereferenced before the check, but computing it afterwards would read
> more clearly.
Thanks. v7 rewords the kdoc to match this helper: out of
range is WARN_ON, then false.

The helper keeps the WARN form here rather than the
later quiet one. At this commit num_rx_queues does not shrink,
so >= num is still a driver bug and the WARN is useful.
interrupt() already returns IRQ_NONE before it calls
this helper, so a residual IRQ does not hit the splat.
The quiet >= live path becomes the right one when
resize can publish a lower count; that is Patch 14.

>> +
>> +	/*
>> +	 * Only mask PHYP when NAPI will run. Masking on prep failure can
>> +	 * race a completing poll that already re-enabled the queue, leaving
>> +	 * NAPI idle with the IRQ masked (TX works, RX stalls) until reload.
>> +	 * Storm prevention on teardown remains in cleanup/disable paths.
>> +	 */
>> +	if (napi_schedule_prep(napi)) {
>> +		/* Failure is already logged with the hcall rc by the helper. */
>> +		ibmveth_disable_irq(adapter, qindex);
>> +		__napi_schedule(napi);
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
> [ ... ]
>
>> @@ -1000,24 +1315,20 @@ static int ibmveth_open(struct net_device *netdev)
>>   	if (rc)
>>   		goto out_free_tx_ltb;
>>   
> [Severity: High]
> This isn't a bug introduced by this patch, but the buffer-pool allocation
> failure just above (ibmveth_alloc_buffer_pools() -> goto out_free_tx_ltb)
> still skips h_free_logical_lan(), unlike the setup_rx_interrupts() failure
> right below it.
>
> The out_free_tx_ltb path continues into ibmveth_cleanup_rx_resources(),
> which unmaps and frees the buffer list, the filter list and the RX ring
> while the logical LAN registration is still live, so PHYP keeps DMA
> addresses for freed pages.
>
> Does the new opened gate in ibmveth_close() also remove the last site that
> could have deregistered that residue? A later ndo_stop now returns 0
> without calling h_free_logical_lan().
>
> Two later patches in this series rework this ladder, first routing the pool
> failure through a path that loops on h_free_logical_lan() and then moving
> pool allocation ahead of registration, so the window does not survive the
> series. Would it be worth ordering those ahead of this one so this commit
> does not carry it?
Yes, PHYP can still write those pages on that path.
Pre-existing — the old pool-fail path already jumped to
the same labels without h_free. The request_irq /
setup_rx_interrupts failure below it does issue h_free.
The later register-helper reorder stays out of
this patch.

The opened gate does drop the accidental recovery: a
later ndo_stop now returns 0 and never reaches h_free.
That residue stays until Patch 6.

Patch 6 ("Refactor TX resource allocation in open/close
paths") issues h_free on that pool-fail path. Patch 7
("Add RX queue register helpers for MQ") then allocates
the pools before register, and every later failure goes
through ibmveth_free_all_queues().
>> -	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
>> -	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
>> -			 netdev);
>> -	if (rc != 0) {
>> -		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
>> -			   netdev->irq, rc);
>> +	rc = ibmveth_setup_rx_interrupts(adapter);
>> +	if (rc) {
>>   		do {
>>   			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>>   		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>> -
>>   		goto out_free_buffer_pools;
>>   	}
>>   
>>   	netdev_dbg(netdev, "initial replenish cycle\n");
>> -	ibmveth_interrupt(netdev->irq, netdev);
>> +	ibmveth_schedule_rx_queue(adapter, 0);
>>   
>>   	netif_tx_start_all_queues(netdev);
>>   
>> +	adapter->opened = true;
>>   	netdev_dbg(netdev, "open complete\n");
>>   
>>   	return 0;
> [ ... ]
>
>> @@ -1041,27 +1351,32 @@ static int ibmveth_close(struct net_device *netdev)
>>   	long lpar_rc;
>>   	int i;
>>   
>> -	netdev_dbg(netdev, "close starting\n");
>> +	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
>> +	 * leave IFF_UP set after a failed reopen.
>> +	 */
>> +	if (!adapter->opened)
>> +		return 0;
> [Severity: Medium]
> The commit message says:
>
>    "Opened / rx_irq_setup also closes a pre-existing hang: after a
>     failed reopen, a later ndo_stop used to napi_disable and free_irq
>     a second time (rtnl spin + already-free IRQ). That depends on the
>     helpers in this patch, so there is no standalone Fixes: tag."
>
> Is that dependency real? This gate reads only adapter->opened, and the
> matching "adapter->opened = true" at the end of ibmveth_open() does not
> reference ibmveth_toggle_irq(), ibmveth_setup_rx_interrupts() or
> ibmveth_cleanup_rx_interrupts() either.
>
> The hang itself is reachable in the baseline: ibmveth_open() calls
> napi_enable() on entry and napi_disable() on its out: path, and
> ibmveth_close() starts with napi_disable(). veth_pool_store(),
> ibmveth_change_mtu(), ibmveth_set_csum_offload() and ibmveth_set_tso() call
> ibmveth_close() then ibmveth_open() directly and do not clear IFF_UP when
> the reopen fails, so a later "ip link set dev X down" enters
> ibmveth_close() and the second napi_disable() spin-waits forever with rtnl
> held.
>
> Could the opened flag and this gate be split into their own patch with a
> Fixes: tag, so the fix can be backported without the refactor?
This patch already fixes that hang: open sets opened
only on success, and close() returns if !opened, so a
later ndo_stop does not napi_disable a second time.
There is no Fixes: tag; the commit message names the
hang and declines one. I am keeping it self-contained
in this 15 to avoid cross-tree dependencies; a
standalone fix for net can follow separately (and we
can rebase on top of it if requested).

That is not the later unwind standalone (h_free / TX LTB).

>>   
>> -	napi_disable(&adapter->napi[0]);
>> +	adapter->opened = false;
>> +
>> +	netdev_dbg(netdev, "close starting\n");
>>   
>>   	netif_tx_stop_all_queues(netdev);
>>   
>> -	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
>> +	ibmveth_cleanup_rx_interrupts(adapter);
>> +	/* Wait for softirq/poll that already passed shutdown checks. */
>> +	synchronize_net();
>>   
>> +	ibmveth_update_rx_no_buffer(adapter);
>> +	/* Full LAN teardown (subordinates arrive with register helpers). */
>>   	do {
>>   		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>>   	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> [Severity: Low]
> Two permanent changes to ibmveth_close() are not described in the commit
> message.
>
> ibmveth_update_rx_no_buffer() moves from after h_free_logical_lan() and
> free_irq() to before h_free_logical_lan(). It reads the absolute counter
> that the hypervisor writes at the end of the buffer list page, and the
> hypervisor still owns that page until h_free_logical_lan() returns, so the
> final rx_no_buffer / rx_errors value can now miss drops recorded after the
> read. Was the reordering intentional?
>
> The new synchronize_net() in the ndo_stop path is mentioned only in the v5
> changelog below the --- separator, which does not land in git history.
> Could it be described in the commit message as well?
Yes — both are intentional. v7 names them in the commit message.
The harvest stays before h_free so the read still hits a
live buffer-list page. synchronize_net() after IRQ/NAPI
teardown waits for a poll that already passed the
shutdown checks.

Thanks,

Mingming


>> -
>>   	if (lpar_rc != H_SUCCESS) {
>> -		netdev_err(netdev, "h_free_logical_lan failed with %lx, "
>> -			   "continuing with close\n", lpar_rc);
>> +		netdev_err(adapter->netdev,
>> +			   "h_free_logical_lan failed with %lx, continuing\n",
>> +			   lpar_rc);
>>   	}
>> -
>> -	free_irq(netdev->irq, netdev);
>> -
>> -	ibmveth_update_rx_no_buffer(adapter);
>> -
>>   	ibmveth_free_buffer_pools(adapter);
>>   	ibmveth_cleanup_rx_resources(adapter);
>>   	ibmveth_free_filter_list(adapter);
> [ ... ]
>
>> @@ -1805,15 +2120,14 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   	/* We think we are done - reenable interrupts,
>>   	 * then check once more to make sure we are done.
>>   	 */
>> -	lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
>> -	if (WARN_ON(lpar_rc != H_SUCCESS)) {
>> +	rc = ibmveth_enable_irq(adapter, 0);
>> +	if (rc) {
>>   		schedule_work(&adapter->work);
>>   		goto out;
>>   	}
> [ ... ]
>


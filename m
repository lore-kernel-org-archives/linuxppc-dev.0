Return-Path: <linuxppc-dev+bounces-26335-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67770C61DFD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 19:07:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYdlX6tYnz2yCt;
	Tue, 01 Sep 2026 05:07:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788203224;
	cv=none; b=Z5bsxtTI6AVGJGIZte7mPmVGtRDZ+Ui1w9ixTEh1dKXe7nQrnKAFWpfTL6Ocf/yXnv5m+5LuKFrH2I433JtEgF6oARst/+eYd6zx6Ypqx8Nv9CdEjP4N1iZkIq5RdAOb9sv3ibd5GZbOIOsQQG16mwCLO9yuCokPjSP7JwM77Rmy10Auc3woqmg2CNjfbDi5kjAcFptg1MjZQPvOI4ZHtE0Cn6QudadlVDV7RRUskSwrOJBx70W+Q07sH0lybrbRR4iYoLpvbNELdqn+dflNdDYEmaE8Wb9QDKJMqG2vh1YHp4bzvU/JIWJDCIND+jArFeArxo//NjfOM3lbdQkYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788203224; c=relaxed/relaxed;
	bh=bMciv9X8gzVIbtZnN7Ngr1vphzosRH4pAZlk+qyNwqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPJUJaLiIuKrJcB8U/iEyC4k+4o86cI2yiy1Me6Ig0uXgFLevYCkOWZyNhKaKXyuG2ebWuLl0JX5oulh166IgyEDOIiqrH55aSHtRvmwbh73kAyrV3YtiZhIS4jwtbvPVIg4u3Qk0NPCM4EEk3JYqyywNHuzKhffi4Biorik8IsfHjZ3GgYF1W27hi2mOlX0uayEBDHxWjetb/wS59Wsd6ZusvFU9bXpEGRUgTRlKy6h3vUP5zOlBoimCfhpXlRSqmwd6DcwgODH3ft+AAWBZJ4euB2EMxLS/aysVxlfgFVKAdK0T2bwq9xpqle+hCes/xIM1BxMam4+yTsDx6iK3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d7nxgS4B; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d7nxgS4B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYdlW5vgFz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 05:07:03 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VIVadp3108045;
	Mon, 31 Aug 2026 19:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bMciv9
	X8gzVIbtZnN7Ngr1vphzosRH4pAZlk+qyNwqI=; b=d7nxgS4BiDhToSuqX0rMLl
	jRVXB2TujpxFQsyklxjm9p+4feaEwuLs7t3tmiGH1wDRrtJolfPhafxVCA9DOXV4
	e6KUYMvVvfbvFml42LwWvPN6a5Sj6vfjYQaqv/DrxKWC5bh59Ul5mSxLFvRkJviV
	onDnC4okLcqzmmapaSvvqpR7F3KiqZWx5LRriaerADbwG4Eh0gzDz3f/eVZSAWnY
	YJZislpawLOtD+Bh8CPbjfO4mMn1as3EgWufTzZEmfLNz4gxeUZuLf98MP5oNSSP
	rUs2Qkg2f7EtglbizWQfXSSdIycTv1abt9oqrnt3qE5lyqcjP4fLo51YTB8hxAWA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54kajs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:06:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VIuRtu022365;
	Mon, 31 Aug 2026 19:06:52 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h7hn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:06:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VJ6krS20972260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 19:06:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1A9A58060;
	Mon, 31 Aug 2026 19:06:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C99F58063;
	Mon, 31 Aug 2026 19:06:43 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 19:06:43 +0000 (GMT)
Message-ID: <c1785619-ec00-4d68-848b-3bad0b4fc35a@linux.ibm.com>
Date: Mon, 31 Aug 2026 12:06:42 -0700
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
Subject: Re: [PATCH net-next v5 09/15] ibmveth: Harden RX poll path with
 helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-10-mmc@linux.ibm.com>
 <20260818014729.3854228-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014729.3854228-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfX7yqs+hdCgYuD
 Dyr60Elxr2h+L1uee28/hy0zGKGiHh0aQklzghNUfZeSt5rl7rCnZnsxULZ73FMFSTHS7Oo3YnE
 DzoMdo9R0AhvsnTuRPPPYC0SdEvWggfXBkAOG7NPuIBcTqsrkt4upESlR9C88NM0GPbTHopdAp2
 mcV1tMwDB6zX76NPj0BfPegnxGHssy97aN4ZnOnEMz90tHBPScqDjBzkGxQYjMPl4bCR7L2kZvI
 FD4Ot6K3G+6wrDotipu3Nsm6ZYnqA0S3hoJj36XbNt/Af/AZhcEMeFf+s6IGFgbVl2vyEt+9gQO
 B3f1MJIAnvySSxAzJ6XNnrqzbM6IEr2MwyQJdHOSXI6qO6gTLRUtQvYvHiITuI4AaOCTF+leOLz
 PyFf0pj/hBeOn05gPYq+Hk3LA0ToOHUjholLNakE9ERdJEpmXKQLLDhBC5TIQ/Ezh1NWM5Em9/X
 WsSCwXYZ6JnkegrLQjQ==
X-Proofpoint-ORIG-GUID: 6MQXfFUSQw5Lpf86v6LmeHf3SVtl4HjG
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95d0cd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=zzz8uMCE5rJb_l3BNggA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HwzjqSgl62wkuQuJoorg8hydSDETMggG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfX0P2V/khYLSZe
 yrF8HBOM8yTYSC8UZTKgeIAn8RwoY4OxLgOmw+grBZK2Z6gwNhq9DPQX1X40fCaG92B9XdLGIR6
 GzrUQinJKv+egJtuW5lvTZiU2HYVnb0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310164


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Harden RX poll path with helpers
>
> This splits the inline RX slot handling in ibmveth_poll() into a set of
> small helpers (stopping / harvest_slot / recycle_invalid /
> skip_bad_correlator / drop_oversize / deliver_frame / bump_invalid) so the
> NAPI callback stays a budget loop.  It also moves the reset escalation out
> of ibmveth_rxq_get_buffer() into ibmveth_poll_skip_bad_correlator() and
> adds stopping checks so close/napi_disable does not re-arm PHYP.
>
> A few questions below.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 58a639a962a67..86299c62d4ecf 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -1346,10 +1346,8 @@ ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
>>   	unsigned int pool = correlator >> 32;
>>   	unsigned int index = correlator & 0xffffffffUL;
>>   
>> -	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
>> -		schedule_work(&adapter->work);
>> +	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
>>   		return NULL;
>> -	}
>>   
>>   	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
>>   }
>> @@ -2338,125 +2336,230 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>>   	}
>>   }
>>   
>> +static void ibmveth_poll_bump_invalid(struct ibmveth_adapter *adapter,
>> +				      int queue_index)
>> +{
>> +	adapter->rx_invalid_buffer++;
>> +}
>> +
>> +static bool ibmveth_poll_stopping(struct net_device *netdev,
>> +				  struct napi_struct *napi)
>> +{
>> +	return !netif_running(netdev) || napi_disable_pending(napi);
>> +}
>> +
>> +static bool ibmveth_poll_harvest_slot(struct ibmveth_adapter *adapter,
>> +				      int queue_index, bool reuse)
>> +{
>> +	int rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, reuse);
>> +
>> +	return !rc || rc == -EINVAL || rc == -EFAULT;
>> +}
>> +
>> +static bool ibmveth_poll_recycle_invalid(struct net_device *netdev,
>> +					 struct ibmveth_adapter *adapter,
>> +					 int queue_index)
>> +{
>> +	netdev_dbg(netdev, "recycling invalid buffer\n");
>> +	ibmveth_poll_bump_invalid(adapter, queue_index);
>> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
>> +}
>> +
>> +static bool ibmveth_poll_skip_bad_correlator(struct net_device *netdev,
>> +					     struct ibmveth_adapter *adapter,
>> +					     int queue_index)
>> +{
>> +	if (net_ratelimit())
>> +		netdev_err(netdev,
>> +			   "bad correlator on queue %d, skipping slot\n",
>> +			   queue_index);
>> +	/* Residual stale slot after resize: recover via reset rather
>> +	 * than spinning forever. Always escalate; only the log is
>> +	 * rate-limited.
>> +	 */
>> +	schedule_work(&adapter->work);
>> +	ibmveth_poll_bump_invalid(adapter, queue_index);
>> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
>> +}
>> +
>> +static bool ibmveth_poll_drop_oversize(struct net_device *netdev,
>> +				       struct ibmveth_adapter *adapter,
>> +				     int queue_index, unsigned int off,
>> +				     unsigned int len, unsigned int room)
>> +{
>> +	if (net_ratelimit())
>> +		netdev_err(netdev,
>> +			   "RX frame %u+%u exceeds buffer %u on queue %d, dropping\n",
>> +			   off, len, room, queue_index);
>> +	ibmveth_poll_bump_invalid(adapter, queue_index);
>> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
>> +}
> [Severity: Medium]
> The changelog describes this as splitting a nested switchyard into helpers,
> but a few behaviour changes appear to ride along.  Could they be called out
> in the changelog, or split out?
>
> First, ibmveth_poll_bump_invalid() is now called from both
> ibmveth_poll_drop_oversize() and ibmveth_poll_skip_bad_correlator(), so the
> exported rx_invalid_buffer counter also counts oversize frames and skipped
> slots.  Is that intended, and should it be mentioned?
>
> Second, before this patch schedule_work() ran only when
> ibmveth_rxq_correlator_valid() failed, and the poll loop simply broke out.
> Now ibmveth_poll_skip_bad_correlator() escalates unconditionally, so it also
> covers the valid-correlator-with-NULL-skbuff case, which returns -EFAULT
> from ibmveth_remove_buffer_from_pool().  ibmveth_reset() does:
>
> 	rtnl_lock();
>
> 	dev_close(adapter->netdev);
> 	dev_open(adapter->netdev, NULL);
>
> so does this turn a condition that previously cost one aborted poll into a
> full close/open link flap?  The changelog says "skip_bad_correlator owns
> reset escalation", which reads as parity, but the escalation scope looks
> strictly larger.
>
> Third, the new off/len test in ibmveth_poll_deliver_frame() below appears to
> be the first bound check applied to the PHYP-supplied offset and length
> before skb_reserve()/skb_put().  Should that carry a Fixes: tag?  As it
> stands it is mixed into roughly 190 lines of code motion, which makes it
> hard to pick up on its own.
Yes, not pure motion. v6 names those three in the commit message
rather than splitting them out: they are the reason the peel exists
and cannot precede it — the helpers are not available before the
split.

bump_invalid counting oversize and skipped slots is intended.

skip_bad's scope is larger: a valid correlator with a NULL skb now
resets instead of aborting one poll. That is a close/open, not
parity with “valid() failed only.” The other choice is spinning on
the same pending slot in softirq, so v6 keeps the wider reset.

No Fixes: on the off/len check. The driver never validated the
PHYP-supplied offset and length, so there is no parent SHA to name,
and the test lives in the new helper. Happy to send a standalone if
you would rather pick it up that way.
>> +
>> +/**
>> + * ibmveth_poll_deliver_frame - Build SKB from one valid RX slot and GRO it
>> + * @napi: NAPI context for this RX queue
>> + * @adapter: ibmveth adapter
>> + * @netdev: net_device for @adapter
>> + * @queue_index: RX queue index
>> + *
>> + * Return: 1 frame delivered, 0 if the slot was skipped cleanly, -1 on error.
>> + */
>> +static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
>> +				      struct ibmveth_adapter *adapter,
>> +				      struct net_device *netdev,
>> +				      int queue_index)
>> +{
>> +	struct sk_buff *skb, *new_skb;
>> +	unsigned int room, off, len;
>> +	int length, offset, csum_good, lrg_pkt;
>> +	__sum16 iph_check = 0;
>> +	u16 mss = 0;
>> +	int rc;
>> +
>> +	length = ibmveth_rxq_frame_length(adapter, queue_index);
>> +	offset = ibmveth_rxq_frame_offset(adapter, queue_index);
>> +	csum_good = ibmveth_rxq_csum_good(adapter, queue_index);
>> +	lrg_pkt = ibmveth_rxq_large_packet(adapter, queue_index);
>> +
>> +	skb = ibmveth_rxq_get_buffer(adapter, queue_index);
>> +	if (unlikely(!skb)) {
>> +		if (!ibmveth_poll_skip_bad_correlator(netdev, adapter,
>> +						      queue_index))
>> +			return -1;
>> +		return 0;
>> +	}
>> +
>> +	room = skb_tailroom(skb);
>> +	off = offset;
>> +	len = length;
>> +	if (unlikely(off >= room || len > room - off)) {
>> +		if (!ibmveth_poll_drop_oversize(netdev, adapter, queue_index,
>> +						off, len, room))
>> +			return -1;
>> +		return 0;
>> +	}
> [ ... ]
>
>> +	skb_put(skb, length);
>> +	skb->protocol = eth_type_trans(skb, netdev);
>> +
>> +	if (skb->protocol == cpu_to_be16(ETH_P_IP))
>> +		iph_check = ip_hdr(skb)->check;
>> +
>> +	if ((length > netdev->mtu + ETH_HLEN) || lrg_pkt ||
>> +	    iph_check == 0xffff) {
>> +		ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
>> +		adapter->rx_large_packets++;
>> +	}
> [Severity: High]
> Is skb->network_header set for this skb at this point?  The old code read
> the checksum through skb->data:
>
> 			if (skb->protocol == cpu_to_be16(ETH_P_IP)) {
> 				struct iphdr *iph = (struct iphdr *)skb->data;
>
> 				iph_check = iph->check;
> 			}
>
> ip_hdr(skb) resolves to skb_network_header(skb), which is
> skb->head + skb->network_header, and there is no was-it-set validation.
>
> eth_type_trans() only does skb_reset_mac_header() plus eth_skb_pull_mac(),
> and the driver's single skb_reset_network_header() call sits inside
> ibmveth_rx_csum_helper(), which runs after this read.  For skbs from
> netdev_alloc_skb(), __finalize_skb_around() poisons mac_header and
> transport_header to ~0U but leaves network_header at 0.
>
> If that reading is right, ip_hdr(skb) points at skb->head and iph_check
> comes out of the uninitialized headroom rather than the received IP header.
> Two effects follow:
>
> A PHYP-without-PLSO large-send frame whose IP checksum is 0xffff, whose
> length is within mtu + ETH_HLEN, and whose large packet bit is clear is no
> longer recognised, so gso_size and gso_segs are never set.
>
> When the stale headroom bytes happen to be 0xffff, ibmveth_rx_mss_helper()
> runs on an ordinary frame with lrg_pkt == 0 and takes the offset branch:
>
> 	} else if (offset) {
> 		skb_shinfo(skb)->gso_size = ntohs(tcph->check);
> 		tcph->check = 0;
> 	}
>
> which zeroes the real TCP checksum and marks the frame as GSO with a
> gso_size taken from that checksum, before napi_gro_receive().
>
> Would keeping (struct iphdr *)skb->data here be better, matching what
> ibmveth_rx_mss_helper() and ibmveth_rx_csum_helper() do for the same skb at
> the same stage?  This same line is still present in the later patches of the
> series.
Yes. network_header is still 0 here, so ip_hdr() reads skb->head,
producing both corruption effects you described: PLSO frames with
iph_check == 0xffff are missed, and stale headroom bytes of 0xffff
corrupt TCP checksums via ibmveth_rx_mss_helper(). That was a v5
peel regression — the baseline loop used (struct iphdr *)skb->data.

v6 restores that, matching ibmveth_rx_mss_helper() and
ibmveth_rx_csum_helper() which both read through skb->data at this
stage.


>> +
>> +	if (csum_good) {
>> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
>> +		ibmveth_rx_csum_helper(skb, adapter);
>> +	}
>> +
>> +	napi_gro_receive(napi, skb);
>> +
>> +	netdev->stats.rx_packets++;
>> +	netdev->stats.rx_bytes += length;
>> +
>> +	return 1;
>> +}
>> +
>>   static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   {
>>   	struct net_device *netdev = napi->dev;
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>>   	int frames_processed = 0;
>>   	int queue_index, rc;
>> -	u16 mss = 0;
>>   
>>   	queue_index = napi - adapter->napi;
>>   
>> +	if (WARN_ON(queue_index < 0 ||
>> +		    queue_index >= adapter->num_rx_queues)) {
>> +		napi_complete_done(napi, 0);
>> +		return 0;
>> +	}
>> +
>> +	if (ibmveth_poll_stopping(netdev, napi)) {
>> +		napi_complete_done(napi, 0);
>> +		return 0;
>> +	}
>> +
>>   restart_poll:
>>   	while (frames_processed < budget) {
>> +		if (ibmveth_poll_stopping(netdev, napi))
>> +			break;
>> +
>>   		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
>>   			break;
>>   
>>   		smp_rmb();
>>   		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
>>   			wmb(); /* suggested by larson1 */
>> -			adapter->rx_invalid_buffer++;
>> -			netdev_dbg(netdev, "recycling invalid buffer\n");
>> -			rc = ibmveth_rxq_harvest_buffer(adapter,
>> -							queue_index, true);
>> -			if (unlikely(rc))
>> +			if (!ibmveth_poll_recycle_invalid(netdev, adapter,
>> +							  queue_index))
>>   				break;
>>   		} else {
> [ ... ]
>
>> -			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
>> -			if (unlikely(!skb))
>> +			rc = ibmveth_poll_deliver_frame(napi, adapter, netdev,
>> +							queue_index);
>> +			if (rc < 0)
>>   				break;
> [ ... ]
>
>> -			netdev->stats.rx_packets++;
>> -			netdev->stats.rx_bytes += length;
>> -			frames_processed++;
>> +			if (rc > 0)
>> +				frames_processed++;
>>   		}
>>   	}
> [Severity: Medium]
> Since skipped slots return 0 and only rc > 0 bumps frames_processed, does
> while (frames_processed < budget) still bound the work done in one poll
> call?
>
> Where the pre-patch code did:
>
> 			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
> 			if (unlikely(!skb))
> 				break;
>
> a run of stale or oversize descriptors now walks every pending slot in the
> ring while reporting zero work.  rxq_entries is 1 plus the sum of all pool
> sizes, so that is on the order of a thousand slots per invocation, with
> schedule_work(&adapter->work) called once per skipped slot from
> ibmveth_poll_skip_bad_correlator().
>
> The recycle-invalid branch already had this shape before the patch, but this
> extends it to the bad-correlator and oversize outcomes and adds the per-slot
> schedule_work().
No. The loop caps delivered frames, not slots walked. That is the
NAPI budget we want. A burst of stale or oversize descriptors can
walk the pending ring with frames_processed still 0; harvest still
advances each slot, so the walk stops at rxq_entries. skip_bad
calls schedule_work per skipped slot, but adapter->work coalesces,
so that is one reset, not N close/open flaps. Oversize harvests
without a reset.
>>   
>>   	ibmveth_replenish_task(adapter, queue_index);
>>   
>> +	if (ibmveth_poll_stopping(netdev, napi)) {
>> +		napi_complete_done(napi, frames_processed);
>> +		/* After complete, must not return budget (NAPI resched). */
>> +		if (frames_processed < budget)
>> +			return frames_processed;
>> +		return budget - 1;
>> +	}
> [Severity: Medium]
> This branch hands frames_processed to napi_complete_done() but returns a
> different value to the core.  With budget == 0, frames_processed is 0, so
> 0 < budget is false and the callback returns -1.
>
> budget == 0 is a real caller value, and ibmveth registers
> .ndo_poll_controller:
>
> net/core/netpoll.c:poll_one_napi() {
> 	work = napi->poll(napi, 0);
> 	WARN_ONCE(work, "%pS exceeded budget in poll\n", napi->poll);
> 	trace_napi_poll(napi, work, 0);
> }
>
> so a -1 return would trip that WARN_ONCE and record work = -1 in the
> tracepoint.
>
> Documentation/networking/napi.rst also states:
>
>     If the ``budget`` is 0 napi_complete_done() should never be called.
>
> which this branch and the two new entry-time paths above (the WARN_ON
> queue_index path and the first ibmveth_poll_stopping() path, both calling
> napi_complete_done(napi, 0)) do without checking budget.  Would the
> documented form fit better here:
>
> 	if (budget && napi_complete_done(napi, work_done))
> 		return min(work_done, budget - 1);
>
> Reaching the -1 case needs ibmveth_poll_stopping() to be false at the entry
> check and true after the loop.  netpoll_poll_dev() requires
> netif_running(dev), so the flip would come from napi_disable_pending(), which
> ibmveth_change_mtu() and veth_pool_store() produce via ibmveth_close() ->
> ibmveth_cleanup_rx_interrupts() -> napi_disable() while IFF_UP is still set.
>
> Separately, returning budget - 1 on a full-budget stopping exit under-counts
> the work by one frame.  The return budget - 1 is still present in the later
> patches of the series.
Yes. budget == 0 is real here: netpoll calls poll(napi, 0), and
v5 could complete and return -1. v6 never calls napi_complete_done()
when budget is 0 (the two entry paths and the post-loop stop path)
and returns 0 there.

min(..., budget - 1) on a stopping complete when budget > 0 is the
NAPI “completed, no more work” signal, not an under-count. Kept.

>>   
>>   	if (frames_processed == budget)
>>   		goto out;
>>   
>>   	if (!napi_complete_done(napi, frames_processed))
>>   		goto out;
>>   
>> -	/* We think we are done - reenable interrupts,
>> -	 * then check once more to make sure we are done.
>> +	/*
>> +	 * napi_disable() sets DISABLE then waits for this poll. Without a
>> +	 * second stopping check here, enable_irq() can re-arm PHYP after
>> +	 * resize already masked the queue — late IRQs then hit the handler
>> +	 * after num_rx_queues was published lower (lab WARN at interrupt).
>>   	 */
>> +	if (ibmveth_poll_stopping(netdev, napi))
>> +		goto out;
>> +
>>   	rc = ibmveth_enable_irq(adapter, queue_index);
> [Severity: Medium]
> This is a pre-existing pattern and not introduced by this patch, since the
> baseline calls ibmveth_enable_irq() and ibmveth_rxq_pending_buffer() after
> napi_complete_done() with no check at all.  Still, the new check is a
> check-then-act on NAPI_STATE_DISABLE and __LINK_STATE_START: once
> napi_complete_done() has cleared NAPI_STATE_SCHED, napi_disable() can return
> and the close path can proceed while this poll instance is still executing
> its tail.
>
> Looking at ibmveth_close(), the synchronize_net() that sits after
> ibmveth_cleanup_rx_interrupts() and before ibmveth_free_all_queues():
>
> 	ibmveth_cleanup_rx_interrupts(adapter);
> 	/* Wait for softirq/poll that already passed shutdown checks. */
> 	synchronize_net();
>
> 	ibmveth_update_rx_no_buffer(adapter);
> 	ibmveth_free_all_queues(adapter);
>
> appears to order the freeing after the in-flight poll, since NAPI polls run
> with BH disabled and a BH-disabled region blocks a grace period.  On that
> reading the residual effect is a PHYP re-arm on a queue about to be
> released, whose interrupt is then discarded by napi_schedule_prep() or
> free_irq(), rather than a use-after-free.
>
> Does the comment's claim about the late-IRQ WARN hold as written, or does
> the check only narrow the window?
Pre-existing, and your synchronize_net() reading is right: poll
runs with BH disabled, so the grace period waits out this tail and
close does not free the ring under us. Residual is a PHYP re-arm,
not a UAF.

The new check only narrows the window. It is not exclusion. The
comment overclaimed the late-IRQ WARN. Scale-down still remasks
after napi_disable for a poll that re-armed while disable waited.


Thanks,

Mingming



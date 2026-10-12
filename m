Return-Path: <linuxppc-dev+bounces-29214-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF249CA9ED5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 05:04:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j353f05Pgz2yYY;
	Mon, 12 Oct 2026 16:04:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791781453;
	cv=none; b=FilKoJA4jPyuZG/XzpThOPH4tPSdTN2GJpD2/HpMtxJFLXbzjLSgPiMZikbKJIpTOseu73FS7Z2Nml6cfggrwOyLJ1g0RoHa4sMaefDON/87Rm9Epp5Zy+4xDD6YaWQSmvB7XajcJADTeGAZuCdI/HZvEFQnZQDQ9qhcjMsKBy5Tuc8+StAH7jOF4cXZZYNfaGNsn9mwIbFCIF+o9psRmN4bB6UDM7D09NTLO1p85C6kRk7HmNxFCtg/opTidR8lIi6awQ7Ptc4MzQpW0LpSAf909ivazdhFYdccaDCKVC3oR0PCxO4c5mBIHeuTEzB/cXCxf7RkQFWq7hovuZIvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791781453; c=relaxed/relaxed;
	bh=uFU+800bsccEesRqUvmAZL8rkHq2KyNXzUK3BpApTmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glJqnP7L8Mob1ZlWy3DEVy7gahMMSJQ1Bh7gsuAoB2o6jG80wl6VuW/BlyXOdgi6OdnQCT+PvuESs4Xtun2U1J7tlRkMDnJaSAqZumQUJRy2f3NlnFxDFRWWED/jygjZpl14yy340Ik39cl3pk1ib3x2IQh0vsgKbo3W1JG0GG95E+miRSJOZFy1nXGs6lwiplThwbeyPbxE6/02p6fEqrVjw3odcWKFb7kQ4fVep1n3/272MvPtq8MdWxrcdgFICWQtAZRe5dAJ/u0FzdymjFaWBrXjbWllXziJjC6202yKpyJcN67COUO/6isLZ22q70c1FOeyOz/v1BL7OO2rGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DkX5FW+e; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DkX5FW+e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j353c56rpz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 16:04:12 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2F1K73019042;
	Mon, 12 Oct 2026 05:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uFU+80
	0bsccEesRqUvmAZL8rkHq2KyNXzUK3BpApTmQ=; b=DkX5FW+ef8GuEuJ39as0op
	1dIYFeNLUk/6glGuRGp/1lbaFHMxPT286whRxbhPxQZXzl7/QwL2yT2fQY6ZcADn
	f6RjXBhhbV255H34DBz+xORxklanf3fbOCAm3sIb535cEZ60PCO0qLrl+UZtfarl
	LdM8c4eqAcQ1YcprlJ6RyFn7PxkZ/mQIUkpQ94TazyHFFbFUJiFTI+mcUqdSWodm
	tQwNThnI6wT86SgHrE8IBptudwrlHqEZkwncAiSS46z23jxXbRu3TwvZt1Ey8I7m
	LK6hYhiAK3gkaXhpjeqRjDls3Rpl+oa7GHgg2JCyHbodHPHMXYxgVd++kkCMqXjA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3789u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:04:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C1o6ih522249;
	Mon, 12 Oct 2026 05:04:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjks8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:04:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C53x7466519326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 05:03:59 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BF505810F;
	Mon, 12 Oct 2026 05:03:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0949858115;
	Mon, 12 Oct 2026 05:03:56 +0000 (GMT)
Received: from [9.67.163.79] (unknown [9.67.163.79])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 05:03:55 +0000 (GMT)
Message-ID: <93cc87b4-14ce-43d9-a29e-d9a6795bb0d5@linux.ibm.com>
Date: Sun, 11 Oct 2026 22:03:55 -0700
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
Subject: Re: [PATCH net-next v3 4/8] ibmveth: step past bad RX correlators
 instead of spinning or oopsing
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, stephen@networkplumber.org
References: <20261009183258.18624-5-mmc@linux.ibm.com>
 <179166081271.434549.2458181310224040226@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <179166081271.434549.2458181310224040226@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: u8b1v0peDjrQLPqgg1Rb4ofNq2OGPsxd
X-Proofpoint-ORIG-GUID: cYnn2M_sA5Qw1tEFTV2dg9lLqStR4cIJ
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acc6a42 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=CpsONLjkRwPTLDU7ZUkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX0LOxcmnFJ4dc
 BI4qRXd4zf5kCznDK4thDyVPE7LxnW6oc8+nvUrnRYyWjT3eyIYM8xEwWRYdV34qf3QJm7+tNkW
 RJQP5Y2dciV0/C+ywTBya3FZAddMm30=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX8zhWFzwWO9wA
 omUqgpMfkwrOTzz7Wldo7Ho54u3HX8h2b4/k1I+nDwVQ+5KLiFzbE81ov0ge9dzjKSTmGqPIEmZ
 FX7ZdEJyQQpYnA/WWiZosTaFFavqhGq+fGgu/0I6mBsogyOvzmGfELCJ7r4CGhduK/JSE1ptDHz
 foMRmpq/HRlAEOgl1r8941PnkogOu6mfx0AOP3/A2tjckvkg6KKher9V2jWpX7zdztg2o3Zf6KP
 B3uSAEzlPicXNJDwzrARJW7SFIkvn9vxozHZB8PYUOkkqbZTiMFqLgPtk68s+O/zWDEtqSyA8ED
 G4Ln8vOGoyXtGj2s85vuSeeb0zI5e4e500F88QwR7PPInNyByhUF3GtOaKhNpQYmot19ZCS4TbA
 1RZXRId0ON99Pcp/4b7WmM8PJVoo9YX5Mx9maYPFQkCaDS0pCuAusBstQuQ6+Mk673ubn1GW8GF
 fJgVFWS8Qoh+S9UeXzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120018


On 10/10/26 12:33 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 · High: 3 (1) · Medium: 0 · Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] This patch's short-frame check is incomplete.
> - [High] Returning budget - 1 does not make ibmveth_poll()'s schedule-
>    and-continue path safe when threaded NAPI and busy polling are both…
> - [High] net/ibmveth: TOCTOU double-fetch of RX correlator in
>    harvest_buffer
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but
>    ibmveth_rx_csum_helper() calls ip_fast_csum(iph, iph->ihl) whenever…
>
> --


Thank you for the review. I agree with all four High findings on this
patch.

I will address them in v4 on the same net-next base (d8674294aefe).
Patches 1-3 and 5-8 are unchanged from v3. Patch 4 fixes the poll
tail (no restart_poll after napi_complete_done; mask then queue the
NAPI), passes the correlator poll already read into harvest, and
keeps the buffer-bound and ETH_HLEN drops without claiming they cover
the RX offload helpers.

The helper header checks (short frames, ihl,
doff, fragments, and the ip_fast_csum() case) are split into a new
patch 9 at the end of the series, with their own Fixes: tags and KUnit
cases.

I will post v4 on netdev shortly.
v4 was tested with KUnit on qemu pseries and on a POWER10 LPAR (the v3
suite plus large-send iperf3 over IPv4/IPv6 at MTU 1500 and 9000).

Thanks,
Mingming

pw-bot: cr

> ibmveth: step past bad RX correlators instead of spinning or oopsing
>
> This patch makes ibmveth_poll() advance the RX ring past slots with a bad
> correlator, including correlators that name an inactive pool, instead of
> breaking out and restarting on the same slot. It counts those slots as
> drops and schedules a reset. It also drops frames that do not fit the pool
> buffer or are shorter than an Ethernet header, and returns budget - 1 once
> napi_schedule() has queued the NAPI.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index cee0e9783b2ab..55c0b5d6e0a9f 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1481,19 +1525,46 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
> [ ... ]
>
>>   		} else {
>>   			struct sk_buff *skb, *new_skb;
>>   			int length = ibmveth_rxq_frame_length(adapter);
>>   			int offset = ibmveth_rxq_frame_offset(adapter);
>>   			int csum_good = ibmveth_rxq_csum_good(adapter);
>>   			int lrg_pkt = ibmveth_rxq_large_packet(adapter);
>> +			u64 correlator = ibmveth_rxq_correlator(adapter);
>> +			unsigned int pool, room, off, len;
>>   			__sum16 iph_check = 0;
> [Severity: High]
> The commit message says the bound uses the pool "from the correlator
> that was validated, read once, not from a second read of the ring".
> Doesn't ibmveth_rxq_harvest_buffer() still do that second read?
>
> ibmveth_poll() now reads the correlator once with
> ibmveth_rxq_correlator(). It uses that value to look up skb in
> ibmveth_rxq_get_buffer() and to compute room. Every harvest after that
> ignores it, though: this call, the copybreak call and the one on the
> bad-frame path. ibmveth_rxq_harvest_buffer() loads
> queue_addr[rx_queue.index].correlator again with a plain load and
> passes that to ibmveth_remove_buffer_from_pool(). Nothing ties the
> second value to the one poll validated.
>
> Suppose the entry changes between the two loads, so skb is looked up
> from slot A and harvested from slot B. On this reuse=false path:
>
> - rx_buff_pool[].skbuff[B] is cleared and dma_addr[B] is unmapped.
>    B goes on free_map, and the skb that was in slot B is leaked.
>
> - skb A goes to napi_gro_receive() while it is still in skbuff[A],
>    still DMA mapped and not on free_map. The driver still treats it
>    as a posted buffer.
>
> - On close or reset, ibmveth_free_buffer_pool() finds skb A in
>    skbuff[A], unmaps it and calls dev_kfree_skb_any() on it after the
>    stack has already freed it.
>
> The copybreak and bad-frame paths would recycle slot B instead of A
> in the same way.
>
> ibmveth_rxq_correlator_valid() does not catch this, because both
> correlators can be in range and name live skbs.
>
> PHYP should not rewrite an entry once the toggle is set. But this
> patch treats the correlator as untrusted, and the changelog says it
> is read once. Should ibmveth_rxq_harvest_buffer() take the correlator
> from its caller, so poll uses one value for lookup, bound check and
> harvest? The new KUnit harvest test could read the ring entry itself
> before calling it.
>
> [ ... ]
>
>> +			pool = correlator >> 32;
>> +			room = min_t(unsigned int, skb_tailroom(skb),
>> +				     adapter->rx_buff_pool[pool].buff_size);
>> +			off = offset;
>> +			len = length;
>> +			if (unlikely(len < ETH_HLEN || off >= room ||
>> +				     len > room - off)) {
>> +				if (net_ratelimit())
>> +					netdev_err(netdev,
>> +						   "bad RX frame offset %u length %u (buffer %u), dropping\n",
>> +						   off, len, room);
>> +				ibmveth_rxq_harvest_buffer(adapter, true);
>> +				netdev->stats.rx_dropped++;
>> +				frames_processed++;
>> +				continue;
>> +			}
> [Severity: High]
>
> The commit message says this check fixes the case where "the checksum
> helpers would write past a short frame". Is an ETH_HLEN minimum enough
> for that?
>
> Once this check passes, ibmveth_poll() and its helpers assume a full IP
> header and TCP header and never look at skb->len:
>
> ibmveth_poll()
>      iph_check = iph->check;
>      ibmveth_rx_mss_helper()     /* lrg_pkt or iph_check == 0xffff */
>          skb_shinfo(skb)->gso_size = ntohs(tcph->check);
>          tcph->check = 0;
>          hdr_len = offset + tcph->doff * 4;
>          skb_shinfo(skb)->gso_segs =
>                  DIV_ROUND_UP(skb->len - hdr_len, ...);
>      ibmveth_rx_csum_helper()    /* csum_good */
>          iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
>          struct tcphdr *tcph = (struct tcphdr *)(skb->data + iphlen);
>          if (tcph->check == 0x0000) {
>              tcph->check = ~csum_tcpudp_magic(...);
>
> A frame of about 14 to 92 bytes passes the new check, but these helpers
> still read and write past the end of the frame. In
> ibmveth_rx_mss_helper(), skb->len - hdr_len can also wrap.
>
> On the copybreak path, those accesses land in the uninitialized tailroom
> of new_skb.
>
> On the non-copybreak path, they land in the pool buffer past the frame.
> That path runs when the GFP_ATOMIC copybreak allocation fails, or when
> rx_copybreak is set at or below the frame length.
>
> The new bound also accepts a short frame at the very end of the buffer.
> For pool 0 with room = 512, off = room - 34 and len = 34 leave
> skb->tail == skb->end after skb_put(). eth_type_trans() then leaves 20
> bytes of IPv4 header, so tcph sits at skb->end.
>
> Wouldn't the tcph->check writes then land in struct skb_shared_info
> (hwtstamps, gso_type, tskey or dataref, depending on ihl)?
> skb_partial_csum_set() rejects this only after the write has already
> happened.
>
> Should there be per-protocol skb->len checks, or pskb_may_pull(), before
> the IP and TCP headers are parsed, rather than a fixed minimum?
>
> [Severity: High]
>
> This isn't a bug introduced by this patch, but since this patch hardens
> the RX path: should ibmveth_rx_csum_helper() check iph->ihl before it
> calls ip_fast_csum()?
>
>      if (iph->check == 0xffff) {
>          iph->check = 0;
>          iph->check = ip_fast_csum((unsigned char *)iph,
>                                    iph->ihl);
>      }
>
> On ppc64, ip_fast_csum_nofold() in arch/powerpc/include/asm/checksum.h
> documents that ihl "is always >= 5" and does:
>
>      for (i = 0; i < ihl - 1; i++, ptr++)
>          s += *ptr;
>
> ihl is unsigned, so with ihl == 0, ihl - 1 wraps to 0xFFFFFFFF and the
> loop reads about 16 GiB starting at the RX buffer, in NAPI softirq
> context.
>
> The ihl, check and ethertype fields and the IBMVETH_RXQ_CSUM_GOOD flag
> all come from the sending partition. Could a single IPv4 frame with
> ihl = 0 and check = 0xffff from a peer on the same virtual LAN oops or
> stall this partition?
>
> [ ... ]
>
>> @@ -1581,10 +1661,16 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
>>   		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
>>   				       VIO_IRQ_DISABLE);
>> +		rescheduled = 1;
>>   		goto restart_poll;
>>   	}
>>   
>>   out:
>> +	/* napi_schedule() already queued us. Returning budget would
>> +	 * make busy_poll_stop() queue the napi a second time.
>> +	 */
>> +	if (rescheduled && budget && frames_processed >= budget)
>> +		return budget - 1;
>>   	return frames_processed;
>>   }
> [Severity: High]
>
> Does returning budget - 1 cover the case where threaded NAPI and busy
> polling are both enabled?
>
> busy_poll_stop() clears NAPI_STATE_IN_BUSY_POLL before it calls the
> driver poll. Its own comment says "Unless rc == budget we no longer own
> the NAPI instance". From there:
>
> busy_poll_stop()
>    ibmveth_poll()
>      napi_complete_done()             /* succeeds */
>      h_vio_signal(..., VIO_IRQ_ENABLE)
>      napi_schedule()
>        ____napi_schedule()
>          set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
>          wake_up_process(thread);
>      goto restart_poll;               /* keeps processing the ring */
>
> The woken kthread sees NAPI_STATE_SCHED_THREADED in napi_thread_wait()
> and calls __napi_poll()->ibmveth_poll() on another CPU. Meanwhile the
> original call is still running from restart_poll.
>
> Can the two pollers then race, with no lock, on rx_queue.index and
> toggle, rx_buff_pool[].skbuff[], free_map and producer_index? For
> example, one harvest with reuse=false could clear and unmap an skb while
> the other poller passes the same skb to napi_gro_receive().
>
> The budget - 1 return only runs after this overlap. Continuing to poll
> after napi_schedule() predates this patch, but this patch now reasons
> about NAPI ownership after napi_schedule(). Would it be better to stop
> processing once napi_schedule() succeeds, instead of jumping back to
> restart_poll?
>


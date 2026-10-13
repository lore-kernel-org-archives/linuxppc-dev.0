Return-Path: <linuxppc-dev+bounces-29435-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA9ACC6B12
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 21:00:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j46Dy1N1Tz2y8p;
	Wed, 14 Oct 2026 08:00:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791925250;
	cv=none; b=gkcz5Mr7PzgBuwH1U6iciF6gDA7yxTe9RNl20o3AM79JGunFeZoF+7kLD244FZT93t+v2IjyReIVW86Zcn1ffatRZtky5+JKI8vnCM5okyacTHhhsU4Ci/P074pdPxRaTKpIUv+4qCat0+pDl/2GgbpUWoRx7oguDlLnXMF+a8qNQdJcQeS/jvqEfJTN6PLS8469wNr6LkLpSL0Sbqdnbwa7HCr0Sqnkpccr1cS49UIsgVbmsr+BVS5h/FHwdxDVKFkNPt+y27i7H7PB6fbE5KivsUrML8gx757/Yn2ZMjhlFOW7exwhcSbnzjgFUr0NAltQxZ2g8URpz9liF5iWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791925250; c=relaxed/relaxed;
	bh=UvD7rjrds7zjnm1JpksHU8I8lbLsavW0heWduxRH7Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIo/8Ia7mYyagEz8lkHaSkrU7AuDxIfQnSbqVgsSIPxryWQ2RXIehyp5cO62rdkHmA4cPv0OZwJrTreRUYugyWECu4dbVH/XnvUpYFhJcR7MsZOkJdDngQbOwhveOgyM5MqFJXl3VQtsgzPMVPzH9Q8eciiP5n+/mFl5FXod/EzQ4vlYbEt4JSFGiAQa4a4OOW4Prfz2kGKUROOYbhgshnVsD4Cu8RhbahythDym0on/yO0Fudum26ZxZfzXPaUzLU8jZ1HBsSNcT8w/PtNCg0ychEbIfSR6c4Woz8icgVn3x7sJtQF9aad06XIty2CS8zDK9IweuNWbKJv9fJp8OQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=acseTAkj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=acseTAkj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j46Dx2dQnz2y2T
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 08:00:49 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDMohY150262;
	Tue, 13 Oct 2026 21:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UvD7rj
	rds7zjnm1JpksHU8I8lbLsavW0heWduxRH7Ko=; b=acseTAkjx6xhpMmHTB+5SJ
	sScPKLZiyFUVKw5+0Yj/uDfkhr/prXZWY8aDKxK4u+6YXIAw3tlq9ZR5pdUATaYM
	PBBv3oz6O5vU68s3i/Qs+F8SQ2AGM3hLcM7tJtDGIK1O5bXB6Xi/fevfmF+TdPzu
	QA4H33cAKjdFgHHWdA/fUKTO6NMBUrzZPWOemtyNia0/DzhpG3GjGWtF4NIuhO8V
	eE7QR5NBq16fvAbBkCgbewrt/rnlckZNQUZk6JdBp+FJRA3YpDdatqZJlvTBvijD
	A1XvXBzm3nYmUAvBILflhfrKZPeIis+davIvhGgGecqnnP0Bliohd17AJmCx4gqw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhgxku-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 21:00:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DIAPr62667524;
	Tue, 13 Oct 2026 21:00:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vvf1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 21:00:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DL0aQa21758598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 21:00:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E03858057;
	Tue, 13 Oct 2026 21:00:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B23685805D;
	Tue, 13 Oct 2026 21:00:33 +0000 (GMT)
Received: from [9.67.58.174] (unknown [9.67.58.174])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 21:00:33 +0000 (GMT)
Message-ID: <2363fbc6-7ad2-4dd1-8ebc-822c16471b25@linux.ibm.com>
Date: Tue, 13 Oct 2026 14:00:33 -0700
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
Subject: Re: [PATCH net-next v4 9/9] ibmveth: check headers in the RX large
 send and checksum helpers
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, brking@linux.vnet.ibm.com,
        tlfalcon@linux.vnet.ibm.com, jmaxwell37@gmail.com, zdai@us.ibm.com,
        marcelo.leitner@gmail.com, ksiva@linux.vnet.ibm.com
References: <20261012050518.88858-10-mmc@linux.ibm.com>
 <179187067525.434549.7404862779574164491@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <179187067525.434549.7404862779574164491@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4MiBTYWx0ZWRfX2182pZXj4SrC
 vFqQwuTydyujwIApahfHKUBRT4vI7a9KjPOy1xu+EFsJNDyS8F/Mm7CjpSArbecJbqTvptUdr5O
 WDtg1Nrd3YtrtHRSj/eJ7MlbMrMzkHM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4MiBTYWx0ZWRfX+FC1YFlzT7c8
 kOJo4ZqfL5rbv+C3JBcBZJhayPuULeZT8vmc5CoKH22I4fzIvNONZMuXjCZ/r0lTY9WHiTydoVu
 42DWJUC9i6YVwFofjn2FzIcTbwmYAsJ/z+knXXZIC0rAkKDHN37vep9dz5iVMdTQ3Kr33KvdIYf
 J+SP6bf9Obni1EehnYA3WTRn1RJO8WxXzLOU5DFLWnpD4IU66k8uI9imIXjWnuPzQe1YZnGK3wy
 YucCm5bK1HgRTKadVKRaC9oqQ5yRTfL4P4UEi10YoK075OCOdHGjQsC403/omTiBWYFx2ZYWTbb
 zioxTpjzQBrCxfwoSSSl7SQ12mqeDEv+f1my4CAAuqzl2/CJGDjt4/u4IJiWpJ0IMWo0V5JGCms
 ADzAk7fuSUv0x1gNxDNcDA2JkCgh8mX8Dxl1fHSHiAChH1wCgKrobCfQR/yrUJjjMMdTwJeBp9z
 ElAm5ihOB18BfUnKdFQ==
X-Proofpoint-GUID: R8_Aug9lxRwXYKbLj67yDHze4xxCIvpb
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace9bf7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=HYs3yLHdxXCyPMkvej0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tuf4ByZ8ZZ3dT_W0MiccTrgCa04WHV9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130082


On 10/12/26 10:51 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] ibmveth_rx_mss_helper() (drivers/net/ethernet/ibm/ibmveth.c) now
>    sets gso_segs = DIV_ROUND_UP(ip_len - hdr_len, gso_size).
> - [Low] The kernel-doc of ibmveth_rx_mss_helper_test() says the helper
>    takes "gso_segs from the IP length" and refuses "Frames whose headers…
>
> Pre-existing issues:
> - [Medium] ibmveth_rx_csum_helper()
>    (drivers/net/ethernet/ibm/ibmveth.c:1530) seeds the TCP pseudo-header…
>
> --
>
> ibmveth: check headers in the RX large send and checksum helpers
>
> This adds bounds checks on the IP and TCP headers in
> ibmveth_rx_mss_helper() and ibmveth_rx_csum_helper(). The checks include a
> minimum IPv4 ihl and TCP doff, and IPv4 TCP fragments are refused. The large
> send helper now computes gso_segs from the IP length and clamps gso_size,
> and KUnit cases are added for both helpers.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 85e176d0ed321..1c2ac88c28ca3 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1406,28 +1410,41 @@ static void ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
>>   	if (skb->protocol == htons(ETH_P_IP)) {
>>   		struct iphdr *iph = (struct iphdr *)skb->data;
>>   
>> +		if (skb_headlen(skb) < sizeof(*iph) || iph->ihl < 5)
>> +			return false;
>>   		if (iph->protocol == IPPROTO_TCP) {
>> +			/* only a whole datagram has a TCP header to segment */
>> +			if (ip_is_fragment(iph))
>> +				return false;
>>   			offset = iph->ihl * 4;
>> -			skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
>> +			ip_len = ntohs(iph->tot_len);
>> +			gso_type = SKB_GSO_TCPV4;
> [ ... ]
>
>>   	tcph = (struct tcphdr *)(skb->data + offset);
>> +	if (skb_headlen(skb) < offset + sizeof(*tcph) || tcph->doff < 5 ||
>> +	    ip_len > skb_headlen(skb) || ip_len <= offset + tcph->doff * 4)
>> +		return false;
>> +	skb_shinfo(skb)->gso_type = gso_type;
>>   	if (lrg_pkt) {
>>   		skb_shinfo(skb)->gso_size = mss;
>>   	} else if (offset) {
>> @@ -1436,11 +1453,18 @@ static void ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
>>   	}
>>   
>>   	if (skb_shinfo(skb)->gso_size) {
>> +		/* chosen by the sending partition: at least the floor
>> +		 * virtio_net_hdr_to_skb() uses, and never GSO_BY_FRAGS
>> +		 */
>> +		skb_shinfo(skb)->gso_size =
>> +			clamp_t(u16, skb_shinfo(skb)->gso_size,
>> +				TCP_MIN_GSO_SIZE, GSO_BY_FRAGS - 1);
>>   		hdr_len = offset + tcph->doff * 4;
>>   		skb_shinfo(skb)->gso_segs =
>> -				DIV_ROUND_UP(skb->len - hdr_len,
>> +				DIV_ROUND_UP(ip_len - hdr_len,
>>   					     skb_shinfo(skb)->gso_size);
>>   	}
> [Severity: High]
>
> Can gso_segs here undercount the number of segments that actually get
> produced?

|Thanks for catching this. Agreed. |

> The only check of ip_len against the frame is ip_len > skb_headlen(skb).
> That means a frame much longer than its IP length is accepted, and nothing
> trims the skb to ip_len before napi_gro_receive().
>
> The commit message says the skb is not marked SKB_GSO_DODGY because
> gso_segs is computed here. That holds once ip_rcv_core() trims the skb to
> tot_len, on local delivery or routing. On the Trunk VEA forwarding paths
> (a bridge without br_netfilter, or OVS without conntrack), the skb is not
> trimmed.
>
> For example, a sending partition could:
>
>    - set iph->check = 0xffff
>    - put an MSS of 8 in tcph->check
>    - set tot_len = 100
>    - send a frame of about 9000 bytes
>
> The new checks pass (100 <= headlen, 100 > 40), so gso_segs becomes 8.
> tcp_gso_segment() or hardware TSO works on skb->len instead, which gives
> about 1120 segments.
>
> On egress, gso_features_check() compares the trusted gso_segs against the
> device limit:
>
> net/core/dev.c:gso_features_check() {
>      ...
> 	if (gso_segs > READ_ONCE(dev->gso_max_segs))
> 		return features & ~NETIF_F_GSO_MASK;
>      ...
> }
>
> Also, qdisc_pkt_len_segs_init() only recomputes gso_segs from skb->len for
> SKB_GSO_DODGY skbs.
>
> Would this let a TSO skb past the egress NIC's gso_max_segs? Would it also
> make the qdisc and BQL accounting too low?
>
> Before this patch, gso_segs was derived from skb->len, which matches what
> gets segmented. Any of these would avoid the mismatch:
>
>    - trim the skb to ip_len, for example with pskb_trim_rcsum()
>    - refuse large sends where skb_headlen(skb) != ip_len
>    - compute gso_segs from skb->len
>
> [ ... ]
>
>> @@ -1493,6 +1523,8 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>>   	if (iph_proto == IPPROTO_TCP) {
>>   		struct tcphdr *tcph = (struct tcphdr *)(skb->data + iphlen);
>>   
>> +		if (skb_headlen(skb) < iphlen + sizeof(*tcph))
>> +			goto bad_hdr;
>>   		if (tcph->check == 0x0000) {
>>   			/* Recompute TCP pseudo header checksum  */
>>   			tcphdrlen = skb->len - iphlen;
> [Severity: Medium]
>
> This isn't a bug introduced by this patch, but should the pseudo-header
> length in ibmveth_rx_csum_helper() come from the IP header rather than
> skb->len?
>
> The frame can have bytes past the end of the IP datagram, either Ethernet
> padding or trailing bytes that ibmveth_rx_mss_helper() still accepts when
> ip_len < skb_headlen(skb). If tcph->check is also 0, the seed is computed
> over the wrong length, and skb_partial_csum_set() then marks the skb
> CHECKSUM_PARTIAL.
>
> ip_rcv_core() and ip6_rcv_core() later trim the skb with pskb_trim_rcsum().
> For CHECKSUM_PARTIAL, that only checks where the checksum field is:
>
> net/core/skbuff.c:pskb_trim_rcsum_slow() {
>      ...
> 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
> 		int hdlen = (len > skb_headlen(skb)) ? skb_headlen(skb) : len;
> 		int offset = skb_checksum_start_offset(skb) + skb->csum_offset;
>
> 		if (offset + sizeof(__sum16) > hdlen)
> 			return -EINVAL;
> 	}
>      ...
> }
>
> The seed is left as it was.
>
> Could a forwarded packet then go out with a TCP checksum over the trimmed
> data but a pseudo-header for the untrimmed length? The final receiver
> would drop it.
>
> This patch moved the large send helper to the IP length. Would
> tot_len - ihl * 4, or the IPv6 payload_len, make sense here too?
>
> [ ... ]

|Yes, that makes sense. Since that behavior predates this series (from 
commit 66aa0678efc2), I'd prefer not to expand Patch 9 further and will 
handle that as a separate follow-up. |



>> @@ -2508,10 +2549,214 @@ static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)
> [ ... ]
>
>> +	} else {
>> +		struct iphdr *iph = (struct iphdr *)skb->data;
>> +
>> +		skb->protocol = htons(ETH_P_IP);
>> +		iph->version = 4;
>> +		iph->ihl = 5;
>> +		iph->protocol = IPPROTO_TCP;
>> +		iph->tot_len = htons(len);
>> +	}
> [ ... ]
>
>> +/**
>> + * ibmveth_rx_mss_helper_test - unit test for ibmveth_rx_mss_helper
>> + * @test: pointer to kunit structure
>> + *
>> + * Large send frames get gso_size from the descriptor or the TCP checksum
>> + * field, clamped, and gso_segs from the IP length. Frames whose headers
>> + * do not fit, with no TCP payload within the IP length, or that are
>> + * IPv4 fragments, are refused and left without GSO.
>> + *
>> + * Return: void
>> + */
> [Severity: Low]
>
> This isn't a bug, but do any of the cases in ibmveth_rx_mss_helper_test()
> test "gso_segs from the IP length" or the "headers do not fit" refusal?
>
> ibmveth_test_tcp_skb() always sets tot_len (or 40 + payload_len) equal to
> skb->len. So in every accepted case, DIV_ROUND_UP(ip_len - hdr_len, ...)
> gives the same result as the old DIV_ROUND_UP(skb->len - hdr_len, ...).
> The only case with ip_len < skb->len is the padding case, and it is refused
> before gso_segs is computed.
>
> No mss helper case builds an skb shorter than sizeof(struct iphdr),
> sizeof(struct ipv6hdr), or offset + sizeof(struct tcphdr). So if gso_segs
> went back to skb->len, or those skb_headlen() checks were dropped from
> ibmveth_rx_mss_helper(), every expectation would still pass.
>
> Could cases be added for a tot_len smaller than the frame and for truncated
> headers? Otherwise, could the kernel-doc be narrowed to what is tested?


|We added the tot_len < frame length KUnit test case in v5. Truncated 
headers are already safely caught by the strict IP length / payload 
checks. v5 is posted here: 
https://lore.kernel.org/netdev/20261013182926.30417-1-mmc@linux.ibm.com/ 
Thanks, Mingming pw-bot: cr|




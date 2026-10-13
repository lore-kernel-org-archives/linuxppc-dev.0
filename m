Return-Path: <linuxppc-dev+bounces-29343-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA7ACA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 05:51:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3k3X6csYz3btP;
	Tue, 13 Oct 2026 16:51:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791870680;
	cv=none; b=gyzyT8A/NHmP6lKnOMr8PIxH4Ngy/tocxW7Ms7hJbRxeE47OjFkx83ChrnaKTBA9cw8lnilVfWInhJ6gYuSSBzOXykORXC9o1XUW90XFa7v+3TW8o/Rj2u9j8B///Vr3fsSOLG6a5KJbP/FtBuRspINDwgd2ASFBJtqQgoIrT+FDLzWUF6pzYAyFkrJh0c0lHMueNS7yWRrzneAurA5Pm+qtsAKDRzP1s/+Yf18yJMXdiGlyGajAeMlwZrIGmzjuhqZxac1YOUZy2w/YcC8jM+fSSpyMUEguwCXG83fD/iyLyOrIXN09nknSpA9isftlQ5BSTLmzpNLTtjuMPEE+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791870680; c=relaxed/relaxed;
	bh=TZOTfwKK/9csisAzSTOEpuQHBSLm5lYYx5WFKdj0fP8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2s4D8/dE+1EpZoJLmCqGrwN+4ARwf38hunIATirDrUeae9IlLWsbEE2b3aHOdPKH79+9BtNcEGf0lk6GWeRIIxMVLJeBxws73WUyA3Jc3MLKqdU8PrrKTBvHNGygElFqcx4BwRMj5XNVyw8OmGiwP4ppPxVc8WHwgvx6dmA0Q0AiMQlv4lo4iVHW3MVRSPmsLEnOunkHFVwLDOrDG2WWNKXiSUJyutMgKN/mcxbj9aovwQoSJKtA4JDedgA/+jhS64exD3AtdO7I6FMQpL9C7hwVDMSjCrN97eX3V516l6JZ8oCkmTLxVbmIuaQKQPMhupEOBkdWfFOs6s4QtzHOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJowRFzd; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJowRFzd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3k3W4cxyz3bsf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 16:51:19 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2D9FD60A5E;
	Tue, 13 Oct 2026 05:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D031F000FF;
	Tue, 13 Oct 2026 05:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791870676;
	bh=TZOTfwKK/9csisAzSTOEpuQHBSLm5lYYx5WFKdj0fP8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DJowRFzdUtFGojE0GWF9gs5XZtoOhsS3lMkop6MJ47Bjfr9pNq3TSbom5aO/ihzuF
	 NFBKmIOx3KgY5melRzz1shSegcux6E61JkhZe1gM6K1Jbt9N1Uo66XSnozllfKksgk
	 zH651Oynwm6wR5KzaHRAbYKmFz/RJzi8fcSvfG5X1AT9EBT0q905tOumjr2se+sySY
	 4TFkuXXIK/fNLKP6gQn+pAu8lhwRVCFSdWVf/wzcQxEBIv9iwQCh2/9nT3Xho8NG6T
	 7drSUCqx9MwoRYXyLZslN13XJSAAvPcc79bvPBE8ceDJkMkr8kI7uPtj4xvsVoay69
	 MyZV5miI8LzGQ==
Subject: Re: [PATCH net-next v4 9/9] ibmveth: check headers in the RX large
 send and checksum helpers
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 davemarq@linux.ibm.com, bjking1@linux.ibm.com, brking@linux.vnet.ibm.com,
 tlfalcon@linux.vnet.ibm.com, jmaxwell37@gmail.com, zdai@us.ibm.com,
 marcelo.leitner@gmail.com, ksiva@linux.vnet.ibm.com
Date: Tue, 13 Oct 2026 05:51:15 +0000
Message-ID: <179187067525.434549.7404862779574164491@kernel.org>
In-Reply-To: <20261012050518.88858-10-mmc@linux.ibm.com>
References: <20261012050518.88858-10-mmc@linux.ibm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ibmveth_rx_mss_helper() (drivers/net/ethernet/ibm/ibmveth.c) now
  sets gso_segs = DIV_ROUND_UP(ip_len - hdr_len, gso_size).
- [Low] The kernel-doc of ibmveth_rx_mss_helper_test() says the helper
  takes "gso_segs from the IP length" and refuses "Frames whose headers…

Pre-existing issues:
- [Medium] ibmveth_rx_csum_helper()
  (drivers/net/ethernet/ibm/ibmveth.c:1530) seeds the TCP pseudo-header…

--

ibmveth: check headers in the RX large send and checksum helpers

This adds bounds checks on the IP and TCP headers in
ibmveth_rx_mss_helper() and ibmveth_rx_csum_helper(). The checks include a
minimum IPv4 ihl and TCP doff, and IPv4 TCP fragments are refused. The large
send helper now computes gso_segs from the IP length and clamps gso_size,
and KUnit cases are added for both helpers.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 85e176d0ed321..1c2ac88c28ca3 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1406,28 +1410,41 @@ static void ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
>  	if (skb->protocol == htons(ETH_P_IP)) {
>  		struct iphdr *iph = (struct iphdr *)skb->data;
>  
> +		if (skb_headlen(skb) < sizeof(*iph) || iph->ihl < 5)
> +			return false;
>  		if (iph->protocol == IPPROTO_TCP) {
> +			/* only a whole datagram has a TCP header to segment */
> +			if (ip_is_fragment(iph))
> +				return false;
>  			offset = iph->ihl * 4;
> -			skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
> +			ip_len = ntohs(iph->tot_len);
> +			gso_type = SKB_GSO_TCPV4;

[ ... ]

>  	tcph = (struct tcphdr *)(skb->data + offset);
> +	if (skb_headlen(skb) < offset + sizeof(*tcph) || tcph->doff < 5 ||
> +	    ip_len > skb_headlen(skb) || ip_len <= offset + tcph->doff * 4)
> +		return false;
> +	skb_shinfo(skb)->gso_type = gso_type;
>  	if (lrg_pkt) {
>  		skb_shinfo(skb)->gso_size = mss;
>  	} else if (offset) {
> @@ -1436,11 +1453,18 @@ static void ibmveth_rx_mss_helper(struct sk_buff *skb, u16 mss, int lrg_pkt)
>  	}
>  
>  	if (skb_shinfo(skb)->gso_size) {
> +		/* chosen by the sending partition: at least the floor
> +		 * virtio_net_hdr_to_skb() uses, and never GSO_BY_FRAGS
> +		 */
> +		skb_shinfo(skb)->gso_size =
> +			clamp_t(u16, skb_shinfo(skb)->gso_size,
> +				TCP_MIN_GSO_SIZE, GSO_BY_FRAGS - 1);
>  		hdr_len = offset + tcph->doff * 4;
>  		skb_shinfo(skb)->gso_segs =
> -				DIV_ROUND_UP(skb->len - hdr_len,
> +				DIV_ROUND_UP(ip_len - hdr_len,
>  					     skb_shinfo(skb)->gso_size);
>  	}

[Severity: High]

Can gso_segs here undercount the number of segments that actually get
produced?

The only check of ip_len against the frame is ip_len > skb_headlen(skb).
That means a frame much longer than its IP length is accepted, and nothing
trims the skb to ip_len before napi_gro_receive().

The commit message says the skb is not marked SKB_GSO_DODGY because
gso_segs is computed here. That holds once ip_rcv_core() trims the skb to
tot_len, on local delivery or routing. On the Trunk VEA forwarding paths
(a bridge without br_netfilter, or OVS without conntrack), the skb is not
trimmed.

For example, a sending partition could:

  - set iph->check = 0xffff
  - put an MSS of 8 in tcph->check
  - set tot_len = 100
  - send a frame of about 9000 bytes

The new checks pass (100 <= headlen, 100 > 40), so gso_segs becomes 8.
tcp_gso_segment() or hardware TSO works on skb->len instead, which gives
about 1120 segments.

On egress, gso_features_check() compares the trusted gso_segs against the
device limit:

net/core/dev.c:gso_features_check() {
    ...
	if (gso_segs > READ_ONCE(dev->gso_max_segs))
		return features & ~NETIF_F_GSO_MASK;
    ...
}

Also, qdisc_pkt_len_segs_init() only recomputes gso_segs from skb->len for
SKB_GSO_DODGY skbs.

Would this let a TSO skb past the egress NIC's gso_max_segs? Would it also
make the qdisc and BQL accounting too low?

Before this patch, gso_segs was derived from skb->len, which matches what
gets segmented. Any of these would avoid the mismatch:

  - trim the skb to ip_len, for example with pskb_trim_rcsum()
  - refuse large sends where skb_headlen(skb) != ip_len
  - compute gso_segs from skb->len

[ ... ]

> @@ -1493,6 +1523,8 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>  	if (iph_proto == IPPROTO_TCP) {
>  		struct tcphdr *tcph = (struct tcphdr *)(skb->data + iphlen);
>  
> +		if (skb_headlen(skb) < iphlen + sizeof(*tcph))
> +			goto bad_hdr;
>  		if (tcph->check == 0x0000) {
>  			/* Recompute TCP pseudo header checksum  */
>  			tcphdrlen = skb->len - iphlen;

[Severity: Medium]

This isn't a bug introduced by this patch, but should the pseudo-header
length in ibmveth_rx_csum_helper() come from the IP header rather than
skb->len?

The frame can have bytes past the end of the IP datagram, either Ethernet
padding or trailing bytes that ibmveth_rx_mss_helper() still accepts when
ip_len < skb_headlen(skb). If tcph->check is also 0, the seed is computed
over the wrong length, and skb_partial_csum_set() then marks the skb
CHECKSUM_PARTIAL.

ip_rcv_core() and ip6_rcv_core() later trim the skb with pskb_trim_rcsum().
For CHECKSUM_PARTIAL, that only checks where the checksum field is:

net/core/skbuff.c:pskb_trim_rcsum_slow() {
    ...
	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
		int hdlen = (len > skb_headlen(skb)) ? skb_headlen(skb) : len;
		int offset = skb_checksum_start_offset(skb) + skb->csum_offset;

		if (offset + sizeof(__sum16) > hdlen)
			return -EINVAL;
	}
    ...
}

The seed is left as it was.

Could a forwarded packet then go out with a TCP checksum over the trimmed
data but a pseudo-header for the untrimmed length? The final receiver
would drop it.

This patch moved the large send helper to the IP length. Would
tot_len - ihl * 4, or the IPv6 payload_len, make sense here too?

[ ... ]

> @@ -2508,10 +2549,214 @@ static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)

[ ... ]

> +	} else {
> +		struct iphdr *iph = (struct iphdr *)skb->data;
> +
> +		skb->protocol = htons(ETH_P_IP);
> +		iph->version = 4;
> +		iph->ihl = 5;
> +		iph->protocol = IPPROTO_TCP;
> +		iph->tot_len = htons(len);
> +	}

[ ... ]

> +/**
> + * ibmveth_rx_mss_helper_test - unit test for ibmveth_rx_mss_helper
> + * @test: pointer to kunit structure
> + *
> + * Large send frames get gso_size from the descriptor or the TCP checksum
> + * field, clamped, and gso_segs from the IP length. Frames whose headers
> + * do not fit, with no TCP payload within the IP length, or that are
> + * IPv4 fragments, are refused and left without GSO.
> + *
> + * Return: void
> + */

[Severity: Low]

This isn't a bug, but do any of the cases in ibmveth_rx_mss_helper_test()
test "gso_segs from the IP length" or the "headers do not fit" refusal?

ibmveth_test_tcp_skb() always sets tot_len (or 40 + payload_len) equal to
skb->len. So in every accepted case, DIV_ROUND_UP(ip_len - hdr_len, ...)
gives the same result as the old DIV_ROUND_UP(skb->len - hdr_len, ...).
The only case with ip_len < skb->len is the padding case, and it is refused
before gso_segs is computed.

No mss helper case builds an skb shorter than sizeof(struct iphdr),
sizeof(struct ipv6hdr), or offset + sizeof(struct tcphdr). So if gso_segs
went back to skb->len, or those skb_headlen() checks were dropped from
ibmveth_rx_mss_helper(), every expectation would still pass.

Could cases be added for a tot_len smaller than the frame and for truncated
headers? Otherwise, could the kernel-doc be narrowed to what is tested?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012050518.88858-1-mmc%40linux.ibm.com


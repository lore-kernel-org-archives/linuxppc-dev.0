Return-Path: <linuxppc-dev+bounces-29642-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5433CCF2C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 19:08:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6WYL1gGdz2yhP;
	Sun, 18 Oct 2026 06:08:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792264102;
	cv=none; b=FnAp9hyHWS6jnJtxwEiyW2wzDwgRsYg5tAhP4bsE04uedPZXtm/ZmNVFACBsOSbwmciPxAs464Gi0yYYxhPvNe96xNJitzS/Sm6lySYUQNRtGKMn0IZVbRPmW8Y/JLFQYPZ4Xr0PPMskj6Gij6jCqdmoZN3FNw5TuqUZPFgEMxcNCV4Z45TvqeoBKIIXbxgem50+g13PE1s+WwBY7sEcy5CfmB95QJE0WdVl1LZz42cBRuNPP4xnDaOYlS7g/U3RnsW43tFxR2SP3CSrT7mTq4T52ktzQsucUGjDkUH0fdd2yv0Kv/SR3R7c3wNv56ldMbdugv9qUgqtcK2xwmvdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792264102; c=relaxed/relaxed;
	bh=s7OXemtrOmTJSAlsLOITwMTGl7EjTYQ9Zwx2Vg7NH0o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KSAwSaMfiaE/D3Osovyw+T/WHAhNAmaxf8SvmNkXdfFtGGVQKPGTPyQ76RSL+eFnFZqAYLU6nVkJfRBjJpARqtiG6QCVQLEZVic76/33Ll8F9BQMGM1a9vF2cLkt8CbFpTFACdzifsphrmQFz/kwKKYgSIDbBccZkZoJ9QE3Q9chGfeBipqjXE9F3vkuTmEHn4wxmH8oQBHESbS5tY4rjBcMRHsVxw3UrNv6p+qoGlOAHIG8XFB3foT2qJ/Aj2wAgMYxxB+VjgPcslbwUFOnnk6XEhIT69eYqHfupY6tlzcG/tMpHcl68wCHGrO5XkHOher3T+2Z41ybBuGHP5/Y1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfETlLXs; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfETlLXs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6WYJ6p8Pz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 06:08:20 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8502A60D7B;
	Sat, 17 Oct 2026 19:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1400F1F000C4;
	Sat, 17 Oct 2026 19:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792264098;
	bh=s7OXemtrOmTJSAlsLOITwMTGl7EjTYQ9Zwx2Vg7NH0o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KfETlLXsVhY3bXHGwu8QdQ79IpD7caKucwRZrZxHMMDsN9VBGRtA4MD3vK2Ag/2iJ
	 svVZArPYPgaR0K+p600DgdpBTHdfHcHLdip9sWJ9umVPyWwJGbAUSaaBnyKLVOvv7j
	 hC7hpNuH3XVsWL+lrOAOhEvTNLkzZjEwD6XQxubCRsPwE0N5LsQUhWAjblXJUkKkXx
	 73SPYtxe8bPil0ZWxuDnXELbqKELnHlpOf1bDdE9TCUwKGinuujjK+Jtyx3CAPImZ6
	 VnHVmdZY9Y7Yzkh19ayorlkBIl0P+puK38eV9kJNlWfRUBMHvMbzW+knEeo0Q5BoeK
	 fBl5LEwm39nuw==
Subject: Re: [PATCH net-next v5 9/9] ibmveth: check headers in the RX large
 send and checksum helpers
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 davemarq@linux.ibm.com, bjking1@linux.ibm.com, tlfalcon@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, zdai@us.ibm.com, pradeeps@linux.vnet.ibm.com,
 ksiva@linux.vnet.ibm.com
Date: Sat, 17 Oct 2026 19:08:16 +0000
Message-ID: <179226409666.3135.9411446164504910300@kernel.org>
In-Reply-To: <20261013182926.30417-10-mmc@linux.ibm.com>
References: <20261013182926.30417-10-mmc@linux.ibm.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (3) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net: ibmveth: rx_csum_helper includes Ethernet padding in TCP
  pseudo-header
- [Low] The kernel-doc for ibmveth_rx_mss_helper_test()
  (drivers/net/ethernet/ibm/ibmveth.c:2597) says that 'Frames whose…
- [Low] The new comment at the bad_hdr label in ibmveth_rx_csum_helper()
  (drivers/net/ethernet/ibm/ibmveth.c:1548-1550) says '/* headers do not…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the new code
  makes it visible.
- [Medium] This problem wasn't introduced by this patch, but the patch
  touches it.
- [Medium] This problem wasn't introduced by this patch.

--

ibmveth: check headers in the RX large send and checksum helpers

This patch adds header length, IPv4 ihl, TCP doff, IP length and fragment
checks to ibmveth_rx_mss_helper() and ibmveth_rx_csum_helper(). Frames
that fail a check are passed up without GSO fields or
CHECKSUM_UNNECESSARY. It also clamps gso_size, computes gso_segs from the
IP length, and adds KUnit cases for both helpers.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 85e176d0ed321..e9874dfedf378 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

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
> +	return true;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but the frame is still marked
GSO whenever gso_size is nonzero, even if the TCP payload is no larger
than gso_size. Should there also be a check that the payload is larger
than gso_size?

The new comment points to __virtio_net_hdr_to_skb() as the model for the
clamp. That function only sets GSO after this check:

include/linux/virtio_net.h:__virtio_net_hdr_to_skb() {
    ...
		/* Too small packets are not really GSO ones. */
		if (skb->len - nh_off > gso_size) {
			shinfo->gso_size = gso_size;
			shinfo->gso_type = gso_type;
    ...
}

Without that check, ibmveth can build a GSO skb that is not
SKB_GSO_DODGY, with gso_segs == 1 and a payload no larger than gso_size.
If a forwarded or bridged frame then needs software segmentation,
tcp_gso_segment() rejects it:

net/ipv4/tcp_offload.c:tcp_gso_segment() {
    ...
	mss = skb_shinfo(skb)->gso_size;
	if (unlikely(skb->len <= mss))
		goto out;
    ...
}

validate_xmit_skb() then drops the packet.

Three cases can reach this:

- a large send whose MSS is at least the payload
- the path where length > mtu + ETH_HLEN and gso_size is read from a
  real TCP checksum
- new with this patch, an MSS of 1 to 7 raised to TCP_MIN_GSO_SIZE when
  the payload is 8 bytes or less

The new KUnit case ibmveth_rx_mss_helper(skb, GSO_BY_FRAGS, 1) also
expects a 2896 byte payload with gso_size 65534 to be accepted as a large
send.

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
This is a pre-existing issue, but the pseudo-header seed below still
uses skb->len, and skb->len includes any Ethernet padding.
ibmveth_poll() does not trim the frame to the IP length before it
calls ibmveth_rx_csum_helper().

Take a padded IPv4 ACK with tot_len 40. It arrives with skb->len 46,
so tcphdrlen becomes 26 instead of 20 when the seed is built with
csum_tcpudp_magic(). The same happens on the IPv6 side with
csum_ipv6_magic().

The helper then marks the frame CHECKSUM_PARTIAL through
skb_partial_csum_set(). Suppose the frame is bridged, or routed out of
a device with checksum offload. The egress NIC adds the payload sum to
this seed. The final receiver trims the padding and verifies against
the real TCP length, so the checksum does not match and the segment is
dropped.

Pure ACKs are the frames most likely to be padded, so a forwarded TCP
connection could stall.

On the routed path, ip_rcv_core() does trim the padding. But
pskb_trim_rcsum_slow() only checks where the checksum field sits for
CHECKSUM_PARTIAL, and it does not correct the seed. Local delivery is
not affected.

The IP length check added to ibmveth_rx_mss_helper() does not help
here. A frame under the MTU that is not a large send never reaches that
helper.

Should tcphdrlen come from tot_len - iphlen for IPv4 and from
payload_len for IPv6 instead? And should a frame whose IP length
exceeds skb_headlen() go to bad_hdr?

ibmveth_start_xmit() does not pad, so this needs a peer that uses CSO
and pads its frames.

[Severity: Medium]
This is a pre-existing issue, but ibmveth_rx_mss_helper() now refuses
frames with bytes past the IP length. Should the pseudo-header length
here also come from the IP length instead of skb->len?

tcphdrlen ignores the IPv4 tot_len and the IPv6 payload_len. The helper
then marks the frame CHECKSUM_PARTIAL with skb_partial_csum_set().

Take an IPv4 ACK with csum_good set, tcph->check == 0, tot_len 40 and
skb->len 46 because of Ethernet padding. It is under the MTU and is not a
large send. So ibmveth_poll() skips ibmveth_rx_mss_helper() and calls
ibmveth_rx_csum_helper() directly, and the seed uses a TCP length of 26
instead of 20.

If the frame is bridged, the egress device includes the padding in the
checksum.

If it is routed, ip_rcv_core() trims the padding through
pskb_trim_rcsum_slow(). For CHECKSUM_PARTIAL, that function only checks
where the checksum field sits. It does not correct the seed.

Wouldn't the frame go out with a bad TCP checksum in both cases? Local
delivery is not affected.

Linux ibmveth_start_xmit() does not pad, so this needs a peer that uses
CSO and pads its frames.

> @@ -1510,6 +1542,13 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>  			skb_reset_network_header(skb);
>  		}
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but the return value of
skb_partial_csum_set() just above is ignored. By that point,
tcph->check already holds the pseudo-header seed:

			/* Setup SKB fields for checksum offload */
			skb_partial_csum_set(skb, iphlen,
					     offsetof(struct tcphdr, check));
			skb_reset_network_header(skb);

skb_partial_csum_set() returns false without touching ip_summed when
skb_headroom(skb) + start >= U16_MAX. Its kernel-doc says the packet
should be dropped in that case.

Here the frame would keep the CHECKSUM_UNNECESSARY that ibmveth_poll()
set, with only the seed in its TCP checksum field. Could a forwarded
frame go out with that seed as its checksum?

This needs about 65.5 KB of headroom, for example a 128 KiB pool buffer
with the frame at an offset of about 65 KB. The offset comes from the
hypervisor. The new header checks do not compare the headroom with
iphlen.

> +	return;
> +
> +bad_hdr:
> +	/* headers do not fit the frame, or a fragment has no whole TCP
> +	 * segment; let the stack check it
> +	 */
> +	skb->ip_summed = CHECKSUM_NONE;
>  }

[Severity: Low]
This comment says "let the stack check it", but the v5 changelog says:

  message and comment no longer say a refused frame is checked by the
  stack; bridged or switched frames are not

Should this comment be updated to match? Setting CHECKSUM_NONE only leads
to verification on local delivery. Bridged, OVS-switched and forwarded
frames are not checked.

The comment also gives only two reasons for reaching bad_hdr. It leaves
out the iph->ihl < 5 check, which also jumps here.

[ ... ]

> @@ -2508,10 +2549,237 @@ static void ibmveth_rxq_harvest_buffer_test(struct kunit *test)

[ ... ]

> +/**
> + * ibmveth_rx_mss_helper_test - unit test for ibmveth_rx_mss_helper
> + * @test: pointer to kunit structure
> + *
> + * Large send frames get gso_size from the descriptor or the TCP checksum
> + * field, clamped, and gso_segs from the IP length. Frames whose headers
> + * do not fit, whose IP length is not the frame length, with no TCP
> + * payload within the IP length, or that are IPv4 fragments, are refused
> + * and left without GSO.
> + *
> + * Return: void
> + */
> +static void ibmveth_rx_mss_helper_test(struct kunit *test)

[Severity: Low]
This isn't a bug, but the kernel-doc says frames whose headers do not fit
are refused. No case in ibmveth_rx_mss_helper_test() builds a frame
shorter than the IPv4 header, the IPv6 header, or offset +
sizeof(struct tcphdr).

Every fixture comes from ibmveth_test_tcp_skb() with complete headers.
The skb_trim() cases are only in ibmveth_rx_csum_helper_test().

The ihl 0 case is refused by iph->ihl < 5. The tot_len + 1, padding and
zero payload cases are refused by the ip_len checks.

So the skb_headlen() parts of these checks in ibmveth_rx_mss_helper()
could be removed without any case failing:

		if (skb_headlen(skb) < sizeof(*iph) || iph->ihl < 5)
		if (skb_headlen(skb) < sizeof(*iph6))
	if (skb_headlen(skb) < offset + sizeof(*tcph) || tcph->doff < 5 ||

The commit message's list of tested checks correctly leaves these out.
Should truncated-frame cases be added, or the kernel-doc narrowed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013182926.30417-1-mmc%40linux.ibm.com


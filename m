Return-Path: <linuxppc-dev+bounces-24148-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A3FC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 20:04:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzYLL5kNFz2xwN;
	Tue, 14 Jul 2026 06:04:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783973066;
	cv=none; b=gDi3B9gttHoMZnvRQgTJ2DFi6WmVyWIzRK+CpUIVZ6EZshQKFh039xD44MDflSPNOZWA5ogeq48/B5mBfNdKRNiu7ChYtVb4/ezfkgduBV6OxraALgyDTKvqiRMWGiMRWkA7JSYKRzAqPBLw9TM3PpOupRI29s7twAqtaWYSdLLyiabeggntt8jqrCQWCEscw9s0+HfwruwuAS5G1dX51qkTMVEyCW5dQvmUf6I1D9HtBfc8zhlU0DhCXi8b3emOQckynnLvtlm+3idGgcOQVoKBtlDBetV8YoZEhWQUNxkRVpk1UgCpXav/uzpo9Q3KfoKmWGI0MrLGxNTlbhMo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783973066; c=relaxed/relaxed;
	bh=JTj575AcHAom2fz7OwDDRttEo4AE92OOBeJUOqyrws8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWHSHYDj3UJ7kqy/TJEzbYcyI0LM7IK1+D+alQODVrMWRUGcZXccbRqYNN0DzeorUQKr2SoGBmJ5DxlEi6UMbhlYGIluvVuUJAFYt5nYSCFqadXQZvnvrbejEkW/sVn2ThBjvSm9q1jcW9Z8Q+7bxk3qIEG79BkbajDl9s6r08W2dpA+TSbYKYj4b7YvwtlC7HEg9AwQ+/2W9qmP86HkSXSfy5cvXA/pniyHZo+HSAUQhIBFgU+ObBqzA7GDU001qoJqJOTeVmlNRv+Tt+TKk6lsXU7uU5fVfo3Kzt1CkXrgVdyOa+AxxKCdRB7g+z/xFYCdaijjJ+BLgeVBRniMxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GmN0D3CX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=olteanv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GmN0D3CX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=olteanv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzYLK1J0Fz2xMW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 06:04:24 +1000 (AEST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-473987fc217so392600f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783973061; x=1784577861; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JTj575AcHAom2fz7OwDDRttEo4AE92OOBeJUOqyrws8=;
        b=GmN0D3CX0tkvQGy0mLkhp0GbsTd9z51sPr+xTS6e3iqfPVrHX6vjr0gEMr5w4UCLHl
         pID9AlCiIZYxdXjklShot1LbR9AH0QvsuqryvXkZPffLaEncxP+8b7BbIXaG3Ox3ER/E
         pPF5wmt4mBvWh+O0txxShwybjFahvuVg6u4UklM3HZP5uyw9k7cBRg+olexxRRrKURVi
         Xj9Rpeq1Ah/iXzZQquRJ8UUzMCxVmytvhJO/bZGIaXJ2/eaS03NUo555K6i0v5S07dqr
         p3GWDZ6MLVY8GguWLi877ccceDK/Sk5Ko9ip8QMu5jxy8/newk0WK9v0BVX/wNwF/Ku3
         sg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783973061; x=1784577861;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JTj575AcHAom2fz7OwDDRttEo4AE92OOBeJUOqyrws8=;
        b=i51uKrJ7uQU8wNwLt7BosdE1KbPSk5Im0OHdNj689mVLKZGDZWlk5RREtaxoDMsKTO
         GgFqMPLd90GeW9GHyjicQn7XGs3b8AwXnefqX8VH31Sngso65PsR55R1mlPKJlH24+mF
         RfgQ5fY1uRgTa7ACO3B5u2Po7k7Q9h9eU8qIgJZYW+7LQh6Pz2RTLWOQu0tAIRr8F8yd
         ugpnpHxrx5rv6hYG/81Mm+Eg46LV0mw8+K+4tFM6/N7n0nuA3QvqXwJkCSUKaGYqHuyb
         Z3d3wx+gAfA1qs4NyIlvhipb/7Xkc5rLRqTwTG7RuNB1WW/fvpn8p4TJk2XyG91IXmwv
         OIwQ==
X-Forwarded-Encrypted: i=1; AHgh+RpC/Yw3qEfoF30+zOq9wGKCsKcE658IcFumvlIAtXUTEW0HPsjLH6QLzKvNbscD0HzgdyjkvSAIpE5KwOs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywg26dVAe6JU9Oap/jdGiZU3fuRafIuSBdYyrAFupYpgM1XLUVT
	wA3KiHpxderfQYVpcD/mFY9dEQk4VEo/mEynhdfUi4MaT8DIRtmZMqIf
X-Gm-Gg: AfdE7ck4aKKQZNkXBhV6lTccfSNoOf58FxARnQyYewN+Ct38rqShe0PTF8WDWb3+C3g
	xnGHihRv6zvE2pxSE7Kg6tFkWTtZY4dpbqNWwJMV6E291zB+mdT3ts6pup6zuU1RQdcC/tEEmoW
	STw1JJ6Gkw7I+MbChpRXewqo/NfJRQMfL2/PnjWep/M+pDwS3fPPG9TeMhTWOLGd6CxE64qMgYU
	wuBsKDlmyJcocWoU1MHx3gvdnnOu7w8ImdbRKGz61bkGGzVnC66LZlPBVEMmjQlD0uKQOjYqTwu
	/xRQIxNyGs/MVZY5QhvEfAF9yncB3yL1d4njmqfkkH9aCZQ7/hcXXUFaqD9ZWG6TyY2pefmaeKy
	VtXGZl7OdmgnLKI93vEpLn8s1DQo2N9wgbDvJNmMEWppQLUEqWgNgPJyZGbjJsTKplxcV9o3YeG
	To5eGR
X-Received: by 2002:a05:600c:4f94:b0:492:1e4d:d44b with SMTP id 5b1f17b1804b1-493f8835228mr59867925e9.8.1783973061275;
        Mon, 13 Jul 2026 13:04:21 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d40e:d500:d8f0:7a38:1703:914b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a322c86sm17366115e9.11.2026.07.13.13.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 13:04:20 -0700 (PDT)
Date: Mon, 13 Jul 2026 23:04:17 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Nick Child <nnac123@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Sabrina Dubroca <sd@queasysnail.net>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com, Michael Ellerman <mpe@ellerman.id.au>,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: dsa: tag_ocelot_8021q: don't read an unset
 MAC header on transmit
Message-ID: <20260713200417.dghlrj4ca27b6nd4@skbuf>
References: <20260713194010.54642-1-doruk@0sec.ai>
 <20260713194010.54642-2-doruk@0sec.ai>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713194010.54642-2-doruk@0sec.ai>

On Mon, Jul 13, 2026 at 09:40:08PM +0200, Doruk Tan Ozturk wrote:
> ocelot_xmit() reads the Ethernet header via eth_hdr(skb) to test the
> destination address against the link-local range.
> 
> On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
> reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
> resolves to skb->head + (u16)~0 and the read is out of bounds.
> 
> On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
> done for the same class by
> commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
> and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").
> 
> Fixes: 43ba33b4f143 ("net: dsa: tag_ocelot_8021q: fix inability to inject STP BPDUs into BLOCKING ports")
> Cc: stable@vger.kernel.org
> Found by 0sec automated security-research tooling (https://0sec.ai).
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

I was not aware of the bug introduced by commit d346a3fae3ff ("packet:
introduce PACKET_QDISC_BYPASS socket option"). Commits
eabb1494c9f2 ("net: dsa: tag_ocelot: do not rely on skb_mac_header() for VLAN xmit")
499b2491d550 ("net: dsa: tag_ksz: do not rely on skb_mac_header() in TX paths")
f9346f00b5af ("net: dsa: tag_sja1105: don't rely on skb_mac_header() in TX paths")
0bcf2e4aca6c ("net: dsa: tag_ocelot: call only the relevant portion of __skb_vlan_pop() on TX")

were made assuming that the bug to avoid would be exclusively a future
one (the revert of commit 6d1ccff62780 ("net: reset mac header in
dev_start_xmit()")) and thus they were not marked as bug fixes.

Are they true bug fixes, as in "can we reproduce these [using
CONFIG_NET_DSA_LOOP=y on virtually any network adapter]"? If so, should
all the commits above also be backported to stable?


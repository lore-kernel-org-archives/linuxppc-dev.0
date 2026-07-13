Return-Path: <linuxppc-dev+bounces-24149-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5A1C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 21:37:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzbPT211pz2y8p;
	Tue, 14 Jul 2026 07:37:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783978637;
	cv=none; b=RCD/ji2aA7r+rKKMZd5WopIygaMXY9LDawUuBEqD/XoHH2MWNIZbrIe9qcBu1ozeODol6aX3/aeSCiXLmVJy9xkzFfcGgxgluBUMWf/XtdzdGOdXwZdvVArR5qODnJIHljzglirNJadKwV/fIlH19QHs3TpWMCKw6mHTJUuOVyswjE8ac4W+V4xzMJmKjKc4lRjxxYhwHax1MMVh4AnztidNlfthZJVjCOdITj4tK/KsWmbCHQL2MUa1nZYUfHo0NEmQ02FnttzBjj3Nrad0zk5g7sIxNj6V/pzmCZtKWR/bTkYi252A8Fw8Vj+lcf/5RTQINXGBEuKXJ1id1KJ1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783978637; c=relaxed/relaxed;
	bh=KFg02OlTkf2Yn/CkP+xFl6ERBV7PQVQSfXTqSOnpsLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofOdI8FuuWtZux34tL8bHgfP684rJ6dYE02/QEJaXevA8kMw4e8DHtbst3MaHfaudQDzcn/bZueXuJr3MrCYLTY8v6CjdWbX3TbzzaKq/ycd/Zb2Dvopy8f21Q65asgVBs7VDhjGOdiG70nNrVveywRLEM3qyGHipg3Ig8fcSQhEj6j99Ha7f9PCcTm9G3ZiNAsTT6+Ou636aIas0yfOrYove/yDzb/MKs94c7dQpIzSaSJZOBmFAS7RZfVP3NjltIg96qefzDYbJFCqzFSgj1Lj+aBPeKFVLw6eLbwFq0mw8sGenksBeqf5NP8coV8oCWlpFmGZhWQ7xvBGUwukaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gUItXDqI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=olteanv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gUItXDqI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=olteanv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzbPR59Yjz2y1F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 07:37:14 +1000 (AEST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-47debaa89cfso261767f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 14:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783978627; x=1784583427; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KFg02OlTkf2Yn/CkP+xFl6ERBV7PQVQSfXTqSOnpsLE=;
        b=gUItXDqITHzPv3wxsOtpsOYCTMmn/75OhlbJlYUI4zW/6gMrG8F7WJic9NhQra9az5
         OpZ38fdloMMxWvSjNSuBR0QERERhWzmxn3CBKU+SyJM4+V4cQOb3KbRGUeGfca0zgwWp
         WJ1g9i7QusLbVxg8hpfBsu8Htc/cvoD5sHk1dFshzkJs+dZ/SbCIf6ZvLiX+3weoAv0Z
         Tkg8pM9cFzd98CNol5a9QCpxkyiG1CCEvW2JgA0bV0Q8QCGTy+c/5iNGSxobpufwvfBc
         WpUbs1YsHTkiyxgiVkSmv8zSqZeox22Kc3TuEB8f+GKJQ6kJ8/0VLE7SJpFtvtWankSn
         e7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783978627; x=1784583427;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KFg02OlTkf2Yn/CkP+xFl6ERBV7PQVQSfXTqSOnpsLE=;
        b=qpquVB0LZmpJsX9szM905OvbS4rkiwimMIl8jO8nI72M1gOL/5obiz7tfsgMjS1nEm
         zNVxy02Dxh0pKftA8iZilVt958gDBn8KJVEKSpmMDvsWdU7+JL1tHo6AmIPAP/8UFnc4
         G0AfHVswrJ7LgP6L+ZVYNF9iLMz5aBauciPSt+ROsPj1oHyO3KN2BtjrX1PWGYgxslqL
         vDoP4I7bgJ/oNMf1Lbv0F9mChv8ydjMu5vXG9OjHz0NtOziM0os7pQBRyRlHOWZHPMar
         uhm/AQnVBUQclbM47V8Vp7Uk9UD7wszz2B7dSElHOp01ppBHBRownkA42Flf5rHP3Z9L
         gszg==
X-Forwarded-Encrypted: i=1; AHgh+RrA0+a79K8dz9uZ6k5nJoSxX6eGkrth7g23rhtl4d58Ai5Iovori6fxX5pOWNukLxPNFR/dAye2ignz3Wk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyLRzuzWI/o1CWEejUecf0rDt0DzL35rNA3MXGLN6yT4tLJLsXG
	zghpyuyr2ICd65tvYCshUl5iRmBhaDOzOzaa1F+49qvVZ1K7AvYQHVKT
X-Gm-Gg: AfdE7cnb4vv+EA7ofejpLHEfg4BZSiTgDU4l+vexuSDyHwV3w3Amscuj8WM3k/oFSlT
	2/4W6MbHmczD/fIkQ3CIIp1+zPOoZGnv80eLTsRpPqDUMBZe2cWJU/ABB1m6t+6GjxhNGzeB6Bs
	XP76mA76TGZawdA4gsZ9vADHyw2QfeZNSFpp3uN4On8+hIMWDpYww5Q4BGBnZCR5CcmNcdTuoGJ
	c67ahaBkzqgtP4Vu7tq4g9dVyhgVPdVwU5jCQ6cEfmOKN7cIE7B2c2DpvB13iKPKn/laM1MUAlV
	Mcd308sPFuaU+IfT+n5IzS/PVb9/V/XiJzIO2NncPUz5SDovU6+nhQcVqKgwKj3AWPnm9CQtHPE
	fW1wA3kFGLc2e8qqMtnLqPw774UoAnm4nx3TK9ejLKw6vpZXiBnBGcYPbJ3xSo3Ydy6adCwlW8a
	4yb++Z
X-Received: by 2002:a05:6000:1843:b0:47d:ed40:a913 with SMTP id ffacd0b85a97d-47f2dd21ae8mr7457545f8f.7.1783978626485;
        Mon, 13 Jul 2026 14:37:06 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d40e:d500:d8f0:7a38:1703:914b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c25b2sm2173077f8f.30.2026.07.13.14.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:37:05 -0700 (PDT)
Date: Tue, 14 Jul 2026 00:37:02 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Doruk (0sec)" <doruk@0sec.ai>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Nick Child <nnac123@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Sabrina Dubroca <sd@queasysnail.net>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com, Michael Ellerman <mpe@ellerman.id.au>,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: dsa: tag_ocelot_8021q: don't read an unset
 MAC header on transmit
Message-ID: <20260713213702.3kjamxnto2bciqak@skbuf>
References: <20260713194010.54642-1-doruk@0sec.ai>
 <20260713194010.54642-2-doruk@0sec.ai>
 <20260713200417.dghlrj4ca27b6nd4@skbuf>
 <CAPdMp1qf4q42MAaRqqzYnhYyU9KvdryGQR+TWsFNvJ1oCTnPKw@mail.gmail.com>
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
In-Reply-To: <CAPdMp1qf4q42MAaRqqzYnhYyU9KvdryGQR+TWsFNvJ1oCTnPKw@mail.gmail.com>

On Mon, Jul 13, 2026 at 04:12:20PM -0500, Doruk (0sec) wrote:
> Hi Vladimir,
> 
> Thanks for the review.
> 
> I checked the DSA cases with CONFIG_NET_DSA_LOOP=y. Since dsa_loop
> normally uses DSA_TAG_PROTO_NONE, I used a local repro-only override
> of dsa_loop_get_protocol() to select the relevant tagger, then sent an
> AF_PACKET/SOCK_RAW frame with PACKET_QDISC_BYPASS and
> sll_protocol=ETH_P_IP through lan1.
> 
> That leaves skb->mac_header unset (65535) on the direct-xmit path.
> 
> For tag_ocelot_8021q, the eth_hdr(skb) version reproduces as:
> 
>   BUG: KASAN: slab-out-of-bounds in ocelot_xmit()
> 
> Switching that site to skb_eth_hdr(skb) makes the same reproducer run clean.
> 
> I also checked the LAN937X path the same way by forcing
> DSA_TAG_PROTO_LAN937X. The eth_hdr(skb) version reproduces as:
> 
>   BUG: KASAN: slab-out-of-bounds in lan937x_xmit()
> 
> and the skb_eth_hdr(skb) version runs clean with the same packet sender.
> 
> So yes, for these DSA TX paths this is a real bug on the
> PACKET_QDISC_BYPASS path, not just a future-proofing cleanup. I have
> not yet checked ibmveth with a pseries/ibmveth setup.

Thanks for clarifying your testing procedure (and please do not top-post
replies).

Yes, manually editing dsa_loop_get_protocol() is the current state of
the art technology.

> For the older DSA commits you listed, I think they should be treated
> as stable candidates if they remove eth_hdr()/skb_mac_header() use
> from the same TX path. I can go through those individually and send a
> follow-up with the exact stable list if that would be useful.

Since skb_mac_header() in TX paths is the real problem, I now think
those commits should need backporting too. I only reworked the
first-order callers of skb_mac_header(), not realizing that eth_hdr()
needs rework too - and not having a clear testing procedure at the time.

I think it would be great if you could prepare an email to the stable
mailing list and to the maintainers.


Return-Path: <linuxppc-dev+bounces-24155-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAF3C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 22:38:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzcmZ52XCz2xWY;
	Tue, 14 Jul 2026 08:38:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::631" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783977150;
	cv=pass; b=BC1G+JQ5tOFfCz1EsUG9Qd6T5Qb5U0b0wl0NXXVdO+4yCmJB+WAjR3xLcLGOdBGRDKI9o3OcDGw0ZvvJRjU/odsfAjQqDiAtMCStfWAUPFo2aXtZbbozKMtfDMJYZDg+jbQ1GBfs1nmEj4I8gMx5CzbuYGAMsp7ws+r+j8bsTG3dYE95qxXEQ/JgB3uJVsGQwaWZFjWLgTghYT2jiCWrvC+QIO9xLMfmBy312OQan/yEt0Pj/26bIjiHGuhGXkILDQbsxps+Ed6WXepD4uSuuPrezii8eh53xvGVtl8Qv8x0eIvBjhmBlyiR9ZN5FZOUPZ2U7ZqY2Cb1kMqI5Drqig==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783977150; c=relaxed/relaxed;
	bh=qUBCghi6kjnH1ka8HUmHkrbbiY09NwwjNH5EUa3nwfI=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJS3nXZAYDof6CcVKluQCdvVUz8c3nYz/+iPjQeMPpoxcYP331qqMGlGrr/kWN84p6M62riIFxPt3S8m5YvPWlJ3hKtQLUIRJRMeLI6bvA29/wUVe6u0zerWsLMjNunLgcxbhdFW9wJrwWtqZdNDalJ6SmdlGGmoM+5PoiQXs/MscyZo+DSAehHc25mtcBM6sdiz63FG1OQna1coXLr8ot9q8K4WVFYNZ46pJ9KGRrCkTztaCl2p26bptylREhISeC2G7rAA1Lw9Rsm91X+JJJa799c88x/h2m6A0gY9uZ0C+jUcoV3I5zo0rWauktKZJCC5g+TCAIWTPCoU0Zov2w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0sec.ai; dkim=temperror header.d=0sec.ai header.i=@0sec.ai header.a=rsa-sha256 header.s=google header.b=NyxggIW2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=doruk@0sec.ai; receiver=lists.ozlabs.org) smtp.mailfrom=0sec.ai
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: lists.ozlabs.org;
	dkim=temperror header.d=0sec.ai header.i=@0sec.ai header.a=rsa-sha256 header.s=google header.b=NyxggIW2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=0sec.ai (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=doruk@0sec.ai; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzZrr6t4qz2xMW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 07:12:27 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2cc73e322dbso41180295ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 14:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783977140; cv=none;
        d=google.com; s=arc-20260327;
        b=TrM+8+CgsX8D+XMkfQYwDKdYNbObNPnvzxwm1Lkt0VR/eSU995TsdK9FMeWu3QTbGy
         HBmgYiIG4LpI9Bpv+KeaYxtDu1xUBPnZz+4X3p7//SW/6K5/w3Qy4lJh9xW7tUAMN0M9
         +a6Q8Kk4YGMogkANxl9eo2rdms16VwYbeOe+8CtWfZ9yvZtrqUHG1ceEGNUZGXi5N+d4
         UE7+PXc69dkfMvQrZAzPLqMob8iCq0Yv3Gz+y+a1X6YHEeTP7kIeCAPdRIczqnMTVQoS
         Gv03+4A0mmJ2gJj4rxR+Trn/VuO9f4bDAxKY1uBsi6LFV4Bdiex3LoWC3C7WOPp4qmVy
         reSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=qUBCghi6kjnH1ka8HUmHkrbbiY09NwwjNH5EUa3nwfI=;
        fh=QRXjT6bfgIih+wwmvyvhUtdvJZnpZkO1ahauAHUHAzk=;
        b=dVv5GjvPrippM3oGyEDOeVuU63dNQNfbeQ+m4y/lly+rUWoz7iYSZFIfWrtfa4692/
         ooGhcZTcCg2yVvoDToQZimGGc1fcfzMUrzboNMTJLgaITrb0406KMM5S2ixKy80p465a
         DGrV6P84rgIwxfYvfojDzcw76cm9FV0sB5V9h79cHSbfxCmOjywZ5HjAVhwosBcfGIok
         w4cSMtBGyzrE3SNlXglfZCk1trJPE2QhVpCIl7zrdEAyKPctIzyh+U2SmQf8CkIKowDx
         ddGggulRkYng17aYIbu6w5cvRC215qQhqjCkub+rdHNuf4xI2jZ0naud6mU6Y/wkRMAX
         caKQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783977140; x=1784581940; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qUBCghi6kjnH1ka8HUmHkrbbiY09NwwjNH5EUa3nwfI=;
        b=NyxggIW2a+GhDW9I6jWGvKTfbhHDixcTdJYqA0TN/hvFP8HfP/wEYh6cTf30q7IWFa
         gPm1FbLZgKFPt+4TZ7gkE8zO42h2q1jNJk3Gmb3mvKjO/tbnslr0PR9b3GMECZ6pgXIl
         IlZM+e7uYUjsTkCgWU6VgvfeFwFHh/if9Mt5GVTL4XEuxroRHL/C0m2nAPkQCC6OhHtP
         ssmPEPVb+cs6fLIen4LczP8hJzORu1V2FqFYDWs7XX/gUTkTkR8V9YAei1CLnuryYWw1
         n5MnloCzBaVab00qcqBPaxwmedReUI/fewl1rVqHOJ8yRG3yPyelxm8vTs0ZyU13Hved
         8Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783977140; x=1784581940;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qUBCghi6kjnH1ka8HUmHkrbbiY09NwwjNH5EUa3nwfI=;
        b=SmulthoN4OufP7NEu9OkQqLAqCcOmgP+aTQ6V9F0Nh8GkM+gb00Zok0BT2XOmV/vWH
         vhdnn3XxxWHE4qkHikwKYqQi1pcx+kwC/+HFD8kyBJ86ng7j/tu0HLt8PJwq3JC9ZaDz
         NTQkGYF4lqXvhbmA94GkQL/9GdrXPm2WnKY7KDU7MfAcYbxu7n+VEtLNIHL2smSGbgG5
         dG7cXoApRV8eV7YQeKKJwpkAL1ut4EFhLEs1U+9M8XRtzFvJgG9gbclpZqjHyyIGQ7fx
         kQq1AmacwCq5YEj+bd1vDm0uPdajTNfzq3z7k6eKTgOPE/Pe8MOrHkl/XVzE0Agg1/8m
         sXAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNHVMlOrCovpgiNLk7qnSsZ7qcWOuNTYECwueLi9v8l/eoZTeiq264dszZUZGxrKIruhAFT9ul3QF2OQg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzxc+Z1j4p/GE7VEP64nby+4B8gexgicdrduv4OKsdey6XdvPRK
	ecjXMvyxtFJA9B66J/KzD/i3Tyn7NQDrBOfMpYGX5rv8ilwrJDNoUdid98CntiCQHig2CH1RYYd
	mgNaUlHzAkySgtERgveUQ0b8/NPaJKpXrRwIbFPdANf0=
X-Gm-Gg: AfdE7clVKqu5k9fVHEXbWD6KVj9ERUtFy3uqnmvUspCQuSlKZKsCtbo9zLQeN0fIPrJ
	NAO0BY0rHYgZ6vBOMbH137G1t2oIfcV99tApEc4NgVCvWBWl/ENaA++snQzo6UKcoHy2KCu4Zbn
	psSf5umvA6UtfmGhSmoWNA9mad0fdWvYwzd+HIDjAOPjiur2WXLljJlH7iT4H/QaWaN6Zf4usoN
	IoHZLnafaMkaq/XiMCMd7rDB5Mjs0bSMv70WyYxCY3hhXtkEMYHadkVciD5aYmuNlA36tt+axwo
	DW2YXQej3qLJWP4XaKH8xw/HD12aQDRs63RGJh6y/jVFu7kQOYsSdq795A==
X-Received: by 2002:a17:903:2301:b0:2ca:ed41:d331 with SMTP id
 d9443c01a7336-2ce9f27eb79mr100834245ad.45.1783977140474; Mon, 13 Jul 2026
 14:12:20 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jul 2026 16:12:20 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jul 2026 16:12:20 -0500
In-Reply-To: <20260713200417.dghlrj4ca27b6nd4@skbuf>
References: <20260713194010.54642-1-doruk@0sec.ai> <20260713194010.54642-2-doruk@0sec.ai>
 <20260713200417.dghlrj4ca27b6nd4@skbuf>
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
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Mon, 13 Jul 2026 16:12:20 -0500
X-Gm-Features: AVVi8Ccf64lA0azySl9H8ulwhmt3h2F_jWjPpkuQXsHGkD6_OCbSPA-I2DgzOTY
Message-ID: <CAPdMp1qf4q42MAaRqqzYnhYyU9KvdryGQR+TWsFNvJ1oCTnPKw@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net: dsa: tag_ocelot_8021q: don't read an unset
 MAC header on transmit
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Woojung Huh <woojung.huh@microchip.com>, Nick Child <nnac123@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Sabrina Dubroca <sd@queasysnail.net>, Arun Ramadoss <arun.ramadoss@microchip.com>, 
	UNGLinuxDriver@microchip.com, Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

Thanks for the review.

I checked the DSA cases with CONFIG_NET_DSA_LOOP=y. Since dsa_loop
normally uses DSA_TAG_PROTO_NONE, I used a local repro-only override
of dsa_loop_get_protocol() to select the relevant tagger, then sent an
AF_PACKET/SOCK_RAW frame with PACKET_QDISC_BYPASS and
sll_protocol=ETH_P_IP through lan1.

That leaves skb->mac_header unset (65535) on the direct-xmit path.

For tag_ocelot_8021q, the eth_hdr(skb) version reproduces as:

  BUG: KASAN: slab-out-of-bounds in ocelot_xmit()

Switching that site to skb_eth_hdr(skb) makes the same reproducer run clean.

I also checked the LAN937X path the same way by forcing
DSA_TAG_PROTO_LAN937X. The eth_hdr(skb) version reproduces as:

  BUG: KASAN: slab-out-of-bounds in lan937x_xmit()

and the skb_eth_hdr(skb) version runs clean with the same packet sender.

So yes, for these DSA TX paths this is a real bug on the
PACKET_QDISC_BYPASS path, not just a future-proofing cleanup. I have
not yet checked ibmveth with a pseries/ibmveth setup.

For the older DSA commits you listed, I think they should be treated
as stable candidates if they remove eth_hdr()/skb_mac_header() use
from the same TX path. I can go through those individually and send a
follow-up with the exact stable list if that would be useful.

Thanks,
Doruk

On Mon, 13 Jul 2026 23:04:17 +0300, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Mon, Jul 13, 2026 at 09:40:08PM +0200, Doruk Tan Ozturk wrote:
> > ocelot_xmit() reads the Ethernet header via eth_hdr(skb) to test the
> > destination address against the link-local range.
> >
> > On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
> > reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
> > resolves to skb->head + (u16)~0 and the read is out of bounds.
> >
> > On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
> > done for the same class by
> > commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
> > and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").
> >
> > Fixes: 43ba33b4f143 ("net: dsa: tag_ocelot_8021q: fix inability to inject STP BPDUs into BLOCKING ports")
> > Cc: stable@vger.kernel.org
> > Found by 0sec automated security-research tooling (https://0sec.ai).
> > Assisted-by: 0sec:claude-opus-4-8
> > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> > ---
>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
>
> I was not aware of the bug introduced by commit d346a3fae3ff ("packet:
> introduce PACKET_QDISC_BYPASS socket option"). Commits
> eabb1494c9f2 ("net: dsa: tag_ocelot: do not rely on skb_mac_header() for VLAN xmit")
> 499b2491d550 ("net: dsa: tag_ksz: do not rely on skb_mac_header() in TX paths")
> f9346f00b5af ("net: dsa: tag_sja1105: don't rely on skb_mac_header() in TX paths")
> 0bcf2e4aca6c ("net: dsa: tag_ocelot: call only the relevant portion of __skb_vlan_pop() on TX")
>
> were made assuming that the bug to avoid would be exclusively a future
> one (the revert of commit 6d1ccff62780 ("net: reset mac header in
> dev_start_xmit()")) and thus they were not marked as bug fixes.
>
> Are they true bug fixes, as in "can we reproduce these [using
> CONFIG_NET_DSA_LOOP=y on virtually any network adapter]"? If so, should
> all the commits above also be backported to stable?


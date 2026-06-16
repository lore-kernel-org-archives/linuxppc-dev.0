Return-Path: <linuxppc-dev+bounces-22677-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F978CD98DE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 02:02:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfVc43bh5z2ytj;
	Tue, 16 Jun 2026 12:02:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781575332;
	cv=none; b=He1VY2gg7zIk9ycq917RHxYCErSrZ9/UB0PISZ7F3X6L/QY+bELTQbnMI8dS1v2tonHffvG8JL+hMyNciKxMwzBvD1C7ds/uOZABoW6zlI6CWPioCehlbgKoIzIpJBdFZ3lgoa+soXKT0ouajHR/sdLWRRPrvxfkdG3CFJ+203FLIJfRM/r7YEbNDlamTcJtu7xzGKQvC7xpKxAD2PWqypmx4bSINP9jBifQIfuDZxrmImmQdssFMk2USCTf+E0k62qZGt/J3XJx6BwjT9INqqs6qDnOK4Jkj8S1BJkZf4mRASqFBWLAbpjcVpcyVvoB9daLjmOzlTH3WNfgj8XCig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781575332; c=relaxed/relaxed;
	bh=Ij2ukDXcMwBNLXQ6jucFsqZ3k4ldmE3wNeTpnN4p5Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7fMOfKyesh7k/G3n645N0Al3Do+leRj9T3uI3KIn4nUI94fuzAOPRe8UuBRsoQJP5y0uqAnObD+QV5ujzc38AoxFabH+l9awxPq4X9Low6O9Q5rTrgjqQ6eZynMdtlxuL3lqJ8GRxTM49rimbNkDv++2rE7lDSW797kCKbJulnzWsyrK1YRigMq29U5tG5CgEDRoyrxpNXk4Iy+r9fcHCPFJh8o/vfvonl0taf2gHgOeCOYr0Bt+BnbdClrdHk1r705aLvqUxiD7uaUz4BvQ3f0FnvWSI9KSfsD5S1qcsIciH/N1/t1723w93Y9YKvIjJWSqfgaOe4IkzpJBqGb4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; dkim=pass (2048-bit key; unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=TRnxjr2g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=stephen@networkplumber.org; receiver=lists.ozlabs.org) smtp.mailfrom=networkplumber.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=TRnxjr2g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=networkplumber.org (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=stephen@networkplumber.org; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfVby4ccpz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 12:02:04 +1000 (AEST)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-306f36df4feso2757014eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781575322; x=1782180122; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij2ukDXcMwBNLXQ6jucFsqZ3k4ldmE3wNeTpnN4p5Zc=;
        b=TRnxjr2gfacuVMUQBIDzxj41ai6w1JbxHc7WW1lmvQ5PRUnIFEF9+XuuQuPvpP0Fbv
         PRqJ0/yRV04V/sMeOxh/3m/IyKoL0e81frHMOTaY0CeaRQLTsyl9L33wFSTrYLSyDXMc
         QgAZFOwfdSVrxPHxet5omIrfrEWSgVscSre4IAbs6CjScUDOD0tKHpkFSItJHbYO+Yjw
         59zLA5iQtcn0GkWMzmhW6muj8+a9AThNqhqaX7vfUtLTUTAdqE4zUAyLd67ZVX6muSxL
         znUqFBn2MO7lHvV+ts0vEaegxKrLMoERx6llgDdOEwgDjyLbf3HKAYJasfSjPcaf8dRV
         EYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781575322; x=1782180122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ij2ukDXcMwBNLXQ6jucFsqZ3k4ldmE3wNeTpnN4p5Zc=;
        b=OSd8P0mE031zFS3cm46zIGWUdPVqbmFFQZp6g/thhEDgIXUflLMjjPF7i4IfZCZf4O
         0pbtPaDNfuLbkDLPChWIAC+/vtLyHdg08Pz5s45FYQOpyq95s9kmgbO1OTNopZZXuBES
         YPoi/Y1GnX1oldCVVC7y4nuvnm4+Eo83JhKcZVsObsgzSMU6CQsi8s12G8n5VAHAmwcK
         LNPmhvQfrZDu/7gwM0uNFkUa+EaAMCAbIIARl+igknKN0tC6R76fBAMj1ZSBWFdPDYj+
         nWCWHFr8KsKI5myf0LLH1oP+gi/Vp0DHcM7uU6NkriIDw9UuM7T06hnXeLRI06QTsXfN
         Xvew==
X-Forwarded-Encrypted: i=1; AFNElJ/i25sB6BjtXF+X/zBYJM1lTY/DfIGMDQYecGFaJO5HFftUHDlG8jqRQ/DtcOnleiShDJjJEowZAYEzryA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwWijlJTAtiTJQD0BKE1Nrmn+ehtSUu/IYbHW9EpWUJBCAzNPux
	U8yZlEx0BbDh884IHJwljYzNoUNE+5JSIo0ibMGQmdBkdyk/p3uBpyEQILzh5BsBCi4=
X-Gm-Gg: Acq92OG7RQTSM/p85KwJEVDgflMmKHJA3LpW1kwNAGyYQgwI1rUQEdF8yTVeUIku4hR
	HzrNADtl2GeTBbC6pSifKthCcBodTNp3MPj5QRL56xch/Qp5zpyS00M2MIbJ/v4zFkS/av7QQ5M
	cfaGdFJF2xy4zFBx9xj34R34SWmDvc5PqaFs6+2SEBkCiXEFophf78ysaSfjUJ5QxA2BwA/sf1X
	3PA58xPfDtnb/V44dGSnbmdvGiY5DXT9CkEJiZfrUXqwtsMKH0/5/jWS4JnJ7+hukwoltkjCZro
	Tq4n54XwsejTA7SOxBHpvIzOTo4Z7O9Zvj6CA7BUoxVNJ+KRV8lMY0bPGS2XTl+Vj71k4xC+JSu
	90hHkyzDK9XCH9JO+HUyEnKZmNGdKyiCqB4YXmGnM1uTBhLm7lJzaSqD0jsnbK+96dfcuH0qUNL
	av1MM18W8elAr4Ryoky9eoSJ1Mye4/XXc9NNxsUFGoi0V9wDAuHmgIn+bDbm+D5aEu
X-Received: by 2002:a05:7300:691d:b0:2c9:ee15:a0ee with SMTP id 5a478bee46e88-30ba33dbf37mr1207167eec.12.1781575321794;
        Mon, 15 Jun 2026 19:02:01 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5cea89sm18324839eec.8.2026.06.15.19.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 19:02:01 -0700 (PDT)
Date: Mon, 15 Jun 2026 19:01:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com,
 mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Message-ID: <20260615190158.55cbf94d@phoenix.local>
In-Reply-To: <20260615222935.947233-1-kuba@kernel.org>
References: <20260615222935.947233-1-kuba@kernel.org>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 15:29:33 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> This tiny series moves appletalk out of tree, to:
> 
>   https://github.com/linux-netdev/mod-orphan
> 
> Core maintainainers are unable to keep up with the rate of security
> bug reports and fixes. Nobody seems to care about appletalk enough
> to review the patches.
> 
> As Eric pointed out Mac OS dropped AppleTalk over a decade ago.


Acked-by: Stephen Hemminger <stephen@networkplumber.org>


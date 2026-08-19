Return-Path: <linuxppc-dev+bounces-25975-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E43C5DF6D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 10:42:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ36c1TnGz2yDD;
	Wed, 19 Aug 2026 20:42:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787136136;
	cv=none; b=bj6mU1JGwWA3gsKRij+u8Tcp6cqxwIszGc/ZfZpVzo1qStvT8yhOntBlk38DmzknxyWP2RfzrEQQ3P5F2dZztRXqUr6YgSPqLCm0YcBxFD0gnlHGS6ZCdrsU0sZ6gc/Iz/1+M8CMzAsq4AJDETYGfsemuARsWPazvoMoFbEU9rOE5GG12FUIb14Tpedyc+dpxsndH2mgY+kAL4EqLyfh7URrIITbsNYP+b/ex6xSSYeUYrXddUkentAoYALtO6JOtIDdujFD0Kw/uwsZVBW7aPiHPr++A+8899hv+SExtKugqbMrZNAu9VkTsD0eanksyHwElWCTVDlpaR/LvE7TGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787136136; c=relaxed/relaxed;
	bh=4i/Wj7VbjVfeq660KhfTJWgWKQG02yPSN0FVJhBIXyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm3YuVzjtpjvfsq5zgKkrG2gC1aBpcklGAObvP63OduKlHJW3mnrS5HE+e8Mlgg5CWtsUUc8J7SxJjQPFR71huMSV3cBvR9tlpVu35qBIRFjC57sCgxLJdUbpXRmxa/9pBUpuwEqiAFlet9K0ErXg6k8v5kTqIx93BEG74TnFFS5onBBzyLnLwsUA12pavMtt3xIX9pS3U2iq4UVdCi29aaDMBJQhdjyD50qAaQtT8B/ECI3LJR40ltEoJRmqFlpVUp5/UPu2+AtQLMarHNy71iwuf5TB/p/RksFTI6OhT7dKdiOzfqheoB+/yRR0it/J4Zat9tVuGte8ee3a3dVxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kBqevUgS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kBqevUgS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ36b0MWPz2xnH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 20:42:14 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so835550a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136132; x=1787740932; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4i/Wj7VbjVfeq660KhfTJWgWKQG02yPSN0FVJhBIXyM=;
        b=kBqevUgSkCEJyIR3WPvkd3RMQgdiDyKHynaQa/vpAtuVwsIjGxQ5EByypyMj2hZzus
         X/t3xai9SiWOW3mGBtgNCrdab86ARmmKrv9+BlbnUMW5lD+56wKtcbrPZ8VXEMlKojKV
         ssh5hSHV8a9eALU0qkl1YZh39NXTHxKLyLiOwIy2QRjONDawqQKpCk4syIPZas3q6vHZ
         sLHljoKND2Ubs2FfqmbRnKGg07RuKf0QURi0dvC9Ms74lmEhn+5fi7O1Mid9UhyihP1s
         MwCBrlc0VtJmu0b+rGbiQcFGBEyg6mJLGY6z4LQ15RgdFGgGlIjox35mtsPEBmolv6o7
         nhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136132; x=1787740932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4i/Wj7VbjVfeq660KhfTJWgWKQG02yPSN0FVJhBIXyM=;
        b=C7ePfiBC3JzR6PF2h+6DE33H2n0TG228uD2LMBaojrnECRMNKBc8z7yA16L5wxthu7
         jPAscABL13LLk3osYNkiWY/nnDUK/wD++2vDnKQKRFPsq7KLpzMvjv4V+7C76zTecqkT
         eo4QuCa5FgNTNsvaopNYl85dHFr1XVimgWRiaJNFlEep+dbRPI9vVX6+ayk0xNetaVxN
         aHazItAJ2jlrZp9kVY7Oi+Vll9L6VXDggkmg5EH3SGWxG5sXMArweSj72ixGmQKxMEei
         hF7MOoCjBRnKwAXveLdL5YcLGUvRajtnrzmmGCO7w97ZTkOc5yPpt3FLYh9k3h7lEz8n
         wuSw==
X-Forwarded-Encrypted: i=1; AHgh+RqXbNytDGsU0bKc33d4TJi2V66psvkapZFm5Y72GRnjAh+5jBKcgeN3tb3GTbGdG4MJy8ZU8h5fCyvTwAg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kMVh/JnqFund58YFyTPijdJmn9yBJcvjEUpAv6jSYSzRsNPw3+
	6MXqdYhsSf/qBig3+uCGAzNB8ARwWMVgIcSsTeW1vAPWI5OmQFcAWG/k
X-Gm-Gg: AR+sD13H/g/r7q/JF1d4ZAgiHIvPhf8E/ZH1RoopBXb5xnbs9us9jLxvMb5qXqhTTe5
	5QjMNjPlQ5h4RKDb/k6dYKxNuyV9i4BJqkzMGS0PtWpBc57G7a0JPlfiJb4mvyE7BWh6UvHIiTh
	AiXS2ORGksHf2tVQqxcLM3gCK1bj4h3jI8FwVQSHr41ODGO+ToHqtpgN3py6oLpsLcvfRNoz/ZM
	KnXbNj/OCGdL1vVZKKPXBPEQQ5KHCML5muH01HeDoRk/nlkUATl2x0G1ZDe8qBTkBOMzNgTnmRk
	+zbkCbceSWbodDUaWH1+E27euQcw5FkGNYLDnNDXjYkRSt7iHhHA7kFdiIXKMy6VoWH0Wu5XJjT
	GUqme3Vplno+rQbkClTtfPKZPWtCntli2fGeCUpqOFUraX2W+N9O1ktxzDPA0aE3rnIlN42ZLPE
	eFWZO5OlxRgrz8gG/rrx2fCqvwLGFGoSNZiOU0H7zDenio+cEKPha61qXQnMQoDWuOgA9wvgpuz
	qlG7gsLAk7iy+Jr5Tn03DyHfhanZ6g0vOQKquKKabA=
X-Received: by 2002:a17:90b:17c5:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-395814cf6c4mr5225113a91.16.1787136132380;
        Wed, 19 Aug 2026 03:42:12 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb3069csm2609681a91.15.2026.08.19.03.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:42:11 -0700 (PDT)
Date: Wed, 19 Aug 2026 16:12:01 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, thuth@redhat.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, FUJITA Tomonori <tomo@flapping.org>
Subject: Re: [PATCH] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
Message-ID: <aoWG-0xRUhzDiuqg@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260819084825.969116-1-mkchauras@gmail.com>
 <CANiq72n=C68iaxuLVR5dbuBpf2FLMGwH8wtB+d5sNgOTv4BQ7A@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n=C68iaxuLVR5dbuBpf2FLMGwH8wtB+d5sNgOTv4BQ7A@mail.gmail.com>

On Wed, Aug 19, 2026 at 12:02:01PM +0200, Miguel Ojeda wrote:
> On Wed, Aug 19, 2026 at 10:48 AM Mukesh Kumar Chaurasiya (IBM)
> <mkchauras@gmail.com> wrote:
> >
> > This brings powerpc into line with x86, arm64, s390, and riscv, all of
> > which already define ARCH_WARN_ASM and ARCH_WARN_REACHABLE.
> >
> > Suggested-by: FUJITA Tomonori <tomo@flapping.org>
> 
> Should this be Reported-by?
> 
The change itself is suggested by Tomonori so i was not sure.

Yeah there should be

Reported-by: Link Mauve <linkmauve@linkmauve.fr>
Closes: https://lore.kernel.org/all/anG67Q6Y59kDqh-c@desktop
Fixes: 73b741adb264 ("rust: Add PowerPC support")
> In addition, probably we want a Link to the original report, and a Fixes tag.
> 
> Ideally, please include the error message in the commit message -- it
> helps to triaging and also to search it later on etc.
> 
Sure i'll add the error to the commit message and send out a new
revision.


> Thanks!
> 
> Cheers,
> Miguel

Thanks for the quick review.

Regards,
Mukesh


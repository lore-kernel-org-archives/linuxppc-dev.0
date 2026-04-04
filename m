Return-Path: <linuxppc-dev+bounces-19324-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40CFE63FF8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 20:28:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fp6ch4dTCz2xYw;
	Sun, 05 Apr 2026 06:28:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1334" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775334532;
	cv=pass; b=cVhNXk1rAZTgwgUHC1FB/Lz57RCeGoNwdHp0IoihwKYFyCfFK27ygnRLM/k5W1D+OwSkiTcIPJdJ4LxyZxDdEJlE7ZM7+KvUubCXUVj0rarA4b8oRUSwrQH47WLXBTVQiczMYAWudSbjb3grxVW1VsJtrEiYeDm8hzdZqy4htjMD9l/DEY+b6nNyxlup0UabIn4qACznqAXdn3/+JNnxmZmm1tSq9byPf6ZSICNVkhnn6qN/mVooikUhOr3s4lBaL/m7zFd0kMPxJ/9q1ytbVcYWIgcp38i1pEhEIFkyfo5FBZN8rTaP5D6cEu0eT+tcBabA9MhuYBUpg69tSGlxxw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775334532; c=relaxed/relaxed;
	bh=fuYkWQmMSCPcosnkt/+bxaLXK1ECUYr+DyPSImbwjCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6rFU77bTKHnUii3R9KX2SlTWQQTv3mukwkH+CnLbpx5kRS3aDfN40ITN5/wm1MvkefpuMfx3Ni3CqwBOvIlqvOHyPukzKYG/7huYOdutm+emcUT678cVe+xy8RciGg49a5HBbqezaIJBPS9dJT+hRFMkYFqS9M/GszDaNMYV0c/EKW2n59LCLiA6qXVw2MJ4Tv/CYIyzO8WZjiiTCg6XEdFUPEgtWOXuKS1grtfXeeVZ3NdJ1ckzrlKk1M9jq0Xrp87fjmUgfBUh5shqe/dSDbKYHKAoV2Q7qpNCLyFX7woPDbHYQLreK47OMZ4AeIbJJkyEdPNeKaOxf2oOk3YsA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j+ktAkOK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j+ktAkOK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com [IPv6:2607:f8b0:4864:20::1334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fp6cf4px0z2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 06:28:49 +1000 (AEST)
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-2cb19ddda43so223649eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 13:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775334527; cv=none;
        d=google.com; s=arc-20240605;
        b=cqEMzLzN1KcJnGWXI6cK9px8jG0qA4moRllH0HHnFD84a7cd5JkoHeK1svMueKiipI
         pAGo5rVvaAYfUZKblVExMCu8IkM8R+DcBReN/0pIc8O7SIbB5xNPIQ0+onpM4CpqneCR
         +BShw9yd63hkYsNI2MhZs3OS53i52vY1LBJ1WBmFluNXZrNhzKzfQxdb+DkdBCxvTHZL
         muedoVxpO5/M7/+xg8Nqs3TaJ3xQ78QgNeTgeRhNF4q53uk3z7gGWcRI9yi7nxR+xigJ
         tVjIgkH8SU7QFatPNgBfcnkVZ73y4Z+WC3DZKWSkyrjCAZkAlsGa/jHLqtD6KCZtSWzk
         0E2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fuYkWQmMSCPcosnkt/+bxaLXK1ECUYr+DyPSImbwjCw=;
        fh=Mxs+sJtaDPuAM2glOD/G/U4CkYvO6nNw3raN7YC0cvc=;
        b=YlHZnhYXW0ZLzEHBdP1RNpINQ/U0Z25536Fh/1yxWGE0Qi9QVNbV1QhlVj4APe0Q4S
         UfU2WEvf6NkWQvWXoPb9yX51NR+dkeKkXm6ypT4prrfuES627LDqsjI8Rj8ChTnC+eqa
         7dmzGQgvuZ6a7mZaxQn91tUx833Bk3ceH/rZTnYA3kNjDffbOGlMOgzNx8z6lW3vdVMY
         BSZ8YO/TXlFZimbbl3fjs2q4ntls5vOKKzAzVWM3tcbdYyDJTibQj9qkx6Q2JxWHoIqz
         g5ObRvbj1sZ/u33fPrW6Q105r4VCdhAIQ8lxIub1ywSESh1u5Yhdbq10DY5qWWZ1QFNS
         T6/g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775334527; x=1775939327; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuYkWQmMSCPcosnkt/+bxaLXK1ECUYr+DyPSImbwjCw=;
        b=j+ktAkOKUkkZZ4T/pJT1p2FBKmwDZ55o2hQYQZqRA/0aWlGY7RST/nfe534N3cZpNv
         RkFi1HLvpiUbsIy37MrhHy0rr8JiYn3K7EAFhI5DjOZDXyQf797yKCfbdEXoMzhisYli
         TDnFpNKKHJXJK2326XQkAc7bMOS12qfaX0wDh7WaocJ6PPV6GsgaO3dOneiX7o28Cyuh
         t/MMK9DO8WCQOetr+sgZksBSQKBX4MdAjSJYbRFkA0czVP7iBJCXmv9ulfiiIczO4zlA
         vOa+SVT2acxkirXeUjOR5RSxC0LADq+loZLjHR1IFS9gieumz6eDGuCYBTd4tpvRex1b
         2Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775334527; x=1775939327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fuYkWQmMSCPcosnkt/+bxaLXK1ECUYr+DyPSImbwjCw=;
        b=ijjPFzi0e0YIPOQ/JV7efD7YaQCAsXV+q4xzMnwyzITpFX9a7YCZovZ2DmthyNQ0Oa
         cbITnBZKiOmBGji29zPXEnyT3kl64+gQAEmoKb31F9EgJlFKyh5ssh/OUtIDRd181kS9
         kxHxoLJwB0l1FuOKb4HFugKjNiIgn9bF3j/fIZfOwbWwJ9/WvGS6oh6Bil0FMEhxwunZ
         KF2kXxo1DtynIAXqAkKyHCa8CMeiuy+1o4wnWDc5d12uhHXjvddRCDBeO9AxWmO92Zq2
         MaujmjATNWdKBhUCo3o0kdf2HhH3R94DefhOACJEHrzTfWuw/ygKO0SSceLDd+L4vETv
         R/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0dTk/+VFiHXqh7y+ojhB6CIM32A7rXE5BQ37/rDbZ0P5lGp6pH1P8XlXwSz6AfvqIIWw5GNApaDIWMHU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzoQciRiKriSx6MpBnSJYP/VeqCTal6UjGwi9th5rOMbK8u+fFv
	M6Wt728OoS/L/ROh+v63KJSwe4aQlc/OpE9f0YDTcFfZ9E9FAszF5+jPjwFA0ZCXRox93LlPcIS
	HJI+el7qIAabKoyL2L3QYLJSL0v4+ts0=
X-Gm-Gg: AeBDies4wMfzukLFv1o51xOkCDjT9RCcSSUAxhrWNVP6EPjsrhJRIeKil7XELcvaB+N
	UyPxsWwg39y5h/Jljaze4NezeJ1rbLnX21x7/IlPiQPM66CYSb2irYCzGsGYaSzlAhs/za4rINr
	OqlqmQfx9aIwFwGySMjQvNldMi42mRSW/akZ0fJNEISSKZIaj6h5JLZmhJeHNcWE3+stfu80CUV
	CX+crPRnbVGXFKPSHq54RJwEaaAqN6qTCkXfbZ6ddIRsqDhMhYnXPjnEvUOZWykrW9klIggqokj
	IkP+soGYL0kBA0nbKFjXYf0K1whikmjklBvb7hlL5ahe2k91d813r5Kbu81y1ZD9uJDkMS/lNtC
	ffjdBZjt4Tew7zuRRV08gt5TWaFdrFNDjmg==
X-Received: by 2002:a05:7301:129a:b0:2c1:7ca:cec2 with SMTP id
 5a478bee46e88-2cbfce5068dmr1382909eec.8.1775334526875; Sat, 04 Apr 2026
 13:28:46 -0700 (PDT)
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
References: <20260403145308.1042622-1-mkchauras@gmail.com> <20260403145308.1042622-2-mkchauras@gmail.com>
 <DHJM52JEY7D3.MGKXTZB319ZL@garyguo.net> <adCHe9rU_azp8svx@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <adCHe9rU_azp8svx@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 4 Apr 2026 22:28:34 +0200
X-Gm-Features: AQROBzCykZ4QROsJXifMoD7BMVI05gD2ToHAxvSrZBE2nSQXFDkyMtGKnsPYJAc
Message-ID: <CANiq72=chqViRu08TxDBA9k3fpL6vAVzvBnTrkfY7jM=FD1afA@mail.gmail.com>
Subject: Re: [PATCH V8 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, 
	rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 5:39=E2=80=AFAM Mukesh Kumar Chaurasiya
<mkchauras@gmail.com> wrote:
>
> Yeah makes sense. Will send out new revision.

In addition to what Gary said, I am not sure if you will need to use
`abspath` anymore in the new one, but in any case, if you do, please
clarify if/why it wouldn't work without an absolute one.

Thanks!

Cheers,
Miguel


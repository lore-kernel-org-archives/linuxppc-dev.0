Return-Path: <linuxppc-dev+bounces-21488-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACB0CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 18:17:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPPHD12Lwz2xfB;
	Tue, 26 May 2026 04:17:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1330" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779733032;
	cv=pass; b=oJfqncWNIPs266JBc4UHs2MYPXZKEsTMcpRgEkkP7TgsabKV1jl/jqN72o00+ZnKjSWey7YZiRIsZuWlw9ED48JLlpKVzoFaxjnbG6/KII+FnMPxDEW3rAjwcXhNBS5AkTT5n+woMEzcStaec9a1DVY+dPkp/0Suo6jNX6QLNBlSsbzBBVctV1Fn25jVIE64lTKSs3PJoSJlvMZkTNc/1Rx/PuWsxYx5A+GvcAD4scPxmXldSHGi++7Tz7rtHrN0bq5EDUB2ytJYcZWf0wSLQYX6VcDc3L04rhU90J6yQxxjUBMPo1j8bdmtCGTJ4XKQ6x7diyGbgkXNqCj4cugTow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779733032; c=relaxed/relaxed;
	bh=N/2UctasxdczuvHkDvPIxcGMO1uUr3Chr5Ej1C66Qh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jwn+G7LRCiMalXtbG9eGTpsX4KuUC9nk3PRNv3labE7HP/gJHMq9LoipheryE8yt/kvWlQNxyItLQzbx1cGAn9z28dxEbMlxuf5QKLHf2O2kyXWLaVKaYB3wdYwU3Ni0JgsUjhQpTu61Lrh9ILeZVN/7ZDSU4+pZ7FWHJLQBWPEh5u830pYUwslOp7YQaCA+74qaf6aCqYXzeIgBwDOfDrNpjb9TtcrZmI/6paSlk8d+KA6f2prIrdEKeXnedte2GKywvz4ggi8HvGuifC0B69BWdtbaXUEkIgavJOIQAvThMyioRWraOZstA+KIX9gQpgtYZuyhBBw3Nazvgqzk5g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R1Op0DBy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R1Op0DBy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPPH93Djtz2xbN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 04:17:08 +1000 (AEST)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-303da604df1so891379eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 11:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779733025; cv=none;
        d=google.com; s=arc-20240605;
        b=H8PifkMQOihqgZ7Batm675rXnS5UlV8/y+M+/dT0n7UgHan3KL4axrIj8r4ExNDOuO
         zJnGlV4woXKnujR2BFc4Jn3XzNrCYaLRyBXkpuds2F6nvMzBBnhf/zKPbsmzP0m9pL+Y
         Jc5NHespkDoJqS3aOaMOg3FkrJXOjjtRlANTp0ghhlguEyBvmFJ02y0IIKo6bOcTVDki
         Ob3syVfnHs7rkl78V2bLbMbDH+t67ZYVzFDSz7gfSNxxch5eXoDz2WXCmi6ERdbHeTUO
         Loky0+5WqxZ/ngW7XhTIMXjxIFpb0CqAH/5B1/wGH5Qe+joEO8YEmVP4gSpDBDhyZgGf
         TnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N/2UctasxdczuvHkDvPIxcGMO1uUr3Chr5Ej1C66Qh8=;
        fh=UHv2rnt7lbO+LtALHqAf3f3LcKkSVx3wrNqiJrOJms4=;
        b=KoeifjHH78yypOkYMuNz4k1wltsceJRd53THkEsLV8pPnIle0E7IDpboLHAVMlfx6n
         IlGYYwkXnoeu5l3EjaOt++FgqqJY1R6Iar0u+KozGMK90uEnv/E65ZzuhKk/x8ggqn+5
         1uEW1gHFu11Px16UkdIXjObRnMwWqZnXoA5AfmU6qmrL1cVx7jk/fsBO7TgDaCoUE85e
         Gbo+Mv9yc3jcTFl/TGcV0AdX8+6g1JVbDB4D1w9hka9V9b+iLjYP2sz+PqQg7/3TUseJ
         m3W/FHWk5c6JdIY3R0+TnnJ0AigM/639cZZEgryJyTRMs7qQd/5N2BK410FcW7jpraIx
         bNCQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779733025; x=1780337825; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/2UctasxdczuvHkDvPIxcGMO1uUr3Chr5Ej1C66Qh8=;
        b=R1Op0DByHMp/swvNws7g3OrJyr90I7imOpR9gWKyNEFieLEk4cFj3Imsr1nC2nhjAz
         WE0kDlo4QdEPPRNJhfUpnapqtrgda2p/yGxwWnAJWeuQullkC+SzgTkUJJvL4YHpz7aG
         kTUhgWkNXkrX2HAjNl2g1tvNQdrP3ynjI13twC9i6w9vCVnpG8BDrKpQdpJzwhnZMB2h
         8FAV5KKlv7opEhQPaojBUCzm5bBEjEHa2xFSBpy9/bxbQEEoLfZKO8VtpokmpZYcovlX
         1h0FOFJtEz2PYg+UIMCViBL+IkyGDHk/thmV92iQ71jjhodPt+iOhk4TksCP7+W4mIXT
         UX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779733025; x=1780337825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N/2UctasxdczuvHkDvPIxcGMO1uUr3Chr5Ej1C66Qh8=;
        b=b4U+sjTDeMDqwrz5GkV/cQW8kx9ice6Fo5fn0mVCZgF4Z0mt0iFezh0JNsuVwjy3JP
         RZe7BODnWtJiVBl9xOVFkEYbdX75AdOjraFnsDFwerNU2dqFnK0utXPa0mQ2aUA4B7Q2
         vqlVfkTKfWL/hVDULUs6gez+D+v810XreeXLBOQsG7idVBr+QYCboNbeK49HX/86omvk
         DHHO3E8xMedjZ+AN4iwsMWOHTULocNVuRwaEZiWkjwWniVYXMRdk7DqzUrIByhEx9jN5
         0XjY20YNKOgPzOj3Pz4Szsmu+2TefRJy2YMnPxPUvry94xbjoHFBeq0BebvCdU73CGFL
         33RA==
X-Forwarded-Encrypted: i=1; AFNElJ81YAuNPqNP19pr5wEaDa5wL5ZArvCywiWzfuFxkZa6ZFgY4ohDkQbRcSApQioVPThwhp9HIFLM+D2A1lg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwR8d9ZOHL5nId5rV4DH8fm/wyhYEL85xXc4YNaaau6zb23QW2I
	vkeEr/7Vx3xvaMWsMSO5/4edSB2/Ag7TlZUBaYoMwDvGVuDCtoHoWZKuXM/AE1oORrRREe8MYWZ
	htFzwRrVrJrwGZJpb3MO8XfA6zWXboOk=
X-Gm-Gg: Acq92OHiVPrOOokN0pgMawgtlViZl2kyxKrkQToU26JI8oVJ9PLKrttFR0ptVw5AXOe
	yZQ914LFi22FPtCSIun6Cf9dpPex5cZCsPC5z+PMzlXH4mqKD9cYi+OIx8LwtW1tUmuj/JlK40D
	T/ks+CVhl4MNXJMEQrl3AOXAThIosYMUAMcwtwHciYGlqEoTlu2x8U6SjHmyXcXeX0jz59UWaer
	1y7lBW7itZgdGGxIuSztY2QCpqJVVufe8+M5ZqGUdPRsBYI6rYo/en/vGbDHlbsI2SeehPQqRvg
	8lxxdLpRoSzOjmeUYFyARwK2oaHAbyXOq7ZXzio/gaSDTWYok13sSM/t2rpSpS4D8gMZoN3GdS7
	5DHlEEj4d0XmH40fw1UIEooo=
X-Received: by 2002:a05:7301:2c89:b0:2ce:db5e:354b with SMTP id
 5a478bee46e88-3044912c779mr3218270eec.6.1779733025318; Mon, 25 May 2026
 11:17:05 -0700 (PDT)
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
References: <20260520064630.1785283-1-mkchauras@gmail.com> <20260520064630.1785283-5-mkchauras@gmail.com>
In-Reply-To: <20260520064630.1785283-5-mkchauras@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 May 2026 20:16:53 +0200
X-Gm-Features: AVHnY4KNP2Nl2JQ1LBLJOr_gMKPZJcSjALxmqaPRFB0APLpX2lXytJLQunJepAg
Message-ID: <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com>
Subject: Re: [PATCH V16 4/7] rust/powerpc: Set min rustc version for powerpc
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	daniel.almeida@collabora.com, acourbot@nvidia.com, fujita.tomonori@gmail.com, 
	gregkh@linuxfoundation.org, prafulrai522@gmail.com, tamird@kernel.org, 
	kees@kernel.org, lyude@redhat.com, airlied@gmail.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 8:48=E2=80=AFAM Mukesh Kumar Chaurasiya (IBM)
<mkchauras@gmail.com> wrote:
>
> Minimum `rustc` version required for powerpc is 1.95 as some critical
> features required for compiling rust code for kernel are not there.

Which critical features?

> For example Stable inline asm support which got merged in 1.95.

It is not needed that the support is stable, but rather that
everything you may need works.

From a quick test (with a dummy example that may not be
representative), ppc64 inline assembly seems to work for a long time,
way before Rust 1.95.

So, which is the actual version that it is needed? i.e. 1.95.0 doesn't
seem to be required at least due to that.

That is why I am asking about the critical features above, because it
may be that this works since earlier versions.

(I wonder if this patch and s390's similar one influenced each other?)

Thanks!

Cheers,
Miguel


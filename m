Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042E606B473
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dsXxoNeh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFFnn6V8Sz2xwL;
	Thu, 29 Oct 2026 05:12:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b131" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793211149;
	cv=pass; b=X4LjQVQPWgembbbk1l5yNgAwH/WLKFNNUUN4a9oL1TiwhpEBuKvLOmnCSXcP3xaFGscYEbPLtAJsPC008GFW8rjtGJkBcj5YXgjRqqAREk77bIGBJQyt4yLv5NevM6haX3WEpshVjpvdcsWgO4ww6ckj/T2jNZFhWBtb2NDmRvTN1N9nHBvsSJcVghal2tWauh3//bMvSU9nSp+I018A7FfbfmRudnkTDtIQVcy2MWvUwwc+O6xdC5z/K2xzBwG9QdZS+485gVnm2g9/v4JMaEPEZRjwLs7PIkrKg8ZSrjXEQymmfoUOPPiUNkrvVnSGUR9/6u2wPhTky+/K/ESb2w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793211149; c=relaxed/relaxed;
	bh=p/wxxGxoBJyhbGLsecA52KNGsy8WsqvTWX50Wr5bw0M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5hYEMxFzZxbqYP9KUg0PqSiZHp0CnYR5PQ0XkUIYrKGZoaRrQlHxa5uwEyw4Fu/Mjyd3PH20u8Fw1oVOV7HAd8IMCIPLkYd0dgGfqylYl8F9WH9z4BRUdUKZHua4qUzEyK8XAsHhURgzchIR2nmKzaVlbjv8bDvc3Zte+8D2TrpLlYwK+4UPJ22Qs4yz5+5eBolLJKtNjlIFLxx8Pz9T5tazGTmD1R9R1QDqf1wlhVBZOUVewdY3hDydXNGMwQVwOpSKIM4PZomNnISODkHtmvSIOQOzlSE9+He7lId3G0CbRKFIUHeINKT0kmLbUsXwHuLrR1YtYc4rM2Zp0b0DA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dsXxoNeh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=ryabinin.a.a@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dsXxoNeh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=ryabinin.a.a@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com [IPv6:2607:f8b0:4864:20::b131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFFnm06Ssz2xft
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 05:12:26 +1100 (AEDT)
Received: by mail-yx1-xb131.google.com with SMTP id 956f58d0204a3-677d9c68d09so171084d50.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 11:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793211144; cv=none;
        d=google.com; s=arc-20260327;
        b=NazlBwQN3qpPXHEJWQK+/ST9bUYPB0+5wQ0+2rM4ITUbfvkPGfwCHChrxurZ8BdUf3
         b5vK1IM5nMcpSUGq0nkqbVuopCj8YB2Hld7oApaXjU9wO8Ln+YLtEO9FsbRLHjbODOzX
         zPisoa/GGW8fOG7C57565JsAPlpT0RyGLOvqJrJbMqIl/QUx8646w0o2ccrGfMZx6eAm
         VczAS0hWr7bjrCmn9gqQKxqcNZv3p/qkHdbql4AI/9mS/CyJdmu+Hi9jZnRDP5R2YpVK
         bPCm3zkM0e3C3EZDYwyibZLSJGKKq5+3GvSWGABvzw6OZX6Kv6fUGyej9JGoNuoKdpuN
         LL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=p/wxxGxoBJyhbGLsecA52KNGsy8WsqvTWX50Wr5bw0M=;
        fh=oCPOLFuRBSaKa3/940/32/+7p00nTVtKKkPbSGM0Xhg=;
        b=qIwMNpT7lKgeYJaZK1W0DSXShbBna+Wrn9bQkeCqkg22IdfUyf3p/lvODPXflAoyW+
         tH+OfA7pNRfKPC7fZSZJ7ERjg90aHtII2D7hk90PJpPP1n0Ax6wCUcjW8FzHaT7tHqsy
         qKIOhhqTWXzmz33Int7gctnPkgREOeskQW2Fo7J5y7i5GLUOJF3qgp8iB4YvrIieESha
         vL9zYoQM32bwYzdwBUoVQ/zfE7drswbOZiVeswH2SiF6EBCChEGL3/puHHCoApQSj7tq
         U74gwsacWKBhh7lEXNxH1vx0VGU1K8FBMSzb+2Q+LAuHDxGm1V86OA+o7hJnd0J6Ff+q
         avKg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793211144; x=1793815944; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/wxxGxoBJyhbGLsecA52KNGsy8WsqvTWX50Wr5bw0M=;
        b=dsXxoNehI0bYHzKudZ4LSyEsV0sTiNWg6jj7Tj2U6eJvEKh4UJP+8A2Hcckqy4KYUU
         9g1fFvj6V39A15Ut4lSn9ylvV8ZrO77Vri0kZIhR4FAGqwodLV5qxsjybmQncBhPzcHe
         uXCL97Y9hMp1A/RsRx2vzxLnu1ig7In5e8zWQFIA9jkqbVkV8AWx4mLDIvPrCbMOpysr
         lxSjWaTiKFa40WtXRWOsH3G867M+I5mslFe4WsuOdbiUas4NnZFdn9jka3XN/D39yA2I
         TrX0BoWf5+TbhhnvbkF+y6GiFgR0VrFVslGWi/UBuEJWO5axgJk07niVppcLUzKZ+aV2
         NWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211144; x=1793815944;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/wxxGxoBJyhbGLsecA52KNGsy8WsqvTWX50Wr5bw0M=;
        b=c6YtHhxqR8q4Dnl/l1TZSs9HYlRhHOfhTgNJI8hXzKxFsrbD7+ZT21U/bfqMwqsNGf
         7RMgomINLC0RSVyzBjR32hBU2iW019xhd0v0lhN16NKnL/SK89tIgbS3GWABtQquZ6xD
         XpaVIGMP/kZDFt5t6e9hpYC+FBdjcjTDpUpqm9FlwzGTvFbobO13/HRu+yD+PIIFPwB0
         lL7DCliYacrqbRNKfOCrsBDOgjwrdSqZx3iYtCJ/O0MANov0R6tGhNsyxAxWUrom5MRr
         4WHCPqYZQIuCJYC4gGosSt8gqEQI9uehH+e1sFRPLQQMfEsaiScoxFqSr1AgP1W5nPDM
         vABg==
X-Forwarded-Encrypted: i=1; AKwUvBxDXuEnI9Fl6SlN8XwcfUrb+zlzyk4FJ/X1UNFVNcDj4yuaggE3f82qR2flKMj27OoFjEd7PN0Y1AnGI6k=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI9huNSxMdcSYEyjOaNqWUlJ+4wr+MC3bgX1XGDU1Tv7b6yX1YZ
	acdCbJD9qu33zpn34OBB87uRm+ak+3oaQtZrds/Nut2V/CYn4dC9IAlyJvjY3n3l2fzNTY0XRfw
	me/IIPo0JC1WRCPBQAmzZPBCRkVaJfpg=
X-Gm-Gg: AYBFou1RHljgS7VQ73nQLNbQAeA35wo8KSVMQ1lpNHyFbIh9IKQta9z4cKR1fiyPeMV
	r9tZCkK0e04SlshCzCZIzlNlx1vN20zxfDUFbb3uuwyOp1zdHceYg08LlOOiZHmugUwGkKw7SiR
	moHSPSsA4kQjAOEZ9a7OoAU0hAbQPbtmnbpy4uNhhGkFNmafK59JsqTrKVe87MhQmuMuyYbCly9
	E9o6Z/xyQJ+4005rUfLrRoMkgkdQ0h+bo9CJfGU9h1LlIJUM9LGZZh9iMj1JD+y81ySp2gNctHo
	BB8tLwx0DSxcmlJYsJcO7mPDP69uWpVGS6wCP3R0PY/dAki2LGeoNIISyaxIR93UY4hqLRAPOwE
	VAoIvaZKsC2Eub8kp6tdMXxSI0O5rm+5K7EQ=
X-Received: by 2002:a05:690e:a4e:b0:675:6f06:5642 with SMTP id
 956f58d0204a3-67a7b9945d2mr4650525d50.1.1793211144098; Wed, 28 Oct 2026
 11:12:24 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 28 Oct 2026 11:12:22 -0700
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 28 Oct 2026 11:12:22 -0700
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261023-bug-word-at-a-time-zeropad-kasan-v2-1-be0ecfbae847@gmail.com>
References: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
 <20261023-bug-word-at-a-time-zeropad-kasan-v2-1-be0ecfbae847@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Oct 2026 11:12:22 -0700
X-Gm-Features: AclHuK-o5YV67AfwlA9WNsjqOxV_ScugEYWYzUg986KltKOOqPQjM_oQFfVaIog
Message-ID: <CAPAsAGyEUL1fj2-1=NGBDDO-z47cOHmcFDFexY9T_1_1LCMQJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Peter Collingbourne <peter@pcc.me.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Qiliang Yuan <odys.yuan@gmail.com> writes:

> load_unaligned_zeropad() reads a word that may run into an unmapped
> page and recovers through an exception fixup. It does the word loads of
> sized_strscpy() and of the name compare in dentry_string_cmp(), path
> components in hash_name() and hashlen_string(), and the trailing bytes
> in x86's csum_partial().
>
> It is inline assembly on every architecture that implements it, so
> KASAN and KCSAN never see these loads, while read_word_at_a_time() at
> least checks the first byte of each word. A use-after-free or
> out-of-bounds read of a name handed to path lookup goes unreported, and
> so does strscpy() reading from a bad source, which the kasan_strings
> KUnit case expects to be reported. On x86_64 with generic KASAN:
>
>   KASAN and string KUnit suites      failures
>                                   before    after
>   CONFIG_FORTIFY_SOURCE=n              1        0
>   CONFIG_FORTIFY_SOURCE=y              1        0
>
> Check the first byte with instrument_read() at the start of
> load_unaligned_zeropad() on every architecture, as read_word_at_a_time()
> does. All callers only load a word whose first byte belongs to the
> string or buffer they read, so the check does not flag their intended
> reads past the end. Add a no-op instrument_read() for the powerpc
> selftest that builds the header in user space.
>
> Suggested-by: Peter Collingbourne <peter@pcc.me.uk>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>


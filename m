Return-Path: <linuxppc-dev+bounces-18978-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13916F3D614
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 17:25:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkLr21M4Xz2ySS;
	Mon, 30 Mar 2026 04:25:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1336" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774805138;
	cv=pass; b=MQVwEoG+rMUeq0N2kp7ahqO/5Wl/gHCrHRzQK9D5Zn8B9L72pHHPKLe8CY3GUtKVQTyssxkBDk96Qg9LD55pCrgg7wgSuVAEdvMAdS3/V6FMpzqhCyQQ+9To2jBTq1zP6FnBluMVfuzRFa89IWVwJTbOLYZhxvp5X273lINj5DushVJtPwhNOYL8cjEE81phdgKUjRcKL3DEHIr7O9yqBZz8O+36tx8sERWqpj0EOk92n76XiNN8lrMMby2fn9bSrsEyLozuc6X5RdQ+KE0gOVndw8dP3EWrRuU+19JytbyzFzGVGqt9QHdvYQKI0+vzxFUjEaeMlHJe9KFCDYn4bQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774805138; c=relaxed/relaxed;
	bh=fVO7p1WTgSqxLyUmITHRrLptk/HqH6c7TYNfvg3jMD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3rS4tGNi1qvnxvZlt3nDMg8XFaVFf3z9qJanFUqytYl/De3IT/GTRciJVmWA464Nqt9fBJHZKoV8cPqOyecEz1lENWsg5YpcmQSUbeyCb4PI4Z3W4qfSliJWFrvxmZalqbWJIpBbUusweEc5HEkZeAO82I3EPvJ1en43FOFko3vBR0bMql1s+uYMI7RFJs86Yyvi+3o0q0/Z8kfISWcgwt7eaePsZep4nzFKsKAePOWAQ4/gX9cLytvoC/ilvK7ShIJXuzeY5OZL4a8ByIf1n4F4AHahnKvG4Lzqj6CQ/2tQNbEi8e2FaaxHJypYcge9Yk/I4CN/5WyBtPyaEIWRA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YbdrVPz/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YbdrVPz/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkLr05Tp0z2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 04:25:35 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-2bda3b4318dso278081eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 10:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774805132; cv=none;
        d=google.com; s=arc-20240605;
        b=Kqh9mqKiKpwZdu/h9jK1o8Nj3qUou4GSk4iMaN8tDGtLUm6lSjjA6nuYi3iCeMFV9z
         QKGKgqCT9k1gZtd6JnfMp56utYFjScTFaJ/HHB8oGjcJrGa9/AOd59QexhyjNXeuH+bk
         azCfsFq2oA3zyb0VznNXf2LzeSK2j5YJN+3gLM5CBmY+z+azxBy6RERUyV7nuvGIPao8
         Lvxz0PPhPkW4HF81MXcWwZGLPTl5WZq0VxkvUK+izw8RMX6tgL5oG8GqmvxCgIFcU8/7
         OqXzTxRBZS9ovQtxXKd8M3sjBFxpBDSkKD+JqOI7TFmFDqUFn4vnMPUuihgcNefbdoK3
         0XHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fVO7p1WTgSqxLyUmITHRrLptk/HqH6c7TYNfvg3jMD4=;
        fh=AhDnqUBAsJSJKf92zuMobB1jsCASz7NPgn6ugn8DVK4=;
        b=SUg5ASmNugqDpqMpYKa/2Q7+fzGMxKIh5tcRcdjAwVA/h5o/Z6ntFG110Qdv7gpJAB
         hfEX68B7PTLspRJH8GAo60CU3yyh3V6YZvz3CTDSd1zGkpUffGtQklwRvWA0xdGmfOvn
         E7I0Cw3BW305pQ+ddlkypirljFcHWo/LynEFbv1fADANybzECLs96V8uqTgylZLGssAr
         RM+y26TNBpV2I8lx0RUEwfzAiBrtw64dSarN2MNBZEDwiws/6874v15hEcsL2okefyAn
         0CtDhErU6gCkSz0u5Bynle4uxDaC3FIZ691/aytsBJuA3xG5V17fthk3QlG6zJGxeJfQ
         zYkQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774805132; x=1775409932; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVO7p1WTgSqxLyUmITHRrLptk/HqH6c7TYNfvg3jMD4=;
        b=YbdrVPz/36uaVn6WECN7H2WvPMiUHDay0O9dZW2nvNufraXsn4kUtEkz50ux0iG7r9
         fJWtZfLzcZ20ShHY+fvIybI9xLnCMAEag91DVpJDiRzevE8/e/JuL/zPrz2n5xgvrE8q
         j3OiwoCkOjG0X0s0PlGwSo7CapSNxWkw60LEPufoaSY0Vsg3u27j13c51C2TIzWyxfte
         Vj7R2YBgRPjStIDji7fA7J1BKUQ3FVZnDt8sZVonhdqZXUij8GjfHQtaB3zS1nrtdrtb
         ijeQgIjeK4X25myqxt/fVvJPNgy6RzfpMYDS2p7ECURF4OiG80CmNPnCxNafvNFUjZ3P
         7dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774805132; x=1775409932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fVO7p1WTgSqxLyUmITHRrLptk/HqH6c7TYNfvg3jMD4=;
        b=aifgInaqb84tlTDF8+0sKPOC9zkS3784b64is3WoL4dQ0FWTsCnl7G0fMGwsUh2of2
         hqRhXBJikwvQT2aq7pVtR+CP2QLIG6vkp3eOXNWZIC6fN9LHG8I9PG0Ft6xAtCriH0B8
         EMUitrTLomibrJBkRMYkg2FAMS4ZKQoa0DIKm6s0lP41+AWmR8klNcfFMcZ5T5Va4Sz0
         MLlTgkLkjljJWCQukvQtkQuqQ6TYB/pOqTVUmAWYXGtRaSfMfDcVjITtjZJbUgBu/Ec5
         J9HPHpBd7tDsYylS9fBFF7j9AYunwMHUtNNQLALbI5JsKEE4XXfoG7Ys3TgORH3m+/Jv
         pdgw==
X-Forwarded-Encrypted: i=1; AJvYcCXxyuw91aDGhPxHsIkQTxNq0SoB9pZrQOJMdolbQSa7qlzCDbEBSlSCniW8oHwrvdGuKcTrjb2k53hsgU8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwjpkHW3WSV3LGWgh9FVqQlZ0goum6XYFI+UreZQCD08XdaFzcK
	xKtm7y0GYGWkwhYbfUGo2kdXNo+xmXjjufnTRELCcf0n71z6skW2f3cuPRj2Nk/3nRZ++ayS0rM
	QpCi52A9gHOLznwVGlu5gDw3697ORXnA=
X-Gm-Gg: ATEYQzz3pRvrv5rRHlbyvYSt07nxv+VfrLfQjaNpxIL0RyE8QVJNwt6qDOobg4mm26D
	6ZxgirfosGWnYVMZTQeV6qMdJfFmWUy9tReZoNBkSYu84kQIqQGk7M5rqWtCmmIzD1ksu+2oVKF
	q1Bn28mrVld5DeD4zo4/l2FdoM78g60SYfp6+Z3rXXRTS74SY7jkQtu1xC5u3AedQ6JNqUWXVaR
	4fHCby0KPr7lPSAQzO+CYVDcmhNtauUrQjzoZQzlm/8oNFYR2nyub3790Ccv1Guu4zQqzCeQSDI
	8w/a6WhL/+uFz93Udg0WFNJ40OIGwWsXIioyRjwMmhGpZuYDHmHS5AOhLmBg5osPKWwrriYFIb6
	T1b66aMUgwGqo/9Hkugpeobw=
X-Received: by 2002:a05:7300:f794:b0:2c5:704f:7157 with SMTP id
 5a478bee46e88-2c5704f7c1amr330279eec.2.1774805132331; Sun, 29 Mar 2026
 10:25:32 -0700 (PDT)
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
References: <20260329160254.2592207-1-mkchauras@gmail.com> <20260329160254.2592207-2-mkchauras@gmail.com>
In-Reply-To: <20260329160254.2592207-2-mkchauras@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 29 Mar 2026 19:25:19 +0200
X-Gm-Features: AQROBzB_vNGuEdtdw3_y_LDGeOkv1V58X3XWTcOv9g2aVEsFJXa9tLMh2e_XwSY
Message-ID: <CANiq72nxgwPUv1AJhRQSFNWtV+w_a-VqK3VWtjaKncRJkNNETw@mail.gmail.com>
Subject: Re: [PATCH V7 1/4] rust: Fix a race condition in Makefile
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 6:03=E2=80=AFPM Mukesh Kumar Chaurasiya (IBM)
<mkchauras@gmail.com> wrote:
>
> When compiling with -j1 flag in powerpc, the libproc_macro finds the
> libcore.rmeta both in toolchain and local rust directory. libproc_macro
> should use the toolchain provided libcore.rmeta.

By toolchain, do you mean the sysroot one or something else?

We should make it such that `rustc` does not try to use them to begin
with, e.g. we added `--sysroot=3D/dev/null` to prevent that in the past,
please see:

  71479eee9da8 ("rust: Suppress searching builtin sysroot")

In other words, we should try to avoid adding dependencies (even if
order-only) to workaround the issue, but instead we should get rid of
the root issue.

Otherwise, after a build, if we rebuild only one of them, wouldn't it
find again both? i.e. this is not really a "race condition".

From the original message, I see this was happening when building the
host libraries, because the targets happen to match, i.e. you are
doing a native build on powerpc, right?

Perhaps we could put the host `.rmeta`s separately, or something like that.

Thanks!

Cheers,
Miguel


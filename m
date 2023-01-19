Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E071C46467
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Jan 2023 19:21:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NyXYq2pvSz3fHs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Jan 2023 06:21:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ReQBSuZn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ReQBSuZn;
	dkim-atps=neutral
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NyXWv50DPz3fGr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2023 06:20:10 +1100 (AEDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4e4a6af2d99so41836127b3.4
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2023 11:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2y96hSgZOdNiQi3iVUDGW1zmbq/2ZeqfDpIjbWl/+AM=;
        b=ReQBSuZnjQ/Hzn9MjrayyI00pkEWhj7Djpqlg/g38iGqjIo4Sq7re3LPR5NKsWo9Nm
         rmijSW7CCq1C2Qdp7/ky7GCkKbPD6xEDKXk305vsRjjmvhP21tX3QKgIjkm4F3ckbHnU
         3rsLopUK6HQfuzAeTV8Gfeem6hCoLYXkKH10aIMTpV67Itec0/0QpXWGecCbZyWvBxWi
         HMb29GK2QtB8DekCsdq6oAVcEzk4KtxgxCvfmYU+Dt+rTUuSwLkYqHnEr/te+cjWSrxM
         NZ3B4MJ4fDhLb0uqTI/T9CcOhWI9zQWWGgQxqW0IustVc/+u90vkW/tlIPMHHewHNDmv
         Ynbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2y96hSgZOdNiQi3iVUDGW1zmbq/2ZeqfDpIjbWl/+AM=;
        b=uU4c4xG+tzEiqwnzNy/yRFtJ9ZK2WoTNkxF7EA7ID8ZXL9o510fxBQzYdiLWeAJLso
         AhDvKCZtlrt8IR93muAIBWJBIqUR0L0RkuZxeno6fnKw+fTkds+KS+TgB5YY12ASg2pu
         snvsW40vVmnZkoVty2H+nO6IcXCct2l+kCglF1rVaNAS7wrVQCk3DUGThHtTJexUzRUw
         GsdI/gMiKKi7ZCqgkir+NIJI0edaU7vWXoGtcOZyBxAQ7zj7RWLSYosqRiGKm3NChc22
         dpzFoKUHvUbQbXMdXLQWf2+hJmWGGwdrLFfeyl8g+92lRvY4e68p670Z1eJvDlPmAcU/
         y59Q==
X-Gm-Message-State: AFqh2kpZlFjaOihkQO1KWHP07s06lds5DZ8gcGGFpCqvP76Y7+6SWo1Q
	gZCXPtV/XMmRKWHJ7P1043zg2rM8FlvtXEwLjKE=
X-Google-Smtp-Source: AMrXdXuhMbeLfhMzO3dNO8FM0BS93W/XkG/FHlqBpBtG6GK7C62jMILFqgYHbTQjwIRvsrMCEslAihTwcRRHs+ouDnU=
X-Received: by 2002:a81:5402:0:b0:3d8:8c0e:6d48 with SMTP id
 i2-20020a815402000000b003d88c0e6d48mr1018356ywb.462.1674156007567; Thu, 19
 Jan 2023 11:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20230111161155.1349375-1-gary@garyguo.net> <20230112214059.o4vq474c47edjup6@ldmartin-desk2>
 <20230113181841.4d378a24.gary@garyguo.net> <20230117175144.GI16547@kitsune.suse.cz>
 <20230117192059.z5v5lfc2bzxk4ad2@ldmartin-desk2.lan> <CAK7LNATsuszFR7JB5ZkqVS1W=hWr9=E7bTf+MvgJ+NXT3aZNwg@mail.gmail.com>
In-Reply-To: <CAK7LNATsuszFR7JB5ZkqVS1W=hWr9=E7bTf+MvgJ+NXT3aZNwg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 19 Jan 2023 20:19:56 +0100
Message-ID: <CANiq72n4MbR+AE7eHfVQZOu26FeSttQnEEMT3Jpft+CcGwk9jw@mail.gmail.com>
Subject: Re: [PATCH] modpost: support arbitrary symbol length in modversion
To: Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Gary Guo <gary@garyguo.net>, Nicolas Schier <nicolas@fjasle.eu>, Guo Zhengkui <guozhengkui@vivo.com>, Wedson Almeida Filho <wedsonaf@google.com>, Joel Stanley <joel@jms.id.au>, Alex Gaynor <alex.gaynor@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, Wedson Almeida Filho <wedsonaf@gmail.com>, Kees Cook <keescook@chromium.org>, rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Luis Chamberlain <mcgrof@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-modules@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 18, 2023 at 8:02 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>     - *.mod.c is kept human readable.

On the topic of `.mod.c` readability: for approaches that may be less
readable, we could improve that by adding some extra comments or
rearrange things in a different way (it is a generated file, after
all!).

For instance, for the original approach: https://godbolt.org/z/6oh45axnc

Cheers,
Miguel

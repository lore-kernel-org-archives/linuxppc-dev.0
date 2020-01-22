Return-Path: <SRS0=NP7W=3L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB1CC2D0DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jan 2020 20:38:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FC421835
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jan 2020 20:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c17kuYSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FC421835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 482y0k1pnPzDqVS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jan 2020 07:38:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::241;
 helo=mail-lj1-x241.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=google header.b=c17kuYSr; 
 dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 482v2b2Np7zDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2020 05:24:53 +1100 (AEDT)
Received: by mail-lj1-x241.google.com with SMTP id m26so50852ljc.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2020 10:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EIMMT3lCl+eANfb55cCw3QDYBNjRwo8JhGMdDvgr7PE=;
 b=c17kuYSrsF8ApH4qTq2aUrhTyJuVUz8Qw7Uqon82/zhXga7zwOs4wblkpbPz0h9lVu
 Mk1jBZzARoiTbYMPv6eHlPBz1kmgDHakPiaAgrUnRGb1IahFhKrpr/e1yazkuLI925En
 FVkjGNvnMMyvMfWRS8f7fAzQi00FO8SB4wXTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EIMMT3lCl+eANfb55cCw3QDYBNjRwo8JhGMdDvgr7PE=;
 b=OU7bicEgYQQnEdx4d5bVugetOcVThFOevFYZl+PKLXv4jSJpYPcMAaEMoNUzZcJnnQ
 Zib2gPt9ow2MzrKpBpEsdIVqXx5rMYY09DjT65gNFYruNTbLvKHUk5AsSrKHJgyfOj1h
 w/og4Hk8onnEnvYhjg27T5NDv31sLcNxNU5HCXy1WsHQeqL7kTUkyRmOumlY4YtHs1d/
 TGgzYzK72+meLmJqgH0BBTtonL2uuo+ndVAklZ0XmrXyVs0xHFCwyvdclCmF7wrr2mXi
 uDBhfH0U2WK19cbWfd6Jkr2MtpgmuV+WKDJU6UuJQUKOUdOj0WFG7cyDyLJpabJjROPm
 iK3g==
X-Gm-Message-State: APjAAAUnBR63NzwZOr19lbLoFyJzZNRy0KtBzVf0j4SLwK5nqgyLMEgV
 xQM0elSPuPOFOlSgw6FvzQXpMfbFXrE=
X-Google-Smtp-Source: APXvYqyiUfeLlldbi67BV1Uxpl5ZSHAHirjQt4Y9jUBsQmPn3e0cr14NL4fe9CRV3+24zwX9vLm7rA==
X-Received: by 2002:a2e:8745:: with SMTP id q5mr19025392ljj.208.1579717487572; 
 Wed, 22 Jan 2020 10:24:47 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47])
 by smtp.gmail.com with ESMTPSA id q13sm20392750ljm.68.2020.01.22.10.24.46
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 10:24:46 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id z26so305196lfg.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2020 10:24:46 -0800 (PST)
X-Received: by 2002:a05:6512:78:: with SMTP id
 i24mr2492109lfo.10.1579717485818; 
 Wed, 22 Jan 2020 10:24:45 -0800 (PST)
MIME-Version: 1.0
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
In-Reply-To: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Jan 2020 10:24:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNQ-rWoLg0OCJYYYbKBnRAUK4NPU-OD+vv-6fWnd=8kA@mail.gmail.com>
Message-ID: <CAHk-=wgNQ-rWoLg0OCJYYYbKBnRAUK4NPU-OD+vv-6fWnd=8kA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fs/readdir: Fix filldir() and filldir64() use of
 user_access_begin()
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: multipart/alternative; boundary="000000000000968f64059cbea3a6"
X-Mailman-Approved-At: Thu, 23 Jan 2020 07:36:48 +1100
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
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--000000000000968f64059cbea3a6
Content-Type: text/plain; charset="UTF-8"

[ Sorry about HTML crud, on mobile right now ]

On Wed, Jan 22, 2020, 09:52 Christophe Leroy <christophe.leroy@c-s.fr>
wrote:

>
> -       struct linux_dirent __user * dirent;
> +       struct linux_dirent __user * dirent, *dirent0;


Patch looks better, but those names are horrid.

Please just use "prev" for the previous dirent, and leave the current one
as "dirent".

I think that's going to be a lot more legible. But no numbering.

      Linus

--000000000000968f64059cbea3a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>[ Sorry about HTML crud, on mobile right now ]<br><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, =
Jan 22, 2020, 09:52 Christophe Leroy &lt;<a href=3D"mailto:christophe.leroy=
@c-s.fr">christophe.leroy@c-s.fr</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct linux_dirent __user * dirent;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct linux_dirent __user * dirent, *dirent0;<=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Patch=
 looks better, but those names are horrid.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Please just use &quot;prev&quot; for the previous dirent=
, and leave the current one as &quot;dirent&quot;.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">I think that&#39;s going to be a lot more legibl=
e. But no numbering.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=
=A0 =C2=A0 =C2=A0 Linus</div></div>

--000000000000968f64059cbea3a6--

Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541FE606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobcopeland-com.20260707.gappssmtp.com header.i=@bobcopeland-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=k0PBEA+3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLg664Tfpz2xNC;
	Sat, 07 Nov 2026 00:30:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b135" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793968756;
	cv=pass; b=ldchSczhkTYcAk+A0uMjgH7XfqI2CACu7EYxUEh7ADRxKIpo6mfGVx3GDSb2WL+aPAkERbo0Q1ViouwlPaWhbUDUaSomcKNgBIMg8NpVWFuAKSOzYcng3tzZu72rWRfM0drKQBlznJ4+bivL42102SR4o3kt+EUSMVAONWMoNLkzHs1XpeDJVaBiJBK27FEJAbmr9suB8l8uWd92KPfa/O9K7Ifis0Y4vv/UMHhlOjYYI3yhUtKybYH8qvFUsq92YnMAWg7PXOM7dLU3pw1noPgP9nBdQ5oQVFdYKYNI+0i+S2tEg8TuXf6nf4qURkIGjC72KC097EAc0XO0mZTmAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793968756; c=relaxed/relaxed;
	bh=ZxNISjiJdH1N8UCraJUsn6wM/XATiJ1CgmmvNLAwlRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMRhvhrh8w4ei6elNajAI9JqZyccEW56m4GmQhWQ7SDvAp3OZhoGlLFinMe0G/O0s2THmw2XLT3JWThzURNWwCaq7s+b7psiVTw3vrdQw52dT9EWn7tkVd9Kl9c1MS+uXu2o3V12U8od/xO6qOp1QCVMuo6/8535Wh+pBTNbcnobI7WGrKfEja8qcy3EUqGDRB4lz6vTAL8bmo0eDzO1j94KLQBqa542hSVjL5ZyaOkuMTeDUlFupN/RXDoGTZ9iK1N03eONh4/uZsHpr2jQKt+3b+0jFATKVe0YJGXkIyitcyTmvxconymm9G8/lIFEHZus9he8ebZY/QT/FBnw+A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bobcopeland.com; dkim=pass (2048-bit key; unprotected) header.d=bobcopeland-com.20260707.gappssmtp.com header.i=@bobcopeland-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=k0PBEA+3; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com; envelope-from=me@bobcopeland.com; receiver=lists.ozlabs.org) smtp.mailfrom=bobcopeland.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bobcopeland.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bobcopeland-com.20260707.gappssmtp.com header.i=@bobcopeland-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=k0PBEA+3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bobcopeland.com (client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com; envelope-from=me@bobcopeland.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com [IPv6:2607:f8b0:4864:20::b135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLdz71GvMz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 23:39:15 +1100 (AEDT)
Received: by mail-yx1-xb135.google.com with SMTP id 956f58d0204a3-67bef25eb92so717433d50.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 04:39:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793968752; cv=none;
        d=google.com; s=arc-20260327;
        b=kmtRVY1tk4U7CL+lk4FWKUCapXM414kU07f6XzacVWyiER9vvr6f5DUv6CcR2ESAh4
         Dr1uoyOaxDy9f+WUH3m6RGHcUX1BRqO5z8WWQmz0AihOz/ggECeK5n6VuE+gfnoCqjXe
         BBJT34XWAujddkjLASPm1h/+T/681P1tMDHQ8CKQwHYXdFyM8piFmYQASe+K6PJycpGh
         RVl/qeLYmIw6bW42Gz/CEk7/gURY0aVk2qrJbjf4Q+AGL+6a8JDgB05Uj2XD0+YDSmXd
         0BQEPZVmZtS90+TEclcTRHWst3QLZUpjmwtx2e2tfl03BSHMA1ZwCOruMKxYuw85Oqgq
         /89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZxNISjiJdH1N8UCraJUsn6wM/XATiJ1CgmmvNLAwlRg=;
        fh=y8B5hBFfYlfURlabiy1ir/typ0vS4kywf0VxEwoRvSw=;
        b=lIj5bWAfXLuIN1HHeB3XySA91XUkuDa7e5Egw9j8M2fU3gHp7s6cPdwf8IwYS8fLb3
         ZKKOgzzWbi88wGQrm6y5kQVQQ7sva1RFJQX0iCE/KIbRiD59rktI/HClkmxxGMxY6ZaV
         cb3h9jleBMx/+fvjHSRkPVVdiem5n9R/8VZ8Fq8Agfu3oqwpbv+EY3/c+9xbU06MIqlO
         LeX32WGrBpLNjuv76GoejQJNjw9VZA0d085J0ZegftDO2JfpW4aoMHuQC3FzYiB0Mcwf
         QGMJjBV1AqLH7TuXNB7fuplZAM8conlUlv4Uk/ERBTa/Bk2N0epqsqWtB4S/OFoNJxry
         ZsMA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20260707.gappssmtp.com; s=20260707; t=1793968752; x=1794573552; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZxNISjiJdH1N8UCraJUsn6wM/XATiJ1CgmmvNLAwlRg=;
        b=k0PBEA+34pqijjgtOZ4A2JpttlOXRrirYrNtJ6tMMqTDplI/XSL6TBYzEs+aHsot+P
         JJXLkeoaEYO2/pL0Pa+oe9nI5KCQRk8OHqjE4GpyxCBvbRLaqbrimVjGe2qy/id4x+3r
         kbEAF0Era/b1hsO28S5gLRIdCAWNE6z6E1BFfll/nEylZM9otqMLU/F6Y38hULcHm8eO
         kJ6lap0u4PwoNDaRFluKHnxejsISlYPFD25I8M/7aXLEUqqcIf19jeGPDknXiUbT7nsR
         SZXaUnr9CSiikcCHz/FHCoRvdF3L4qqbAzGDYVAsQQwItOcqygseDxix2b1nJ52LxMjp
         nrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793968752; x=1794573552;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZxNISjiJdH1N8UCraJUsn6wM/XATiJ1CgmmvNLAwlRg=;
        b=gdR3ShM9DAZK5IgCpqcDbGekcjGLjoPUvhPlLZnIJbSoTG0CCfQzp0UvGM0QAmy1kC
         OQcTrYrJxr3KbZvpcG1SCJYZtFZct/lPFn4arGTE5s1P+LPF0bAQiw1tS/B/N7901Ti2
         r3chcPxDUhdyEgJxftgB3fqmaBeq7KxVDzaseFQlHg5syumch8VQIHNjBBlD0QqChr23
         K4k+8adq0frv3ccbTs72hwyIaF88qM2v8igyV5BvlEtfN689MtLe/0XIVqFE02tRLsz0
         iQOcVqpmvpplCBXDmTjro0fMcuq5aBQqfS16GdclDqHMfcy2BAqCnupNqEUlGIS5TrRK
         h5uA==
X-Forwarded-Encrypted: i=1; AL+hErG8h/+vZ+w/9+Wr1xS19/B8tObUCY9MzV4Kdoomb9IwEan7vJdfqaBWX1LiYz/lMMhAjAiFlHyBmDyDh6s=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/KNDx2dSkP77cu4TEPjhrl276l/DaN6q1KINArjanrYBwKrUka
	RPSpgQCH5xflujWax9Glv3rjkOS6m0IcI1IC3s984kGEExpJNp59J+MmCZvsAji8d+DAz8J9876
	2WUT1k08xNkNFof12nvSxkTiWKcPPaT2Re3XbbGELEA==
X-Gm-Gg: AYBFou3O/Ql1dyP8Yy0DGRfLC7JyVEwnQq+eGIGNQXMboe2ADF0U2rlclUkN7HfkHEI
	vaN4PNq72gieKb66/1uJY4EKTPxFZ7RAe9TNAM48PYNhGUCxn8jND7lGtQTVG5XpLNPdZ0uuWuH
	FtZmTOhO26QL92TM5zkmPwbaRiLsRAP0zyyBVsEK4Lqcgsbam17lvjf0o8ugdxT/HO3Pv8O79Kw
	REzSPTKbVsTU0QHG0RBNNVDeoTS7cMzPOpu83vQKaQ7uZFRObyKC6A6wxEV56nrVFEClR1js177
	MW0JV5/osoiHtTuZ7iFmW1x6Yf+1H3DkNS1OSQtUW/Wx2QA+uEKRYQJrdy2BgNnfd2nTm6ZZjli
	0S2r4zEN8jFPPw/U3igorxyFht0U5TV24EuLI
X-Received: by 2002:a05:690e:138f:b0:67c:1cb5:53ac with SMTP id
 956f58d0204a3-67c1cb55c1cmr557385d50.20.1793968752298; Fri, 06 Nov 2026
 04:39:12 -0800 (PST)
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
References: <20261105044046.52180-1-dennylin0707@gmail.com> <20261106-vortrag-exotisch-pelzmantel-66235662f81f@brauner>
In-Reply-To: <20261106-vortrag-exotisch-pelzmantel-66235662f81f@brauner>
From: Bob Copeland <me@bobcopeland.com>
Date: Fri, 6 Nov 2026 07:39:02 -0500
X-Gm-Features: AclHuK_U-FH1rUc5FpGMB4Ukprhh_KPYehEm6vL6pH0GiiOv8bZqRy92Jig1sWE
Message-ID: <CAB4u3sVuyGZ2+mhDOdO-+xRbfF0ZjUmjZDL7k4q08AWb5Ngc0Q@mail.gmail.com>
Subject: Re: [PATCH] omfs: remove the filesystem
To: Christian Brauner <brauner@kernel.org>
Cc: Hungyu Lin <dennylin0707@gmail.com>, willy@infradead.org, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, akpm@linux-foundation.org, 
	Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org, geert@linux-m68k.org, 
	tsbogend@alpha.franken.de, maddy@linux.ibm.com, 
	"open list:OMFS FILESYSTEM" <linux-karma-devel@lists.sourceforge.net>, linux-fsdevel@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000003820c7065f9ae6fc"
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000003820c7065f9ae6fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Bob Copeland <me@bobcopeland.com>

Thank you!

On Fri, Nov 6, 2026, 4:28=E2=80=AFa.m. Christian Brauner <brauner@kernel.or=
g> wrote:

> On Thu, 05 Nov 2026 04:40:45 +0000, Hungyu Lin wrote:
> > OMFS supports the on-disk format used by the long-discontinued Rio Karm=
a
> > music player and ReplayTV DVR. While reviewing a fix for incorrect bloc=
k
> > mapping on writes starting beyond EOF, Matthew suggested removing the
> > filesystem instead of continuing to maintain it.
> >
> > Existing OMFS media can still be accessed using an older kernel with OM=
FS
> > support.
> >
> > [...]
>
> I agree. It's great to see that we are are able to shed a whole bunch of
> legacy tech.
>
> ---
>
> Applied to the vfs-7.5.omfs branch of the vfs/vfs.git tree.
> Patches in the vfs-7.5.omfs branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.5.omfs
>
> [1/1] omfs: remove the filesystem
>       https://git.kernel.org/vfs/vfs/c/b4d257187fe7
>

--0000000000003820c7065f9ae6fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Acked-by: Bob Copeland &lt;<a href=3D"mailto:me@bobcopela=
nd.com">me@bobcopeland.com</a>&gt;<div dir=3D"auto"><br></div><div dir=3D"a=
uto">Thank you!</div></div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 6, 2026, 4:28=E2=80=
=AFa.m. Christian Brauner &lt;<a href=3D"mailto:brauner@kernel.org">brauner=
@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, =
05 Nov 2026 04:40:45 +0000, Hungyu Lin wrote:<br>
&gt; OMFS supports the on-disk format used by the long-discontinued Rio Kar=
ma<br>
&gt; music player and ReplayTV DVR. While reviewing a fix for incorrect blo=
ck<br>
&gt; mapping on writes starting beyond EOF, Matthew suggested removing the<=
br>
&gt; filesystem instead of continuing to maintain it.<br>
&gt; <br>
&gt; Existing OMFS media can still be accessed using an older kernel with O=
MFS<br>
&gt; support.<br>
&gt; <br>
&gt; [...]<br>
<br>
I agree. It&#39;s great to see that we are are able to shed a whole bunch o=
f<br>
legacy tech.<br>
<br>
---<br>
<br>
Applied to the vfs-7.5.omfs branch of the vfs/vfs.git tree.<br>
Patches in the vfs-7.5.omfs branch should appear in linux-next soon.<br>
<br>
Please report any outstanding bugs that were missed during review in a<br>
new review to the original patch series allowing us to drop it.<br>
<br>
It&#39;s encouraged to provide Acked-bys and Reviewed-bys even though the<b=
r>
patch has now been applied. If possible patch trailers will be updated.<br>
<br>
Note that commit hashes shown below are subject to change due to rebase,<br=
>
trailer updates or similar. If in doubt, please check the listed branch.<br=
>
<br>
tree:=C2=A0 =C2=A0<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/gi=
t/vfs/vfs.git" rel=3D"noreferrer noreferrer" target=3D"_blank">https://git.=
kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git</a><br>
branch: vfs-7.5.omfs<br>
<br>
[1/1] omfs: remove the filesystem<br>
=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/vfs/vfs/c/b4d257187f=
e7" rel=3D"noreferrer noreferrer" target=3D"_blank">https://git.kernel.org/=
vfs/vfs/c/b4d257187fe7</a><br>
</blockquote></div>

--0000000000003820c7065f9ae6fc--


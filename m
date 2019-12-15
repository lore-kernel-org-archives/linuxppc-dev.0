Return-Path: <SRS0=g46S=2F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516F9C43603
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Dec 2019 17:44:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD8E206D8
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Dec 2019 17:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWFc+tty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD8E206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47bWxz29cbzDqcG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 04:44:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::143;
 helo=mail-lf1-x143.google.com; envelope-from=alexei.starovoitov@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="vWFc+tty"; 
 dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47bWvd6DpXzDqXl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2019 04:42:50 +1100 (AEDT)
Received: by mail-lf1-x143.google.com with SMTP id f15so2568969lfl.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2019 09:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AUhydgvmr8d296EsM44KLtz5TapZKISR8Mk06Hsxmpw=;
 b=vWFc+ttySOUZBiFE/iWiSppbkP+sqNfBnoBw/J2iL3Hqn4Drlz+PSTvTjKoeD10YhC
 3csWHOkn+ooTHB0Jf6yLQJCRuUnfL7HGatXc6autez33cqhB0FG6joQQjnyuN1zZJFGO
 VG4xGVjI4NnpO0FY7fiXhS4h36Qs+khbbqtW69dIboGFkTPAq9zuqXv62BUVzmnNk7Lf
 ZFHXyQB/piXa+EiXO3wHJnIvjaWy9jG51X1lCbYn2X+UtjRLoFexDBIzDU5O+LCOpoCC
 OWCDq8F+YucbIjVP8gEqkdbDg+eLOrU6jF9oyLsXSM5uKOK+/xa2gQdTWCnwFrObtfuY
 ScZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AUhydgvmr8d296EsM44KLtz5TapZKISR8Mk06Hsxmpw=;
 b=fNCy7uycO05MqE6j6JgSIdzcFAjEK+wql8TDsKEfVLhq0vLdKsp0HqfnOY8lKK5Jdx
 bZoNPVWMUuUzgxmcfo15KT1KfO3DI3WJhG6YgRI8qa/kzTpP4tNqQsgMdjBU071NA25m
 MTvaXo9Q0ZWS8xlbaW9M+SPZAZ0sraBLhWfN7CZKJJEX8rIgBf/dVKAgU8b3lj37Xdu0
 PTtKdVS5xumrEMHIFvM7MnAv+mtEySlHoFdfUBr5CYCb3ZlYuThkPs6ZSPb7sxHq1bzp
 lc6oLTkwG0ewOcQ8Ahl3nj2nBDcsS+APaEueeelJoSeE17itFqLMq1hTGh9SjwSSgyM7
 nLlQ==
X-Gm-Message-State: APjAAAWarHI4LsOM0me/jmK+SXhtBBrn9Szdm8e1iDtWIt5uv2XFWkWy
 IJ1r3n4inkENUY2YHTdOoOreXcUhucCqGGZ1Dws=
X-Google-Smtp-Source: APXvYqxB9j2tqO8U7z+jhYOK+V++KM2dx+C8P8/kFICH+Gwd/b/A8Evh9Z1mIuzX8BRExtjVm/sbfnpJEeelvLvd5H8=
X-Received: by 2002:a19:48c5:: with SMTP id
 v188mr14502104lfa.100.1576431765980; 
 Sun, 15 Dec 2019 09:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20191201195728.4161537-1-aurelien@aurel32.net>
 <87zhgbe0ix.fsf@mpe.ellerman.id.au>
 <20191202093752.GA1535@localhost.localdomain>
 <CAFxkdAqg6RaGbRrNN3e_nHfHFR-xxzZgjhi5AnppTxxwdg0VyQ@mail.gmail.com>
 <20191210222553.GA4580@calabresa>
 <CAFxkdAp6Up0qSyp0sH0O1yD+5W3LvY-+-iniBrorcz2pMV+y-g@mail.gmail.com>
 <20191211160133.GB4580@calabresa>
 <CAFxkdAp9OGjJS1Sdny+TiG2+zU4n0Nj+ZVrZt5J6iVsS_zqqcw@mail.gmail.com>
 <20191213101114.GA3986@calabresa>
 <CAEf4BzY-JP+vYNjwShhgMs6sJ+Bdqc8FEd19BVf8uf+jSnX1Jw@mail.gmail.com>
In-Reply-To: <CAEf4BzY-JP+vYNjwShhgMs6sJ+Bdqc8FEd19BVf8uf+jSnX1Jw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 15 Dec 2019 09:42:34 -0800
Message-ID: <CAADnVQJY+URQfAk=372TUqVkB4dxNPqNVY8-eSe7mFXuY_XhRA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix readelf output parsing for Fedora
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
 Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 "open list:BPF \(Safe dynamic programs and tools\)" <netdev@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Justin Forbes <jmforbes@linuxtx.org>,
 Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Yonghong Song <yhs@fb.com>,
 "open list:BPF \(Safe dynamic programs and tools\)" <bpf@vger.kernel.org>,
 Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Aurelien Jarno <aurelien@aurel32.net>, debian-kernel@lists.debian.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 13, 2019 at 9:02 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 13, 2019 at 2:11 AM Thadeu Lima de Souza Cascardo
> <cascardo@canonical.com> wrote:
> >
> > Fedora binutils has been patched to show "other info" for a symbol at the
> > end of the line. This was done in order to support unmaintained scripts
> > that would break with the extra info. [1]
> >
> > [1] https://src.fedoraproject.org/rpms/binutils/c/b8265c46f7ddae23a792ee8306fbaaeacba83bf8
> >
> > This in turn has been done to fix the build of ruby, because of checksec.
> > [2] Thanks Michael Ellerman for the pointer.
> >
> > [2] https://bugzilla.redhat.com/show_bug.cgi?id=1479302
> >
> > As libbpf Makefile is not unmaintained, we can simply deal with either
> > output format, by just removing the "other info" field, as it always comes
> > inside brackets.
> >
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Fixes: 3464afdf11f9 (libbpf: Fix readelf output parsing on powerpc with recent binutils)
> > Reported-by: Justin Forbes <jmforbes@linuxtx.org>
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > ---
>
> I was briefly playing with it and trying to make it use nm to dump
> symbols, instead of parsing more human-oriented output of readelf, but
> somehow nm doesn't output symbols with @@LIBBPF.* suffix at the end,
> so I just gave up. So I think this one is good.
>
> This should go through bpf-next tree.
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks

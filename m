Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE88C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 10:06:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847E72082F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 10:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TF2ylQHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847E72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fjXB5lKczDqQN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 21:06:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="TF2ylQHQ"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fjTx5ktTzDqVQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 21:04:05 +1100 (AEDT)
Received: by mail-it1-x142.google.com with SMTP id c9so1938151itj.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 02:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1rZmRkYrQKk3sCyEFFu33/UQOzqgS6+8CGeODCvYF/s=;
 b=TF2ylQHQEd5iJSoMu3xW3NRRnQg0nLYymB0YSGlvJyLWjfZEN+1R0SvUAjR3hr3gov
 LE3Bys85UGMon+7lUvmZdB4Zy3zB+9SjOk7TNeynbZX9KgegPPTlSKEJqGFU4eNJBF+E
 0ND+IccUodxtSVBIrEQGYOW+x96X97fHNmyidOlv2zX5EpV5ZdOYtNYmhdHXrmJb0fyk
 iCG4MFql60DSCyCy3ylU1QIrIgfd9DZ9gLwxwh1qEwmpricyEPND87Pk3d3N1Y82cB6f
 mgX3egvRkAQiTqalnc/71+66GrUv9OKvfNVfl7rPqYCPrDSicoMogDMj+b+UN6sVOoez
 xMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1rZmRkYrQKk3sCyEFFu33/UQOzqgS6+8CGeODCvYF/s=;
 b=Ql0XZ8h4k0Vc4LDYfoaiNcviWoNV+rex761W0o8erSnUtKIJ1uvpAAPnEsXfP60yZy
 b0++jhWHTgpoDCXtMRZDRVFRWl+uwCgg/zOgf1AimCTyRbrrGHpXNFn1Hm9z13PrsTmL
 oAlXJZytYY3l4FSmbF8IzuX+rh/UZebIWEK7sUG3RtbeeU+mfliGguueD9T/+m3VSoge
 ocVSnIvempPD81G1Qb51tonPCIl2FxeeUZh7iXJN9ZLxyG+QwGGmEJPcA1ZvgfeGPXB/
 3iHxmbrEuJqCKh52f23jOfYQaJs7LQO6WwLdKlD2UUxOjnR5yscDtKs64v4gTnRG3IIm
 +ZGQ==
X-Gm-Message-State: AJcUukeM0HcZKDd5qbSIVAl3BrDVzKHPyhkrbz9ODpVHZD82KlP8CGZJ
 NhleQo5HqL0E5JBzcYgQeiHrStsvaHsOWlTOz7eSxg==
X-Google-Smtp-Source: ALg8bN6OfhZJYhHBs6jSF+6r2V38ZHVwZbvkgMhXsfwfH93O7RWmpMbG6jFEQjktwPrJ6siIxoaEwAd7AdV06eEQVpU=
X-Received: by 2002:a24:6511:: with SMTP id u17mr5175695itb.12.1547633043176; 
 Wed, 16 Jan 2019 02:04:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547289808.git.christophe.leroy@c-s.fr>
 <0c854dd6b110ac2b81ef1681f6e097f59f84af8b.1547289808.git.christophe.leroy@c-s.fr>
 <CACT4Y+aEsLWqhJmXETNsGtKdbfHDFL1NF8ofv3KwvQPraXdFyw@mail.gmail.com>
 <801c7d58-417d-1e65-68a0-b8cf02f9f956@c-s.fr>
 <CACT4Y+ZdA-w5OeebZg3PYPB+BX5wDxw_DxNe2==VJfbpy2eJ7A@mail.gmail.com>
 <330696c0-90c6-27de-5eb3-4da2159fdfbc@virtuozzo.com>
 <CACT4Y+ajgTdDyFFWCp0oRSPKZh9ercDpq3pAq2-ZSx7ouAvZYQ@mail.gmail.com>
 <301f5826-64ab-1cf4-7e7e-cd026de77bca@c-s.fr>
In-Reply-To: <301f5826-64ab-1cf4-7e7e-cd026de77bca@c-s.fr>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 16 Jan 2019 11:03:51 +0100
Message-ID: <CACT4Y+aPsrfaY94tiYGwAUifeLJK3gobMk2Cq=6s_29RWvFZ3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] powerpc/mm: prepare kernel for KAsan on PPC32
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 kasan-dev <kasan-dev@googlegroups.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 15, 2019 at 6:25 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Le 15/01/2019 =C3=A0 18:10, Dmitry Vyukov a =C3=A9crit :
> > On Tue, Jan 15, 2019 at 6:06 PM Andrey Ryabinin <aryabinin@virtuozzo.co=
m> wrote:
> >>
> >> On 1/15/19 2:14 PM, Dmitry Vyukov wrote:
> >>> On Tue, Jan 15, 2019 at 8:27 AM Christophe Leroy
> >>> <christophe.leroy@c-s.fr> wrote:
> >>>> On 01/14/2019 09:34 AM, Dmitry Vyukov wrote:
> >>>>> On Sat, Jan 12, 2019 at 12:16 PM Christophe Leroy
> >>>>> <christophe.leroy@c-s.fr> wrote:
> >>>>> &gt;
> >>>>> &gt; In kernel/cputable.c, explicitly use memcpy() in order
> >>>>> &gt; to allow GCC to replace it with __memcpy() when KASAN is
> >>>>> &gt; selected.
> >>>>> &gt;
> >>>>> &gt; Since commit 400c47d81ca38 ("powerpc32: memset: only use dcbz =
once cache is
> >>>>> &gt; enabled"), memset() can be used before activation of the cache=
,
> >>>>> &gt; so no need to use memset_io() for zeroing the BSS.
> >>>>> &gt;
> >>>>> &gt; Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>>>> &gt; ---
> >>>>> &gt;  arch/powerpc/kernel/cputable.c | 4 ++--
> >>>>> &gt;  arch/powerpc/kernel/setup_32.c | 6 ++----
> >>>>> &gt;  2 files changed, 4 insertions(+), 6 deletions(-)
> >>>>> &gt;
> >>>>> &gt; diff --git a/arch/powerpc/kernel/cputable.c
> >>>>> b/arch/powerpc/kernel/cputable.c
> >>>>> &gt; index 1eab54bc6ee9..84814c8d1bcb 100644
> >>>>> &gt; --- a/arch/powerpc/kernel/cputable.c
> >>>>> &gt; +++ b/arch/powerpc/kernel/cputable.c
> >>>>> &gt; @@ -2147,7 +2147,7 @@ void __init set_cur_cpu_spec(struct cpu_=
spec *s)
> >>>>> &gt;         struct cpu_spec *t =3D &amp;the_cpu_spec;
> >>>>> &gt;
> >>>>> &gt;         t =3D PTRRELOC(t);
> >>>>> &gt; -       *t =3D *s;
> >>>>> &gt; +       memcpy(t, s, sizeof(*t));
> >>>>>
> >>>>> Hi Christophe,
> >>>>>
> >>>>> I understand why you are doing this, but this looks a bit fragile a=
nd
> >>>>> non-scalable. This may not work with the next version of compiler,
> >>>>> just different than yours version of compiler, clang, etc.
> >>>>
> >>>> My felling would be that this change makes it more solid.
> >>>>
> >>>> My understanding is that when you do *t =3D *s, the compiler can use
> >>>> whatever way it wants to do the copy.
> >>>> When you do memcpy(), you ensure it will do it that way and not anot=
her
> >>>> way, don't you ?
> >>>
> >>> It makes this single line more deterministic wrt code-gen (though,
> >>> strictly saying compiler can turn memcpy back into inlines
> >>> instructions, it knows memcpy semantics anyway).
> >>> But the problem I meant is that the set of places that are subject to
> >>> this problem is not deterministic. So if we go with this solution,
> >>> after this change it's in the status "works on your machine" and we
> >>> either need to commit to not using struct copies and zeroing
> >>> throughout kernel code or potentially have a long tail of other
> >>> similar cases, and since they can be triggered by another compiler
> >>> version, we may need to backport these changes to previous releases
> >>> too. Whereas if we would go with compiler flags, it would prevent the
> >>> problem in all current and future places and with other past/future
> >>> versions of compilers.
> >>>
> >>
> >> The patch will work for any compiler. The point of this patch is to ma=
ke
> >> memcpy() visible to the preprocessor which will replace it with __memc=
py().
> >
> > For this single line, yes. But it does not mean that KASAN will work.
> >
> >> After preprocessor's work, compiler will see just __memcpy() call here=
.
>
> This problem can affect any arch I believe. Maybe the 'solution' would
> be to run a generic script similar to
> arch/powerpc/kernel/prom_init_check.sh on all objects compiled with
> KASAN_SANITIZE_object.o :=3D n don't include any reference to memcpy()
> memset() or memmove() ?


We do this when building user-space sanitizers runtime. There all code
always runs with sanitizer enabled, but at the same time must not be
instrumented. So we committed to changing all possible memcpy/memset
injection points and have a script that checks that we indeed have no
such calls at any paths. There problem is a bit simpler as we don't
have gazillion combinations of configs and the runtime is usually
self-hosted (as it is bundled with compiler), so we know what compiler
is used to build it. And that all is checked on CI.
I don't know how much work it is to do the same for kernel, though.
Adding -ffreestanding, if worked, looked like a cheap option to
achieve the same.

Another option is to insert checks into KASAN's memcpy/memset that at
least some early init has completed. If early init hasn't finished
yet, then they could skip all additional work besides just doing
memcpy/memset. We can't afford this for memory access instrumentation
for performance reasons, but it should be bearable for memcpy/memset.

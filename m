Return-Path: <SRS0=mwa9=N5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B83C43441
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 15:57:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81092080C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 15:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4YH+vLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81092080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42yc7P3sF6zF3W2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 02:57:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U4YH+vLZ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="U4YH+vLZ"; 
 dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yc4c2396zF3Tp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 02:55:28 +1100 (AEDT)
Received: by mail-io1-xd42.google.com with SMTP id m1-v6so9688068ioc.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 07:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LVpHVlN8yMb+8QBmHy6R38Io2Rvx7iOnFnXQ1i2RcB0=;
 b=U4YH+vLZlLB+8Lk1fLwwL9SqcRVKdWwEYNRWI29Tc2kuUJ6m4LvNFoAYY88XZbezRI
 jL+Uj+gZ15vaSPqfe1C5w38l7H/tUnQhdPqsTe5oC8bnov+61JhICme1/RWg1ppqNiZI
 ziqrJ5EiU8nbt66gD7FcGQ/P+iO/KFV8ZVSec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LVpHVlN8yMb+8QBmHy6R38Io2Rvx7iOnFnXQ1i2RcB0=;
 b=fAeDzAO+3rjhtPKSPfRWmHw4oaj7LBm2eG8AHsI1UHl5MDsvE7zshn8sKab9gMTDjq
 nvQvzyE8IIaZt3gtCB4b9uM5EIUc8HhuGZoR5cM0DSyVqI2wU6FscX8RzxLr9kY4KfS1
 72TjDl12tLlhcH9w1F/l+5Du2pp9lSrZvI9/jaMs2/58z3vM5uSlReYyvCK33uPVxpVz
 paKjlI2/JdyIKU+k8rTLgQpqm4FKOg38ACF3hIBuyFHRGtd/ycbcPMkPVxraKvh+xptL
 BxXGVVzuHq6dCHP/63pjd8w38SUvOm5E3vyQUX0tj0HW84cwRZpik83gtFywkz6P8H57
 9APg==
X-Gm-Message-State: AGRZ1gIipZ5lCnwppa4TPmTK/ksGMLhcQof7kvWj1zdT4FO2W8l3RXUj
 9ChX2Z/x1LmBO8ARlxW4fjaTULmQtTVuFeu0KWDcOQ==
X-Google-Smtp-Source: AFSGD/VNKyUsHCOcVEU25YMknGotPrNhpWyqf/fQRCqaqAvE2Nbcuc3zJbxkUkBaiT2Ul2zjAYDD4rvDQg2QpnI523o=
X-Received: by 2002:a6b:37c2:: with SMTP id
 e185-v6mr15113497ioa.173.1542556525869; 
 Sun, 18 Nov 2018 07:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-3-ard.biesheuvel@linaro.org>
 <CAH3MdRV85imzia+=irgbjL48wqFdorB-F1=BkwBgJgi3Z-XAKA@mail.gmail.com>
In-Reply-To: <CAH3MdRV85imzia+=irgbjL48wqFdorB-F1=BkwBgJgi3Z-XAKA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 18 Nov 2018 07:55:14 -0800
Message-ID: <CAKv+Gu9hB3a5LfFQskNzXZDmgps_+9dewbC1E5GFndcQZ-KgQg@mail.gmail.com>
Subject: Re: [PATCH 2/4] net/bpf: refactor freeing of executable allocations
To: ys114321@gmail.com
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips <linux-mips@linux-mips.org>,
 Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Jann Horn <jannh@google.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Jessica Yu <jeyu@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 17 Nov 2018 at 23:47, Y Song <ys114321@gmail.com> wrote:
>
> On Sat, Nov 17, 2018 at 6:58 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > All arch overrides of the __weak bpf_jit_free() amount to the same
> > thing: the allocated memory was never mapped read-only, and so
> > it does not have to be remapped to read-write before being freed.
> >
> > So in preparation of permitting arches to serve allocations for BPF
> > JIT programs from other regions than the module region, refactor
> > the existing bpf_jit_free() implementations to use the shared code
> > where possible, and only specialize the remap and free operations.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/mips/net/bpf_jit.c           |  7 ++-----
> >  arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
> >  arch/powerpc/net/bpf_jit_comp64.c |  9 +++------
> >  arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
> >  kernel/bpf/core.c                 | 15 +++++----------
> >  5 files changed, 14 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> > index 1b69897274a1..5696bd7dccc7 100644
> > --- a/arch/mips/net/bpf_jit.c
> > +++ b/arch/mips/net/bpf_jit.c
> > @@ -1261,10 +1261,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
> >         kfree(ctx.offsets);
> >  }
> >
> > -void bpf_jit_free(struct bpf_prog *fp)
> > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       if (fp->jited)
> > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > -
> > -       bpf_prog_unlock_free(fp);
> > +       module_memfree(hdr);
> >  }
> > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > index a1ea1ea6b40d..5b5ce4a1b44b 100644
> > --- a/arch/powerpc/net/bpf_jit_comp.c
> > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > @@ -680,10 +680,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
> >         return;
> >  }
> >
> > -void bpf_jit_free(struct bpf_prog *fp)
> > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       if (fp->jited)
> > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > -
> > -       bpf_prog_unlock_free(fp);
> > +       module_memfree(hdr);
> >  }
> > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > index 84c8f013a6c6..f64f1294bd62 100644
> > --- a/arch/powerpc/net/bpf_jit_comp64.c
> > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > @@ -1021,11 +1021,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> >         return fp;
> >  }
> >
> > -/* Overriding bpf_jit_free() as we don't set images read-only. */
> > -void bpf_jit_free(struct bpf_prog *fp)
> > +/* Overriding bpf_jit_binary_free() as we don't set images read-only. */
> > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       if (fp->jited)
> > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > -
> > -       bpf_prog_unlock_free(fp);
> > +       module_memfree(hdr);
> >  }
> > diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
> > index 01bda6bc9e7f..589950d152cc 100644
> > --- a/arch/sparc/net/bpf_jit_comp_32.c
> > +++ b/arch/sparc/net/bpf_jit_comp_32.c
> > @@ -756,10 +756,7 @@ cond_branch:                       f_offset = addrs[i + filter[i].jf];
> >         return;
> >  }
> >
> > -void bpf_jit_free(struct bpf_prog *fp)
> > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       if (fp->jited)
> > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > -
> > -       bpf_prog_unlock_free(fp);
> > +       module_memfree(hdr);
> >  }
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 1a796e0799ec..29f766dac203 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -646,25 +646,20 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> >         return hdr;
> >  }
> >
> > -void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > +void __weak bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       u32 pages = hdr->pages;
> > -
> > +       bpf_jit_binary_unlock_ro(hdr);
> >         module_memfree(hdr);
> > -       bpf_jit_uncharge_modmem(pages);
> >  }
> >
> > -/* This symbol is only overridden by archs that have different
> > - * requirements than the usual eBPF JITs, f.e. when they only
> > - * implement cBPF JIT, do not set images read-only, etc.
> > - */
>
> Do you want to move the above comments to
> new weak function bpf_jit_binary_free?
>

Perhaps. But one thing I don't understand, looking at this again, is
why we have these overrides in the first place. module_memfree() just
calls vfree(), which takes down the mapping entirely (along with any
updated permissions), and so remapping it back to r/w right before
that seems rather pointless imo.

Can we get rid of bpf_jit_binary_unlock_ro() entirely, and along with
it, all these overrides for the free() path?

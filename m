Return-Path: <SRS0=mwa9=N5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3E2C43441
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 20:23:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41F620817
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 20:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz4lMIlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41F620817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42yk2L2Tm6zF3Vb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 07:23:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mz4lMIlp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com;
 envelope-from=ys114321@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mz4lMIlp"; 
 dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yjzN6pC6zF3Td
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 07:21:20 +1100 (AEDT)
Received: by mail-qk1-x743.google.com with SMTP id d135so45568303qkc.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 12:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hW3YpOwOV7MHavGct4c1SiC54gWbITC/Pd96cayi0Xo=;
 b=Mz4lMIlpVHPrP52pqhxBHmIIJ4hgw8GnEwiNYGL9FTgsYlTaDb3Vk0PYM4fez3uUGV
 xdNcj0BK4rvrhTPAWu0Et1hNBs72DLUoGccDSqE8QySAYKlCHGPfrC/Fp/4N9atMzXVO
 tUIiuWmO2PuJOmgLN5B65uirxEYZP5ku6Y4d/oQh4vywfXulcg76SQ07mEV3xoV/6yxE
 4T7mgH8uXXNpeUypktO5SG+LQWfWb75ZWfhWlzb6nR6SmBkpF6OcxaQISE1oQqvdxXlZ
 All2Oa+tCSFVsuGoA0i8BnyyCNb8y5rdv8aPBlPhG68tA47LEUiRkVLiGNy/hGhEaL2U
 ZQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hW3YpOwOV7MHavGct4c1SiC54gWbITC/Pd96cayi0Xo=;
 b=DkJUJvLPN4gqvDU7MZzGaGlEfsFx3kdYFZ/qFfKHDMQyroROqQUXUrbpJC0cWrGUv4
 PxMq/buwsJhkrxcaKCJWtNFKLqHdb5MnR60rBLoFFyt1A/KGkNt7jxUtExmQq5fGMRVJ
 jNzSlc2dxTVlGnvscXsU+A+XZQFb+IF6Vb9MndTnSpQxkxvPkXMZas27r+I4ZZdGFj5z
 r6NXSDFLDKHmWLm1pHpiCB1wSoDUSEkF+tqLg/gjySGst2yD7b7vBCBcNpmi1GvzQHik
 26T+gGyUZXF0LW1e5ViB6O+m+HvHLexadeD1Rt0DsxrkDg0C1vU4D/JJWyrildOnh8IP
 KFEg==
X-Gm-Message-State: AGRZ1gLgkLMnY8wDapv0Rw2Xg/22Cd6gGE1oxpiKwYVKVZNTnSzX1IUq
 xdqaNLFg+ppny/KNUwoqn6TNs/cqOVOmIHc8l2s=
X-Google-Smtp-Source: AJdET5e+E9tKQsv6QteVqWmONyPKJI3b322+yZsfi+VI3OF8i8PqtMNqOZiyc3Viy1Ej5ZqieDe4yfVxpbNIH3Udxl4=
X-Received: by 2002:a37:a4cf:: with SMTP id
 n198mr18400351qke.101.1542572478632; 
 Sun, 18 Nov 2018 12:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-3-ard.biesheuvel@linaro.org>
 <CAH3MdRV85imzia+=irgbjL48wqFdorB-F1=BkwBgJgi3Z-XAKA@mail.gmail.com>
 <CAKv+Gu9hB3a5LfFQskNzXZDmgps_+9dewbC1E5GFndcQZ-KgQg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9hB3a5LfFQskNzXZDmgps_+9dewbC1E5GFndcQZ-KgQg@mail.gmail.com>
From: Y Song <ys114321@gmail.com>
Date: Sun, 18 Nov 2018 20:20:41 +0000
Message-ID: <CAH3MdRXESr62o2XnQ0L7GGZRfM_GpbFpG2xmk93LDLL2es8y3A@mail.gmail.com>
Subject: Re: [PATCH 2/4] net/bpf: refactor freeing of executable allocations
To: ard.biesheuvel@linaro.org
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
Cc: mark.rutland@arm.com, linux-mips@linux-mips.org, will.deacon@arm.com,
 Alexei Starovoitov <ast@kernel.org>, paulus@samba.org,
 sparclinux@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 catalin.marinas@arm.com, jhogan@kernel.org, Kees Cook <keescook@chromium.org>,
 arnd@arndb.de, jannh@google.com, linux-arm-kernel@lists.infradead.org,
 eric.dumazet@gmail.com, netdev <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org, paul.burton@mips.com,
 jeyu@kernel.org, rick.p.edgecombe@intel.com, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Nov 18, 2018 at 3:55 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Sat, 17 Nov 2018 at 23:47, Y Song <ys114321@gmail.com> wrote:
> >
> > On Sat, Nov 17, 2018 at 6:58 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > All arch overrides of the __weak bpf_jit_free() amount to the same
> > > thing: the allocated memory was never mapped read-only, and so
> > > it does not have to be remapped to read-write before being freed.
> > >
> > > So in preparation of permitting arches to serve allocations for BPF
> > > JIT programs from other regions than the module region, refactor
> > > the existing bpf_jit_free() implementations to use the shared code
> > > where possible, and only specialize the remap and free operations.
> > >
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > ---
> > >  arch/mips/net/bpf_jit.c           |  7 ++-----
> > >  arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
> > >  arch/powerpc/net/bpf_jit_comp64.c |  9 +++------
> > >  arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
> > >  kernel/bpf/core.c                 | 15 +++++----------
> > >  5 files changed, 14 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> > > index 1b69897274a1..5696bd7dccc7 100644
> > > --- a/arch/mips/net/bpf_jit.c
> > > +++ b/arch/mips/net/bpf_jit.c
> > > @@ -1261,10 +1261,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
> > >         kfree(ctx.offsets);
> > >  }
> > >
> > > -void bpf_jit_free(struct bpf_prog *fp)
> > > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       if (fp->jited)
> > > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > > -
> > > -       bpf_prog_unlock_free(fp);
> > > +       module_memfree(hdr);
> > >  }
> > > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > > index a1ea1ea6b40d..5b5ce4a1b44b 100644
> > > --- a/arch/powerpc/net/bpf_jit_comp.c
> > > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > > @@ -680,10 +680,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
> > >         return;
> > >  }
> > >
> > > -void bpf_jit_free(struct bpf_prog *fp)
> > > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       if (fp->jited)
> > > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > > -
> > > -       bpf_prog_unlock_free(fp);
> > > +       module_memfree(hdr);
> > >  }
> > > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > > index 84c8f013a6c6..f64f1294bd62 100644
> > > --- a/arch/powerpc/net/bpf_jit_comp64.c
> > > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > > @@ -1021,11 +1021,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> > >         return fp;
> > >  }
> > >
> > > -/* Overriding bpf_jit_free() as we don't set images read-only. */
> > > -void bpf_jit_free(struct bpf_prog *fp)
> > > +/* Overriding bpf_jit_binary_free() as we don't set images read-only. */
> > > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       if (fp->jited)
> > > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > > -
> > > -       bpf_prog_unlock_free(fp);
> > > +       module_memfree(hdr);
> > >  }
> > > diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
> > > index 01bda6bc9e7f..589950d152cc 100644
> > > --- a/arch/sparc/net/bpf_jit_comp_32.c
> > > +++ b/arch/sparc/net/bpf_jit_comp_32.c
> > > @@ -756,10 +756,7 @@ cond_branch:                       f_offset = addrs[i + filter[i].jf];
> > >         return;
> > >  }
> > >
> > > -void bpf_jit_free(struct bpf_prog *fp)
> > > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       if (fp->jited)
> > > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > > -
> > > -       bpf_prog_unlock_free(fp);
> > > +       module_memfree(hdr);
> > >  }
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 1a796e0799ec..29f766dac203 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -646,25 +646,20 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> > >         return hdr;
> > >  }
> > >
> > > -void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > > +void __weak bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       u32 pages = hdr->pages;
> > > -
> > > +       bpf_jit_binary_unlock_ro(hdr);
> > >         module_memfree(hdr);
> > > -       bpf_jit_uncharge_modmem(pages);
> > >  }
> > >
> > > -/* This symbol is only overridden by archs that have different
> > > - * requirements than the usual eBPF JITs, f.e. when they only
> > > - * implement cBPF JIT, do not set images read-only, etc.
> > > - */
> >
> > Do you want to move the above comments to
> > new weak function bpf_jit_binary_free?
> >
>
> Perhaps. But one thing I don't understand, looking at this again, is
> why we have these overrides in the first place. module_memfree() just
> calls vfree(), which takes down the mapping entirely (along with any
> updated permissions), and so remapping it back to r/w right before
> that seems rather pointless imo.
>
> Can we get rid of bpf_jit_binary_unlock_ro() entirely, and along with
> it, all these overrides for the free() path?

Maybe based on current implementation. Just a pure speculation.
module_memfree() can be overwritten by arch specific implementation.
The intention could be restoring the allocated page to its original permission
just in case arch specific implementation of module_memfree()
does different thing than default vfee().

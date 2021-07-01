Return-Path: <SRS0=ZiU1=LZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE34C11F64
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 19:34:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DB86109D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 19:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DB86109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GG7gl0q6fz3bc4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 05:34:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=hAGVhOtS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::231;
 helo=mail-lj1-x231.google.com; envelope-from=alexei.starovoitov@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=hAGVhOtS; dkim-atps=neutral
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GG7gC5zFbz2yMb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jul 2021 05:33:42 +1000 (AEST)
Received: by mail-lj1-x231.google.com with SMTP id k21so10043416ljh.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jul 2021 12:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nkp8B00ycwJr9MIlQRc0VrwsdNbLkEalV2JxoBIwEz0=;
 b=hAGVhOtSg/gpltdMEXUH7u/TdN06+/KUI70LLleG9VZr2zCaYT0yVJGuqYN5emcmGQ
 S1RwGFtgtp8c5wps7I0GRfALoO06wdQir3NwXfRWPrI/ZDqVKjWSChai1Tv73xWK9bTY
 hgX19FBEtaWLGnsJ6NwFrQl+ffZzwXfxWo3vqVhZ42Ru7gbJS7wbDW/2XJEven5atHAF
 FCc+WWikubXyjhu8f43kmUkaLWpZexMlh8LRsuDJJdVZcIyYjEQ3G7hdGVtSz1vhE83M
 iA8CDTSgu4LrCUuHbdf5KdZKIYe8RSDGpO6zzd54vDvEb09pweGcnaDVeeYyHEDB4aN7
 xtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nkp8B00ycwJr9MIlQRc0VrwsdNbLkEalV2JxoBIwEz0=;
 b=eUiy1T/PSri5YFpqJ/A2F/NY1Vzzg+qjzUAr3ia4shgbYweekAc3h2REM2oAeRKwuN
 8JS9iRhy8HgciNN+oBPSuNGwdbJPUYoHpwFOrUDNcui2sCim9C3qh5YH1d4QNE+Mk5ub
 UhIF0T8+vPp2rjfaBi9pJNoq4S9gBGy9s7Geg0z4mYRE2NC2hEhGp4aTPkS2UsOAzUcD
 dmJy/5NDarn4ur45JYYTD5LTg+QzRj5kP0rG3XkJ1kW0hHfmzPGKdDhmCOv0R9L/07pl
 2g1DOQhkefT05nmDwOX1HXseMpsn0nHX35ipdDJX3jI66i1x3MCbPmdExc09Be8LCIv8
 hJCA==
X-Gm-Message-State: AOAM532f9JMTrU7Ggp9c7ciycZ07W1AOFcnfyTrYoxWPpQoxMgwo3vfk
 XY6h7NPNrwTK2HHfCp50YtP9jRJ9+jMKBkkYQKU=
X-Google-Smtp-Source: ABdhPJxWzd7M5N4IZjMNC6Y5HpL1QcTszjnUAVEUsh/eBDfR7LosgbQNZWM8+0OTKsInvg60ycJNB4Kqr3rF/IceMJo=
X-Received: by 2002:a2e:9146:: with SMTP id q6mr916447ljg.236.1625168019289;
 Thu, 01 Jul 2021 12:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
 <4117b430ffaa8cd7af042496f87fd7539e4f17fd.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
 <CAADnVQ+78iDs7N=8xA6BZVBnPx78Q-Ljp860nmb8cOq7V_6qtQ@mail.gmail.com>
 <1625167613.6vloxo7l3w.naveen@linux.ibm.com>
In-Reply-To: <1625167613.6vloxo7l3w.naveen@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 1 Jul 2021 12:33:27 -0700
Message-ID: <CAADnVQJQAb5LHSKw4nLPcHLz85qwBu2V7vy-4gTScHqc5tYykA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/bpf: Fix detecting BPF atomic instructions
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
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
Cc: Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@redhat.com>,
 Brendan Jackman <jackmanb@google.com>, bpf <bpf@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 1, 2021 at 12:32 PM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> Alexei Starovoitov wrote:
> > On Thu, Jul 1, 2021 at 8:09 AM Naveen N. Rao
> > <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >>
> >> Commit 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other
> >> atomics in .imm") converted BPF_XADD to BPF_ATOMIC and added a way to
> >> distinguish instructions based on the immediate field. Existing JIT
> >> implementations were updated to check for the immediate field and to
> >> reject programs utilizing anything more than BPF_ADD (such as BPF_FETCH)
> >> in the immediate field.
> >>
> >> However, the check added to powerpc64 JIT did not look at the correct
> >> BPF instruction. Due to this, such programs would be accepted and
> >> incorrectly JIT'ed resulting in soft lockups, as seen with the atomic
> >> bounds test. Fix this by looking at the correct immediate value.
> >>
> >> Fixes: 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other atomics in .imm")
> >> Reported-by: Jiri Olsa <jolsa@redhat.com>
> >> Tested-by: Jiri Olsa <jolsa@redhat.com>
> >> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> >> ---
> >> Hi Jiri,
> >> FYI: I made a small change in this patch -- using 'imm' directly, rather
> >> than insn[i].imm. I've still added your Tested-by since this shouldn't
> >> impact the fix in any way.
> >>
> >> - Naveen
> >
> > Excellent debugging! You guys are awesome.
>
> Thanks. Jiri and Brendan did the bulk of the work :)
>
> > How do you want this fix routed? via bpf tree?
>
> Michael has a few BPF patches queued up in powerpc tree for v5.14, so it
> might be easier to take these patches through the powerpc tree unless he
> feels otherwise. Michael?

Works for me. Thanks!

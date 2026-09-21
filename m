Return-Path: <linuxppc-dev+bounces-27861-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6006DC982E6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 16:25:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpT9037kWz2yfH;
	Tue, 22 Sep 2026 02:25:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:41::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790007908;
	cv=pass; b=HkrFrkUi0NgDP61nI2NBFFl7treL9eoUG+4Y1oaVFcGAz9Lfg/e/lsPGqIhXQisil/Hjt0q4ujKuv1hfZibKYmyoOXsYlFlFRgeg5aaun1ni8knRZw/WvFQoVtCdQRpzJPZpO+xpLkJ4rxozoflsH1BMQzZAFlEZnQHnCfm8ygfZRrni5woP0roQaBVINBLZ5Jm5WlrIIBceoeamIIfDdA2MhZwQub1WiIomdd4erLqJdp1tZxpGob0gMJl21f3+G8VvmrCD/5ucowutsdHM/kUgJMs9bz5tTvHN/WI0oewJSU08puQxU5nPYX/CVDc/vNQV2bKUrxotxYWUdlxIWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790007908; c=relaxed/relaxed;
	bh=FscOTKf6GX9LsYtYTRZ38iEWAQ8+A7NhnQp2GLbb0QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UreV+74sBGptj0TcAeRcq+81LBwF+M1nWToZJE0MWZZvf/vNATfCaahatXf9NKcWQYEsiG2UH0bFYT5/ow3Crzp6hlF9Fy4fGaXIZr6vraQmVict5k3FOfa3bnUB2o82rDdelnr3nAGbKm4J5+zPdOn+OxbWSkCopnayWHPbYIKtqcIf2OGARAsWh7WQaOGhHqqx2bZl9ipdMnYKBlpYh55NGWxRGbTq0ReNtqR8vxmxhBWjbqxLeRoU0bJd4y3xbBzTyONncQt15zgvbp//ykpEKj2qYSanj7vCUmfQ/fyJxKrsjAUdjvfvYjt7JshyRZ/eVqD6HohNgn0VkZbxcg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hNHMtzE8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hNHMtzE8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com [IPv6:2607:f8b0:4864:41::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpT8z1FBzz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 02:25:05 +1000 (AEST)
Received: by mail-yx2-x10.google.com with SMTP id 956f58d0204a3-67109935888so3091353d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 09:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790007903; cv=none;
        d=google.com; s=arc-20260327;
        b=b3MlaZxG+G9o8AGG9kkqlH9E1EbGNYVA/jJraQl2lM8GZLCldgtZ0/mfZ9ihq3EPJQ
         3u1hIKf2bpJY22zB7NSnHkidPWUZvsDpQxsognQH5A507djNWku7NfqgZvMKsRwfrVrB
         UgSw4/gkg9j6uaGQs1u//pJ3faL3RG7g2FTdhpbibOfxHMobW806F/jCXP8fTXg4h1ov
         EEgD4D+TeaMx9TOF4ZC/hnQ1ZDJT3IgpnRr+eU7BGCWj7XOpb3k31enVGnu5ug0P6bMa
         jdR7xpE6bhW6+CezqMCFRwR5KEji3Jynqn6nO3pbxXz3CacSK3oslCRFDvzg1C5RQFNm
         uMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FscOTKf6GX9LsYtYTRZ38iEWAQ8+A7NhnQp2GLbb0QM=;
        fh=6F5uc0nDfm6BODUHKDVM9lZTMsS/uBgBFogMcR563bk=;
        b=YMwifH9LskBhVWnd8kAV2V4jZFa/G+I6I3eUo8S9tBZ8q3+2hQ/XUZxo+O/Y85SzSv
         mfthzkEhW/2Ukgy2X7L2JmFfSfMMIBXQmxhH6cV9kTuQMIDNA6znGtailo0/QZs+Ma35
         jfixeTqMt1PWbImtRYwh+oqHFt5UdYOgDpZnDySHG9qwMQSScXChCKrBO3DH8GPjwTDs
         IVGXY94/mccVygc5fVHRfQiZC1RzFW1Y7bS9u4yXD+liKYX7r6u7QEUfvSkS7+ME+kq4
         k5AjkwEaOU1XS6TLvVIrVTEm9sqTgdjllRvCtX2kdHOrDTzNq4B3+qIVScLlVTSDKtpz
         kNFg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790007903; x=1790612703; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FscOTKf6GX9LsYtYTRZ38iEWAQ8+A7NhnQp2GLbb0QM=;
        b=hNHMtzE8JvhQ7ffDSvYDdx/erWj7XWWV3TJkXLzFN+/3JgPodVrpNPhXXxNrrP1lA8
         kTjwlc9av5/H8ASJINFoT30zBJ6nFw8FJFPd0kQtzx9c3OH3SKfshQYU4WXncXTQhf5b
         LRloDRbFf5m7LmsN7eRrYkzGQkk+PsrXcX2QMmpyrUqFCHFgzVZuBNFpSKHYgJJFc8w+
         i6ycFs4Hx8CWyh22KnTsxXqFzc6cOTtsJZhxqgK5lrw4tylnrXhb4X038GsYHcw+W7Wv
         ZQOW3//M3w4+uLC5pUb8VEbo9XIA4qpDdC2sz9oH4uEgOMYIlaKr4IAIKSterSKhRoff
         weyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790007903; x=1790612703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FscOTKf6GX9LsYtYTRZ38iEWAQ8+A7NhnQp2GLbb0QM=;
        b=Um5/V9VVPNSVMu6wqui7DH1Yx0PYWVr9bGJawF49IHL9UW5tzPMue2WEGtEVm0vKxr
         qtNw8We0NtO3CjFx+65aJxpOo0HCmBThe6XPfKO/ParVGHqKvjANSOevh9aCg//a67bO
         R8SP1o8sCL/QXoz3DnLt9VlXLIf8vUnfAFx7ommjA75bG86arkdIhhLNeOJd8WULTur0
         B3dKymdVwL+8QsvhwHUEymePrCfQjZwHgaPauNZjak3+mjbPaNw8VEYnMKQ9yPpxdC63
         nVrEovYKMdNmMZ/+QEautCVxrRLPje/qGPa38XXCVBdj9cYNtCVUb9iRjuF7BKgsaHLL
         /2Vw==
X-Forwarded-Encrypted: i=1; AKwUvBzqtG8Xt3i40ebV1zW4NKo19Bf21RxhIzy3XBUtjzVcU0MDN9pvPG+BkbKhmPGNgGOsaC3Cc4Oy1/pWTew=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m1Z48UTg86qR7EQof6GzuPnFlYGp9oHOzrZvXAmbiQ6t0E79dw
	SnSpwkjnia9J8RBTS23pX2GNZDbkX+xIgv/uNPfWiR4lLwVvRHFi4d6JM9De5NderXOiTREHtUa
	DuvKnnwy3i73txcPlub/GCq/zZEvHe3U=
X-Gm-Gg: AYBFou3FcJOyiuQL9mbJciCz0MAcka1Ea0MNITyNl4NqUCUUuLg/XJa7t4PBwlax6H1
	W6yIdHrWkTel0aqH1CGaaPnBUDAaV/piOlk+3T5GJ5882YA53xO25TVSLLet75Pz29yKSk9DItM
	sWHd0OUbEsuD4SAp6mnnyaARtplCd27+aNQnI8Q/tymv98jkZrzQGHQ1iUWq/Mbc2BnJJ77i0Ho
	2RjEIyHIbOoVwKog+/UVgvX4ACFRwMr91iH0eCih4fr3f/Z89wvW+5AM8sHKYfQbcJXknoAEFnk
	BeLsPIH2MxDKzy1JI5DDbhnonfxilAkgstKyVBs6BTdzqvuk80tsS27qBLQ426YdAUlpgOF3jyp
	2MWg39etD7O8nfY9M53CQD4dl/E7wFY2opG1DAv9+k5avn2UFtwQcyfrE3OOuBz3DSRzrwmdiu+
	/59l+rcR9CoKQK+xifgIwPw3A=
X-Received: by 2002:a05:690e:c4e:b0:672:be40:5eaf with SMTP id
 956f58d0204a3-672be40629dmr713487d50.54.1790007902724; Mon, 21 Sep 2026
 09:25:02 -0700 (PDT)
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
References: <20260904195132.141068-1-sidchintamaneni@gmail.com> <DLKORFKGW8D8.XVSVVIH3Q6Q@gmail.com>
In-Reply-To: <DLKORFKGW8D8.XVSVVIH3Q6Q@gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 21 Sep 2026 09:24:51 -0700
X-Gm-Features: AcwNN1VSvI94aKmDMDlc9C_7_9UyySkBSsqPddt2OeIwAs5C5fHNExBLC9Hitxg
Message-ID: <CAE5sdEgLFFcsQ8rpraQ4L-EvppqxUn+=ZdHFgker2Wd--EGL6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/7] Fix timed may_goto with private stacks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-riscv@lists.infradead.org, rlmenge@gmail.com, 
	hargar@linux.microsoft.com, apais@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<SNIP>

> I think we can keep this fix local to x86. Would be less churn in the end=
.
>
> The problem is that x86 switches the BPF frame pointer from RBP to R9 for
> private stacks, but the trampoline still uses RBP. arm64 and powerpc64 ke=
ep
> using X25 and R31 respectively for both stack modes, so their trampolines
> already use the right frame pointer.
>
> Instead of changing the generic fixup, can we resolve the pointer in the =
x86 JIT
> when emitting the call to arch_bpf_timed_may_goto()? We already know whet=
her
> priv_frame_ptr is set there. R10 contains the offset passed through BPF_R=
EG_AX,
> so we can emit:
>
> /* Private stack */
> leaq (%r9, %r10), %r10
>
> /* Normal stack */
> leaq (%rbp, %r10), %r10
>
> Then remove the LEA from the x86 trampoline, as patch 2 already does.
>

make sense! I thought that the remaining arch's have a similar private
stacks approach to x86. I'll give it a try and re-spin the patch.

> This gives bpf_check_timed_may_goto() the same address used by the genera=
ted
> loads and stores: the BPF frame pointer plus the counter=E2=80=99s stack =
offset. For
> normal stacks, we just move the existing calculation into the JIT. For pr=
ivate
> stacks, we use R9 instead of RBP, which fixes the mismatch.
>
> The existing save/restore of R9 around the call should stay. We also leav=
e RBP
> alone, since it is still needed for the native frame chain and unwinding.
>
> I haven=E2=80=99t tested this approach, so it still needs checking with b=
oth normal and
> private stacks.
>
> pw-bot: cr
>
> > Siddharth Chintamaneni (7):
> >   bpf: Fix timed may_goto stack pointer for private stacks
> >   bpf, x86: Use resolved pointer for timed may_goto
> >   bpf, arm64: Use resolved pointer for timed may_goto
> >   bpf, powerpc64: Use resolved pointer for timed may_goto
> >   bpf, riscv: Use resolved pointer for timed may_goto
> >   bpf, s390: Use resolved pointer for timed may_goto
> >   selftests/bpf: Test timed may_goto with private stacks
> >
> >  arch/arm64/net/bpf_timed_may_goto.S           | 12 ++------
> >  arch/powerpc/net/bpf_timed_may_goto.S         |  8 ++---
> >  arch/riscv/net/bpf_timed_may_goto.S           | 13 ++++----
> >  arch/s390/net/bpf_jit_comp.c                  |  6 ++--
> >  arch/s390/net/bpf_timed_may_goto.S            |  8 ++---
> >  arch/x86/net/bpf_timed_may_goto.S             |  6 ----
> >  kernel/bpf/fixups.c                           | 19 ++++++------
> >  .../bpf/progs/verifier_bpf_fastcall.c         | 30 ++++++++++---------
> >  .../selftests/bpf/progs/verifier_may_goto_1.c | 17 ++++++-----
> >  .../bpf/progs/verifier_private_stack.c        | 19 ++++++++++++
> >  10 files changed, 75 insertions(+), 63 deletions(-)
> >
> >
> > base-commit: d761934c9483ecde93fe99d8705282f716dfee50
>


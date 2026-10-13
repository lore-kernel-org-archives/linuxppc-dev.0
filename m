Return-Path: <linuxppc-dev+bounces-29364-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D953ACA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 11:47:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3sxv56x1z3btl;
	Tue, 13 Oct 2026 22:46:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::833" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791892019;
	cv=pass; b=eH/DQ566IDMDRFXKEAa5oAOa2GDjY/akG3Gl7Vd3X34tereyt38/Cj2VNUSKOSx69m8HgKgcqB+ZSs9/7sSeosKtSJt7FLmgawHhCSddvnMI/B53+p/q/e/Y3CDvV74AwmkC0U9fg07GUmUCGrKSqiRMpOUWPAAS5lHY4QuC8R5H/X78u44sgWrRGgI7OmFdshQwJvh3LyKlSoWFNxi94yLsfBcRKDA7tlFMT/m7mufwXi7zAjVEqlT9eYJCDGlMWWAhRR2xWnZYzsLPBX4FjO868IuAZxlDyYVtB3wC2QqDl5aYLs1TIcBrfBQW66TCJurgfvchh2JxqbiMwmK49Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791892019; c=relaxed/relaxed;
	bh=e50qtwOpKMO/U4AtjtJKqyhM36icTenN92VD9AuVD+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfLnF3I+o4op8fmMvlFsmjeuMcz2HdU4/uXb/XaiBlulE3rZm5+gY8swEIeq039r2HzjCVksZEYfjTNB5Q2cPj1u1WM5oc1tvx/SNyZQ0MGw1wRgsr/wKUJh3qPOwW2gcLE2LqcDqVvP+ZAAx83zWs8fpgdTs8G2NJ8ZvQM0g0jTpXXegYwE0/VtNzknIVtsvU47VGI4qNzbCMc+yIDjEJgvgNOMQz7cZSp+ZzP0wjWZ4wV81uBhTq+WtfqM4dGq8cuqc1GwswbOU1MdeT87FVZex8mqXmGXj9BfyjoJoC4wfD4OdxQHGAyM3eD2cu94Ff0OS/HwApdj/utxGaFnVQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KOtU4bCG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KOtU4bCG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3sxt583nz3brm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 22:46:58 +1100 (AEDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-535f598d126so93291cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 04:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791892015; cv=none;
        d=google.com; s=arc-20260327;
        b=ZI337Y3ispOtPK+seYLr0iBHoSYKVX9N+RTXY9ZhMIRfVYaH2/uZFyq2OiJ5nuBIFs
         RjXUaID2S1ERG3ybMGx8VvRvNv172rnwT5RpqMj3UBjsOTrp/3yxPxlCOHD8qj3MiFzT
         qL8aLvWFMgsKA3ub5qMBHz0Kcfv0pQuUaiw+KCJb6cwbG1iZ+/FP4JQ8rdKUY2/YCtZD
         F0k7dTuiLI0qmJljTIRhsbsvWHbAbjCZ0U8yr3IPS96NK4LP2G9+1Q2QYD7+XaROcNfB
         KUFrlt4tZ9iwVjD/UzMf3hp6EPUIFHlQEZDT0SjQxEnOoeKb09XP8Qe82uhtL7tbIeoD
         h3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e50qtwOpKMO/U4AtjtJKqyhM36icTenN92VD9AuVD+g=;
        fh=WsDkZlAWUdwUk4jU6aRE2jPdtOSAFnxLxPMgcmTCGtM=;
        b=Nyq96Wx1dpy5CUoZUXMVlri8bfENBbUMnPZTBW5jNNgLnq8rzivRXh/FK++6ki+V6c
         V59kTaxoHSnIufatSa+qOyZy0xahWC0uWDfkFNRh0tunUmJQwpFUriyip31RWoHGOtKb
         W+Tcq+2yAwyHSi6Ys0myjaPX529v1pxeEsoqv/odC6prKywYx5EzSnPRJtXoxDqhQGw9
         SKOg3CSkfuUJkOazbIONivnoreJDoJ54t3zcV+b1qe5IlMZXlHEOc9+lcQqR73azprbz
         TtacK9Jr5wG6VLDEdlBGnVpkRKEdqnahmG0OPmG7Yz5bky63hQl8RxJHpC6Bi1gHvwtp
         2qmg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791892015; x=1792496815; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e50qtwOpKMO/U4AtjtJKqyhM36icTenN92VD9AuVD+g=;
        b=KOtU4bCGiz85MFiAEam00CDcHksxQrCzcx3X9Ch29lCFl1J7yx4/3eS0dP2EAAJ+1d
         0JsVGjFc0Zd1k/s906pi1qNT6FPW/pWgqXMN7McZwsyAyjabwKuKBosU+RzOVE6Tt9F7
         U9LATcZ2AHsKcTmN44Ldtn4iMxFpzb//ktt6z8KAp0QC8kQnHiAJV5I6eZVTdTQ8xLmg
         RU+s33CTYVN0mIB9zzalwm/UzebUGTmMa2QJEn6U6utV7/pTjhoXUoLZd1lWK9HEaQvA
         y/Pari8w2Scr90Ki7X3Eqq044T/up94RUB7UqnN4qC3cBQ3fyCX359SuSMsUpKywF2bg
         ugqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892015; x=1792496815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e50qtwOpKMO/U4AtjtJKqyhM36icTenN92VD9AuVD+g=;
        b=fesd/N0U9tNXBIvLvmqYtPzirWJeEITKBBWLnD4tVOFvYbd2zV3vXMxqKxjMxIu3DQ
         WWyG4eOAuOsJxM0g8eloaSsjlxZGXxSb/AvOEnLcrI2E5t8P6hRUabhpCoAAH+5/ZrOA
         QHEh8wCrHgouhCutDekeWF39GtRtOSEUzlbLIMA2Bvly6HBJiKHbR75JMyIrxG3ITYtg
         /SpRjc8uEyaCgbn8bTqEIfIUurmxTkI7J1RCoo9kTUgHDVcQ8esgYvnAiPRgT1M2Czvt
         PzB9G0c7GccA4vRh9JEdYGyWA03Ci/F7J8OELB+mz+yxZwg0M+41vVLBMpMqyZa5RVlf
         85VA==
X-Forwarded-Encrypted: i=1; AKwUvBx7+p9PXFLt3SNJ08hHyAFkWhq454rceeqiA7MFJv4AvmYWeeoSeTPc5KnYPXtEpWJHLoE24Wy9gfutnmQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIAAx5gsQV/WmG0RwjSdPao1dp+1AWxcgR2a4yw6cXMJkHVCKr9
	GhNGFJKxgvYdEZmajMviqoFbKSjvh53Mg5i4tGW+5GJ2X1odE6mIFuKiPqQlVEyJI1PZu75om06
	3gB/L3wWFxgYfDFNd/KOum8gDXuJIhZy0tYIjBDad
X-Gm-Gg: AYBFou06dwxqvcgi9IvTkzNQWGFlqp7TBO/ZNrmddy4zVYdFvVu574XL5n9R3T5AOod
	xjU6JnEMvyvu7dr1JIERQl+Fkdodu0FUpTUuD60FAl7n3pnvtBVZW+6nDQGJx2MU/7rMWpF4S3Y
	B250xl7O3uWw5hDaaOU4m83lLf/lN97WfskLRjWLC9IG8Yi+BFG/+Q0Pg3iM/HJTW1U7a1TXiyl
	MOtEXYb9doKlFjayXLp/762urBuVhnkT0NFfqzoQHCk7ydIBTjempnahROEB0fUb/I563EKK8Aa
	j64+SnQWICiV2M7oJBuenInS2CZClIWVtBcLPNvccNg9VaLYeXtTxjJXxBzd0HmOIT0=
X-Received: by 2002:a05:622a:345:b0:532:eff8:3491 with SMTP id
 d75a77b69052e-535b4f9b8d1mr44577431cf.14.1791892014742; Tue, 13 Oct 2026
 04:46:54 -0700 (PDT)
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
References: <20261009063619.112313-1-hao.ge@linux.dev> <20261009063619.112313-5-hao.ge@linux.dev>
In-Reply-To: <20261009063619.112313-5-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Oct 2026 15:46:43 +0400
X-Gm-Features: AclHuK-C9Oa0XUvUff-bHIAvSup9whOwQ_UowMIbXZJ1HaUMoBUz_0yhskfwzJI
Message-ID: <CAJuCfpGEgTocqrdpOtkOfks-geU0vVMZudNEG5+XWi3sxQdymQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] mm/percpu: stop unmapping the CPU that failed to map
To: Hao Ge <hao.ge@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Uladzislau Rezki <urezki@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 10:36=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> __pcpu_map_pages() clears the PTEs it installed when it fails, so
> pcpu_map_pages() only has to tear down the CPUs it mapped before
> the failing one.
>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  mm/percpu-vm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index 509d8901835c..59d3a336a6bd 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -252,10 +252,11 @@ static int pcpu_map_pages(struct pcpu_chunk *chunk,=
 struct page **pages,
>         return 0;
>  err:
>         for_each_possible_cpu(tcpu) {
> -               __pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_star=
t),
> -                                  page_end - page_start);
> +               /* The failing CPU's partial mapping undoes itself */
>                 if (tcpu =3D=3D cpu)
>                         break;
> +               __pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_star=
t),
> +                                  page_end - page_start);
>         }
>         pcpu_post_unmap_tlb_flush(chunk, page_start, page_end);
>         return err;
> --
> 2.25.1
>


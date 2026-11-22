Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA9606A320
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 04:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ckNxVt6U
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXFzz1zPHz2yQn;
	Sun, 22 Nov 2026 15:13:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795320799;
	cv=pass; b=S4MtkOq5iCUYgov+Nu7Vdi8Ddme2cXOvBPzBqqgy6s0wz9iVbRs5BYmWqVikSEv9w/mce3yenEWTKcvtpcOVTHmgvCUqGEOzh2Gi3kAc3gBDzNRMx6g57Y2O5pdYuhncYm466gMYmhA63xCgmJFQvhMTJoxXw3Nobyfvq40bb3stLZUO8xhpL3GYTvex+MDJ/jVdmuQJXwjgcVYkYI4VK6AvlRqoyV+2oVkOgvR0mJGb5IL0gd/QdSQg07kTa9+uHNk4AX1M3IZYwgOy2fK35i9R3qD/U88+vUQKgPJaji6mQZ+8dhw8k3uFdACc9R89ffBcFJUZxUdl1vOkHMWe7w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795320799; c=relaxed/relaxed;
	bh=5ljRHehwKpqXIEQjugVh5IB8G8Jh5NOSn1c67fpxeVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRMeCZ/hyKNlc/aSwIWQy3Rxw6aKRuMNpebGHdkuV7+9ECXQkqre2WmxTT0dhUHrEPxhjmc3SNMxiVOoG+vKZDfYp8AdYWe6zxaAYivdS6pCO4iLGc+18CQ+dUSj028v2edaXFTvdjyp4hPXRnAbCEKhoUfyMdj9TAL80juW4aZwCa3dTahPL0b8ExmNLOxDodPjFDFvC74LA4kXNTM8IPCeZFyHMtw6z/3LoYg3F+YE1bQjVOq6w5+9e1jI3Z/BEz48kPTTp+eJOR0tIPVmcA2OKrfosalLi3X39USfr9Un96FXS7h1/arfNmm3sbtPUpLM5CkXwmT0MMNZL92GwQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ckNxVt6U; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ckNxVt6U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXFzy3DXzz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 15:13:17 +1100 (AEDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-55c7445cf85so155271cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 20:13:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795320795; cv=none;
        d=google.com; s=arc-20260327;
        b=bRhQDfLGfASArVyyO12FzObPWzfNw0liVrH3NISBiBMuaR6YEW0tSkZI+LsSfiTjk2
         yghrh75HaD+UjQJtJoj+MRR/FGr3/VVG83i0KV0oAnxjOdWdv/muAFKj9ymHw14p0xKP
         iPNqu1+vNOEB3Dd67jRQxAs2Y2uxbo0Zdn8xsdp+H3KmQcNDg/BRz1cwkxEfUDKYx2mO
         nhalqmTf2wsXYqZR9I6Coi2XRio3W6loAW0uL4vF9a3S9O1lKh6XQmXB1rrK567PHJQL
         Uwrk4POg0I+LdF4icMR0nHaQ8RQ5/LA5Dpesas5IqF6I5TrJfA+oZZeMwnKJMYgtICSY
         hMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ljRHehwKpqXIEQjugVh5IB8G8Jh5NOSn1c67fpxeVk=;
        fh=rSvuZVxOxAZLkn6235mYrEiEq8+IgL+8mlj3jKmAsTU=;
        b=fEwG6OxmsVv5dLLiOUIYmGdLSnjfPkFOg/hdSPLPhOj9+MUEaDP76LEFlUz/paSGef
         YX0NSamr8ye8fW/4/kNCul2oeb7dSDTAPr6gXAAZre+d41EnSm6SXt6gD2xHFuDMprZT
         Fgh+WQkA4Dxg1VgN55dGe+lb0ax5m4hebPfLlV7+GrtxNB+MBGJBOdW3Pgqp6KmxmAwa
         5gr3Jl4oSHR3HhiEyLhKjnbw6YVooyCGkDfXw4NhD6eHLcw7m7WpfQzvSiO/OprR2wAa
         vrCVYPsXmtcgqysxBElCaAT7vmbitnCNTGNOrbLlaV85gJueWe5viqYBNmt03+3SKGYw
         Opqg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795320795; x=1795925595; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ljRHehwKpqXIEQjugVh5IB8G8Jh5NOSn1c67fpxeVk=;
        b=ckNxVt6UZCZsh5X9sANL0AANbEek+HTvhl2BWxrh8TZLKcPRKRC9QWaD0Fohj/M38T
         pmI1nU9Jic9gsKPHsNqbjdQ5dHL5HmS0VSaTt87he1+nUqP58tZxwNYZH1OL0SKgO5N+
         zAh/8+mAlK+tRyFkP/4onQg66PSFYg1C/vaknFiBm4SM5fjTMgPWUiDZXB6aNimNf0w5
         AlKTN/yv/ldCNyUAwueHHgxYLJE7piepKA5MpV7qr68jK0c8N//uGhEbgczp3F2oTTAS
         KsjkldVDuaNeCkAK1qFw+XwxZNiimuKaUOoJ9M2f56ibU0Wk4c4aBLJgJMF2tMgFfchG
         mZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795320795; x=1795925595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ljRHehwKpqXIEQjugVh5IB8G8Jh5NOSn1c67fpxeVk=;
        b=YXpsaaUUDkFQGj366agBvifHe1nLOecTUR7zD3mlBY0zwyJKXCeyYXkwMG+mqUqpdV
         iJ4RbTM0t1qWwXkvgFk0t3BhCtYnme23fS6nKZeSRvko6cqKsCvEi9XwJLR8FMZKeTmC
         8SZiaz1+fOAn4REZjTpKQ2QQQD5lIs64mmslGrurTINsHCSVIwrSNEHo3CgHydY66sdK
         MjDdXvy0bIxDu0blv/9muPJ8I2Spi6oHtaUzHAB6paG9W1WeU1agIR2Rs3r/vZuO/dPS
         XMyc69oDo3LBry7+wVFkqafGTm5Yw/ida5Bfi6OGmAkUQAF7UFQx1EfaHg7AWEkdNfz1
         DRJQ==
X-Forwarded-Encrypted: i=1; AL+hErFpcWU+Vgg4bsIyUASEpT75h6vTvyH7CV3pIvA5UfqLOREohv+FRxoxgI190rTWmUFvJLf6FesCfjzwcsI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+suu7pAmwNzXsLM3qUm3KsBgeQOhDR2YB6fsyVYnoI9AYAp4WO
	Sei9JbLMDsgFNBxCitsMXyNUl4JIPTIbHCzck7d8ZZsAEecwWSqPd2CL9AvHDeOovUuKnHA7J/7
	L+ymGxPEO5LtGqXnI0ahnJ6+n72/R1o7Pvset13TX
X-Gm-Gg: AZFdTZf22FmyOkm5u8b+2GZpFwuwVmPxTrmcyEA5pMnOIQPe4f43TSjYtjMrzUjTPyn
	Rq9gv1xDCAIBwiJxFbpR+uaIpWU8SRe9UkdDboI9+yH5S/pdcJW9bmNqJd95A8RBQ4hkkdJfof3
	xxfcP55B+BqWcGVXeBb/vU6/9Yqat9yIr2g2MuAGrbo3B+RkpuqXh4nkaZaR001zqq8Tcxkw3dG
	S6dJHkPORX0Z5vtOwOzKTZQMXgRgwoXOyd0b191VH6zfUaxaivR+6eFOxlC0TBjr5rnZFlQt60Q
	3SoPvNQDqIUSdaoi+7B0uUG/oE3C79ZqWKVJOXb9UBKNOqQzqkM1iUAjKLJq9tLg4abv91pN/9b
	zF/a9aOMemN+syAUuC/1A4vLmFeY8vD6lptEq7RE6UdCnCZJuTXlIpHTeGEa1n28FtcUfxf8=
X-Received: by 2002:a05:622a:c15:b0:530:e335:4ef with SMTP id
 d75a77b69052e-55d88014944mr19387541cf.2.1795320794485; Sat, 21 Nov 2026
 20:13:14 -0800 (PST)
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
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-10-hao.ge@linux.dev>
In-Reply-To: <20261116071325.263682-10-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 21 Nov 2026 20:13:03 -0800
X-Gm-Features: Aa3M54q14FtdKOZ0RiWv5OEBoj77CCH8AI-Mq7soe9RzxldP46nF6XTAMApufpI
Message-ID: <CAJuCfpF_=KV3ArFO5LtMjc4EGMr79tX_tX2K=YCG_JTvC51OfQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] mm/vmalloc: undo what vmap_pages_range_batched()
 mapped on failure
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 11:14=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> vmap_pages_range_batched() maps the range batch by batch. When a
> batch fails, the batches before it are installed, and the failing
> one may have installed some of its pages. mapped_end follows the
> end of the last installed page, and the error path undoes
> [addr, mapped_end), never past the point where the walk stopped.
>
> The KMSAN metadata is set up for the whole range up front, so it is
> torn down as a whole when the mapping fails, like in
> vmap_pages_range_noflush(). The only caller, vmap(), also calls
> vunmap() on its error path; the double teardown only walks over PTEs
> that are already cleared.

As I mentioned before I think this patch should be merged with patch 7.

>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 28e65073624a..aa80bc273ec0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3748,13 +3748,14 @@ static int vmap_pages_range_batched(unsigned long=
 addr, unsigned long end,
>         const unsigned int nr_pages =3D (end - addr) >> PAGE_SHIFT;
>         unsigned int prev_shift =3D 0, batch_idx =3D 0, nr_mapped;
>         unsigned long batch_start =3D addr, batch_end =3D addr;
> +       unsigned long mapped_end =3D addr;
>         int err;
>
>         err =3D kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
>                                              PAGE_SHIFT, GFP_KERNEL);
>
>         if (err)
> -               goto out;
> +               return err;
>
>         for (unsigned int i =3D 0; i < nr_pages; ) {
>                 unsigned int shift =3D PAGE_SHIFT +
> @@ -3764,9 +3765,10 @@ static int vmap_pages_range_batched(unsigned long =
addr, unsigned long end,
>                         prev_shift =3D shift;
>
>                 if (shift !=3D prev_shift) {
> -                       err =3D vmap_pages_range_noflush_walk(batch_start=
, batch_end,
> -                                       prot, pages + batch_idx, prev_shi=
ft,
> -                                       &nr_mapped);
> +                       err =3D vmap_pages_range_noflush_walk(batch_start=
,
> +                                       batch_end, prot, pages + batch_id=
x,
> +                                       prev_shift, &nr_mapped);
> +                       mapped_end =3D batch_start + (nr_mapped * PAGE_SI=
ZE);
>                         if (err)
>                                 goto out;
>                         prev_shift =3D shift;
> @@ -3786,13 +3788,21 @@ static int vmap_pages_range_batched(unsigned long=
 addr, unsigned long end,
>         }
>
>         /* Remaining */
> -       if (batch_start < end)
> +       if (batch_start < end) {
>                 err =3D vmap_pages_range_noflush_walk(batch_start, end, p=
rot,
>                                 pages + batch_idx, prev_shift, &nr_mapped=
);
> +               mapped_end =3D batch_start + (nr_mapped * PAGE_SIZE);
> +       }
>
>  out:
> -       if (!err)
> +       if (err) {
> +               /* Undo the part the batches installed before they failed=
. */
> +               if (mapped_end > addr)
> +                       __vunmap_range_noflush(addr, mapped_end, true);
> +               kmsan_vunmap_range_noflush(addr, end, true);

So, you are unmapping (addr, mapped_end) range but removing KMSAN
metadata for the entire (addr, end) range. Is that intended?

> +       } else {
>                 flush_cache_vmap(addr, end);
> +       }
>         return err;
>  }
>
> --
> 2.25.1
>


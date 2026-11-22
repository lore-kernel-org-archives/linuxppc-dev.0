Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1E606A32A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 04:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XdM6PEwE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXFpZ1XSXz2xgv;
	Sun, 22 Nov 2026 15:05:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795320310;
	cv=pass; b=CDvqbDPzOBZS8n3Gsy+ytc810/PHQuXhp9wid1gQ5KyE3f+4Q/O58U/+/TD/sq6p8nz9lFE3CQ663ze7DMia5LjcKWkjjzRbTuW0nUW0A7MWGcRJEl54boyqg0fvUf+4jfN3ddWZc89n4T+RYaehaJrYd1rRi83XEebCTpsfQHEQNYlVV1pN005/lIZpPYegGFjJfOgKmScWfD4/oTB0B+EgqjmMJ2YlCZKwRzrmPQYJxnFFollRXusrz8XoCYx1l342onE7ebd3h05GfItSVGVIFgb+TlqdDwZF7iwof3K189vEFdJWblk2aordQTDMkfgUcCd9Esa//xG9NQKwYg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795320310; c=relaxed/relaxed;
	bh=EdQh1078VcVl8/I0mQZEP2eKR1ViU5tIGep2uHjM3/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/cocroAeNN0//iOhWu7j9W5NnG/TsvDJqFV6KEQPLLqsJlVXU0QmLycS+ne5OgggFbug5mv6JHTmK8Gzr+Alx9vBUliXca/GVS4bXZtTiPnWZN0uqwG87SL0VNxZSibyZ9UeHOMOTvPchvdoIkatVR/Lc+YUO03F3TNm1kZF/q8K2fkW1aoJFKjQwiqVZvBM7HcjedNF14gUXuvy40FsBcDUhaKATWTjJwg16+zW9r40koOHlqnkEDYdqr4lhhjoHyLmz0lcatVe6xpvwuzmNpMkhj4q4GrOA7ILAR5ysicYwvmz7sPvgvDb/ozOsCi/LXgRaqE48DuqChAZjHB9w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XdM6PEwE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XdM6PEwE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXFpY1d2Yz2xdY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 15:05:08 +1100 (AEDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-55be673e029so154491cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 20:05:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795320306; cv=none;
        d=google.com; s=arc-20260327;
        b=pjfOSJ0JiH++P7J6UDZiRnb3qyY6N2aaxQIviuW6J/K1xxtaU9YPC4ANwng0Ob9wBY
         UqUe8Jg4s1Irhbh4BxkrMtsHRVUThaxEtpuDnbXN9r1zVtZHsgKek06liTlXyvY1zPo+
         X7hqr9lHvB69SzeEErRNRY3aNvnSj/7e0Fm3YcvqHFfz0+elp8JEseJDQFB7oFKmfDxt
         sX1kSfAI7I0wc0B55qyMyIUmHj0LefrDYViMQC/q3JERof9q40yoi+gdhwqGnsAox9bg
         WU6D3KfKv5u34gQVY3kqw/OvgQMqAlQMmLmdzy47fp/8sKnhNURK2O6EX01ah3As02qV
         qmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EdQh1078VcVl8/I0mQZEP2eKR1ViU5tIGep2uHjM3/I=;
        fh=S2W5aEYjyggmWoOyohhseLXddeL3CdrQYsc9/fcC3uk=;
        b=oKViuMdU1RKtbQdIFrBwNxWKvD/+JoxmI7HDPhnWqZTMvXBZjN4vD44XTLxR/cZooa
         N2BqLNG0oop75cwZPWjzjkqxuKeDdIBLEtfoq8rSFZmgsuOuzZc8gIXdMfqgHZX3g/Kc
         lH1DBwrnr97ob3quIiRWx9Ty8mmLhu2sdsQW2Ov7wzoG0MLS751JvnJXzDQrN3AkBx6+
         E46iZvRU+v7IseLFEEheFWRLrDl7WdrnqnQcbxvUYBhwEVJgH0jWVZETXMfzcY/OloRS
         vw44XKvuN6zPrUcwiecr5e3+ms5246DPOOjmW6+oAZirX7n26rvj0TmDBJaVMHomUO9u
         tbPA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795320306; x=1795925106; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EdQh1078VcVl8/I0mQZEP2eKR1ViU5tIGep2uHjM3/I=;
        b=XdM6PEwEKRfR22la5AhwuamPJfUma7+wuSIN3y0QmwS6ubixAElFFS2VedJ/v5Uw0c
         rRueFIlV52z79YCdp9EswonxCyzFriyQvZyGwhpFwU5mwFh+elTHqf/AI9LvSfXVPZ/1
         2S/BvE/Mt1GtuQp2Wt2nTxUxs9v8JttVU0RBiTUjjXVHfMq0HF5zA7cpZBGWE5GW2ZKZ
         2OAHbNJxCi3Klghi6hnRjSpP2i6cPzkXOy81emcSL8hBw6WulAgJJjOmYeTPbdtuGanq
         i5mWHZxM/m/aODFrv/31qi77UEP0f6emIfN2IoyUabDDS1HZKWny67MQPht5Y8551m9K
         iCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795320306; x=1795925106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdQh1078VcVl8/I0mQZEP2eKR1ViU5tIGep2uHjM3/I=;
        b=OraGfhJ9c0Q35lV0mAn7iJPrCDAMbQnfsUEq++JY84clXhjrRifZps7hW7zq2rIIfd
         TDlMuZcwH8j83n273er+i7l3g0NQwjsUREP5VPqa1dzMIh29DMozv2DoJRp9mXZCbfKF
         bZr5PBGVCRsw2021qfs9pB+ipT3NyomX2IYnK9G6V1NFfJu/fBDeSQTnz3cnkmtFolfW
         4PD8oY7+u6KLRZ+dPWwDei7McMyXlcHw5mV6WV+X+1skczqbLBvj917GAmOfZtlDg98J
         At2taJAlrK4dhWktWaFj1NwcMi6f2sxmnGNQcrkG4sWlJI9sJijR2Goug0tnLbxX/Dh9
         vuxg==
X-Forwarded-Encrypted: i=1; AL+hErHsPaZozLXBsqFtHTd3K/wm4vaoEN2xbCZHYRwM+Q4lT0bRjAYMhB/qYqS8lDMdqXMkIec4RRzm9eS61og=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+UFu5we5U2QRrgRSphoh1N7Tizve2Pqc8c6eg4GSzHheGBfEqC
	Ntm2M/moP9DpSXwWEXzR0+gj1/yz/CQIGghiBSrWZy3Bhy3rsoUWmtZsbk9De2hwGKeqQ0WYMM9
	5ZVfUvv920AR/khQtVa/I27Y6FgTvEgoKvFqAAJ3B
X-Gm-Gg: AZFdTZfcZCZQyBdJpYJyOlaveFLXKjhb6Hj6uangU9raEN8CJ275qBjs1xxx10Nlar6
	E5qTQnZcFk0Jlx0IG82YHy21Fh2Z6iPTnJ1jobyClcZCHCCf1GiIhmESNJ1LlepjQQOzBtX3dIO
	GjnyY1Xqk5EtQsYC5UFIlbxJav32mP59c06RZ6Opf8fx2T/m7eUlwdOwLOWTRR0k4zhD5TVAE7U
	1xJbOOw4Nyt8DgrfDiYq2IRGVEzKrrKYSy0r/x4YIQRwS2TYKS2TsqSCa+X+R4lMy6evfzXOfBz
	9pLJ3cmkGp0TwUp3C1nmgfpq9Vdz15ZGiPcdAOK7iUbHTcUvrQgQxvMzjqZ+0fxC1SKP2P9qmod
	tvIVd+xwEsWIj+sarO7bKkpXlrBjW+vu5epWSYnZoJhK04wtdQG5QH9cqxqsNf5jj59edDsA=
X-Received: by 2002:a05:622a:2b44:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d88013e93mr20693911cf.2.1795320305782; Sat, 21 Nov 2026
 20:05:05 -0800 (PST)
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
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-9-hao.ge@linux.dev>
In-Reply-To: <20261116071325.263682-9-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 21 Nov 2026 20:04:54 -0800
X-Gm-Features: Aa3M54rNW-fgq1PCt8XmLDMf2BnWeGOuBPMCOY35tY8eLiMpaqrvJYSsrRzr_ls
Message-ID: <CAJuCfpF==pGi09rnh2ts6VhV6Cj9kjk0rvvkGD3=8TmFKW-VpA@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] mm/vmalloc: drop the KMSAN metadata in
 vmap_pages_range_noflush() on failure
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
> vmap_pages_range_noflush() sets up the KMSAN metadata for the whole
> range before it starts mapping. If the mapping fails, the page
> tables undo themselves now, but the metadata stays behind, and the
> next attempt to map the same range hits the leftover shadow PTEs.
>
> Tear the metadata down on the error path, it was fully set up before
> the mapping failed. The teardown follows the page tables and skips
> cond_resched() when the caller's gfp mask cannot block.

I think this patch should also be folded into patch 7. Leaving the
metadata after unmapping a failed partial mapping introduces an
inconsistency, which this patch fixes. So, in a sense you are fixing
an inconsistency that you created in the patch 7. Instead of
introducing an issue and then fixing it let's avoid introducing it in
the first place. That's what merging those patches will achieve.

>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 4f3c320a4849..28e65073624a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -801,8 +801,18 @@ int vmap_pages_range_noflush(unsigned long addr, uns=
igned long end,
>
>         if (ret)
>                 return ret;
> -       return __vmap_pages_range_noflush(addr, end, prot, pages, page_sh=
ift,
> -                                         gfp_mask);
> +
> +       ret =3D __vmap_pages_range_noflush(addr, end, prot, pages, page_s=
hift,
> +                                        gfp_mask);
> +       /*
> +        * The page tables undo themselves on failure. Tear down the
> +        * metadata that was fully set up before the mapping failed.
> +        */
> +       if (ret)
> +               kmsan_vunmap_range_noflush(addr, end,
> +                                          gfpflags_allow_blocking(gfp_ma=
sk));
> +
> +       return ret;
>  }
>
>  static int __vmap_pages_range(unsigned long addr, unsigned long end,
> --
> 2.25.1
>


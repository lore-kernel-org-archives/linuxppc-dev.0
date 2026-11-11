Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C6606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=saA1mbZl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPr3H04Q4z2ylm;
	Thu, 12 Nov 2026 04:23:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::32e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794417834;
	cv=pass; b=XP5hu7rbzdKwmArYo8Cno5xQoGy3ux/7wRni1Ytg5QtYOxX+TlBA9DXLoAwPXfzEAVeavJ5+JORee0sxwRu9gzEKMXRP91nEam7WxLc9WmSTVb2L7JlI6UwxN/ZbiLxGce2hsfjO8xVGfgcQbgM//pdHti09eFxeMUupWNPQ6b5rVNl5OuQsHjDjcJYh6lVQopGsMXV3OXpdJ1xS+IDGMbF8krblgiUk8dAqLwEJ2aWs1iQC6Q7Deswzk4OHE7qhR2MUIcRGRKETXAG4MAM6PcysEewWqF7+pLVFXs2+uCINs8CQCf1hN4g/BbtpN6IdhdawFs+FQJqoGY9jADrZNA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794417834; c=relaxed/relaxed;
	bh=mcheYV28FEeG84nrqn2wc0u+T+lt+CzxE83toBxPN9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATPQK49osLxgq3hu/yXpaXsm4T+8TNb3OnfVaeyVsu4bzmfkklOUkhN/3wzVO5H3aC85WHo9musoUi79GEsWwEcWNQfbbgvDHu13kHIHxDxJa8Kio3VWUjqUg3upouhy4WaK9OtoFLyQFQx4EOwof8FTKbY9zYdQmdx1tGaIY63ELUzq5WIGl+6sZxml1HtNbwfli7XZQ0JefWQcvzH/ovmjs+UdnK1CyjyzhSgPL4nfpwt+2yf9NFEBqHy/ZMxYqCy/7tADy048ZCNgKFI/sCZDosB/Gw526BzF+K8i0U55X6o0w5lb2bg92h4kwpIugjWo1DMtvZP56Zv7agkVSA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=saA1mbZl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=saA1mbZl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPr3F0Tjtz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 04:23:52 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so26414345e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 09:23:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794417829; cv=none;
        d=google.com; s=arc-20260327;
        b=Jq7F+nFWhxC4Mir66C54e+M7Kbj+LdwFQKejDeGFTXn7Xf59RalDTY8Pa3dpvLq4hg
         oCAKFdf0kCcSDAphkja0RLdfST9ta8QRkck2EhETrCfhlJc7rocnLZZxJaBMd7x6nD7E
         xbUUintexhNTmCL4Oq9sx5SjdQ7JX48V7pFnHxDNhUARB0irDTJVhHXM/SEsJMwJ4/HK
         wpEF1G0KAqEv5vUZFCb5dzCRQ2QeAUl8Mn9uXN4hClUzoJFBcJ21txymVVeTkVYJbreD
         Mm6isF4PT4YlvwDkDmrpHr0kPONxBil8daAoWFsoK9IEwcNq5BMOW+p7/Zu7jMJOYwgF
         +Hew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mcheYV28FEeG84nrqn2wc0u+T+lt+CzxE83toBxPN9U=;
        fh=nKySTxtor1BFgN925hUMlxa9E3Rg+QIB5FFDw3IDebE=;
        b=IGpTbvEou6R6w6Lfu3oZVq69pLuXaAWwJFKe2U1AC+Ndjbr4HMe/HoMAOZ7z2oMHBa
         xojiRLm+O56agKejhCoRSE8pbzQGpfiusfBruf2fEmL3sD2aEsVCIk8bNDRdYDE2YXrN
         xy3oj03HT5c1tFr1oRG0wdnOtgjKs/OLCnhWrgSWuG4R5S1D29yZq/Voqh0qqhwlhqsC
         r7QE95iRfOQY6R3XB0gCDdPwmspeTEkVG0qhLoj8AxShv+63xDNnKvl7jSfY9wTKNlr9
         2QnB8s4J1bR0gejpy/T4j8wXmC0YdTjJLiqKvXPkd8D45PFc5vuhsPoyVdkZtzJ9M+mp
         BjXw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794417829; x=1795022629; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mcheYV28FEeG84nrqn2wc0u+T+lt+CzxE83toBxPN9U=;
        b=saA1mbZl1Foqt1m7II819HLrrQyNbGgvmRi1URvKrxXvgvycGet6OBsXtDqsPxPsId
         d1pNjPlgCrN+h507ldRhnJ7hz5jnsuxQwIxxb40Mvr7grbLjlreE830pFF7cnksItJ9l
         FCUvVW85Z2uh+zxcv9KlCDDSxrSOWXnVvvjQj7o7ykwOSEgEO8D69U4L8fHdGwEb2D9h
         wGtXMwGmHD7zCwSfnW2EhPlt4a6/qihJz8kHX7DkLohOUF+dK2uFyGpIueD6Mqxwom90
         GdDoctbPPBQawYApCZEf+GsjASGFaVda+UOsG7ovnBuxG202pJ35PCTR64A0j89kylnW
         W87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794417829; x=1795022629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcheYV28FEeG84nrqn2wc0u+T+lt+CzxE83toBxPN9U=;
        b=PTxxPS6p8DBzx1lSEk6TF6KpuE+9cWKAH/FamEY5zGuG3pjkIW0wxlILH8V7qeJrD6
         TLRx1qgzOrxfmDLwLL4wzDN7ZO5naQM9VWTNnCXyRcD+/HgjqMBCkmwxh/BSryTfgHXd
         v6fkVwTd6qOhbepLBhnMyav8xzzBCEAjJ6VcSLYgHVccGKNgN2ATByTwFI5QxTmeFiQ4
         OXnmodPxLr4AuFzhU9rWRwBMr7rXEmUYFOUlig9rd1Xry53drECHgaMDemxguyrPKhI6
         6xxsPcXBIn8oKsD6aja2e/bvndORpsRPXV/SdNE5/UtIJgDNJyPfRlURiUU5X5OxIe0U
         Jrag==
X-Forwarded-Encrypted: i=1; AL+hErGALFC0Uvi01LybPTmFLKBhQ0NY5x4pEP3WBUjFiJEVs+BpKxRfySbWwdcNHhaY6iqOFB7vyo0mcjYAhas=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8cjrt0GJheYWKmUP/MvtgzwlJG1dG6wHbFqjDSLFOP8aSr5Jof
	oAjEuEnaTjnpCT48O/4IXc/HfYFmz78X3u46Lg71i375RHPT2cOKmIdXR+0JOErLYDmZl/mGMFe
	KD5ZaR7f0YnC2XwhnW/yrDMV7EiiuNcc=
X-Gm-Gg: AYBFou1xPwreDl4Bzc7l25wwgqgrZ37uYcgAG6g3sv+OvkdeBdbmNYgOd8I6ipBWCNG
	HYT25JKIv2gE2JuYEEHO7rKA10UcHjkG20GfnEIyMDtSd4Wd72GXyBGcIGxr1qSu22nK343tVUJ
	f+FRoc9DnCg9TFO8ff1VJgpcRVE7oFw/TDrgYFaoAeXuffZiE8C2Mv7Av4EKbJe+75oMijnD8z7
	6bf6L6CwViCk43MPOrnqnhBOA/128m+olSqk5df7ySnOA/+ADXsQrlqUjiIACISymXi90LA/Bti
	chTLpTSuRAlxGDKB44R5FmLfPfloxZWwZg40g8qp1++mRcQ/+ca+eakw6uJMw38/NwZvfyIJYG6
	o+X3jJYAVrOu6icT3RfG9N3c38SHpA4RV0acrdNNfhcqL
X-Received: by 2002:a05:600c:c11c:b0:4ba:4395:56d3 with SMTP id
 5b1f17b1804b1-4ba43956399mr35681085e9.7.1794417828858; Wed, 11 Nov 2026
 09:23:48 -0800 (PST)
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
References: <20261026080329.140244-1-hao.ge@linux.dev> <20261026080329.140244-5-hao.ge@linux.dev>
 <e1cfd568-8fdf-4aa1-a8c5-961bb8d7efba@arm.com> <5b0f90a4-c7d2-4f12-9d95-95c7149c49c7@linux.dev>
 <CAJuCfpHOZPKKd-bGWavBmBf5cmR-PEZO7a_jxXMZVS8tsgG5PA@mail.gmail.com>
In-Reply-To: <CAJuCfpHOZPKKd-bGWavBmBf5cmR-PEZO7a_jxXMZVS8tsgG5PA@mail.gmail.com>
From: Uladzislau Rezki <urezki@gmail.com>
Date: Wed, 11 Nov 2026 18:23:37 +0100
X-Gm-Features: AclHuK9kTkE7tX3_RqNj8eIIBWW_zm-niQDFwkMhLI9nwK05oSQZyNed3nD4i4g
Message-ID: <CA+KHdyWZ6F1=xY1zrJ65TBwJad5k8gkuKmws_hOHVuGtj9q-JQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] mm/vmalloc: propagate errors in vmap_pages_p*d_range()
To: Hao Ge <hao.ge@linux.dev>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 1, 2026 at 5:00=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Fri, Oct 30, 2026 at 2:16=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > Hi Dev
> >
> > Thanks for your review.
> >
> > On 2026/10/30 15:29, Dev Jain wrote:
> > >
> > >
> > > On 26/10/26 1:33 pm, Hao Ge wrote:
> > >> vmap_pages_pmd_range(), vmap_pages_pud_range() and
> > >> vmap_pages_p4d_range() return -ENOMEM whenever the level below them
> > >> fails.  But vmap_pages_pte_range() can also return -EINVAL for a
> > >> page without a valid pfn and -EBUSY for a pte that is already
> > >> mapped.  Pass the error up as-is instead, like the vmap_p*d_range()
> > >> helpers for vmap_page_range() do.
> > >>
> > >> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > >> ---
> > >
> > > Fixes?
> > >
> >
> > Sorry, I missed that.
> >
> > > Reviewed-by: Dev Jain <dev.jain@arm.com>
> >
> > Thanks! If you have some time, I'd also appreciate a review of the
> > remaining patches in the series -- or Suren and Uladzislau, if they
> > get a chance. No rush, I know everyone is busy.
>
> Yep, it's in my review queue.
>
I see v4, so i will have a look!

--=20
Uladzislau Rezki


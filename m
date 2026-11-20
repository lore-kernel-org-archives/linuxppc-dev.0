Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC770606A699
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DWZNXxaX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWV3B1vlKz2xnZ;
	Sat, 21 Nov 2026 09:13:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::835" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795212806;
	cv=pass; b=imFY4srRQzDOgKUGsY0EteRcKt7L0u1XHMh2BkrnYm2Gvgb7AYqLSNtyWsREats9Br01vidBQ5eC3dCqZWmZ6ZfpAJe+qkbSjGgA4utF55kK6htyEyP22DQTj3XwqmjSUlSPrtGEfg4qoBp0eQvO0tEvtgIDJo2J3tr8u2tldxlLgM9QAaUW+9LodJiM13zCpFvIoPIVUxlGYsStShopuvteRO2eDcXPg9E4cJaK19tO+iBG7IL69ljpPW0G4WsSjwEXCX4w+ZdGXCEw31SbmZgx9LY6UtDdreq/1/yBcybhOVU+cX3rrT+3ZOr3B3wwgI+X1Ii7Xyggq9YieeGH3A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795212806; c=relaxed/relaxed;
	bh=rOA0kle+ETDmz8eQFgvwrDcZAmSvRA8CUZ0yI4t+KI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keJGjQ5zcJi80XKDp1khuAfsWkUAMI9SlsTVcoTCHxY/SetXqcVEtgepQ9qq6cOhCJryhX/kSattJ6UbQwywb2keCNsGV3lz+OWG61TqodO15lXWIONnQxDavd/f19C83emu+PaDihwKdVsPNCoeM30AD9I60w21vSy1LuQ0sxwHHbWpDeHlTI8jv6fyCQsdkvSfWnriTVDYH8fnMC1KbGYxSofeiO9S/VRlwo9h3RuUI8hb3Cc2u0P7ZkLtii75G1WuNkFIma+H+T+MCCo6t+KnJUxcwLat+prmVCPEo1N0wdgxoCk8JkPl5Rr+BZPh9vNNZ3xV5+QYaF7dBSqPMQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DWZNXxaX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DWZNXxaX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWV384WT2z2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 09:13:24 +1100 (AEDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-533202fe429so86681cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 14:13:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795212801; cv=none;
        d=google.com; s=arc-20260327;
        b=ndyoZjXhGt8SCLuMretZ/wo3ILYx4h759x/HxcWUqIlZaUGWoykdxUqJmLmPhotBrR
         T11d521nx4zn0PfjR0w0wahK/me+KxP/N+cLOFc2KNUMDIFYMOnMYcP6/hxgVm5JWzrO
         jyZCgx2kOFrGlIdsoThNeEbBAEfAQCFv3ipBAradmZawfXGj7cmffJ50B62Bwt6XBNaA
         qSNhnqp/LHR5hCxEiTrQMQbFiDz4ZGbLVDIrJthpkbNbLkIw+++0qjdvaQB8MfP4fJpV
         Nrt2W5pC5U0k82spQ3fkwkqXbDC1QQnHMqPiX0TROFl3/Y5KrygTO3/qxEt4Z7PKULCK
         JILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rOA0kle+ETDmz8eQFgvwrDcZAmSvRA8CUZ0yI4t+KI8=;
        fh=dmZ7TZ1xZWKxoEsD4ibWYFCYh/1YPGBzUVhwHi2xBok=;
        b=tCutQLDEh2mOizIFBZNDV4inE2a/8S2+IJjRiH0FwyBXoWJGCrbuluUE8WSdxFjCkc
         Bc0IUtZj2KicbPql4n6mQmtvT5Qi00WlgMVhPJ0o5qt2Qbnh7SXlvZwNtSOUE2oQpRMp
         PIrJMcIf+84N8UlYhSy8WiZPqRnzLqZJugxVrK8uoc59XPEQ8Zxl1YdejLOtfsenRX3V
         d3ed8LA+FPopOQKHaLkZcz8fIvBliXO6ns9TMUZqcOli9rIZGsB6K5IX+Idpz2+gOkG0
         oRvL1YuofsisSz3Dpc4SKE0Sg+0nnK7+SIlfR4P3wxbNq/etXv9V0ZpdY5CU5/waNTI5
         2hXw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212801; x=1795817601; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rOA0kle+ETDmz8eQFgvwrDcZAmSvRA8CUZ0yI4t+KI8=;
        b=DWZNXxaXwt9HE8WcW6SdhA/J/I94exXRiyseX0nbtutQXPHxmiduZwkX7tkDhZczkE
         pLEoxm4gKS1ehJJR9y0CTWPUJlwCtsHPk37wJFmO/2aA8uI7bx59LEH92GlfAMGeIL8J
         eT8PeFlpZ63OLYYKB/+I8zGZjCuBoiYDZUKo2/whSYPbNZFJMcmOymT8tkih3C2/jiaV
         u1BPhXLtQsMDsQU801sIzgseVVdZjGo79gi+z+BlIzrk9uOWfnMCBoAt3zAmh8PXX/E/
         nE2zfd33C/4aUgECcOJVvutcozUuakJJ+K0mp5uu0nW0qkwYjMCs23cWSDxAfqfSqz8V
         bsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212801; x=1795817601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOA0kle+ETDmz8eQFgvwrDcZAmSvRA8CUZ0yI4t+KI8=;
        b=2f7EXVeLW+/UzH1ChUUVDWICsCnbPEZg26Lv2YGEDQDbgwKFmhS3e3nnANDs2P7g2g
         buScGlO/2vmwlq9F8hpcx9jeY3EqhfV73q2R55i0gwd1pitn41kBsUrKRckiYXxb+7w9
         bAk8vtz1ZQwDRnoPzEDXKlNgBYILxspy0sMgxucY/mT79nyjt/Tw4vsguxDM4++IE407
         XytcQ+wnymemuyWY4wxI27xslYwGEj43slwSXQ70Y2OTdwnUCvFgwUI3E9IaEDKuR1Jf
         jedMjmIQW+JMH+8GjifPHXj1PmjWdCDURb2CnkohyduuJhKssPqg6Kq1xN8N+oIXh1qt
         p9QA==
X-Forwarded-Encrypted: i=1; AL+hErEWlrKw0Hep/9OF006NYep0FmK2mrWpLM+kchRcWH8Fp/Z4Xv+/ZWBj/uFUN52lMXewM5NEGDqnVmJrP5M=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/KejZg6Vjs1wMQ7ejGUF9avzYabjdSSdnHtIdM0UhS3BzvP4l3
	gtDa8xzo1hVyqznanZijmNFyGPgGi7Kdmt1wVx4nBtsVrT4jtlVi12upMNIVeCWXfswRB/ahR0V
	bfZP3xcpUO/tSuAeZ1MFvtX4S5NA+bQ6vqpPrOuOb
X-Gm-Gg: AYBFou0rTHTDIkhQJBD2q63tqQ8ewFXPRWxVMEOMx7+q8dbWmfTQX5g7bzbm0/SNNzS
	DWsWRFaQ7RUnyH9RnIk2utzbcQMUaCXD/9DT1yTEgINpvZL/jcMn/igRvwIwPHl/76+vlictXa1
	Qid7UeWqw9oEcNKq1eqFaUXpBsP17LG31No1IHoyyIet8jIp3tXbPMjNSdKR5U7spKJSxpkVxPK
	C7UBut8nXC7qPt+rejPXdmOQMit0E61d+QvzVc+HqBWiNIU1pfBtZy780gC+xpeNK9vfnUNXpPU
	CEyjhw20XD3oAyCFPGgUk96sr13EKDTueo0Yyhhp5wJ7xLGqJbFYp1f0OKSa9O8nNK4ejKlb6c8
	tgzbUi5dYYx4RZ7pY7gBcaASzBa2mFCi2a4g2POgao9HipRbQ4lx4IAuNl16R2Tr1xETD7wNYOk
	zRwoj/QVgJ8skjwIakYY84L/V4EOuJaqp7Y6h/iVvzS7wAuA==
X-Received: by 2002:a05:622a:5a12:b0:536:6ea4:e6a0 with SMTP id
 d75a77b69052e-55d89047301mr1602591cf.11.1795212800722; Fri, 20 Nov 2026
 14:13:20 -0800 (PST)
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
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-5-hao.ge@linux.dev>
 <4c233641-15ad-4e5a-a106-423bc31f357c@arm.com>
In-Reply-To: <4c233641-15ad-4e5a-a106-423bc31f357c@arm.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Nov 2026 22:13:09 +0000
X-Gm-Features: Aa3M54o8iPUi5c4eBLmIEsreudNlx9QkbSDoAuhcBwsY9KLGNvEMLlfilGXZ-DY
Message-ID: <CAJuCfpG5shRGvjHJyEOveSxkPE=x7nGTo4xmy0XLabV7NutrMQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] mm/vmalloc: reject an unaligned range in __vunmap_range_noflush()
To: Dev Jain <dev.jain@arm.com>
Cc: Hao Ge <hao.ge@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 6:05=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 16/11/26 12:43 pm, Hao Ge wrote:
> > The PTE loop stops only at addr =3D=3D end. An unaligned end is never
> > reached, so the loop keeps clearing past the range. An unaligned
> > start clears the page below the range first. Both are caller bugs,
> > and the damage is hard to attribute afterwards.
> >
> > vmap only installs page aligned mappings, so an unaligned unmap
> > request is never a legitimate teardown. Warn and bail out at the
> > entry of __vunmap_range_noflush(), before any PTE is cleared.
> >
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  mm/vmalloc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index a168f6f20f4f..e2b63cb1592b 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -523,6 +523,9 @@ void __vunmap_range_noflush(unsigned long start, un=
signed long end,
> >       pgtbl_mod_mask mask =3D 0;
> >
> >       BUG_ON(addr >=3D end);
>
> Nit: It is usually a practice to change the existing BUG_ON's to
> WARN_ON's too, if you are changing around that part.
>
>
> > +     if (WARN_ON_ONCE(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end)))
> > +             return;

nit: It's also better not to combine multiple conditions into one
warning so that the generated report clearly shows which condition
(code line) caused the warning. IOW:

if (WARN_ON_ONCE(!PAGE_ALIGNED(addr))
        return;

if (WARN_ON_ONCE(!PAGE_ALIGNED(end))
        return;


>
> Reviewed-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> > +
> >       pgd =3D pgd_offset_k(addr);
> >       do {
> >               next =3D pgd_addr_end(addr, end);
>


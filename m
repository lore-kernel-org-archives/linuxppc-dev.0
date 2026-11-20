Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569E606A6B2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PlT6niQb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWTWy5CKWz2xSS;
	Sat, 21 Nov 2026 08:49:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::536" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795211390;
	cv=pass; b=dfwAaknOVkQ5twOzDRaRHvalunU1BROdwkQ65txIycrR2wJvSHlkpsTWuTfeB6a+FAEfvBrH6p+nn8/UArFA8WW28oioh0hMlKt1ZpGLZ2eFI+bSe1+Ku+EBKtmHRAvE6LTBUFajtKAAMVUxykF+eRMxKcgdmCyXB836j2SaLuMshbl0SHFSrBG20JTZXHJMcHQYYGndEtgJoDFuDYGFwkpClQQtr6EX0FPVj1s9Id9zHK/f5LVu9zTqBkqW4urvTxBApZI0WTssqAjUmpNbHauAfSxPP2dHXb1zPI10jUbjevb3eqfWZTdPoM6Q8TsHqcPlIPSf/95dZUeth2NmbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795211390; c=relaxed/relaxed;
	bh=E5uDN/vzQdjrsq85f8uIb4z/yYhd7+ao5rN+lXxRb7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/OeEsi0O0br0AZoAE6sszrKtClpFkH5QNTG/vOsaUjUpTuOAHNbvUfE48ul/De/s5a7mGTnUnLWwVtxIx1oSDwboXia6Vvqu8C2zNeoE84yyjAf1B0yY3zCgQL1ONru9qPa9zp9wiQKBdT+YU14W06Iia/6vdrBUxUvAzIe43AYCwYx93k/FNl6NxauBKMNQ1Pkkpl6ODNhvZvCZtzxhYTBvZOT8dqNlQg5mNHGL9YD8+1nWx9l8jRy8xM3VLgbyOkhuLiNkjZDeWMhas79G1nUCmtpClGiIXLl7rG/QkLhU86RuNjCmC+e/j1TVBYm0GmpALlZGMCX7Mxhba2d6g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PlT6niQb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PlT6niQb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWTWx0frGz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 08:49:48 +1100 (AEDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-6ba2bd43dd8so1104a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 13:49:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795211385; cv=none;
        d=google.com; s=arc-20260327;
        b=X+y2zwUoKBAPltRsInNwvM2BTYbUU4XG1FjGQ0ajSl3USpQZRwhLDKeh+Csfctfu0s
         o9vGR2/xO2O9TZfht0hYYSI+yg3xhhyPcjNNklSR5cmvX+RU+rIEQNkz3q4f+8O3Sxrx
         gfmdrCzbXxN/cx2pbPVKoK1YYwqSPhFSBQ/c3K/8gKEWZXg9Zk+96nP/lc8akZ1tkCpe
         eU++deUh6DWa844gbnOTj7uobbZws1xf6518gu/awF0CskhUPScJGDvvDPQODP0nUHbI
         r091PZZcHkbMDgwiddt+md77dZAGbtKb3nfl7RvqxAhFUzFNbiGAG5fZupQQhc5QQYkP
         Ee2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E5uDN/vzQdjrsq85f8uIb4z/yYhd7+ao5rN+lXxRb7E=;
        fh=1/vASnmogp29noQCMgkc8GGHKmGlVqrcvViFEjtq1mQ=;
        b=VrD4lUyBKlc9riukRft2to6JTDBZhetqbBNXHFAXRK7/LmC5jOI/ioVeNSegaKJGrE
         fJdhWn58hVP1glYMnuz00YotRrnPZEk9P5K6jqf6FA3egHvFvGZWyk+0Txwn4SmGFcaj
         wq+bGz+4pZdiOrpXWqtcX6FDWiX6s002SrVVVs6rKAEFE+9+RPXl4WWZDxs0LpS6PyE2
         aRdFEa4BBaDl8efX7eptr9RawPjnf374rH3yZ0/8krEZ2m9G2l4R09vpJ1iZXdVD2dxM
         g/y59RwouxUZuf511/2FzoiFpCInTMzsixIih4MtAYsy4bR/v+9j/cct2PDTdTjybnJF
         wOgQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795211385; x=1795816185; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E5uDN/vzQdjrsq85f8uIb4z/yYhd7+ao5rN+lXxRb7E=;
        b=PlT6niQb9Lij6/kxxsjJWRoF+E8qlDfAowePwaTM4me3x0byyC2/BXDiyRQ/zYsnXe
         h+KUVDCtzhtQxc2RQDJ9fxI1ObayrU6lEhhk38rHherIxxGmUCZVwHmjz1q1HrWDQVgC
         D+4gj8sCSsuBp15TWhyERm3zBRclfENJarkF+l5aqXVg3Bbg072AAOa3nHdPu0t5kL/W
         qPWq0tjRLy/Gk4KlouJQCfDAdxFcQi8GKXh1LSIWjrBLRWEJ9f68uPjVg+DlO7Nq5/Pj
         Z73QeahRkV7pCPIUmH/O7k1w8PMu1w+iSHe7Pxe/UE4/O5FFbAyWdLMP1Gxtu8bhG2XV
         wtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795211385; x=1795816185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5uDN/vzQdjrsq85f8uIb4z/yYhd7+ao5rN+lXxRb7E=;
        b=qIMDWjqDigw4CCO+qqRqrN+iBno4xUX10i8wX4osqNwXU5yQxPUHG9bSvK6oPd+vRl
         KYL/qAXAsxnxBaOwg4oc4hS3D8v6eTJRzcrJanY5mh5p64mm1bVg5IXmMWNZSogKn1l2
         htlL+kgAY0EjhuavLTuourckGPLcYOAiy/SeFCL6nigfBKiHXPpRkfvVUK3jO4KpRzJJ
         TLWazFszI4Ltu6CmsYDmyJ+QnbTBZWYY1AUxQoXDXHDkD7HFIICnRtUS6yhvbqGL/29r
         erSoSqBTCz0VKLVGVAECtKEJYI0oD78t/C3iTomZwD8JSd5v4SksxlW+ZC4s7jq/s0O5
         pTWQ==
X-Forwarded-Encrypted: i=1; AL+hErEnehgyl2TGF2Emkkyt7qXU/Ixe1MfkP84R1tZhQu1Nnoq9+4MMlR8WHleVvXfvs825/iFeOmBgXUsWl5g=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8gcONxi54ljSOef7xXN/BMUp722GIavSB0van6guJxLhEJMq4i
	6NAoSkeHL0ca3SCK4EIWYaZhig8xjwDrozTvfeEWVDBz7U/MXN9V7O6bj1Sz4hgLenVeILoJZj7
	iqJmRX60MCeFW5/jmexfN6HM/K4Hptzokg7R08WZp
X-Gm-Gg: AZFdTZeom0Mwy/qWTWTiDs3ImDJs10h6S/v5NulvUNIIT7+oGzu39UOR0DSLpkvtjNR
	NPI902IgP9CktvTKXAQdahdD9qxuKL71jMtjg53ocBbBDvtUQ8GD7i9xz/7TP+yjX3iU/z2XcXb
	WB1Iza67O/1JEDCTNbyltqOcuDDl8KQ7PccJ32dT91y0T6vQtTRWxBNM7yYqxC7NhDH6YgU23ze
	bYTdi5P0oT0ZtUsUZfIhnkVbQh6kxbWdJXGUPMUHSf0FTQ5L2AgicsxdLDRudP0M2JYClCPfLh5
	CbjOKBpp3QenZyxBjabnwEbd2Z3GL1F0mEoTXvwOeaqq6Cui3SMVYc6PSUj7zt+67vN9DCh5b4f
	GMFKCi9RP7elquPBYkYNFBEkEzwLwISn9c/aoELjcjN6DU3lMAFVrqhBXYaUlr/2PYLI1pZTH60
	wwcIvjZYQPAruz/5UnQgda75wDRvBbV1duEeM/dXA7jYuyeQ==
X-Received: by 2002:a05:6402:1ed6:b0:6b1:c6fc:aba0 with SMTP id
 4fb4d7f45d1cf-6ba6edb6b8dmr7974a12.7.1795211384379; Fri, 20 Nov 2026 13:49:44
 -0800 (PST)
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
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-3-hao.ge@linux.dev>
 <CAJuCfpHOZS6mp_no3wKmU3-S4HKspnbriUw8Mwtxf3nmw0-pfw@mail.gmail.com>
In-Reply-To: <CAJuCfpHOZS6mp_no3wKmU3-S4HKspnbriUw8Mwtxf3nmw0-pfw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Nov 2026 21:49:31 +0000
X-Gm-Features: Aa3M54qncu_g5WX6d_gqnAW-RhgHGus495VL2_o1wphopDeOUeDevYVBGMQXiF4
Message-ID: <CAJuCfpFv=sCeib+SDWJNW6oqbNnhT+m3YjnfKh8jNkquzuYORg@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] mm/kmsan: undo the shadow mapping when the
 origin mapping fails
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 9:14=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Nov 16, 2026 at 7:13=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
> > the origin pages. If the second mapping fails, the first one is left
> > mapped, and the callers do not roll it back. The next vmap of the
> > same metadata range hits the stale PTEs again and fails with a
> > WARN_ON() and -EBUSY in vmap_pages_pte_range().
> >
> > Undo the shadow mapping on that error path, the same way
> > kmsan_ioremap_page_range() cleans up after a partial failure.
> > __vunmap_range_noflush() only clears the PTEs; nothing has touched
> > the shadow mapping, so no TLB flush is needed.

After a second thought, kmsan_ioremap_page_range() does not skip TLB
flushing. __vunmap_range_noflush() comment at
https://elixir.bootlin.com/linux/v7.4-rc1/source/mm/vmalloc.c#L497
says:

The caller is responsible for calling flush_cache_vmap() before
calling this function, and flush_tlb_kernel_range after it has
returned successfully ...". There are no mentions of guarantees that
mapped PTEs require explicit access to be cached. Please double-check
if this is safe.

> >
> > Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pa=
ges_range_noflush()")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> > ---
> >  mm/kmsan/shadow.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> > index 0c88d89bf0d6..212449db34a1 100644
> > --- a/mm/kmsan/shadow.c
> > +++ b/mm/kmsan/shadow.c
> > @@ -258,6 +258,11 @@ int kmsan_vmap_pages_range_noflush(unsigned long s=
tart, unsigned long end,
> >                                             o_pages, page_shift);
> >         kmsan_leave_runtime();
> >         if (mapped) {
> > +               /* Undo the shadow mapping set up above. */
> > +               kmsan_enter_runtime();
> > +               __vunmap_range_noflush(shadow_start, shadow_end,
> > +                                      gfpflags_allow_blocking(gfp_mask=
));
> > +               kmsan_leave_runtime();
> >                 err =3D mapped;
> >                 goto ret;
> >         }
> > --
> > 2.25.1
> >


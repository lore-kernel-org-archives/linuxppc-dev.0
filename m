Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77473606A326
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jls4cjkM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyPy6xjDz2yLY;
	Thu, 12 Nov 2026 09:10:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794435030;
	cv=pass; b=lotlKfE/XH/Fpc8iucOfnpVuA2pDEnFmONC5w5vqCuq1iAOpUochsJFaFE6LR9370LSSb8Pk6rJ5kLZRJyPy9iGS1kZQr03qVqdH620VYqmz6I9JE0KRsUyvtHXbTZCz1Qd64EO8QT3n1hqveV+Kweh0Dm/dWT4acDoONe5agvV2L93RUcQ0sHTkpPGXhO/R4x7ON55uY7tWh7RUDHttWkSNm6IDtf7NtnjRIKzQ1r/bAusgQybJ1P46DrAZKRBsSqKTSintAMrQA4AnXBHY/mrke/lt4/wHs2yW+YZ0VHFnBHYC24zgETtpYvY5rS9Z9c+/KGzSIz3Wqzz7CZSlpQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794435030; c=relaxed/relaxed;
	bh=bLKfpDlOWEozQoVsuZM54f6sj9dITZwkN+hPeWugxEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAR8YtbIxoH2ehOB+luMBGLnidc5lacyOmpkiAWB6KGME3ZupdDKMqKH4pve6xJ27mQ7TUl0MZhjGa/a/YYj9GQmmhiGpevRWzi2qCBDkHrYlN6ublEqjVWxNsC97+IxGFN+aTNPmuA76kLmvhGjM7j5CKPtfegZKm3DlDoLMsWq/UOwrxtnGqn9ntx2OmwuRv7qvTojWLik8TIYo7MczWv8G7iKx9Ad37Dmwp7V6tqyzrdUWNOxHgKuVLBbV+gL/tkknpVLWndaJ+cYclLh7kSeneY+kGO7VfduUb8pqtuwAlITE+rCsgQtxGLzUKJNU0oWhrzbIkgoXhvDIl7Jiw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jls4cjkM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jls4cjkM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyPx6YZBz2yKn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:10:29 +1100 (AEDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-535f598d126so18541cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 14:10:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794435027; cv=none;
        d=google.com; s=arc-20260327;
        b=lJI6zChqVOu5XgnWHnPDjdFElIZlC04B6qcNxi8S5bMyKigMaF5mKsVLjXY5hlCi5Y
         K8ieG8+N6iyEhyrPWLSX05JnX6/iRTYmPEVyDCQh080NuRmDXSFUTQlPt1uTyYdTd1el
         qDVfgAJrpvYjqio1hBFcvcQtiAmrAW12N95J+dnxypLmAovKJA9tRLfEffaGsRhJ9+Um
         3dWty3DSXMVDJW1jAgCU1jeb+eCd+cYFeNFMX4v/cns0+ZoNfFE2SlrmNTITmbbO8DQz
         O/Fg6Pci4GR9CL1lJi2FiyhgQd3ZN52YgS+1D7aSta6JVbKhCb/RBtIqQhuYUGmdtXdU
         dKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLKfpDlOWEozQoVsuZM54f6sj9dITZwkN+hPeWugxEc=;
        fh=XYbRL1hhFIxuj2f1QrgXLN9BtegVfx4i5PRQXlkPbkk=;
        b=gprxYLfmNynLK40TGNlKUvNryqQyGyf3y9Vn5hHHPAcnNpWDeIBEx5HE2KzhFuSlRE
         oq/cH/HAVNvzQgFT869OqNYR/P9fRbVBOgWZW4T7aqSX1BELzsOlz5H7OGaJWpnE9WLs
         eyIvqViVdrKqZye8u5HQTTY6Dij27d3Dy18itmNhyxl2+S4zz+gty2uQkGS1G6c3Z5Do
         28bHk70f3d1/vsaYhCEcKCPlrjFzp/A6zw2ZbN223zBw6CPL6tyb34wrX4t//IkJd2gc
         9HtrSRybUQgNcG48kZMspxcZgnPPP6s03lods3WzULBD0GfIISO9Mu+AIGeV+zDAaC/T
         dEMw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794435027; x=1795039827; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bLKfpDlOWEozQoVsuZM54f6sj9dITZwkN+hPeWugxEc=;
        b=jls4cjkMJ1ia3lXcaqdU/ZaZaLTLgiDGPvOPbKBFwmbIM/GHJGxPdFIr/+pUzyuDfG
         DIR5jeGe5c6r3Ep781tgRgRpduZixhozQ24867zVrJYK8vi5SmJx6KvV2psM9WXo17q4
         onyGyKe4hKrRNqc00+Zpt/RpvxTB/ELW2q5bgO8sXlPUszxu6HecPMgV6e5lDqK+ky1f
         8KKFFeO/wp1DfEYEaTVkCM0IGL9v7+ObJQ+d7ItT3JgPglNYSHEi6VIIJB4gml2F46NS
         K7mJl1065Fj2SHvLsZSp1x3KUkiavIrEbRPQoHfyQfwabVyz6j+Qai8MuHlEurx9Z7oN
         faNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435027; x=1795039827;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLKfpDlOWEozQoVsuZM54f6sj9dITZwkN+hPeWugxEc=;
        b=NbHGGbUL4v/mV8oMcrSPeMTY/OLqMqzra9jW4pxJCWrBLg0PbRCTfk2BIOa160FbYL
         H+0BBQRvsQlzuZxUoQ1h3DvliajAlzymjCfoKvJflTBMqkbemsV/h6Zyh/sFF5j0LFwM
         Kg0BroETT/oDVOWdM55m5mTkjFaBoqok9cVk/pLfmRMR92CiiZt7YaGa0TVvrtQQp70G
         zU1UlRHYuzkfS+QmiNkE0zijJgId926nL5cebCtY1jPUmQu6lyK/i5SSVuV/zphf19jN
         B07DN6jYmnzfUoHhD7ouErXHtVLhSosT6WJSdg3XcMYEt6vMCzBhQoJ/tazgDoHv3YCW
         LTMA==
X-Forwarded-Encrypted: i=1; AL+hErHIy0WvU35NgM/2mfxLHpIRUZ5T/QxISsuFqvQFXkDMiNrPNmALElPjNBSZYOldCx8Md9lHuet4a+95evc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8XllFsXIOCfhYPJ5xDETbhy5D42K/ABtH2Ao6tabCc6wqZRsAe
	9Hy87rvINMmIsD+YYTm3jh8ZkXkuSl1OpfgV3xLYekjCUFEcz4rD5G6oQUDRfjMXNn9q6CLxAjo
	RnBEHtB2Trau3LCdh/XngkR609M/K3do/TP2iDk82
X-Gm-Gg: AYBFou2jC7xtz8ezGGPLdd0SlsUfILptl/2R0OAx3Y2xm6R2x56/SRPeEWMiDxpfmoV
	D7y+BMK2E5fp+f1BxjNMXm/eqjyFAuzBRjE/eAvJzcK5ypLkyR9SZxdy4PswC3zFqFwG/GyMTXd
	1Cn3L46vW8faaX0tY3uhOXbLhZQQllVHICJ9ukqp5oWq+SuR4Edheqg+go5d9H3/kH0WuxBE67/
	ofd4B1xVP4ingMqdDd5Oq/Wa6JDbNDcoSQkuaMxNohJ53I4w214HreSDn7CkzHKTbw6SBFplumF
	Hq1laweXGc6O6j1Ef/fx6A3UEFY6yCUa8miHJ/TGdl9fUJFd/N6gzeEmVRsT6sxHZeDImYGEj54
	ieRWfo8Alya1KfZ+eW4nObgnvbgSCfAwcFcJrFyVWZzFVP4JLv7tjj2GG17sW73UMaTjq9OKK4L
	O/lYdZqm78yrI5J/EvvlnTAB7IoXM0OkhSeUqWtOSrxMyp/A==
X-Received: by 2002:ac8:5c84:0:b0:534:d386:c3f1 with SMTP id
 d75a77b69052e-5598d505571mr2244351cf.9.1794435026089; Wed, 11 Nov 2026
 14:10:26 -0800 (PST)
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
References: <20261110112546.261415-1-hao.ge@linux.dev> <20261110112546.261415-3-hao.ge@linux.dev>
In-Reply-To: <20261110112546.261415-3-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Nov 2026 22:10:14 +0000
X-Gm-Features: AclHuK_l3jxTpbDz5cj0MqeD6GMw7HTTKbt-o4s7KQ1Qky5aunw_Bq-cT2pqqvA
Message-ID: <CAJuCfpHneeqRFOXyzCPPPa66xfn7Oa1n5m2N67o_pVwJfNgeXg@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] mm/kmsan: skip vunmap_range_noflush when KMSAN is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
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

On Tue, Nov 10, 2026 at 11:24=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> kmsan_vmap_pages_range_noflush() returns 0 when kmsan_enabled is
> false.  The unmap side does not, so it still walks the shadow and
> origin page tables even though KMSAN never installed any metadata
> there.

Note that KMSAN_WARN_ON() can reset kmsan_enabled flag, so the fact
that it's false does not mean that metadata was never installed. I
think a proper bailout should depend on CONFIG_KMSAN, not on
kmsan_enabled.

>
> Add the matching early return.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/kmsan/hooks.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index a706666db097..107f66841274 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -138,6 +138,9 @@ static unsigned long vmalloc_origin(unsigned long add=
r)
>
>  void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
>  {
> +       if (!kmsan_enabled)
> +               return;
> +
>         __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end)=
);
>         __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end)=
);
>         flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
> --
> 2.25.1
>


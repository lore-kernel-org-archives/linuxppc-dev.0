Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B8B606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gCsryu7g
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVBDK16RJz2xdX;
	Thu, 19 Nov 2026 06:16:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795029409;
	cv=none; b=VKRK6Mq1OF2HDDV6Kjq/h5vtEhEdGqs8RJfJkAnEAmfocoN+C6p0/yCi4Ohn9N7mG0GM3Ji5NYbG4D04WhHzEpKoTFgteXqwioAucbQYEyBkRQKvUkkXumOuZk5F8gkKT6OPC5wfYJPJHx+0HgmOhSC0okAfVtoBURBsUvlWYtbNnD8umiITBtBR/fQbbkkaanu4lj9XmoEAWxWMb7N6OY7LEquS/BVIfEbH4Zu9/K5QdUsQfRlAYe8iCxYKH8gq5wFOiTk/9nAaoAQdqucziBNx7abqhbSo1D1gE/AdvySgVsR5/a5TsFlojaWKtrDn+A5wEhMq1hmX4GG4w8sHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795029409; c=relaxed/relaxed;
	bh=wesoUpV5LSWdODsu/SFZafU9p7VW5qMB6GV5WAXmCps=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dS7HsOwHJIXZB6hDqh/8HeAyA5YjLC6BGu2OTHLuqz6TKsZsMoTFUi597jiybInm8FzZXVXYnZIzlYwRCaqLqZ2S9Sz/S+DYrjUMIIQfHp8ZSDk5TROq4VvmabHGfnEHpmo1ymR7blVjbXZL8nO+yTmm5ZyiVSfin5NJHi/aRvtl94gILaU0vmNQwaR1LFUnBYu4MEhkXtAbLSQoyslZ/zF3mV//26u9o2EY8Wt/Eb0a9VAIuB2mEsF0daFBNU1xvT2yUw+cTPHoDyGf4i3EHGpF1DALfHKjeKRQhFkqm5PfAMPcod2B0sf/Xr3IoiKMKZ/FyzoaSJSGMTyZ6F2eVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gCsryu7g; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gCsryu7g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVBDJ16Mxz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:16:47 +1100 (AEDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-c5127c7abd5so10633066b.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 11:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029404; x=1795634204; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wesoUpV5LSWdODsu/SFZafU9p7VW5qMB6GV5WAXmCps=;
        b=gCsryu7gbNW5cdJkZgR+M0Bh0cf16Lf3uwwReFxfVVxsC8/JSAFCGVpozLFXU6zKFJ
         Kyr8nfsNJO//mIs5f36+WNSwutwtcsBq6sETypoq9UiRz6B4eHin0HjvVWPVY+RwltCG
         kD0io1yx8i8Y17jte/rrAsvFkI6ckPO+YWvvUyd0UEtabh7w9/LhobltDveWYNYpRcok
         qN37wG+wa/KeN1Ph0RTPGN2EXUaiRtTlvUAoltFZYc8yQFqqeIBdkZSHdYQOGp3YCPpz
         nWJTRXejysbcaYYMhB6+z65TkzFH5nNKymzxD29zX0S1ZTBzqaoXPgT5hWYaRziynASH
         aDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029404; x=1795634204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wesoUpV5LSWdODsu/SFZafU9p7VW5qMB6GV5WAXmCps=;
        b=JUYeoEVRGtcoYKeMxZrTlUySNxIH5wtMv2SP6Jws3NDr7mDWr4nxcx4gtxqOL4YVXL
         rgjhi/TWrHqHw0y+my4CoQP3gUzmXU7QQ/TiVaRdzpfJPAdE4HqjGaslLYlOgpHgGHOI
         VpC3ZJaG41v76s9VqLVVFxe3WSP37+Pkhxh7h/XOvhvN1Q3A30QG+vKbxD7qyu3Ugrz+
         W2UqwHA+2P4IsVweHjq3dblKTL1uui0GyxoFScj30ZJc4UZNCR5k6rERbDx0di++vdZj
         s/aDACNGCy9B7wuwv5YKc7kQYzj7dJ8aZ5gmLwFkgsybu1YwiUrODDN4shhkzhFtzQ1r
         aN3Q==
X-Forwarded-Encrypted: i=1; AL+hErFj7JyvMNh2GEi7qOHyvTmOnOMpYapTvJQC6e4tKDq2JWC/x0qrCiVk5+vR4tFgIdi3XJI8yTKjSvIHxwo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9hfN8exHhjysGMxt6SDAnFcIr3f5eLUe7rEz4sbyXXPTD/ULs7
	J2wIAb8oKBPLxK3j2baDHE3jEzWll+CBcat2SntpOVL1AzlsG2AKBepX
X-Gm-Gg: AYBFou0//T7zOFKHo8pRaBHsLbY6b7sMZJJfGLtrXLnj8PIVBi/ds6qjtwhDULrja6k
	VlQmf89wuLgyeMCYRe2xay4xoJq3mpmPzkb0N8O4TdtHzouuuX31AEay1pbQqpf7poFDvmjLlR6
	b8ROHR7NwKnSMvjF6Fv9FLlE9Xgc1aIrBbiCyXw5pFwWFwUqQeJPQ3lPRx2yP7Bdyz1fDhq4duJ
	yBgi45uUCRJqBvHrcRKYiyYeZope36l5qCg/Jtf3qmTBymPg14lm2GGqXqRwr1X4Y4fQCmj5osv
	13sw6e3G/4h8IE50DHkaABIxNwgYXEl5WyUgyHO3qx61l53PKWLTga5XWSz31Tq3AZMdSfx93eA
	jsHWwPa1Y5F+7f54KO4Sbqxhnep4NB56piPo3p0PR9oHdZ37RbYD5Ra94vCnE4iy26zDDrVXwIL
	q7tCsP1OWXXbkY/vH4vljQVYNKrJgBjnVGukk4vOJASjczrevr7gsAdBtbO56YbPZFM8sDW8GfC
	qZrRLOFRy6cIJcJCnpjceh42HBpWhh8pSpyMnyachSCakAnp8BKuTHoD/sQLarb3BlDgA==
X-Received: by 2002:a17:907:3e9b:b0:c50:5186:a428 with SMTP id a640c23a62f3a-c510e2d83ecmr343950166b.27.1795029404223;
        Wed, 18 Nov 2026 11:16:44 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4cf4sm30980066b.29.2026.11.18.11.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:16:43 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 18 Nov 2026 20:16:40 +0100
To: Dev Jain <dev.jain@arm.com>
Cc: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 04/11] mm/vmalloc: reject an unaligned range in
 __vunmap_range_noflush()
Message-ID: <av35mNq7RrxN56Tp@milan>
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-5-hao.ge@linux.dev>
 <4c233641-15ad-4e5a-a106-423bc31f357c@arm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c233641-15ad-4e5a-a106-423bc31f357c@arm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 11:35:24AM +0530, Dev Jain wrote:
> 
> 
> On 16/11/26 12:43 pm, Hao Ge wrote:
> > The PTE loop stops only at addr == end. An unaligned end is never
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
> > @@ -523,6 +523,9 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end,
> >  	pgtbl_mod_mask mask = 0;
> >  
> >  	BUG_ON(addr >= end);
> 
> Nit: It is usually a practice to change the existing BUG_ON's to
> WARN_ON's too, if you are changing around that part.
> 
> 
> > +	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end)))
> > +		return;
> 
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> 
Agree, please also replace BUG_ON() and feel free to add:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki


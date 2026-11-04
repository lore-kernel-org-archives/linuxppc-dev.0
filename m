Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F196E606D81D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZhtkiaTu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKlqy6jSPz2xNC;
	Thu, 05 Nov 2026 12:59:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793833077;
	cv=none; b=gDIQavHKQLuHcBjNsecQfiIF36gUokPR7lICqGuoluiKO/xQNv50230082Dyoe2bp2FaoxxzO2Htk7b0s+jEI6d69GcWL1gcEk207qpqVekmq6ZcE7wLvSdd1ZG/tCWrxR2OmIQ6dmGnmNwyPebLJolGEvhbBFZtOZ/kCj3oY3pSJ+8YFA4Ia2fyGIwqOAG6wvqX2c7Xs+pmnlUdLOzabg22vtgDYbhRgxMj1r8Y6NmJmwo6d31NW59SpHRBO4Ptd950ICfqw9gr2zLuvcg3sWDkoapHccemXb1NuEyvxJWQTRZUPG6SnTW1EyNIGRXZt27xpjAh3gsrxPiXvoBAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793833077; c=relaxed/relaxed;
	bh=bZmm/fjciQHFDsHygF6gqzElYGHv0HpumcgfM0NGUjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHr+IWFVxFmW2poKlEgh8Mk7eRC/cv2F9TPBUZBKmW1HcQfs7LiMwJp45e4YnuqYo4RVXtLuGOiFeaZXP7f2BlTFPOrMuDJR5H41NgeaCFkuBrekftESQvKEOhwEMoZ8lp+0RdVAdh1BBMA7ra7cluTfQLuHBaBms5gmdU7V/fjIOX0aEZKFJTWJPfkhG9UFCYAOSlD0Yuu+gfWZJwTkF9LT6bx5pg2uAFghDyLFskNO81ktGHDfmQ+C8Dg97id8zckY+9EuMnpzd95iG7k5poquLTj9a6r8a6EiEZcTZN1j4yBblXvLzp3PsfgBlteuBBWqucAEOfnTvc/LCXQ7vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZhtkiaTu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=azpijr@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZhtkiaTu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=azpijr@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKgnv2jTPz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 09:57:54 +1100 (AEDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4a214af2076so8994415e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 14:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833070; x=1794437870; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZmm/fjciQHFDsHygF6gqzElYGHv0HpumcgfM0NGUjo=;
        b=ZhtkiaTu/W9DdtytpRzEx4W/mgoOkDVmLEgW/y/5HZ8ZpVlLHteJpaeGFIphvDV4sR
         3dDcGdVgoDofHNmJ3mZHgwltZtJ+NvBArn3pgoaLT739TaI+Q5XgCWn0ST6p5cobNc+p
         xVuWGMqeakUqJxk9jfjb/mo0ksy1a5N8fzJJjacp9LbYXN3hvKwYPpXZTwnv93+NcYgM
         SbxdYdorN+Bd1tdLEtwPX3Q1wRb0gu8PJGGTp6e5xSP8+VVE4myk/kNZBZUh0lJFXrm/
         5zzOPdYQeq7p3phSya0geH1T+U/9x44p1uuqZVrjKyuB+KSZUdWmt9qEbvm8f1SKPit8
         LQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833070; x=1794437870;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZmm/fjciQHFDsHygF6gqzElYGHv0HpumcgfM0NGUjo=;
        b=j9VYFz6Dx7nI+rF5fOYCwSouF7ioHEGNy4D1utrGPE11xEKXdaRjEg0Io4+dP+zHQc
         WYEUqbmosLUx4BB07uikXwMDe0/TDxlN0iaClamk0M7Tcr5wEltoAZynGSScfLL2S8RF
         3PNaB5NEQ36DEuWkmsKvxaozsFadPuqCJVJQtlLYmVxR9Ch9LkFKNHc5K5DaxfxMpZmd
         8WPZgOkS8F4hsiT6+71HKskQ6QWZilVD+4gMihNLbrjc6DzVZMF1KjUvjRoHzE27mQGv
         +Q3WOW1aDxiQr2zeEIgZCAXb/1/PGptULusygXwOQ8+knjNxYzC8OKAn3Yc3OQ60M1oP
         AHIA==
X-Forwarded-Encrypted: i=1; AKwUvByvpX/dWT4HIfHqciqpqO+p7EyN9itCLxdLcuhOwi87KDy8SCTnC0qf9+dM/LCP2vrStzmMoPf5d2poB9k=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9fmtD/9ReMOgNKTEY5t/F4Y2P+98zCjY5up+xgejqXLMxXGM0X
	ihHeJZaxilwpibJxxxfinfzZZrR/8BEQokgcyvU6CXTK/EXsExVa+Lug
X-Gm-Gg: AYBFou3Vx+IcUlQggKIuRBzaUX+DhuOGGbJv8DrGxFH1Ks4ndTQ8lnpRj0wly8du0Gg
	dWRfxkQP8hEJnBOVA3DFzDN9ZvthQoOJvrZLKT1SZOg6BKNb8i57ffWzlpfvm7gJ3IEILC9g6eh
	x4YX8GmWVYnmUSwivOgwByDHKDapMo/ipWVJlU/uXsIjRHqwpmzHimRw3zaG6YiQZZ948+x4My8
	6X9L+V0bENMRKsAfAzUo+Gm4OhPWhtXGxsCGAAFFnOKdsRK968bOf+vKmlJEIa1sp77Lam4PLkC
	mcfmELnsLJX0DLytNNtDX6kpCiot69Lv2Id3z/E8OKnC4Rf7XSxkh6TO5jPf0tU7kCF6zD5Pgy3
	fq2qkNQ5tltcebj7RKBP5MLt3k8BVyXtItsVWuUbKoAD96L/aQis/G/LeY+/1ikA5iZPC0rJIkz
	4lVcdx0TRAu9Lf8I3WRX/d/QCt0QKS+l5ckUpTtc6XDXxMhQxXw8sIgfAmwE7wI0zfS9h/kqHua
	V5+GtIJtJKJHG8NQkFB3h/9kZ/iO18JIMNeeWqfm7HZR8UBevgOeAlSfES/tT0UVvnfyDt2MPkR
	FOQcrji2DJsLMfHm2y998bI=
X-Received: by 2002:a05:600c:6212:b0:4b0:a7aa:843 with SMTP id 5b1f17b1804b1-4b0a7aa0a54mr222825565e9.25.1793833070285;
        Wed, 04 Nov 2026 14:57:50 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b5725061e1sm17756545e9.7.2026.11.04.14.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:57:49 -0800 (PST)
Message-ID: <93d13781-0c37-4a3c-8fca-6f8108eff35a@gmail.com>
Date: Wed, 4 Nov 2026 23:57:47 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-1-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-1-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> folio_dup_file_rmap_pmd() passes PGTABLE_LEVEL_PTE to
> __folio_dup_file_rmap() for HPAGE_PMD_NR pages, so it adds HPAGE_PMD_NR
> PTE mappings to the folio instead of one PMD mapping.
> 
> The helper has no caller yet, the next patch adds the first one. Pass
> PGTABLE_LEVEL_PMD, as folio_try_dup_anon_rmap_pmd() does.
> 
> Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a


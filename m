Return-Path: <linuxppc-dev+bounces-22575-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDBCCD98D6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 15:37:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcNv76fVPz2ykX;
	Sat, 13 Jun 2026 01:37:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::334" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781278675;
	cv=pass; b=Be4YV3/bFhnquDsjbweHMhFF0B8TCmsBsvYC2RtidUbxKC8mGnLpC++QID1+wr7f8rc4uOSnBcGMFA3ezzLQYDKTrPBKNv4x7UDE8FjBH4H3weZ/2Z5A/zZju/qwLVKdKtsaabqDnmbOGNDJoiurnze8vb+QIf2BC8krGWFkr0nYjEm9sht7Oaf0CH7C2g0AIBVyB07zRRZ/1BAi8ZcHFuP+0md0ikz3j+Ghokej0N9YcL9Mk8EnSsVbTzjc5fL4f9Vn3gwKHE3+Sib1xtleZk7ynMoF5hd2gzK+MPRFx+IIJcO5BUUpKAtXOQ7PiTCNw6OD1ikMSlNb6rprE0an7g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781278675; c=relaxed/relaxed;
	bh=bSvLr/lAiEeyR05iNmyP4S5A6xbdgQJ1b2X7JVpkEig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyEY0taPWNe0G8MPuPcpMk9UfAIv9q9E0XsaPlZNAnS1m7WMn3iWjV66lgQLp3vINX/WTnzhFGhHlIcFO16KO0ApreejOD9+vxZqxTSxV42XcuR9NmjuTKaweFfOVwLh0FKVuKBw5JBHUc8DRpnnBgGHEKQsr8ggsyrVzFpFU+VKMlkwTKG0cCz1iZgeyzGAq0CTeeDc1fzG/Fj1X2kdJEqW1ClfV9ZiyVCJiHoGi36+u+jMSsKkisBHQPjJtFlDpNYsfDi9VYkN4MccPpf6HZPrLdO4v9szoqSmaHEmERsGu1OrK4htkIPzPfqxau2kZ6TpWxKAzjXPH1TsFercsw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NYDpdeTq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=fvdl@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NYDpdeTq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=fvdl@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcNv62Td5z2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 01:37:53 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso78255e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 08:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781278670; cv=none;
        d=google.com; s=arc-20240605;
        b=CJi5WMg2bbnM+t609Xq7ddSrhfxelObt7T3cycJdKUJ841ArRegbt0WTX78Zmpk8S5
         aL49Fg3NE6nASwIfeSXUF/AOob6ymlGgkPCcOXb3gqJUraEtw0XS9SMYHTaSwb9P0/aU
         4YVzWdUBqOnsbpOl9fzDeQl35kannWi5jDx995AVTXoTx9NfDc2g4+ERpff5JkjEpN7i
         VOs/dBJDTG2FprCf02GP1AguaYM0ESqBpKImRlQ/sml0vC/PMJbbiYAoH0zAZN91RAKC
         /fcU5i0g5Yq8pm8Jy2o7LQdtKPdSHfH+M+/YKVihaPPDIq3UTTVujzzh7OAo1x9cPqYa
         f7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bSvLr/lAiEeyR05iNmyP4S5A6xbdgQJ1b2X7JVpkEig=;
        fh=XzEtsk43uuBNgBWmJSGfvOpiwi2oyJElMRYlAqYAAz0=;
        b=UqBnULFQcljJoTBFLtcrLm54qz/Y9KQl6xDWFJzkehQRYk4LtMrDIMvQ8RVBlxbcuD
         niCg4YYZmskGsWIIL6//0U+3JdwOvsYGdKRxQxdjqMSW1Yo/F2jawoa1dbMbyU5tKP8v
         90H3CqGCfB7sq8t+XTESqGuxvntbMh+5U63IGlxUv6QTyn/os46o0g9Pjy9Ym7wTk0HK
         K0XUNsoj6m0kCdNWovzNFvG7mkFAXVqvu3g0znc6TZ1qi0pKCzXCp7o14gy5oV/0klr5
         hjRjNhPA3jKRCSHCYSaSstGkQ+b0tFy6tQ20HyTkWytE2Hsbvz1DRql96pWJtqN9KhJc
         XzTg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781278670; x=1781883470; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSvLr/lAiEeyR05iNmyP4S5A6xbdgQJ1b2X7JVpkEig=;
        b=NYDpdeTq9920rl7kCjeIUv01NUuW4zNXpN0uO+u3JIBNp0TBb+Txa7Hj8LUCOPhO6O
         4FdGnF2qffbRLHH2H7rBfyQE0b505rnbpOiNNjCL0zXtYGkhlYA5MPw+bd+OauqP5oHJ
         iNrTgOnXaNs4zISr/VfI/HvJYDXf6mcF90Z+Jqjr0n/mIVadfH08Ucs/bpQ4AWDcn8p2
         Gkbwa/mGAqsBZiT24qT/K0cAPfwRzrl072EQ7Mv83TK+SE4oTskUNndXgL5gNNsluIjl
         UmvQemuDOcZ2ymqGCVlNDRrh53gUXiGqkezb0iuIwdhOiA+mvz2WDrC03Ka6IxLNUttb
         KqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781278670; x=1781883470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bSvLr/lAiEeyR05iNmyP4S5A6xbdgQJ1b2X7JVpkEig=;
        b=Js52HcJ50MtDoRNZN2MNiPuZwXEGjgkZ5KinkzhU6L4POk9Gje8TYkk9y03AfiCrSG
         h/qRDLG7lpVtFG7Caz18nCfg1pzbmHqM5OPbaj4QJ/YsIIfMAid41PCU6JN6tK/riVv6
         QUP1Q60mCrwrCpTBYhm0rc3Qvyw1Eqe4LrLPzrgVEOVcK4HkcpmLS3RWNgABllMPLCsj
         v8Js87HfRcWXOmP8Nqvk+IyOvoEst1rv2KQKOWHaUQVC7SIPMIHU/18TYH0ogpuZhU45
         6SKCm4o+6sbmZRexeBOaTkXux+pGMHY2nyc8LZTDwDm2QfyB8VbaUtYhfXoPhMH3Mmxd
         xMcw==
X-Forwarded-Encrypted: i=1; AFNElJ8H5VSq9ghPFaA1eMPHekvCseTEfavyQwCYYs0pZWEQ27xuyiSxp0GQ09N53ZOmdhcydrW/REhrJ0n2RQ0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5/Hk5dwbReNzTclePNcQfAPc5+K4E8NWBmqGJ+eDM237B3vBe
	Wyl0gR+CYeHvxThzgsa5sOCTTMhbhScr6hO2R9A8SSyH50VAjAV4lgFyUyJDGUvGTXe18YoxTBc
	G/f+1A1gqP2fbvpqCUz0WbiT8hHeGD+4qm4ICzVnT
X-Gm-Gg: Acq92OHGVLCadKYg5ezPzQMxjPCFbQfGorQv+e8P6NVDKnys5RaksTG/Xvs95pbboJK
	9w2gDlQwZEdFZFM9+iFDUL30OSvcfpK6chk1THVn2CXWiA2axpdkw6uc7bhXyDnlPvkQYNoeIco
	iT+ta4n7hVuGTJQ97wpqNU9wiyETHY30g84NwnQlVsAeS8VC0enec68RwlCCPHBZFK5uJpl2HRy
	+0/eyYTtjQcZyti0/gcgO8Td8lcjZtJhYIZ0xDURPPJYWeV4UgFGcjSBu2pJUAqrJ6L5rH71LYp
	0OO7j8Y=
X-Received: by 2002:a05:600c:604f:b0:48a:623c:8859 with SMTP id
 5b1f17b1804b1-490eabf8ed1mr791455e9.7.1781278669647; Fri, 12 Jun 2026
 08:37:49 -0700 (PDT)
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
References: <20260612035903.2468601-1-songmuchun@bytedance.com> <20260612035903.2468601-3-songmuchun@bytedance.com>
In-Reply-To: <20260612035903.2468601-3-songmuchun@bytedance.com>
From: Frank van der Linden <fvdl@google.com>
Date: Fri, 12 Jun 2026 08:37:37 -0700
X-Gm-Features: AVVi8Cdc4B9DOI5h_B7aQcyBPFaEKb3BaqoI3DRKTY6Pl2XtpJFskCaA7xImrJI
Message-ID: <CAPTztWYx-_A8Jq=U+OGA4y0LUWkKWJxutOzyHJ6FeR+C2gj0JQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/19] mm/hugetlb_vmemmap: Fix __hugetlb_vmemmap_optimize_folios()
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 8:59=E2=80=AFPM Muchun Song <songmuchun@bytedance.c=
om> wrote:
>
> __hugetlb_vmemmap_optimize_folios() uses incorrect arguments when handlin=
g
> bootmem HugeTLB folios.
>
> The section number passed to register_page_bootmem_memmap() is derived fr=
om
> the vmemmap virtual address of folio->page instead of the folio PFN, so t=
he
> bootmem memmap metadata can be registered against the wrong section. The
> helper is also given HUGETLB_VMEMMAP_RESERVE_SIZE even though it expects =
a
> page count, not a size in bytes. In addition, the write-protect range is
> based on pages_per_huge_page(h), which does not cover the full HugeTLB
> vmemmap area and can leave part of the shared tail vmemmap mapping writab=
le.
>
> Fix the section lookup to use folio_pfn(folio), use
> HUGETLB_VMEMMAP_RESERVE_PAGES when registering the reserved memmap pages,=
 and
> use hugetlb_vmemmap_size(h) for the write-protect range.
>
> Fixes: 752fe17af693 ("mm/hugetlb: add pre-HVO framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/hugetlb_vmemmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index c713c0d2593a..ea6af85bfec1 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -635,12 +635,12 @@ static void __hugetlb_vmemmap_optimize_folios(struc=
t hstate *h,
>                          * mirrored tail page structs RO.
>                          */
>                         spfn =3D (unsigned long)&folio->page;
> -                       epfn =3D spfn + pages_per_huge_page(h);
> +                       epfn =3D spfn + hugetlb_vmemmap_size(h);
>                         vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio=
),
>                                         HUGETLB_VMEMMAP_RESERVE_SIZE);
> -                       register_page_bootmem_memmap(pfn_to_section_nr(sp=
fn),
> +                       register_page_bootmem_memmap(pfn_to_section_nr(fo=
lio_pfn(folio)),
>                                         &folio->page,
> -                                       HUGETLB_VMEMMAP_RESERVE_SIZE);
> +                                       HUGETLB_VMEMMAP_RESERVE_PAGES);
>                         continue;
>                 }
>

Thanks for fixing my mistakes!

Reviewed-by: Frank van der Linden <fvdl@google.com>


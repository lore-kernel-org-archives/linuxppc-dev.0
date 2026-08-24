Return-Path: <linuxppc-dev+bounces-26066-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B513C5DF9D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2026 15:45:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTFbx54Gnz2xpv;
	Tue, 25 Aug 2026 01:45:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787586317;
	cv=none; b=D7Zzj4sF+U4uYcZZR8ijFpOCc7WDrXHnSIstkB2EqZf1qeNsXBb4c4pFBbh9JYCpqpXSp+YozUb0pt1YkThyAOi9S0VNf3yhQCsIy/244pQRXawZimY9Dtg500eNkUbhDD9AdV8fVkED3BMG8O0bV2LHMxB4aAZ/viePgLPZl+p77EmIzT18PHXjFvsKeqV5pE/c5SxGp/7DRlLpRMMTYxS1zpIt0CTSV0X2EBme4ufJhYuO5ABxsxUvvMGAsNQCbP71dJFlU5OuT1iH0+OdRPsmPCsRDtMtDBXWrbVztOvHfWGsE8iTO1HJ91BmThNjUunEMsS8k/f+nZS5wY4HlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787586317; c=relaxed/relaxed;
	bh=QEtJVtkW7q375yAi3A0GskrIJ2s9H0yJ3yupt0Y509Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TagAOlOScV5zhC4rPFAM19kfV4c1TEFfZGC6bAqZqLi99BDIjxUL3+BZEzOXMmlYm9ZAHnyXX+XwWhUaKo31nFivf49FJC2r2K1yOt5481ZBjNptBqv+EdcAGXryCWzPLSUJcHtF1fEhvg5JWEWuwREYjsTs8XLFFYBlwjRrTobQnqv0mpIgkyrr2f/Zq8N2mO8In8WQ5ySmAOnzF37EgkV31qEoo/YSvaBrna1+K8hVLCsjkBfMhfXm4DgD175/ElqcnZVgKrBSF5hG7us8H4eMchAyD2b7SI3YccJPsbgAmkU+j5Q/oKAVd2S9J6bPlI9CShMk7Qij722GPtVXLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=FOOFqf0A; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=samuel.holland@sifive.com; receiver=lists.ozlabs.org) smtp.mailfrom=sifive.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=FOOFqf0A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sifive.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=samuel.holland@sifive.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTFbv5tHwz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 01:45:14 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so2820102a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787586312; x=1788191112; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QEtJVtkW7q375yAi3A0GskrIJ2s9H0yJ3yupt0Y509Y=;
        b=FOOFqf0ASokvlP1oZgkLpBTg+LpiGHQ3FlHGI1tfOjEO5RVfmJaOrv2Z3O0LkqrU3Z
         hMQorzqdbQiJSNn0Hgh5WDfvN9QliPJmwqKFL8nlFr/FTxanH7gzjcc5hJZBHstBVyEZ
         SQvhoiGQjKIIvqLBdMTaX73tJv+Y32xGoF37VB2Z0XSGI/sdvLWzjL7MDdeulXPr0csK
         dQsBx0wGRbCutEb89F192qCk+/kwMrNFklYM1uyMBF5oSq1IfsXBrmw+fnoZgUhrAnc0
         pznDDFcaBph1dK7Wgk03NuRV4I5qNq1fdyk2nihG/OKCydWCJT0hejV8qv1q8X5i6NXp
         6glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586312; x=1788191112;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QEtJVtkW7q375yAi3A0GskrIJ2s9H0yJ3yupt0Y509Y=;
        b=PAKoJlRzed++FCqnfb3cnQKSdlH+tN56oed8VCjthqgFUCFun71n+Ez8gFl5ERvgJ1
         TczUAsc6WuMFoz5OKdJa7FrdzofL5yg8m3lBnWtmS7hOhwx8k58u1amZSCHn8GMTpwJw
         znAHXZDUGYl2INO6t6DivmuhA3nWoV0t6B7yxvqy9w3ARTuiSDbqKsv8LYEQaIMZwTnA
         GfEysJQPemPRAKYbr+7Z5SN35tG4SkFIW4zr/pi2T137o3ZX7BRAJiHMWL7kx/hgXqpj
         IySW5eZKHPVTaq14Mg8PE+zkfGUjNI+FhFluYUH6xO9/YSkA2MOvOLlhEVzpCA59N6dL
         nV9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqN+U3XKQZ77gDiG9cYhMcXrI7LH9+Qi0N1Ik9wjihZc7tlo9bVFXvwpjgrIZ8XrxqliPqtP+vz7PPX3BI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mV4JAXR0DYS43DOtdSNhRwroUha1eBecWr4QmuWjKPcKxypLZh
	v9FwZipCYlfvcZlIHjfr8/IksCL3bsUGvMGgWoji3xgC4tkUZWxVD48xxZKy4J6sKZ8=
X-Gm-Gg: AR+sD11E12256rzfOv8F8xid25R0BQzYPu1t6wva3q6EBKjAjyKqEtdVGvXxhTqxfwI
	cYJDc3Zz2FrGVYjKzZ4Gsa3N8QU5gh3zCwZoRzbPlRJK1LHjxlnSzFxDeXG49/NK275fUH+V24D
	KQyH+zp1xgUkNpDT+1bCjnIbRAzun6geEpX9ABY0lBBf/1N0vU03zmI/nLbzHxn1dH94B8QEIjx
	HRVJH0aFXyPN9+NtcLer310MwU/ORbeQISAhgblbPQPEjgSCHxnMMqppkyoKQG0sOCAlXxzcTyT
	oyuYcnyAstfklCqamP5gE1uUzZZohlllkKqPbQDlu+WLmfWBjkD1Jo/MWTjMywkl6ztVcYTFYN8
	QM/c82rWGrzfID6Asg3JrWK2jvu+bXgLHunXdqus2P63TMp1G+Asnlq1XNgAoVONbHGqiwkPYZS
	UIGSLqDQqM1cyImKrdVKDTqgdHHaruDm+NVPASSldF1nHxDFlGCJEyO86+W7HoneAfjKLTB0kO7
	f6s0yLOBXbJiVM=
X-Received: by 2002:a17:90b:5867:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395df4dcdbcmr39252435a91.15.1787586312489;
        Mon, 24 Aug 2026 08:45:12 -0700 (PDT)
Received: from [100.64.0.1] ([165.225.242.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b7ff6dsm23611a91.10.2026.08.24.08.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:45:11 -0700 (PDT)
Message-ID: <029cfde8-74fc-4437-bc18-b1b53d44cab2@sifive.com>
Date: Mon, 24 Aug 2026 10:45:09 -0500
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
 linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260818040041.1891769-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-08-17 11:00 PM, Anshuman Khandual wrote:
> Move ptrval_to_str() inside a header thus making the helper more generally

Typo here and in subject: ptrval -> ptval

> available for new users which are being added later. While here, also move
> another related string size macro PTVAL_STR_MAX inside the header as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/mm_types.h | 15 +++++++++++++++
>  mm/memory.c              | 16 ++--------------
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b18c2b2e7d2c..a5b514e55dd7 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -2001,4 +2001,19 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
>  	return flags & MMF_INIT_LEGACY_MASK;
>  }
>  
> +void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size);
> +
> +#define ptval_to_str(buf, val)								\
>...


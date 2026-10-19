Return-Path: <linuxppc-dev+bounces-29685-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A9DCCF2DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 09:08:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7V8g0f0Tz2yjp;
	Mon, 19 Oct 2026 20:08:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792400931;
	cv=none; b=hBZclZr1d8RMZ3EZvU2JbeOFXzMnRnwoUT90A7UJb3+1+PoC8igD3iIaFPyCfENpYxSN75NEUmGaKf+Ip4uc0AcqxhcI9HBoLIQcAtPOgDKFQTxfG3rMWOPqimPhqkNzgjn7p9jGX4Q7yKdUEiarMJxV5RL70q0JN8uAYZdMJo5jUIt/2iaVlVlxRDhNEjprhznMvGAg9EReSBm5xHhnYktg9dGVLKhyCQsU8eV96gvom9ykHXkoZva6WcBebe9ssf7IBeI1TG2tZsb7qr8nqokfElAjNkOWUPkfnYxIPu46JLSvMeF4WXKfBSg3rB3e6tMpA6/pMrwj/WMDncrQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792400931; c=relaxed/relaxed;
	bh=wKvHy7y34UnvBEvhC3G16rSuhlzefUt6PxJ3Dpiy+6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrxX4npLkOZeqM/IqgpNXCXMF/FDUfS6jCIqfGoOb21jmpXty649yFa8VeY8bCbV/VO+xRspdcMjKKYMqH6JkxhlGfMQJ7wT24XmXFfK4A4sgfS1rm6FSJoX1o6KvAuUUuJ/LFX7u+3aeuuqL27O8+EqTt3sq9tDlW+rg1besijg8xGlKcgLhd4H89IcYGrBJjV9lFil6vjq2+xpoy3tYs6wotgjmc/ULhgJnH/xuIO424i3OWp9IQmiNgXRRZRkG7bvO2Z6FZpcB8elF55ISdRKmtEFf1EQHxmIKX+n57lkI7okIuPUt/N8o4NN+r0g3HBU+5bmOMQ/ncugxXiA7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UCUuRope; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UCUuRope;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7V8d4glQz2xfj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 20:08:49 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2e942864693so8336555ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792400926; x=1793005726; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wKvHy7y34UnvBEvhC3G16rSuhlzefUt6PxJ3Dpiy+6U=;
        b=UCUuRopeQeRgT268SqNao4i0uKR77SWF1D6YWHVAk7Ob7tp1YWXh+Iioj+dm2fIETp
         H5wFi+UDfc0ay45os4tMrBYTUnWRw9rS+XFATggWYEnGUE6w0c99joFronDCpcmPOPpS
         ztIajxmJJZPF7rdsjvXEm1EX+FBTwo5m8BXUiwCJIhIYB8DjBhqCl+iHj5EEo8Yn1RjA
         pVM0dPUAAGL/L2IHpAZtfutyx2DezK8w2E11MoeV/1JEKGNHvZWcuaxKrpk34+69l5zV
         L9jrGYLx8P+1PVRi06iBTI0u3f3P/uXR72GpW5oczZYsXpxx6jHKiTFACMSHyALMsaU/
         Jlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400926; x=1793005726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wKvHy7y34UnvBEvhC3G16rSuhlzefUt6PxJ3Dpiy+6U=;
        b=UPrXf8vVRTAztV3OTkDgjWQN2R+tNyOWQXRdnF9P/IPZhOhov8lO/UOiuStlRC6W7u
         VP2uX1M2lsbw6wExEaCUctdzwrWgH0sPWFxwnEl7ocYIXJ8WJHXV/5gNPwitzKVI1QtK
         IpGpUomozSfrJeAVup3Mp7SvPC0RbVf3OG4rYqzBd2x88v5ud6V+0vWzKb6P0MIjthW1
         WzzopE/TT3v9+qrl6dILalO6UD6zVj0Q/CoNwscMkZj05jfLKtNJE+dlLahaqIAPAiEe
         OX9UGFQKwULh4S9Udzf4okX2NaNGPyYLqYudLnKleNDXKaPXESrsIAUcykde87OIWAyg
         wY1Q==
X-Forwarded-Encrypted: i=1; AKwUvBx9diALut5n5MTO/+RV5eJq+jT29LUabQC34lgw6Sq5+DznsE/iksn87MLazKoQhILi/nF0dVxSsVZz2LY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKs5bmIrXOsteGdhXTN6sEMpZe2KiTaF1Z7NnuhzQ5cOYjeafge
	6T6qUp5NUKfymWq/S9cituWZdWeB9LcCeNYcGAlM0DSoHvOEGZVItoYhy/xlmetSIEg=
X-Gm-Gg: AYBFou3Sk+n9kClJ+8krmOLCRHyIiMAhmUxtWk2TgMfHuYwmNl5lyjAKdlMfuH5cQgC
	V0Cw4V9UpL/iudJfB2x2StGkL6g1/JVGictt3cFbgdP3jECvlR7CeoBrI7iAKeFZIcpopOgZiNc
	xGJkJVbUD8DPGwW3oHF94gbceU/tYOYsBch111rA2lh2v8C4gvFBwyX81Fx9IWqU6SEJ5VhgEm/
	cotPeY0JM3iOa5AOih/zhMrFNgNbXpw4538qYBOGN7e2rmJXX7SSA0/2ATZeOos7dth8yPoOKkU
	XP7egxhWuv/TQqovjCEMggvvibJfJo+LROFyX1Tk/W5CbHs7EYH0y3wUlk45rju11IWP83FPhYk
	0ILBGgxDzKI8gtwP4pdvmkK6393SbkTpBkNpTifPloidyOW0qsYZBJkyOpB5qo3cVchEn9eGgaI
	RcROFnmbthjAoGPJYhiZvEoy/N8kOa/AIbbMIT3+eFU6aLWdrwf5MJc+B8bn7WpR4o9PYePkmGl
	wdN2UtmOpUO++bl800=
X-Received: by 2002:a17:903:2c47:b0:2d9:383a:30f1 with SMTP id d9443c01a7336-2e9a6842eb5mr63237055ad.4.1792400926399;
        Mon, 19 Oct 2026 02:08:46 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e305f1dsm36707595ad.0.2026.10.19.02.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:08:45 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Muchun Song <muchun.song@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/4] mm/sparse-vmemmap: map shared vmemmap tail pages as read-only
Date: Mon, 19 Oct 2026 17:08:27 +0800
Message-ID: <20261019090830.1917657-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019090830.1917657-1-songmuchun@bytedance.com>
References: <20261019090830.1917657-1-songmuchun@bytedance.com>
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
Content-Transfer-Encoding: 8bit

Both early HugeTLB HVO and device DAX use the common vmemmap population
path for shared tail mappings. Map these pages read-only so that illegal
writes fault instead of corrupting metadata shared by multiple tail
pages.

For early HugeTLB, this moves existing write protection into initial
population without changing the final mapping. Device DAX gains the same
protection.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/mm/vmemmap_dedup.rst | 3 +--
 mm/sparse-vmemmap.c                | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
index 8c287ae3f86c..76f903975a40 100644
--- a/Documentation/mm/vmemmap_dedup.rst
+++ b/Documentation/mm/vmemmap_dedup.rst
@@ -193,5 +193,4 @@ There's no remapping of vmemmap given that device-dax memory is not part of
 System RAM ranges initialized at boot. Thus the tail page deduplication
 happens at a later stage when we populate the sections.
 
-Deduplicated tail pages are not mapped read-only. The mapping layout is the same
-as HugeTLB.
+The mapping layout is the same as HugeTLB.
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 40eba70c0048..ba0496daf4de 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -295,6 +295,9 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			return NULL;
 
 		entry = pfn_pte(PHYS_PFN(__pa(p)), PAGE_KERNEL);
+		/* Map the shared tail page as read-only to catch illegal writes. */
+		if (vmemmap_optimizable_pfn(pfn))
+			entry = pte_wrprotect(entry);
 		set_pte_at(&init_mm, addr, pte, entry);
 	} else if (WARN_ON_ONCE(vmemmap_optimizable_pfn(pfn)))
 		return NULL;
-- 
2.54.0



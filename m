Return-Path: <linuxppc-dev+bounces-28421-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E67DCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 17:53:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htppD6Tzdz2yDD;
	Tue, 29 Sep 2026 03:53:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790618036;
	cv=none; b=VYu3XwlcjCTNg8JgQr0D/tl49/rzFcLWDE8Cf1DMOSlVCQIsMz3tU32eRlfHy75uxbLvkzIN4+oXndTRRqS+BLcaAHRn1kTyrg/jy6KsUmpKzGO6eUwNnFSWYD6SEh0HuUM5YfJPGPqRNVRgR6j5oMtbgMpy0PnDi7GeKBLyrDcUn0UN0C/E+BSk0DSdLitsinXoPaBAxu8ptEOFEf1qrCqwgGLOb+Q3LvVs/8bLOpKN8Jraq8DnlxCBJ5+fdVdTMAJgRPJd/vSWnFevKFBjVqiZsnPptltEgEbBlY0Tmdl4SXHUGBL+FX3qvPt91IYekwViqvm68hSQ8xKZIpp5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790618036; c=relaxed/relaxed;
	bh=Ry9723u1VCONEYNULtfqjmkGkxac0FV34z/xJBvJ25M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=gQPDoG3rRpjryRHlv0G6Xms1X77Y4V/J5E/eHeu+ptdXUwxrkh5HihGzuYrtSzj1WfYPt/BDDhmkMl0WOFVV2HvmAmAhp/imobz6YWhnhHyayWidNL9tw6X7k8cbIISQ0lE6w9rkzu2jQbITIsXWhTINFwl6BN+u+dkVHNDec4SF+V3ldL9QnLvhcIy0SJAyWIylDj35QEt5JXgeItx0/egCIaip/vhbdpqngphqb78931NRu+sTCVQiCWXwaauktRP6w5ARmipLlMhsP8HfUwOPoPuy8kmmz8HKN9eNx6rWdpOQPXHVTNqVeiAh2TUo1Oxyj08Dq+O0jR9NK5AXIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G/ED9Byr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G/ED9Byr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htppC1my3z2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 03:53:54 +1000 (AEST)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33c0d931083so1222985eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618031; x=1791222831; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ry9723u1VCONEYNULtfqjmkGkxac0FV34z/xJBvJ25M=;
        b=G/ED9ByrZ7PWl2S0Y9yOUgnfL9xHWwvuB5rhotmBdsupZ5ER9UVIzLDF5NyEvb9Els
         OceyY5+sc8Qp9I8wgehLQKiyxajFe9NluNcvuW92UJLlyzgk+DxcXM9n+6u2/mKls+G+
         0UAcLZsxOgrksEYgzg740dULFewyt5trB4VqAKOR5PCUesbV9AdOGGH5HXlM5KR3xtYe
         j7NiaOsaCmdy3QTHyppIQjeVUxqMprDghzCrcwxB5ZfrqtbApTrkT1UwRBCQ6kHH9Wx9
         kyQiFGaHn+CJedh7BF8bCeIXFX6ZyXtXE/iJerONUFctDKbbW3xbsebv+ap0z17Y/KN9
         4kJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618031; x=1791222831;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ry9723u1VCONEYNULtfqjmkGkxac0FV34z/xJBvJ25M=;
        b=y4D5i/bhrg5x9/CxeowCbbbb7cbiM304g5uAp2tU/5O4KJEd6J3hz2yCpBowOaFjF4
         wKGsnKF2K2KdTngQeO1Ay3EvWWwa8KVRKao9a4WWMs1aNUsJaKlLM85BxTJKeSUW3ma9
         hOVn43sCgGegyy5zEjBS+o67QBMyeukcd0s6uWB+bwi9jyp5Kyib/e+SwFHJ5QLGVU2j
         adO6mLkBWKBEHjXCiuFBOFZxJxj3AJYOmb0c6w9B0cvyKEmCHQiQpahoc61HolNCZLGm
         UAmnSjBHN/zybaiuutOmaqoDOuQXsbvPkamyyni1ADFTth+liBojrB7W1dQmH/bqsNUc
         7fgg==
X-Forwarded-Encrypted: i=1; AKwUvBzN2ocm/bmnrwQ4Ymdi36yo4rGEsoeu4te2MmzxxtBHBiu6XvyS96vD+AGgGlO+jHXCqG2S1aRCYC8+S6U=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kOL13oie+EWgD5CSo1en2x5Vz/zZXWS3tseM0iYyrA7jEYZQBv
	zYPhVI9rA1hJkEW88/4poPBugWUcxyd9oajmrdAQZGAt+7kDH6GrnHSE
X-Gm-Gg: AYBFou3odq7DmGaR0HvMosgE6SVT394PTlDSslg88G67UnA5uuXUve0xsOHXCeQ82vf
	kn8Z7KOvxHt6ZLKvt0vKHVBDCh5hnafNjkbLWTO4ttI9+VjLe9RcpO2wK0Tdc7bW6MAyx95RRkU
	797Q2RRMpV6DSINFqMeRhb3iYv5mIos2e6jMujmG1qCHWu/MBmLOJUtaU/RUktmzH5H8HiDwwQE
	eG0bDQo2/XEHfitHLk9IFMJg09nYv/DA2H/1hb8HWfm73j+ZC13iBjdAHNbUBE9xJejs1cMvp0R
	QDm1cmX8W8X99qlyMj+Lttz8yjDMLEbCYwCmwGQCBhnC6S0tA3lL74N1OQESw8ZK4o45jdRWOa3
	vU1TVvcb+KG0T+aKHIIkZpgBXX9Rq3vPaDk9u/WdqWaO+x4Wcl7NNcfMR9fD0NpWJZXePqY/2Q9
	bUk3KM1pSjOsTw2cP7s9RpZTL+ybWMbX53vdWiYEuKZcUMl21uNKYIOhh+nWgGjhBX25oZbnNW3
	Efc9kP5MkWZSytL/Rjxt7zs4ea0lM3St2px/T9Y7NPa3wbiGcJ1uw==
X-Received: by 2002:a05:701b:2210:b0:144:fb71:dbd8 with SMTP id a92af1059eb24-14b2b6bd4dfmr165181c88.8.1790618030705;
        Mon, 28 Sep 2026 10:53:50 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145aa0cb6b9sm24285377c88.1.2026.09.28.10.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:53:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Muchun Song <muchun.song@linux.dev>, "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Qi Zheng <qi.zheng@linux.dev>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/6] mm: Unify device DAX and HugeTLB vmemmap population paths
In-Reply-To: <8385F749-0F72-494E-9CA2-2E433A066712@linux.dev>
Date: Mon, 28 Sep 2026 23:13:35 +0530
Message-ID: <se2tjmpk.ritesh.list@gmail.com>
References: <20260924075259.2013039-1-songmuchun@bytedance.com> <607759bf-59f2-4ad6-b95b-e780ed2acba3@kernel.org> <8385F749-0F72-494E-9CA2-2E433A066712@linux.dev>
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

Muchun Song <muchun.song@linux.dev> writes:

>
> If you're planning to review this series, I'd suggest waiting for my rebased
> version.
>

Hello Muchun,

Thanks for taking care of powerpc side of the changes. Is it possible to
share your git/github tree somewhere? Sorry, but it's hard to follow
which series is based on which and the overall multi-series is based on
which upstream tree. If you could share your updated tree somewhere -
that would make my life simpler.

Thanks!
-ritesh


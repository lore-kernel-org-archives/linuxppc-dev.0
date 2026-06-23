Return-Path: <linuxppc-dev+bounces-22926-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECD6CDB479
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:37:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl3351MPTz2y71;
	Tue, 23 Jun 2026 21:37:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782214673;
	cv=none; b=ojVXefgpen5ZtPy9S3djmSF+NbcG5V0SDarN2KQ68oJIgdHKhQwMuAwB3lRo8RoGLyualykxkgWmb/aBguA4xSF+M6KI0LtNrmZdzBg+nUVbC8pWCBYyO9ql9XZk4ciMAUYARAVKtGKbah7sEncgjMawWF9LsuxfhYUsCJ9vmsIHhIBuYQlBG/WV25zJrCHY2n05lrmpseHqZr8EMdt7F3wb8QQCwlp3x1bpZ7UPiljWTq3/52gkXrsOIInQUMYd9HiK/HEN1e0KaKJh91cd5g5QS3G3ZNug1n+obKbTeWaa2SFuVRzGOK16GNDr8hj18GrMLs6X9zO4YzWQpF3JrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782214673; c=relaxed/relaxed;
	bh=t/a2x5Ghb20XmVHJR+ek7GnEWJsjkaghf0C6SjAspjc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=oiAGEMQ7zquijeub8VXROrMv3yaUuuSEq2gfnBr2ofjNxpjWiAEC6q3We97J2F/oZHa34mYkdHbsvhAzpRfigccpjzXMiasgSEYKR4mz9zFSpKskOyAH1WM0w9fjoDK+LzYozsqMjoN/PDuaZFLg5MfPIN7Zpsh+K1aaHGA4T4nZ3btf05yROfWbkrJ9fxmw2qyMdGWBChu6/VigcBUiy5Ylmxh99v01pgOgMzXoCqAQ7qiKz1vCmKbzNSI6ASIuP3c4eLCzBjgyKjw9wFr1UjhBjpYk5O5PIafAH662PM8IhplcASytHnaAQ0kIDpB0ei6nDOCFVWCHN3yHByGp+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TTMV05U/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TTMV05U/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl3334mVBz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 21:37:50 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-842358aaf36so2410264b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 04:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782214669; x=1782819469; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/a2x5Ghb20XmVHJR+ek7GnEWJsjkaghf0C6SjAspjc=;
        b=TTMV05U/hHKrKk5YiYynSFEM6oVNENWO6wbr1Ul0sepWkVuLLwUeujt2kqz0QiKbPZ
         +Huk3ywp6ji9JFbCx937iYBxRd9xTdrLiZY/6l6CkClIh/+DX1AfDq5nL6E0S0ZfF4Qs
         P/G59nQEtIO/HgWPcSrbO49SiRL9k6kHZ56SEW1bOlmCcjsByEYl965l8vjWrQO3s5zc
         RPHW4kS9kDi+mfjdt4yuenKTSucAl591uUkKUIGb++qDglAlTVC3SbPWlg132R1/dC3/
         1j8lAhhMCKdjTEdRXOiIgVjw1eOVR79fcKgpGDBGxTHfcZRoKA+DvTxJwFz89CGIAkbI
         f6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782214669; x=1782819469;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t/a2x5Ghb20XmVHJR+ek7GnEWJsjkaghf0C6SjAspjc=;
        b=DjOfXjZkKbCexN7eHcR038/sw4HbpTneh/qOXo+2ydbSiETuTqbyzAxJwkZQUc8GLW
         5qog+Cjr/bhn2na7xk2s5QZ07Lzwinu3f9bXaUN/dlyf4q3YNAg79EAvptF3KIiNgwKK
         +OntqxhjcWqvYxvGfXyL+lZlEHlVD+uQgCnso+7HpYH9T4PP9H5yWzTpqw8uojMGs1Jr
         N3EtoArN0V/yFFJOIUYgoXlDAjroZiSWZVG/eZC1QKDtphy2gdiXYjFW+sIu68yDb03c
         lRNs979KSo3vxOhcNvTC6dREEC3DAQruUj9qWADxglzBD33uQETsZxFKkDrf6YowCQGq
         1zfw==
X-Forwarded-Encrypted: i=1; AFNElJ/hoadtoUvEzkMl8bLVBWwsk8XIuUbgVJkPLQVu0SyCZ+PbSXZKxd8kQXSiuFmqt6SWXOso5dPVNQpEruI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyShayfAkz30V/SvdK7BtPmh++mNsX8Bris/Ma1lwgDJzOx1Cy1
	5NT6Ksi1i7gvurpBbUUrLWyrPiXNTLaMSnS+vb5sLj6KDF24rgCUncS7
X-Gm-Gg: AfdE7clNA7TiHMUBZRPZYt+KzaBLcTj7Rum+TfLdEysBvhAjNwTf7zJ+0XMgAt/6Y5q
	PSeB8YLKGWMLojVgdb0aqRNs6lbOBiLFEtt7YySIAh4LLjjw7scfHoYw4g4fRD4DcsnC9/fYXJA
	svJAKkariS4UW3wcvQnAjBJYIqFY4Ca95HAu0Dhqc7h1C4DjKXUnVosUwjrJWqsWFjIFHXuubm5
	DZC4khhWjPdFEp1S6iOq1Ycgqe4V8A43f1RgeDAIL7Fv4F8GF3kvOri8eKksETvigwEEvROVzVa
	ReLxk4EOy5zJgcQCZum9HZdckd9SWqs1b/zmOPyA4AxtluzCLsIFQuxb0tZMJ/QgXDrRtQ1R4yW
	bvvKJL/LyWruXdj9t9DDLic0aTHbPs0/hz+Vt8p8ekhvyjR2/z/3yQ+zOSTxyktWe9/VCM4AlBZ
	AkMr6wgbhVaU7XuFo=
X-Received: by 2002:a05:6a00:4b51:b0:842:4327:6cfb with SMTP id d2e1a72fcca58-84597123e04mr2464203b3a.46.1782214668486;
        Tue, 23 Jun 2026 04:37:48 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ef4c09sm11953864b3a.61.2026.06.23.04.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 04:37:47 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Barry Song <baohua@kernel.org>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH v4 2/3] mm, swap: allow archs to override SWAP_NR_ORDERS via ARCH_MAX_PMD_ORDER
In-Reply-To: <CAGsJ_4zZBf2dGjG2SF8VkwwaYm-oFpmFEJ+Kx5-DuNk0ez7xbg@mail.gmail.com>
Date: Tue, 23 Jun 2026 15:02:07 +0530
Message-ID: <wlvpwqjs.ritesh.list@gmail.com>
References: <cover.1781843449.git.ritesh.list@gmail.com> <eda4e51ee9f1270582fbb2823ec5873e769de089.1781843449.git.ritesh.list@gmail.com> <CAGsJ_4yTY8g3M7qmpM7HeUq=E05e7v_QFTzk=2D5Mv3Vj3Usqg@mail.gmail.com> <33ydyd82.ritesh.list@gmail.com> <CAGsJ_4zZBf2dGjG2SF8VkwwaYm-oFpmFEJ+Kx5-DuNk0ez7xbg@mail.gmail.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Barry Song <baohua@kernel.org> writes:

> On Tue, Jun 23, 2026 at 3:05 PM Ritesh Harjani <ritesh.list@gmail.com> wrote:
>>
>> Barry Song <baohua@kernel.org> writes:
>>
>> > On Fri, Jun 19, 2026 at 12:41 PM Ritesh Harjani (IBM)
>> > <ritesh.list@gmail.com> wrote:
>> >>
>> >> SWAP_NR_ORDERS sizes a few small bounded arrays inside THP swap
>> >> allocator code (nofull/frag cluster lists, percpu_swap_cluster's
>> >> si/offset arrays, next array for rotational device). This currently
>> >> expands to PMD_ORDER+1, which only works when PMD_ORDER is a compile
>> >> time constant.
>> >>
>> >> However on architecture like PowerPC Book3S64, PMD_ORDER is a runtime
>> >> variable which depends upon which MMU is selected (Radix / Hash), so in
>> >> that case, PMD_ORDER cannot be used to size the static arrays.
>> >>
>> >> This patch provides an optional ARCH_MAX_PMD_ORDER (upper-bound)
>> >> override for such architectures. The memory overhead on enabling this
>> >> override is negligible. Even if we make SWAP_NR_ORDERS runtime alloc,
>> >> default slab padding could cause some memory waste. Also we lose the
>> >> per-cpu cacheline benefits (for percpu_swap_cluster) because it might
>> >> cost an extra cacheline indirection overhead in swap_alloc_fast() for
>> >> fetching si[order]/offset[order]. Note that a fully runtime
>> >> SWAP_NR_ORDERS was considered in previous version but was dropped for
>> >> this reason [1]
>> >
>> > Do we know the maximum PMD size?
>>
>> ARCH_MAX_PMD_ORDER will be 8 on PowerPC book3s64 with 64K pagesize.
>> PowerPC Hash MMU with 64K default pagesize supports PMD size of 16MB.
>>
>> > On arm64 with a 64 KB base page,
>> > a PMD can be as large as 512 MB:
>> > https://docs.kernel.org/arch/arm64/hugetlbpage.html
>> >
>> > One concern we have is that performing I/O on such a large folio could
>> > incur significant latency before reclaiming any memory. For this
>> > reason, on arm64 we initially enabled THP_SWAPOUT only for 4 KB base
>> > pages:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0637c505f
>> >
>>
>> That's not the case on PowerPC. Max PMD size for Hash will be 16MB.
>
> Yep. A 16 MB folio might be fine, although I'm not sure whether
> splitting a 16 MB folio into eight 2 MB folios would help much.
>
> For 512 MB PMD-sized pages on arm64, one possible approach might be to
> split them into 256 × 2 MB folios rather than all the way down to 4 KB
> pages. That could provide a better balance between I/O latency and swap
> performance.
>

Fair enough. I guess this can be looked upon but is outside of the scope
of this work. For now Radix with 2MB PMD is the default on latest
PowerPC, so this will be slightly lower priority for me right now.

>> Also we still need this patch since we can at runtime choose Hash or
>> Radix MMU. So, the main problem this patch is trying to solve on PowerPC
>> Book3s64 is enabling this feature w/o impacting any other architecture.
>> W/O this patch series, we can't enable it, since it gives build errors.
>
> I see. If possible, please mention in the changelog that the maximum
> PMD size on your platform is 16 MB.

Sure. I can do that.

> In that case, the I/O latency concerns I raised may not really apply.
>
> w/ that, please free feel to add:
>
> Reviewed-by: Barry Song <baohua@kernel.org>

Thanks again for the reviewing this patch series.

I will re-spin the updated version (with additional details in the
commit msg as you requested) in a couple of days.

-ritesh



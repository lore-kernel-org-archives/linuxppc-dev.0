Return-Path: <linuxppc-dev+bounces-28071-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1001DC98304
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 21:38:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqr1V5V2Qz2yqw;
	Thu, 24 Sep 2026 07:38:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790199502;
	cv=none; b=VNrehdLiYt6HrX3JR6gNHTF3rQbzbOQUa8qmkpWdVRjoi+/QGl8LMgsUW5uzLDYDhA3O6PCMRI4NfHUK0z14b02reG3mcN++g7CZyVRCb/z+wUYFTQyF2hoR3MfHtd2CK+k9OI0623KmkNPm+4jly6qNnFiMSDG02wfZB7YEiz1hkBEV0aCRwF/K9wl/NRTT1y7FQYkSgFgb7ZwBwqR0vbynbyXw5aJfqXKN/Z/28TAVfBiMVEPMaWOzubcPHczqw2Nvfmd5TltDOV+oFqH7OKefJjYI8YTHAXKGmZPCCCAy32dKgknK3DdURrugCZL3COi2iLU3BmnbsDNNMyPuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790199502; c=relaxed/relaxed;
	bh=YJsOwx/QHJRKZ+n0C8ukvZV0N0chl7bP1M9sQ8QHM+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0SatQaOMHIr1dSBx/XJzDvLrpa96cLNo2WvcFpaZqCCy2C66djFLiXt7mUSmfYmvY8dsqtJfyx+YQDh9RZToVnx0ESLR5KUAXqV6BIKbvgl8aMhjDXe+roUTEgdmqMFIaFvrJxafd+IRhxnsNdYP672xvDqZM8QvkaUN+riCFeTJIJoHQOhUOSjVcvlIgp+72/vUncS621W7h+pC206hTKKw/7RPyk/ABoQlLoQMmSeJQa0GR1Lw3aeanbrJzgo0hFp1y3EA4dpf2/4AmeJJaRI1K1qADuMQ4RRSAeFDdJQjgde9QP7paavrbF4OCp4IYXwf28jDMnFQ9gkyvZwDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxo6gZMN; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxo6gZMN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqr1T6Ndsz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 07:38:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0280B43E19
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 21:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFA01F008A5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 21:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790199499;
	bh=YJsOwx/QHJRKZ+n0C8ukvZV0N0chl7bP1M9sQ8QHM+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dxo6gZMNT18URkGZhYXcRMlxr2sCiuieBP1kADBFjFrV7hwOqC6KI+cYMVN0+459x
	 7bn80QRNap9jNWfvtKyMpgpbo9dLFi6KDfP2icWTd2ZXz+yFAtVNl4+QreAQpCSN8N
	 pC4LbSpIqLDDzmSsZkRoXkFZ3iOH9lCUYcDsoRc4hRQC8K44gptrtwf20PCytUIj26
	 IePdBbiMQvRknVtoEJFcE09lTXXYBC9s5W2TkhZZjI55udEfooLXi7Jr2biYFbVExJ
	 97k0rjqJWdHJzNynvyNVR0yXYZJ/UHOyaBuKV2u/YIrSlq0Onv6ewm8Kr3NILwH2L2
	 6uCeRWG1jXQsw==
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-532db7db0c6so11507361cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 14:38:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy3W7aIAkvQogqv4rtwNjGfbHIr9s2/w4CQOyFnTyiLAc3vwb8G8uDgcMZiLD0ZqvP1jMx4fCtqmrOz+CY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mNIZzPgi0qqKpw6+VQ7c/569Pild1Z9/uUc9M+eyN7pUzHWesU
	/CWgOszlyUQhvv9wUyt8+Gpk5Fna5JbiCA04OK/WHIoqzIEWS5O81U4dgFJCGjhSU+yQGlMHiMc
	P+quMYkauXVGxdJxWUuRU9ulPdzWBo1w=
X-Received: by 2002:a05:620a:2556:b0:939:7c8:78a9 with SMTP id
 af79cd13be357-93c346c0eaemr75510685a.3.1790199499119; Wed, 23 Sep 2026
 14:38:19 -0700 (PDT)
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
References: <20260923062832.479455-1-jiangwen6@xiaomi.com> <20260923062832.479455-4-jiangwen6@xiaomi.com>
In-Reply-To: <20260923062832.479455-4-jiangwen6@xiaomi.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 24 Sep 2026 05:38:07 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z-oqoxKynRr6mz0-5zZU_2NBnPkwz05CEEHHnwTyqa-Q@mail.gmail.com>
X-Gm-Features: AclHuK9KKxh7jAVCjl18JX2rsGxXVsV-K4ZOPHC6NmnXnXWa0kkH7W0rz6HMa0w
Message-ID: <CAGsJ_4z-oqoxKynRr6mz0-5zZU_2NBnPkwz05CEEHHnwTyqa-Q@mail.gmail.com>
Subject: Re: [PATCH v9 03/10] mm/vmalloc: use pte_set_huge()/pte_clear_huge()
 for PTE-level block mappings
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com, 
	ajd@linux.ibm.com, anshuman.khandual@arm.com, chleroy@kernel.org, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:28=E2=80=AFPM Wen Jiang <jiangwenxiaomi@gmail.com=
> wrote:
>
> vmap installs PTE-level block mappings by reusing set_huge_pte_at() and
> huge_ptep_get_and_clear() under #ifdef CONFIG_HUGETLB_PAGE. This makes
> the feature silently unavailable on CONFIG_HUGETLB_PAGE=3Dn kernels and
> couples mm/vmalloc.c to HugeTLB internals it does not otherwise need.
>
> Now that arm64 and powerpc/8xx provide pte_set_huge() and
> pte_clear_huge(), add the generic fallbacks next to the existing
> pmd/pud_set_huge() family and convert vmap_pte_range() and
> vunmap_pte_range() to the new helpers. The CONFIG_HUGETLB_PAGE guards
> around the block-mapping paths are dropped, so PTE-level block mappings
> now also work on CONFIG_HUGETLB_PAGE=3Dn kernels, and mm/vmalloc.c no
> longer includes <linux/hugetlb.h>.
>
> The fallbacks exist only to keep the build working on architectures
> without PTE-level block mapping support. They are unreachable there:

Since this is a `BUILD_BUG`, can the compiler simply eliminate the call?
I guess the build would still pass even without the fallbacks, so this is
more of a build-time check than something needed to keep the build passing?

Am I missing something?

> the callers only run when arch_vmap_pte_range_map_size() or
> arch_vmap_pte_range_unmap_size() return a size other than PAGE_SIZE,
> which requires an arch implementation. BUILD_BUG() makes that
> explicit rather than silently doing nothing.
>
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>

Nice to see that `#ifdef CONFIG_HUGETLB_PAGE` and
`#include <linux/hugetlb.h>` are no longer needed in `vmalloc`.

Nothing concerns me except for the changelog issue mentioned above.
Please double-check whether the changelog needs to be corrected.

Reviewed-by: Barry Song <baohua@kernel.org>


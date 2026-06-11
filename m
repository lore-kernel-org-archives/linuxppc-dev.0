Return-Path: <linuxppc-dev+bounces-22468-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14686CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 05:35:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbWZD5mjwz3br5;
	Thu, 11 Jun 2026 15:35:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781147901;
	cv=none; b=YGVnymwdgRxbumHngIqBPhDXI94Pe2Z0fcY+tiCg1/3DVZbhZrXo9rrN730+5cKLwdcQ5eBLLLml7JO5DxiryiqNHFKZljshPAXSAFSTAqZVPQteWdLpdNxOER3hFfJDw/w5N3hmZJU29uCQ+Eztd8ZAGR+pgeDgfhc/h9yW+oGBoTTcrjsrwQOqY8DGGTM0s6PWJYDO/3dh6VOkIlF+DP/5eJljr0Aa5JMjorJVqgkNUZnph4nNNVcUmwJgxUEF34BeKDp1ASJ2o109xHsN5IeDu8ih2I/18rJ7r4gfqyQkgHO6UuU2pA6FKJD74rPYcWklg2lZ5mgCgKhSnzKJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781147901; c=relaxed/relaxed;
	bh=/x68ABRg379J30fMcenonWGwnmir0RuQ5ej/rkgPavY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lgwt+hOm9rqo5U5wlGyhQRoErEWx3bBjaYXEPHlToy1OSdnR5JFkWb+ursIbNBvp9cfxFKSqUwAp/d5eJxxuIzBKTE62dXZw6N9NQFJvwb+QAwJvZB6YUWkF5Gt/Y7EBrfohudNbZ7YChn28IKVKEbAbTSSAwqI9tFlwp03GOG5JrQ0P7MtV2s/uNzVwlX2t1zcZV6/Bz2ulS8mnFcyVH61NvLZd6p/h8mMV1/TWxG+fW6yDuVhdRzsWYXyWdMFrB0U54xYIvM+uIPOSSbxqiz9I5+6XBog0MgvZORXC51U/SWsU8AN7HZ+0tG0YlhfZ33F6Bg7Xbg7i8gKAoMcYkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAgP2nUk; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chrisl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAgP2nUk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chrisl@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbSXD4bylz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:18:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3CF7160208
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 03:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79201F00898
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 03:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781147897;
	bh=/x68ABRg379J30fMcenonWGwnmir0RuQ5ej/rkgPavY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hAgP2nUk0OsKgS7OORWG7+8FeDP/7/EsmlwVRvn9Rdp/9dagBh9SPD1zS+CINg+wX
	 ojlMkPCmQuONG+HCsx9MPU3vzvg6uZPIpQGZFvIrIqYXLY60aXfY7k752SkDqUP0Br
	 ogZ425Ye619aRzc/Ft5a3JfVzDwyUroUpDsAI+Dks8bqvZxWphBNirRnislevqdmIk
	 yyXU8DXC+Y75tSzBefrK0rjPZsChJERPST/U+//ggPTyGdy3Au0ZAJaz0ML/rNJgeA
	 IUIs/qCKvfSSVR29bj9cJDMjyEYah6KQ+FXHw7RIf5HjksjsG2xoT9sovPnF0i/tlB
	 ciUlRkH+c/k/w==
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66061993294so7888694d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:18:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+8dNiU00K8W51a8dczyIqCMW5hV7/jh8Nj3Y4SxmGYLE8rJanuR61UCTbTpe0fWh3J8LmFRNWZcSr2XcI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyIRXutbHoVU+S2DaRqIyVJC8f29nUARiEFIs7cKHRITEtFKOId
	SPHnrFfrNyopz+BkDgmeyOBoSUjq4GLM8m3MUnBTR0mxiWtwhlnhlqEWH7RNnwzW6343saomVTb
	JyE8f7ccmgrHtWnW3VxiKHN1E0sco9tLf1QTaejrdtw==
X-Received: by 2002:a05:690e:4087:b0:660:651a:26e2 with SMTP id
 956f58d0204a3-662696264aemr832644d50.13.1781147897429; Wed, 10 Jun 2026
 20:18:17 -0700 (PDT)
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
References: <68591daf0d679e5a0072d63751f187d14613e2b0.1781146877.git.ritesh.list@gmail.com>
In-Reply-To: <68591daf0d679e5a0072d63751f187d14613e2b0.1781146877.git.ritesh.list@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 10 Jun 2026 20:18:06 -0700
X-Gmail-Original-Message-ID: <CACePvbV5StK2W47UsoVBM9V_XPoFfd1UMfS+QS_j3jfLvrk9vQ@mail.gmail.com>
X-Gm-Features: AVVi8CdqmWc_pAJZ1j0CGRdRempowIcbT1sudR1BZVzbc-u16prEzm_YyQdKOVY
Message-ID: <CACePvbV5StK2W47UsoVBM9V_XPoFfd1UMfS+QS_j3jfLvrk9vQ@mail.gmail.com>
Subject: Re: [PATCH v2] include/linux/swap.h: Remove unused leftovers
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 8:09=E2=80=AFPM Ritesh Harjani (IBM)
<ritesh.list@gmail.com> wrote:
>
> This removed unused leftovers, most of them are forward structure
> declarations. Also removes SWAP_BATCH macro which isn't used any
> where in the code.
>
> Found these during manual code review.
>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

> ---
> RFC -> v2:
> - separated from the rest of the series (enable thp swap on PowerPC Book3=
s64)
> - RB from Barry
> [RFC]: https://lore.kernel.org/linuxppc-dev/cover.1781000840.git.ritesh.l=
ist@gmail.com/
>
>  include/linux/swap.h | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 8f0f68e245ba..46c25523d7b8 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -16,10 +16,6 @@
>  #include <uapi/linux/mempolicy.h>
>  #include <asm/page.h>
>
> -struct notifier_block;
> -
> -struct bio;
> -
>  #define SWAP_FLAG_PREFER       0x8000  /* set if swap priority specified=
 */
>  #define SWAP_FLAG_PRIO_MASK    0x7fff
>  #define SWAP_FLAG_DISCARD      0x10000 /* enable discard for swap */
> @@ -29,7 +25,6 @@ struct bio;
>  #define SWAP_FLAGS_VALID       (SWAP_FLAG_PRIO_MASK | SWAP_FLAG_PREFER |=
 \
>                                  SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ON=
CE | \
>                                  SWAP_FLAG_DISCARD_PAGES)
> -#define SWAP_BATCH 64
>
>  static inline int current_is_kswapd(void)
>  {
> @@ -175,7 +170,6 @@ static inline void mm_account_reclaimed_pages(unsigne=
d long pages)
>
>  struct address_space;
>  struct sysinfo;
> -struct writeback_control;
>  struct zone;
>
>  /*
> @@ -442,7 +436,6 @@ extern sector_t swapdev_block(int, pgoff_t);
>  extern int __swap_count(swp_entry_t entry);
>  extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t =
entry);
>  extern int swp_swapcount(swp_entry_t entry);
> -struct backing_dev_info;
>  extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
>  sector_t swap_folio_sector(struct folio *folio);
>
> --
> 2.39.5
>


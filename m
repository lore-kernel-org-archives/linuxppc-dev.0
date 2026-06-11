Return-Path: <linuxppc-dev+bounces-22467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14221CD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 05:35:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbWZ05gnRz3br5;
	Thu, 11 Jun 2026 15:35:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781147861;
	cv=none; b=Ni4UySFOnlT2WRQIMNDQY+xAIQ2cexmuRA+LhvOSVfehnPPjVJLIcQ6knrVXNPwwlV+tKcpYOo/7opSUcpRId9nUJ9gtlvX180l8qRMtm/0BwWZtDaeqy+9fuPbgAA1FvCWdeqwq0X77llzx5Geujxlcr/xo01bN1zeCqIdUINkgVmYvZnHfLf6xtBmZvdHsF54iqLlGGPJmi4/R87aD+sYmDJl5E2TXSGOQOZSptu2tPsz3vVpazMTegLnOaelT1hyizXCqM6T28iimQF2lLysz2m2ngKJGTczbsnS24wfntIE4tNOi2YGEIXAkPeUXCz+CS24Jhr3umnNDhVLlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781147861; c=relaxed/relaxed;
	bh=FLooqN0yndNNSOMAEv1OhI/neTi7ZUfo9M9dFDLWUXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1SAHJlas7iN9QXcfqvfS3Q3kAxfUM/X3skys76mu+TC6ZK8UmLPDT6LsZquGe5VTLNPWd/j2B8vSePrbt/prSjFM+OmeSNKDRfJ6dASi2GC5nONjd9Q8ynh1LLpgCAt+N9Qtp/gbuSGpGvbMJcJC0kFy5qrqVrR4PzR3FX1aJsJRZIyxOaH0+iNBdm53g1fi3v9sE9IXSVew8OeHSCapFYvPtrHcHhBoj3zMEtHUZRy4w3fI2lJ7nKgQSj3C+vgqNOx14jxGqeP1i2sDJhIOYlfXABHAcfF7GToT6Fxf9R/PAVexdyYdja1ZpDVdYEGLR/6zg4g+3d+3J0aNDW+Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ociBo8my; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chrisl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ociBo8my;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chrisl@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbSWS3zkZz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:17:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 28A7660208
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 03:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F8F1F00893
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 03:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781147856;
	bh=FLooqN0yndNNSOMAEv1OhI/neTi7ZUfo9M9dFDLWUXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ociBo8myi7nMA486WCJzTn9Ba+l0h3FmAOM+NUMm7gfUh7e6tTolanB0q1Ny0TeFX
	 Lo5t5AeDsneWeLLNICX9fdslBly5TkGNtLDKKI2y9x7aS9QaGcaDkXCzJunaRyDesO
	 wMRnNTwlX9xWklDReE7Qn8q3rFTkhUdKoBEKJke7VjWb5+PyU5dA8bMpaUsDr8DD7e
	 jHZ/6nnxvVWE5KFaOjNe61/BzaG1xkMnEOoJ5Gz7VL+R6+KX1UPSjv8amr73M4S73l
	 GpDzNwZCKSkzKvvFn09eZEjUieAb+C8aVXm8spcE/EoYQZEJEdJZ/zrAyOAI3T42cv
	 2EH3S7cPGM5MA==
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66077e888b2so7519556d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:17:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8qxRGOdsJLpSBwbfsbmIJZwIVKPSVvRXLp/GbaxOwOWn+e3Y7e/kAL02gVfLznzw0/jhwyirHfqR1cpMg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzNhztL93Ap3u89Ewpw8KThX3M2jiqJn++qLWwClH19tH9eP+50
	ZlVg6cDPKJaWQrVgxfiUuAqc8qViT9bxCTva8OXW0kBSPlyZzr1CdJ/AbOfqT6TfKy0MO1XtqKY
	cnJi2Drmfth3KEmDDiPZy6gS0TnenO0KI/Mw5SHarWA==
X-Received: by 2002:a05:690e:1555:20b0:660:5a88:6445 with SMTP id
 956f58d0204a3-66269a1c8d5mr623151d50.63.1781147856233; Wed, 10 Jun 2026
 20:17:36 -0700 (PDT)
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
References: <cover.1781000840.git.ritesh.list@gmail.com> <68591daf0d679e5a0072d63751f187d14613e2b0.1781000840.git.ritesh.list@gmail.com>
In-Reply-To: <68591daf0d679e5a0072d63751f187d14613e2b0.1781000840.git.ritesh.list@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 10 Jun 2026 20:17:24 -0700
X-Gmail-Original-Message-ID: <CACePvbXDW-euoxVta8SL8gWG1L9WRVdid0PeenQsMzuBZbLb1w@mail.gmail.com>
X-Gm-Features: AVVi8CeRjfh7lIAOBd_MgIZBBjqz3E5dbnm1fw9CUyM3Tu5c7QEaUgnKV4cNBlY
Message-ID: <CACePvbXDW-euoxVta8SL8gWG1L9WRVdid0PeenQsMzuBZbLb1w@mail.gmail.com>
Subject: Re: [RFC 1/4] include/linux/swap.h: Remove unused leftovers
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 6:20=E2=80=AFAM Ritesh Harjani (IBM)
<ritesh.list@gmail.com> wrote:
>
> This removed unused leftovers most of them are forward structure
> declarations. Also removes SWAP_BATCH macro which isn't used any
> where in the code.
>
> Found these during manual code review.

Thanks for the patch.

Obvious correct.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
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


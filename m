Return-Path: <linuxppc-dev+bounces-22865-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41C9CD98F0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 01:40:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gk9qj1VXZz2xyj;
	Mon, 22 Jun 2026 11:40:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782092401;
	cv=none; b=aOSbwJGWow21xcaTdmPVgTz98eOFSjOH8HYtPDpDfN+4UNV48C/q4nFa6u62OKe6THOhfJ/LGmI60Uuhyg4tN/XEszjolNFkjfZwQk/+0plR3n499iQ1ikzCQOeQdZYlmkSgsmJ6Ceukt7F/dTOuLAl4XJnj8+ZvoqLa+c/kedGmWSbkYg+WoxJrI8LaMs6Ejlxz/FpiN526d6gVnEYdyNcsqdeBLz6fzTzZsFJ2Itky1DMvJGQikLOs0nCecM91UnM8+RrBSj4Dj8G1ZJqq5C3Tow5NW4XPLmxR0E4VIUYRSECyGer3PCbVWOT5sfU6acQN+U0LBCisZ3j6KZaDew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782092401; c=relaxed/relaxed;
	bh=rx0mLq1GyG1gPfhWohtRuJsYSfIXcRSpekf/XOMayPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWinMuCfnMsuGutKlCCUYa3b2tTfSBdWF69NfAGu4jl4UcYov0HyHM6+Z0WIwuy1FKolYEB9cCQ0pPzJAoN4zwMotbEk7BHQIv742oueztRIHTa3bgHi+s3tSKvrBfP1zVHb6iK0iNLcYb/GLdqrPQrV6sWDzW4FFnZ28O6I1vY30qPn5PVixmUXLtOup/d3t7KlQrEoAo/ym0kyWqITdjEDJOstYHGrEdsDLiF5bnIF/aPLC+YmroqRK9ajOzAIMhMF3LSipE1d3foib1F927i9L8ruYmd9V6RQEXscDkJclIVTSv7pbQdgJelbRV3ttVb4Ci/y3AImoq4Mr//w+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlsUkLk+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlsUkLk+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gk9qh17FNz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 11:40:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C4DD4444F6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 01:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC141F0155A
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 01:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782092397;
	bh=rx0mLq1GyG1gPfhWohtRuJsYSfIXcRSpekf/XOMayPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OlsUkLk+fc+Hyi466MxqhAa76hkwJ4T//hd3BpWmTUg6W5S0jHxOeGmV0bgnRjxnr
	 3hvhy8UdUVXlb7vmQqRNukPibA0KXst8GHmyw6U7CBmHzTKGbrJqhkJppbDPWy0mis
	 4PamqWbf350aTkTN1Ja1g7E/wAUT9DMGIZ7z90cS2jHHI8I245cYsgfDj9f74JtGpI
	 qrGV7fwgAFGkOUOXiVA8zZmt/p+yG2GeFBWUWvvIB0QrjO4cAJvtf1k0Q2hgTb7LDL
	 HleXs2k4vJxl2eh6XD7Irnd66poVyDB4GRK3dRwFzSGDSlbrUXb4xOXSF9p4muDTbx
	 1aqFRQBuhboKA==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-920fbdffa31so187702885a.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 18:39:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ83EvJJE+TXwXpM5zIdSUm/JNJvaYNYSFUdI2otTcfvn766qAdG1mBa3N8wtkpF2ZgdhwzX062akDrExNc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxzdPI5VsLPKhlRvix3lD7Qyo5m48oNAw9Q5C31vaZcidNVCy0z
	gObiQSngzLh6+cibEdNLjslOnSp7wyLzz9oxOuvmEhLGfGrt0ySYt0i4aU7yCrhPQSIi4i5ogr+
	RTyi0gBeIz5cMRTWZGG+X9xbyeXQOC+M=
X-Received: by 2002:a05:620a:29c6:b0:914:7e9a:2716 with SMTP id
 af79cd13be357-920d46198e3mr1850079885a.38.1782092396983; Sun, 21 Jun 2026
 18:39:56 -0700 (PDT)
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
References: <cover.1781843449.git.ritesh.list@gmail.com> <e519e98f51be2d310367e39df0935da79001e535.1781843449.git.ritesh.list@gmail.com>
In-Reply-To: <e519e98f51be2d310367e39df0935da79001e535.1781843449.git.ritesh.list@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 22 Jun 2026 09:39:44 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y++uh_4Dqso-fafywFCAvTLd-JSRJ8RZ6HvNLDkaLUJA@mail.gmail.com>
X-Gm-Features: AVVi8CfWnOC73cLiX1qD7RC8Yb8ND5XGWQFATC1PtKwV9KhKnymRT10brK4O9Ng
Message-ID: <CAGsJ_4y++uh_4Dqso-fafywFCAvTLd-JSRJ8RZ6HvNLDkaLUJA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm, swap: make SWAPFILE_CLUSTER runtime
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 12:41=E2=80=AFPM Ritesh Harjani (IBM)
<ritesh.list@gmail.com> wrote:
>
> On PowerPC Book3S64, MMU is selected at runtime, so macros like
> PMD_SHIFT are effectively runtime variables in the Book3S64 code. THP

Not an expert on Book3S64=E2=80=94could you explain the runtime variables i=
n
more detail? Does enabling THP_SWAP on PowerPC cause any build issues?

> swap code uses these macros to size some of its array data structures
> based on PMD_ORDER e.g. SWAPFILE_CLUSTER macro is used for this very
> purpose.
> Hence this patch makes the users of SWAPFILE_CLUSTER to use this macro va=
lue at
> runtime and also modifies swap_table and swap_memcg_table which were earl=
ier
> using this macro for defining the number of table entries.
>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  mm/swap_table.h |  6 ++----
>  mm/swapfile.c   | 17 ++++++++++++-----
>  2 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/mm/swap_table.h b/mm/swap_table.h
> index e6613e62f8d0..90e2a7852300 100644
> --- a/mm/swap_table.h
> +++ b/mm/swap_table.h
> @@ -8,16 +8,14 @@
>
>  /* A typical flat array in each cluster as swap table */
>  struct swap_table {
> -       atomic_long_t entries[SWAPFILE_CLUSTER];
> +       DECLARE_FLEX_ARRAY(atomic_long_t, entries);
>  };
>
>  /* For storing memcg private id */
>  struct swap_memcg_table {
> -       unsigned short id[SWAPFILE_CLUSTER];
> +       DECLARE_FLEX_ARRAY(unsigned short, id);
>  };
>
> -#define SWP_TABLE_USE_PAGE (sizeof(struct swap_table) =3D=3D PAGE_SIZE)
> -
>  /*
>   * A swap table entry represents the status of a swap slot on a swap
>   * (physical or virtual) device. The swap table in each cluster is a
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 78b49b0658ad..4bf11c5b87eb 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -129,6 +129,8 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, per=
cpu_swap_cluster) =3D {
>         .lock =3D INIT_LOCAL_LOCK(),
>  };
>
> +static bool swap_table_use_page __ro_after_init;

Does a static key help here?

Best Regards
Barry


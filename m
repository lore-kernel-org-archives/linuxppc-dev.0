Return-Path: <linuxppc-dev+bounces-22922-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F187CDB471
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 08:44:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkzBz14qVz2y71;
	Tue, 23 Jun 2026 18:44:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782204267;
	cv=none; b=PTFXLuz5TmSl9PMhVaxTjNGN7/Xbr0Mk9R1a0Asc9VxsH4WBH8psACRQkWrSf1mLdhOkvRBpGjzxKFULmb7jIvKHB5V+h3eK6oiyfrjtRzGV6Np/NQYFj/rAUAO0Mw8myimNf341O6VEISb0I6wVcx0av47xoqp1B+x4se7gFnXilxdTzan45zDqwlJhhwgXECd+3k3Yy6l24M/D6IsBlIyKA/uZubHFF8/hc8ssdCqQ7rw48YjQzLIN8I8PSqtRN4zbskL9zG0BUVlF2z672ocCYEEPjxhkNJbvpQiuP10B+aAVA9lvIK9YzcXnUoP8nEHc1mQ3HCEYaPdyZFuo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782204267; c=relaxed/relaxed;
	bh=V06gLYpVPdQObMIALtn+nG4jTG6QOLPlsd9Xveo2TGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaCFg8NO3mq4cO9bR9Wm2UwtOaA0cCV+TbD1LcX1NRcT9Hn3VC/D1r7HgmMQ0zve+i9EdU68LEtFCcYCc73UGB16Jt4rFkNxhxc9t4zKN4BT7YsvVvUSpZxt2Hy2F+Nwjvx2v3YpnvxnWl01GIrOKtl5kJkV+KJ+sIK3jBPRBoErw7eE0q+PcvfFpSOR/MTZMOB/VJEGkLjrrqUuF1gDbeqYmcdm5JU25m4a2pUrQcBw5hFjK3HymIWfU6elfbSL1i0Wt1L3k2WAIaWJj0Bg7HFmisd+OGe/O0ezEEHdv+eioDamLtxZNFSGWeEjjheCof9RubamVYKolt1GqXX1kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DK6H1+he; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DK6H1+he;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkzBy31fYz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 18:44:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 85B68417BD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 08:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BDC1F00A3A
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204263;
	bh=V06gLYpVPdQObMIALtn+nG4jTG6QOLPlsd9Xveo2TGg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DK6H1+heID3E/pUR/HqL+kQG1FPd45HfBcYd+muM2fJpu/+jWR89tId3qlRYdHPSD
	 aNYIr7BkYtkOg4usQA/eB7gk55ahHoY4xPYBPEoBUCa76knDgqG1x/uGh8K7QofxDS
	 3Wy2xUE5CL14PLsJOmxRfB3kYPGSyUSFJCpvgoB1zK4yKDvKVop7K2YFseKTuaYx/H
	 DpS13fO5wVpuw9VVCWi0mtgUmtx3ELIOvc8nCAixaboIdGT+s5fk73AEkO/Ib7Qc2j
	 mLVAaTTPHhpiQqKDnG4J9n0xrTOsr9CmprfWo2VT/HcKMq0Y6eFdzLcx8WQTSb/yWb
	 eDQiRZ98Wl1Yw==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8df26121c88so29329376d6.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 01:44:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+B7HSeXCYA2+79Vlo8vl8KNLcpc8bhrz/UElkz51OkkUAcsW41l1W4bIxJIxJoIFjUqEbrIBhGdk3YT4w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz2gcUUXh08QreTluf4HwIeLPEEgNHBUfb8Bb/HnjaxZ60i9eNn
	MPaLFpPWWe6+zNKsmcf5sUoYKKzdLGfTAFF/lsddIX6Zi1DGZwM68S1VW2rWgkNj94jFLXmwien
	EFacY44mMjccTZ6NKWs4Gba5VNtNQnsQ=
X-Received: by 2002:a05:620a:2813:b0:915:b852:4361 with SMTP id
 af79cd13be357-9208f92f166mr2327832385a.20.1782204262908; Tue, 23 Jun 2026
 01:44:22 -0700 (PDT)
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
Date: Tue, 23 Jun 2026 16:44:11 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xf4FoYAzGwf1w6hT2RKA0Vjr_yY2LHGzke_cP4VQh_9g@mail.gmail.com>
X-Gm-Features: AVVi8CcGK9RQyTQe6B_OzPqxpd__RZ0H_vwxCCpKUZk2XxYWrFfWHfgF1qK0Drc
Message-ID: <CAGsJ_4xf4FoYAzGwf1w6hT2RKA0Vjr_yY2LHGzke_cP4VQh_9g@mail.gmail.com>
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

Reviewed-by: Barry Song <baohua@kernel.org>


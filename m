Return-Path: <linuxppc-dev+bounces-22916-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8D9CDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 05:21:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkthf3XZFz2y71;
	Tue, 23 Jun 2026 15:21:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782192082;
	cv=none; b=TDfLU3mr49z2zjtAeXXDsdy9JDzXLJdlbVN1G0e42FIQBcIb2aQOCkdN5UBLSVOsPyDuhY0QeqPPsIWpKEF7z2r1KTXMeJSUZ/LCH3MM+wZ9carIQj0nh/VNnJGbv3T66icvfXlJ2/WIZnA9wko+nphU/d0Y//jn+WurEmxFHBwx718o/dojC3VrIulx72DzRzvkTsVj/Pg/UPQnm56ltuKqap1g1yMNFLrSifsLgJtcLFGbmLEGsgfeYXHnadqlo5CfRLUeFWLSy9R5LBKdLSt7wUlVFYqUWKBovRtSpQo04lnL+P/SMoyryD6C4sr4b4ShbGf3kyuKYzo/kKbmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782192082; c=relaxed/relaxed;
	bh=f9xcHL0zKeHdVldIVcal4xWYBnpP9GoKJfV/vtggwPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzITymcuOozXiCSLmSMuuyCVms6ZweFIuOubc0X9KUq+ymZLMOOUutJJoXpgcF2hT09t2a36BretJJHkCtuwhlk9jTxp2RhKBEKiIxD71m2w0JMM7EtPkowBUeP6IdohboG2RORtn4Wa5Jhw+e2qJb4OUufIz0G2a14cI2C0ArTNL9vJeRsu5IRlKNbsmMgmHi7w+2lfNq0J42m6MkIMV9p5NRKphSo/sLa07DW+Nsp0kWFMO8JAP8hoYQdHXwExvLm1towbPCU7yxGlbQhJA9+ROGnGatwv9FENpc6DR1VpKtbVNj9G3yPq6xNc2fkCBusZ3ukOktbSvBfdAapw9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbdCyaDc; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbdCyaDc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkthd3sd4z2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 15:21:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 232D2445AD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 05:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0799F1F00ADF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 05:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782192079;
	bh=f9xcHL0zKeHdVldIVcal4xWYBnpP9GoKJfV/vtggwPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cbdCyaDcakBo8y9Qy5UWuhk2O2aw58n25cBDhw/DKga8b94ePDG9vyz/zA//HlwRG
	 u2W3SZnGiAxtcyX+mFvPozlLMw/erAzgkVkpqQsLUcpMbSoq2q80+MSeNYhuA30ysb
	 e5eWQtfKGxvBDIF96wiWEusH3E1xGCP3h9glQKv4INS4CcNWDia2GugQmE8cVlAgoQ
	 PBLSLSoNiHNU1KzNlzimAlUJGhIPYcSz8vH4yaWAHLabmOw8SPvESa2X1zuDHcvlmZ
	 kZEwZQ3+Bz72a8O8+DmulSV1YY2OBr6+hdZjMB9LT+SmfGhuK6bEcqI3zgTlqW717B
	 CUwK+paWj9syw==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8dcd895a4c0so61729856d6.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 22:21:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq/FYWpoJ/GTjHLuckbOvddc9lHwYqbiFjYWlwytHkKP1fq2h2E5MONc9k1z1GMNfK0F5yYhggqCINVGTk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YziITiI7SjOqeOCCb1d5Q7UUP1K3jSyOey6SU53qm09SyPL9fYs
	Oppn9S6DXNhdk1FkUENlTt3x67syaZsf27CDjYmvXZfoalA1nfARvQbbs6CVIDHc8sdWztDw1U5
	nswsaMKD8VmXt5QrjBiwUpPiG7k0i58c=
X-Received: by 2002:a05:6214:3d13:b0:8ce:ee76:1597 with SMTP id
 6a1803df08f44-8e43709599amr15409076d6.43.1782192078434; Mon, 22 Jun 2026
 22:21:18 -0700 (PDT)
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
References: <cover.1781843449.git.ritesh.list@gmail.com> <ecbca3be3fa8bd7e213d013a2ec6ff9a11c6e0d1.1781843449.git.ritesh.list@gmail.com>
In-Reply-To: <ecbca3be3fa8bd7e213d013a2ec6ff9a11c6e0d1.1781843449.git.ritesh.list@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 23 Jun 2026 13:21:07 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zxcp-jdnRTn09b8ZfxT0P7suFq3BEpyiUzA2C_iRRUGw@mail.gmail.com>
X-Gm-Features: AVVi8CeiUTUaiIcSdVYVOkLXA4Apo1fqvv-IRKNsnhGzJmhGJPkOscl1sBGYS6M
Message-ID: <CAGsJ_4zxcp-jdnRTn09b8ZfxT0P7suFq3BEpyiUzA2C_iRRUGw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] powerpc: Kconfig: Enable THP_SWAP on Book3S64
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
> THP_SWAP avoids splitting of a transparent huge folio into 32 smaller
> 64K folios (Radix-64K pagesize / 2M PMD) or into 256 smaller 64K folios
> (Hash-64K pagesize / 16M PMD), during swapout. This improves the
> swapping performance since all the bookking & I/O submission happens
> once per large folio. More details at [1].
>
> PowerPC Book3S64 could not enable this before because PMD_ORDER is
> selected at runtime depending upon the chosen MMU. The earlier patches
> in this series turn SWAPFILE_CLUSTER into a runtime value and introduce
> an ARCH_MAX_PMD_ORDER upperbound override for SWAP_NR_ORDERS. With those
> changes, we can now enable THP SWAP for Book3S64.
>
> This increases bandwidth throughput with zram backend for swapout by
> 40-50% with Radix and 100-130% with Hash (Tested by Sayali)

Thanks!

I am curious about the contents of the anonymous memory being tested
and the compression algorithm used by zram.

>
> [1]: https://lore.kernel.org/all/20170515112522.32457-2-ying.huang@intel.=
com/

Best Regards
Barry


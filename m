Return-Path: <linuxppc-dev+bounces-3375-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989E1D68BF9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Nov 2024 12:26:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xrqj86QCXz3bhs;
	Sun, 17 Nov 2024 23:25:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=150.107.74.76
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731846332;
	cv=none; b=kqXomnigKeBZ71LULtDnMkRzGpdXmRov3QoPzQBsoxTBzmAz/U29ZfveSJUz0kU0WFNK/PrMSo9XQU0mkglyu2Y9XxutyNNiueTQCsUMbYx/Hn47iG2sMlRQH8me7bEGZITO5u8jcxZQgRHbmC1XMlsSQYtzHPCUwju2C1tISBEAyPq7euNqmyU84ZMdYlqzI+bRbs2Sy05hSZffK0hGxjv6viO/SJEhPNMrT80Ca33rKN/7ZYI8Jed0bRMmFc2EuQSfbnpbSwLKH7WGSw8owx4aHgLoPrTauhzPUuh+SougL/OA7mHoD21C1b61Cz1e9H1tQwtPm4sEVUpZHsj5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731846332; c=relaxed/relaxed;
	bh=TzfrLpdGHL3Qnz2E8gxDPlvroex0p9dJ41ENg3SSw7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X6UpPdoQL5QZexd437SgS49hpMvQSd0xmyS8Vu0n/AcmEgLNuKVr6Rhf7EHs25pbNwkaBblgpzGsrdwYryUph4UYBvh3/rHePPKSo6iOF4S3ueHWdYuSx1o2n+gUi9cEXG2gPweMZ46xdeQn4NLUEtxlU2x6hksu4/gnjyxPVQJsdnZrTCpNgaxfstWl/bDUoVh0+MbRXXvbGcnAN5c2D24IPgLfQxsrvB774SH9p0mjHA2BWNt/6q4xEs4EaJzSFBxKsm3Lk5VO5zP5BnE0dwg43F3uBf2TYOV07kjYtdr1QffGzag+rCLPt+s+vScOhGhFURoY6+fCVtlorGi0HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=AN9vuw5x; dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=AN9vuw5x;
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xrqj808B2z3bkc
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Nov 2024 23:25:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846329;
	bh=TzfrLpdGHL3Qnz2E8gxDPlvroex0p9dJ41ENg3SSw7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AN9vuw5xnyr6yD6oq3dWL70XoDNuDRpt3qR4+jeeSmq4Wjshk4eQ10Oix6wxkC/KB
	 TCBi5jcxLYASVQx+WVk7DtD8HTw3aF5LPk3QkDBe3iORQerSDdvlo0BbMBjbFUZ9Yj
	 jvn4Xvo+CSf5JfC19KFjL/pMlRZ9orzg29al33Hlt0+H2Nwp/cbq9CFjereXSz1vyE
	 LO/B2KTuq69Kam82vr0ZVG7juR0wnFzbVGLWXKN4F5vhUbJjQjsth51MgF/Lf3xQw9
	 nxQfHGtetY7CZBeW/Rh6cnjomIeXITmrgB1t7PZjatHECEK27QgRLxyuCNEQcWGI4j
	 5WwbUlxX8DYOA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqj46rrNz4xfL;
	Sun, 17 Nov 2024 23:25:28 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: maddy@linux.ibm.com, christophe.leroy@csgroup.eu, naveen@kernel.org, npiggin@gmail.com
In-Reply-To: <20241115045442.675721-1-mpe@ellerman.id.au>
References: <20241115045442.675721-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] MAINTAINERS: powerpc: Mark Maddy as "M"
Message-Id: <173184539769.890800.8018972179833150498.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 15:54:42 +1100, Michael Ellerman wrote:
> Mark Maddy as a co-maintainer, so that he can get a kernel.org account
> and help manage the powerpc tree on kernel.org.
> 
> 

Applied to powerpc/next.

[1/1] MAINTAINERS: powerpc: Mark Maddy as "M"
      https://git.kernel.org/powerpc/c/27aef9391bd3bc08eb07fe23e6c4d7c9afabe1e8

cheers


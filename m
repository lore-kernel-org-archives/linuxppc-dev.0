Return-Path: <linuxppc-dev+bounces-19033-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB30D1061B08
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 21:09:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl3m92XQPz2xN8;
	Tue, 31 Mar 2026 08:09:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774881700;
	cv=none; b=QmiMVnm/pnRQy/B2t3vzqqa2tZr/5UZhDk+0q19gbskXL1oWvszCuBryRcYbGBM1PI+/dq1pzo4EzvWs2vvH91u3aKJ1rAJFwUghKGDukUUrDTu+2XX0tyg+KiyITvFLrgxryLWNE/mGHVJQscK2PtxPELH83LeEcblrwKPxP0zDXvK7aSRP6Moy5Vmk2IdaBKAXBKMQ9GaU+2EfJMfRp8/KxA6OIICLeGmxIRgqk1hrR4obzVrZoH5pYpMkEGKc+uMw7/AeYi+Cla51SQrioNdjv+ImYfCb26FQFV8t0lmH3b5qRrtZdPHtcc9Snx21FmTg8TIiHgaG+zv6zSlz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774881700; c=relaxed/relaxed;
	bh=oR4aJHAX0zFPiy7Ebr56XFjWRoB4NdpweCLDlqMD7G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbRblkWUw1p8JEMvsjYJUtbN8jy5kXqZQxR3cpw9Xu/bEZJSvbiT9c2rxtWvaVO6XOMeRwsfTA8h9gXYJhDdTxJiepavXl0L3ICaazAMTMv2JsHOH/idfqF7nYvDTNNU87ToJJISjmzqaaJKW5YXtsRjyBbdcLu7+SciQBb7SnjX+NjJUQKpB2WFBWD2X0zv9APpGbV5PbxJXZE4XwsmDj/oUYbu/oiZt2lqWH1V7KjmJu00x07HJluWb0LLfrZwxVAFWwwbgZ8Jhn8IJ90AghZU4R4gGoAgNxwgqR10ZZTcZCfoAJ/aEdy5c7m4QmfkA7A+ZLHGFmncQ7FhLsSeeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E/wQUhQb; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E/wQUhQb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkv8M54tMz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 01:41:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A904543AF1;
	Mon, 30 Mar 2026 14:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A526C19423;
	Mon, 30 Mar 2026 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881697;
	bh=q1b29V/4pBqAX8CvMK4aRNivkNTJ18eDUC9nnf6AzYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/wQUhQbleB3IMASqvJCUU4R1GS/SMKx65uF/2+Nt2C1VB3w9Xho1geNlAPY1vdph
	 4dnpNCSgNk7TJNzcL2iGlX9nrkg8Tb/0mH7oqN8T1Ck4R9+k9Kl3h8RuSkLpuMGgMy
	 tEijami7egbnqUWtA/53DxBUuGJYG3AK7ycGJSs2LGSZEVH3eFspuOWTvMK0Sd3792
	 ATxPKiSqhVoBZdoEFFbPgkjFVELgozXwaDyNKvnP7V6I62bsqB7Lglq2QBPENqHogd
	 ydiR4NMLEp1j/jRLrtjvETBfach/i06tz6KpBangr49KEPrelKyTgAUNi0Izc5rU1F
	 BeY04sMB72PSw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2D6B0F40070;
	Mon, 30 Mar 2026 10:41:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 30 Mar 2026 10:41:36 -0400
X-ME-Sender: <xms:oIvKacMH4pOUW8JXzjJVcV1JLzTY_4rDoT65o0x10z46C2K2JSs5iQ>
    <xme:oIvKaanQVUb7bHySeH3KuajIHPvb4CeD9IiHtDeY9rZMkNbzmFDV5YwyHXoa1GZ9G
    x_OjvKLyV3RmCnA4I3Fh57qch58qCAqtdTFoi46GQLS_79B9tcNRRo>
X-ME-Received: <xmr:oIvKaaq8KEaqXgMksQxNtNzuauD7tt-PlwwS868pJJ0CeXnge6oxIL3tPVU1dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepheekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehushgrmhgrrdgrrhhifheslhhinhhugidruggvvhdprhgtphhtthhopegrkhhpmh
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiuges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehfvhgulhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdhorhhgpdhrtghpthht
    oheprhhivghlsehsuhhrrhhivghlrdgtohhm
X-ME-Proxy: <xmx:oIvKafP9t2FsSI-ZdJ9ZVNXV5FpK1ku-TWrmAckhaNHLY6HFw3SpNw>
    <xmx:oIvKab8Hh6_7PeZedKLo1IrRiQRb0sN3lqFZqD3jayWAIdx6_5RZKQ>
    <xmx:oIvKaSjR6nXSb8o15Qfy00tBqI3goNQr7LPPAmFDKjADHeeZTucDUQ>
    <xmx:oIvKaerDRj-PItMlNiCaaZjsbVjD-mjCZevsuatZWZyJWu-aOeCeLg>
    <xmx:oIvKacM9haxG7npqDzzSIoNVqtGL8pCMFQrFUNHVYhBT0WFrlHw2iuvR>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 10:41:35 -0400 (EDT)
Date: Mon, 30 Mar 2026 15:41:34 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, willy@infradead.org, linux-mm@kvack.org, fvdl@google.com, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, baohua@kernel.org, 
	dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>, 
	lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [v3 16/24] mm: huge_mm: Make sure all split_huge_pmd calls are
 checked
Message-ID: <acqLbkH_aN6aeZXN@thinkstation>
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <20260327021403.214713-17-usama.arif@linux.dev>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327021403.214713-17-usama.arif@linux.dev>

On Thu, Mar 26, 2026 at 07:08:58PM -0700, Usama Arif wrote:
> Mark __split_huge_pmd(), split_huge_pmd() and split_huge_pmd_address()
> with __must_check so the compiler warns if any caller ignores the return
> value. Not checking return value and operating on the basis that the pmd
> is split could result in a kernel bug. The possibility of an order-0
> allocation failing for page table allocation is very low, but it should
> be handled correctly.

I think we want the same __must_check annotation on stubs for CONFIG_THP=n.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


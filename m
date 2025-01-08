Return-Path: <linuxppc-dev+bounces-4874-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC89E77188
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jan 2025 21:48:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YT1kk1T0Wz2yRD;
	Thu,  9 Jan 2025 08:48:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736372910;
	cv=none; b=RN06pKxOnEzSLyCkKbT4A1t5ZWFW85DVAmC5/vvUqsM0Zk/zNfx5/zd1yFPvI8YAR1lFLtG95esR7ntVQU8bB2nUuOPKzeRE1P+x62qNWANNm539jrCqxt+mX1jRHu2DDnvf5nMZ1QzLUVHun4J+GBpdqQjVbxLNzC9210rgIecowPZgfeA5cgezvNSDnbmPbi0P8toilJkAe+NFfWu0a8BVcxvxHZ/RNBHDOoESeGv+Qzz0Lwd+tG2Q1XfUuNj5Omn5PCxdZIKeT923MoO4anrFvBV34zDTjiPynB8q0xe/1jN/SYhwP9/15Tjm7cLoMDqNdR1PSojwgaT3qyYFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736372910; c=relaxed/relaxed;
	bh=ZwaYwJGPQmfvcTNku9kBMYOI9OThl0lsTwE9etmIndc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0bUw3dyACDRpbuJo2m2J9TUI6RNK9TOpEudju0pXq8Adt+EMhNbCDSf5Kq9diC9Eg08v2ce/a2GdVvOFY/Mpi7ZcCTsg+SjdoNLhpypXC+DObNb5jVQPaKtt31d6tXFGhpYiY9FqaXz7/Dg9RNyYNFlClOuKmesYZif0gnGc8YGI97P130AEAPU73yn4IphVDpgUyV2DpZFtQIH6l+BRajn7Z7VgjllM64QHMUDmfkFVyUSu4HNo7k1JG+qEdoMh5yS6urOYmcQ47OqJ32VuqOVE6I7i0r7V5B3KkVP9Y5CLWg5/LvByyA7/IhFFQN8kEFlabpQyJZBZ7LXRi4lcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KYJhahsj; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KYJhahsj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YT1kj0ncpz2yNs
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2025 08:48:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9C43C5C5786;
	Wed,  8 Jan 2025 21:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5296DC4CED3;
	Wed,  8 Jan 2025 21:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372905;
	bh=6UUOHGd+KwqdJcDC5tzPLn5f+BTzR2NlW3LC2k/jO/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYJhahsjfU4O33TpAsv8ZoFaWSSrSGOAlmgT2jz3Tsdcoi+8nvRr7laMNTHlqR1MW
	 UGYhddZwumJiwyMEb/thDgYCt8Xhzdee2RC+2DsupAkOjs5MoiGlrEK04t6gzi84nU
	 wzGpiuFONyVED5IBXQx5FH5GLytKcgVQgo0FtmJkOjrvhjtxgpx8p2U9HoY7GM02+d
	 NM+k/xkFsUNdczdE0umsHx+03wI3NET20z9unanFM+pKhsB2cIxBXee9aWwnblWJQC
	 wyBsy6aikxPZu3ygf5XieW9U/7CuFj1NuaI+9JBVb6V9k9v+X0okAb6N2ifZGoIgxv
	 2CyT1yTq/vr/w==
Date: Wed, 8 Jan 2025 13:48:21 -0800
From: Kees Cook <kees@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH] powerpc/32: Stop printing Kernel virtual memory layout
Message-ID: <202501081348.7F81D6079@keescook>
References: <430bc8c1f2ff2eb9224b04450e22db472b0b9fa9.1736361630.git.christophe.leroy@csgroup.eu>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430bc8c1f2ff2eb9224b04450e22db472b0b9fa9.1736361630.git.christophe.leroy@csgroup.eu>

On Wed, Jan 08, 2025 at 07:40:38PM +0100, Christophe Leroy wrote:
> Printing of Kernel virtual memory layout was added for debug purpose
> by commit f637a49e507c ("powerpc: Minor cleanups of kernel virt
> address space definitions")
> 
> For security reasons, don't display the kernel's virtual memory layout.
> 
> Other architectures have removed it through following commits.
> 
> 071929dbdd86 ("arm64: Stop printing the virtual memory layout")
> 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
> 31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
> fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
> 681ff0181bbf ("x86/mm/init/32: Stop printing the virtual memory layout")
> 
> Commit 681ff0181bbf ("x86/mm/init/32: Stop printing the virtual memory
> layout") thought x86 was the last one, but in reality powerpc/32 still
> had it.
> 
> So remove it now on powerpc/32 as well.
> 
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook


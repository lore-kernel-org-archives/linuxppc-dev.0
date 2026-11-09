Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F71606A321
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=qMT/iSQy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNLVR748Wz2xdb;
	Mon, 09 Nov 2026 18:08:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794208127;
	cv=none; b=CYw/TOvXsmNXstk/8hDQHkU2km74lEzcEk9CYZW53WCGIXlfRVWfF58MV2rFJY0vaxZfMhVbsYPrkKzIY+neomW1zZ6m87rhpAFKhK+c80z5dBdNG0g+g2O+pbqRWWVPdKytmIWhnaB3NGW1wEsMNImiey11l3cy6OX5ID3EgYBJ9y63ROVqUgE30XCdr2vMfA70Q+z3y8GiNJU5qe/Y+EbxOD8h+CiwwseYAOMNG7pJ14cBwV5YjfUvpo2Ins0einoO0K0J8tcHVligQN0N7WMrfjwSO5Ilf1P09DOOYbc+8N2pX3mmWhLM9db8glbifFiwBFOFadYC8lpfOcRl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794208127; c=relaxed/relaxed;
	bh=R60RtisWcqPaJsP3z5umkKLOFCDRWj8EeZj2DKpMtAQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N2u6/bT+rjzDu+lffSqjE2yD4IevjxeIhev+0nwUGBZxK5bWGm8v2agvuL/3M9m8jLFwdbwNSNdTa6pp6yRPD7kX3y+OtvdnBGoU8HdQCstrdz0+kET2IsMd4r+hPYUWzwsM0dM1fBYLFA6XuxCf9TIqEWukvoG8MSHlpIeAic3ILWivhz+wxSsCbe1BfOrhPpjN3Iy3Oxvo07SZnKFtSL0nSnpWfKQ/hzTDoTOpLjkzxOajnZDSH/OpdmlkRg50RD3ak+/xk4xLgTg7nNqrWkOfnKYXHbNviIbyoc7BkWkL2l2wmZxdO5OD1ZLqjZpj5UGzvknggWYw+Of09ochzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=qMT/iSQy; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=qMT/iSQy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNLVQ6DNNz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 18:08:46 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AD594405CF;
	Mon,  9 Nov 2026 07:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E782B1F0089F;
	Mon,  9 Nov 2026 07:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794208123;
	bh=R60RtisWcqPaJsP3z5umkKLOFCDRWj8EeZj2DKpMtAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=qMT/iSQysf11EbkSRNfEw5+UOG45cxeA4/obABZTaIw5jUZNkssXGGYgeRSJMbaYy
	 4E8KZZmnu6+b5WKd/WEV/xp+PLbFam/lUK9OTHuHSBpa5qP5AL4fflcKZd+3cWe9S8
	 lJqz1moFNyVTZFHsRQlHIuxUMxLy/q96EhQPpliE=
Date: Sun, 8 Nov 2026 23:08:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, urezki@gmail.com,
 linux-mm@kvack.org, baohua@kernel.org, dev.jain@arm.com,
 ryan.roberts@arm.com, anshuman.khandual@arm.com, david@kernel.org,
 rppt@kernel.org, leo.yan@arm.com, xueyuan.chen21@gmail.com,
 chleroy@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, ajd@linux.ibm.com, jiangwen6@xiaomi.com,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/10] mm/vmalloc: Speed up ioremap, vmalloc and
 vmap with contiguous memory
Message-Id: <20261108230842.3a77b9fe2d4bfc2a04b355a5@linux-foundation.org>
In-Reply-To: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
References: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat,  7 Nov 2026 21:49:43 +0800 Wen Jiang <jiangwenxiaomi@gmail.com> wrote:

> This patchset accelerates ioremap, vmalloc, and vmap when the memory is
> physically fully or partially contiguous.

Thanks.  This looks pretty mature and reviewed.  I'll add it to the
pipeline for linux-next testing.

Sashiko likes it.  I'm working on a different AI review setup which
finds different things.  Very slowly.  I'll let you know if anything
interesting pops out.

Do we have sufficient ARM review?



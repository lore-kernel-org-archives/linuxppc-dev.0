Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01281C47DD9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2024 15:43:31 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kwj619xn;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V4WD252nVz3vgS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2024 02:43:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kwj619xn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V4WB40CQSz3vyP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2024 02:41:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 143C5615AD;
	Wed, 27 Mar 2024 15:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8D6C433C7;
	Wed, 27 Mar 2024 15:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554105;
	bh=LSkdq/t94YMFNlamRqeWvTTfCAU7fVztXM9mzQlr1gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwj619xnpdyJcHARuFdyABjHRFcqAdSXTht6r7soAxbPD/i8JwH+Wbuob+V12R3n2
	 rjT194985hg2t/tELpPWn6hp5xbV83OJPRUcfIIyw1XiOKlN+pZKuEoNANmwzA8bXf
	 xibCFVjADjaBzJLD5hoFzVnQTvcKdyo0G82FBxUUQdfhnn4CUkqUgeMYvOCYAi5VRT
	 ICQPFF6NQuQf4/VDzP7+eI7NawGxe8N8bucpZBSmyyIJQw1RHRtdi2tOpl6QuBm/+L
	 aNjfOvRL6V2syLJt/UUb2Ue3dsT7fVlFSSHfAu+IrlAx8FS1BvBEkD0naTCJXB4YJQ
	 /1gP29XdpE5vw==
Date: Wed, 27 Mar 2024 17:41:03 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 6/6] mm/mm_init.c: remove arch_reserved_kernel_pages()
Message-ID: <ZgQ-D5Gpvr_LJM-Z@kernel.org>
References: <20240325145646.1044760-1-bhe@redhat.com>
 <20240325145646.1044760-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325145646.1044760-7-bhe@redhat.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 25, 2024 at 10:56:46PM +0800, Baoquan He wrote:
> Since the current calculation of calc_nr_kernel_pages() has taken into
> consideration of kernel reserved memory, no need to have
> arch_reserved_kernel_pages() any more.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/powerpc/include/asm/mmu.h |  4 ----
>  arch/powerpc/kernel/fadump.c   |  5 -----
>  include/linux/mm.h             |  3 ---
>  mm/mm_init.c                   | 12 ------------
>  4 files changed, 24 deletions(-)
> 

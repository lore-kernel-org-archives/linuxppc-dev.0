Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D212C25B75
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2024 02:42:53 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=IoYrDqUy;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VfvXC1Kwcz3dKS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2024 12:42:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=IoYrDqUy;
	dkim-atps=neutral
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VfvWL0qLKz30V1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2024 12:42:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1715827326;
	bh=iVSKuxqhWqP0pGI+v769ZkjrMQDRcsRIXy/mVC+Gwzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IoYrDqUyv9fqD7HsO/MKcHPWSmQsZJQtViDC5HpvjTv20kA5uhx4yRBYvSXIVRTrz
	 WgeNhlK5sXMYfIaZowrZ/OuXLBAZjfLO1synJV+yIMeUOMgVVULLmUgQxe8WfAa6Cp
	 so0+e/9TsQ9BN46+PqDNTHXlqryEdtrmdRDoI/j4ytqFAtRfoSWa7VUQGRbohz8szo
	 wxC6Be38msSgwRqgYvNgxyIv5aJz2dFpmSi+857dD8QsWtf2xgZT9iINtKxNqH7tF1
	 J8vDeAt1rU3+ZBoC/LDlVlxEMMJK4+IyXLde+um/HSsHZ9muBnLPVpRHVO+Hnx2OgC
	 rmLT/kRUvwJkQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VfvWK6ZJhz4wcR;
	Thu, 16 May 2024 12:42:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build warning after merge of the powerpc tree
In-Reply-To: <20240515163708.3380c4d1@canb.auug.org.au>
References: <20240515163708.3380c4d1@canb.auug.org.au>
Date: Thu, 16 May 2024 12:42:01 +1000
Message-ID: <87cypmwk92.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> After merging the powerpc tree, today's (it may have been yesterday's)
> linux-next build (powerpc allyesconfig) produced this warning:
>
> WARNING: modpost: vmlinux: section mismatch in reference: fadump_setup_param_area+0x200 (section: .text.fadump_setup_param_area) -> memblock_phys_alloc_range (section: .init.text)

I don't see the warning, but clearly it is possible if the compiler
decides not to inline fadump_setup_param_area().

What compiler version are you using?

cheers

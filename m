Return-Path: <linuxppc-dev+bounces-21344-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6C8CD5BAF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 00:17:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gM5Sx2tYpz2xJT;
	Fri, 22 May 2026 10:17:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779409057;
	cv=none; b=RnOcnDSYsUybOAv3RXrcLXYtk3BmuPTCDVDJLjupATdLd2EFzdblZz0hW1rL9yTip/FV6joNazzIG5F/3ZHTGzUihaAN6P74Ft/IJh3NRMhesyFQdlIAQDv0TfQUXPOpFymuhPgACs5Qz/AK9BTpqT4xRGjmmhhilhY3xuggVlHE6WjGY0xytyP10OyxxzhLdUNSzJ3iMazdNTszS/AA1tUhjSnah/l/u5726b17uMzQa4K4TFP8BjcVaFrjB2lutwddY+9tsUylvFVI6sKRB+nxIQT8JPQqiF9264tka5m6qHOBDqXg+Bt+t0QMwJYvUyMs1edaYLkx4q6h+sUJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779409057; c=relaxed/relaxed;
	bh=CU1uL6EPLGCDhveEV6q88XhXLU9G2F321bQb4+LouN4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b5LQ9kJ+ju37Z8KuRLUG13dM6bSMnBxgsjwG0+IujGc4Hl57WOQrihfefMYrsXMgjbEEwPvNCBcW5ygj+hPG7dBecWq7OugRJou2tjNiIiX80eGJw37a5LRgsR4MdEtpW3JBV6/FIIfutVX+FdMFAOXY6pTKAVd7lonnghE+UeyAHwH7TAIuaepT/6QfRcrVQSx1eeR6+bwcCbmR+qYbZNqZg1FygLLiIcvZUPSyNW7kzx7Zej2pYe4xgIpcVZIPQw26pGOUOKWLm1nFarPRrLB0HvuM2zGz1pMCqOL8L6wOE9+hD3VrPFUbbj5rvnLkn8zISCCOJXQdgJXu5F8iAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=tEOlAwj1; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=tEOlAwj1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gM5Sw1NZDz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 10:17:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A502F60122;
	Fri, 22 May 2026 00:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB491F000E9;
	Fri, 22 May 2026 00:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779409052;
	bh=CU1uL6EPLGCDhveEV6q88XhXLU9G2F321bQb4+LouN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=tEOlAwj1g8LscGq036JIP92ztTOZa0Zgac7ekTv/50pIaaEK2W4Kh2iSs9mjKKeU3
	 0E+2P+EF9NE/33lqS+qb4XkzDA6GlEgAvB+jA6sk+cyej3pym+Q94Vs41XiDgm/F+z
	 FHXvYWEtcRfRDonE2oSvzPrH33/ywop/mXaGAjBA=
Date: Thu, 21 May 2026 17:17:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@lst.de>, "H. Peter Anvin" <hpa@zytor.com>,
 kreijack@inwind.it, David Sterba <dsterba@suse.cz>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel
 <ardb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, Dan Williams
 <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>, David Sterba
 <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>, Song Liu
 <song@kernel.org>, Yu Kuai
 <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>, Li Nan
 <linan122@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
Message-Id: <20260521171730.7872482df453975cf60ce7dc@linux-foundation.org>
In-Reply-To: <f46636c8-80ba-4802-a6a0-74cbc35e7bee@gmx.com>
References: <20260512052230.2947683-1-hch@lst.de>
	<20260512052230.2947683-2-hch@lst.de>
	<20260512114231.GG2558453@suse.cz>
	<20260513054742.GA1018@lst.de>
	<0a8d1ff4-f5a2-49e9-aa45-d25dbe4ded40@libero.it>
	<20260515043705.GA3855@lst.de>
	<34C16854-1065-4542-8836-DDED58EC1844@zytor.com>
	<20260518051207.GB9374@lst.de>
	<f46636c8-80ba-4802-a6a0-74cbc35e7bee@gmx.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 20 May 2026 18:11:09 +0930 Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> 
> 
> 在 2026/5/18 14:42, Christoph Hellwig 写道:
> > On Fri, May 15, 2026 at 12:59:34PM -0700, H. Peter Anvin wrote:
> >> I don't think this is a good idea. Error out; it is the btrfs maintainers' job to ensure user data isn't lost.
> >>
> >> The RAID-6 code has *never* supported only 3 units, and if it ever worked for *any* of the implementations it was purely by accident. Speaking as the original author I should know; this was deliberate as in some cases the degenerate case (3) would have required extra trays in the code to no user benefit.
> >>
> >> I would not be surprised if the kernel crashed or corrupted the page cache in that case.
> > 
> > It does, that's why I wanted to exclude it.  Anyway, for the about to be
> > resent version I'll drop this btrfs patch over the stated objection and
> > will otherwise not change anything.  This means the (IMHO hypothetical)
> > users of this configuration will get a WARN_ON_ONCE triggered, but
> > otherwise keep working (or rather not working) as before.
> > 
> 
> For the btrfs part, I believe I can get the current 2-disk-raid5 and 
> 3-disk-raid6 to fallback to raid1 inside btrfs.
> 
> I hope the btrfs part can be finished and reach the next merge window, 
> but I'm not 100% sure.
> 
> What is the planned cycle to merge this raid5/6 cleanup?

At present it's on track for the 7.2-rc1 merge window.  Does that suit?


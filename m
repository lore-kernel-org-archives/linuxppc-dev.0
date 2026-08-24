Return-Path: <linuxppc-dev+bounces-26059-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2BDC5DF94
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2026 07:27:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hT2Z30pJZz2yDc;
	Mon, 24 Aug 2026 17:27:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787556475;
	cv=none; b=MS9xcmIxNnIZPFe6wOQ82g4lOwN0kXtjlugForIRF9WpQiXWaL/NMi8R7lDzW3pnfPdcZSnjGBHUFp751w6a36SPsDULb4owHhsOntMAQehhorLfF7rAqS3pEpHsHpRLqoyHjuSRmXGNDrBEjnA88ileHPDmFJnZdbUcvmWi92BRqxoYourd4LKFRJ6APePu/jvA3MOc1cO+VDqtTYCUKM6EJMRXRgPH6MyCAJYxYFiePBNnP2z+bLvnp5ufXjmJhIvyV/PBW82nNQZJrPqxzzGvKgUW3KsNEEhkRT5LHKE7NkFiXUPn+xAq0L225x/R7IhUWVNmGkKbHOcP4iU/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787556475; c=relaxed/relaxed;
	bh=TDmng5bNiE+YiLBp1dwqj9DRhmUVXQIS/lif+VRO/fE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=N1sZwIEPecJBOuhkCYWk1ZW20ne+A7xqkD5w4V6Dwjv+wJ4kr1JEthy8/cnKglwGjy3TMdKEDqtIzh8RKxOXFnmmeRFsR8FNMDGl2T+b7FY2Ifw3j3XcXLoXL2I/nq2CaSctBXtWKyfU4Hi5DLvxsd11sVgdz3lYUWRIFmjiDmxz195Tp9ZiFCbE2c1tKU5QrmDUu93EGclBj24UuhKS0fo2dJ4IIwEk3X+j1W1YjjQK3bQICw+Oa741mCDY+GskiufIz26EqsnfrtrY5lONRpbWUdG4oukEpEOmLxcRJ3MpBj257uKNaguZOGIqg8NXv1SAG+iP+5qptxCgU27skg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LisqMsMw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LisqMsMw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hT2Z23DRHz2y06
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 17:27:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1173E600AD;
	Mon, 24 Aug 2026 07:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AFC1F00A3A;
	Mon, 24 Aug 2026 07:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787556471;
	bh=TDmng5bNiE+YiLBp1dwqj9DRhmUVXQIS/lif+VRO/fE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LisqMsMwto/kBuZ7gdbcgEJrUKMCvB31iYajSaP8VSdLEt16BVkX4Oh7MmltHH6/x
	 lgJMQ/bHIDKxJx2zSKHsCi53faclUGyXrEjtwgO9HglPDbBjmzSGM601uHETfiupKK
	 k9L2jhdovk2XzuRexJe8lI2Ja3+L6F1zhgtZeR57y04iBM9ZTxAg8R4/0hzvBRU/1n
	 j/yQ64IOrcqDTuW2xREKaopx2MCLiJJbnIajCPVW+gYaQ/oYq0qHnMHsDEPBeQlGIk
	 UAUiHCdZACNNtFoUCqb60H6mqsfCFPiGb92umTHv0AOcuZ/mH0PdZQm1D5ksQY3O+D
	 A0IEUUHfnBZfg==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
From: Mike Rapoport <rppt@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>
In-Reply-To: <20260818040041.1891769-2-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
Date: Mon, 24 Aug 2026 10:27:34 +0300
Message-Id: <178755645423.3606540.12945780031100652573.b4-review@b4>
X-Mailer: b4 0.17-dev

> Move ptrval_to_str() inside a header thus making the helper more generally
> available for new users which are being added later. While here, also move
> another related string size macro PTVAL_STR_MAX inside the header as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

I agree with David, include/linux/pgtable.h is better.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.



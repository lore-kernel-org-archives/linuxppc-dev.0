Return-Path: <linuxppc-dev+bounces-26347-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1006FC624D0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 01:55:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYpph1slGz2ygp;
	Tue, 01 Sep 2026 11:55:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788227724;
	cv=none; b=kGSrITw0svan4Oj2+jerwU1wKFXYUFvidmgwkJOQXcBCWsvAs6WfFj6eZu3XY1eFCTAZQNRiPTWBhutBoI/DlQqZ9gHi5e0hgUg3HxFk+n9Yfe8M6XD6IE6XaITXYrWWN7Ranh7Bf8QDsY4KjQb/9zLknMYwwRIqyURzatPjPjj81ythTknBh5wP6MfMKFP/dqk3g64Xy1WlORCK7qHYIjymp/cVYo1BhIATcejt4qN01KCDFk/WrNSydX0alLj1McBFrATY/ShR3qYx2NNs26JFjOD0Ie2SWtcmRR2vqE2esN4uT7/PbjB58g9Ktpn1MeN4tx5wP1AiZONr/5mY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788227724; c=relaxed/relaxed;
	bh=CbUFClJ4i3J7LjCwTB/35AHxIba4ym0JuMW7MLg9RkU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MnFELXdKl+4mzPMrTUHp24BRYfJj71LA8z7TK7PVhCkeG/xM2jdpKpCVZoxQ7uF9wrPLfiGy9H+ZPOoXrdu2xdDm9tk2+WR18gzcA8651iK3Gx5xbBXWk23Vl17w75spiX7fZxQHiPSnqrx4u1AYeEnpEfvsUbP0laL6PEncg2C7a3y8Zs327SPMhD1Ch4lx0g5t6VibHYa+xGy/GmsiDcfK3Nsf3VSyle5S8dbuQUN1KanszrFNQsO/0QlLqAflaXJFeOIoj1/wjLoWxWE1u3m1clewZirTo4D01RQNTJUYqIlVrFz9IOzbZii3AXdr2fJwDTr5MeM/tcA0rHxutg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=QTvMOsLY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=QTvMOsLY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYppg3mjPz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 11:55:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A24CC601DE;
	Tue,  1 Sep 2026 01:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FF81F000E9;
	Tue,  1 Sep 2026 01:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788227720;
	bh=CbUFClJ4i3J7LjCwTB/35AHxIba4ym0JuMW7MLg9RkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QTvMOsLY/HyZChL07OeBST7evAmOyQDdqEsNG8IojIx94RZcYBwP8DgxztrD6FxPx
	 UxNXGzD1L06crgm/t6O7u1Azv9jZngQt1/ls6DYB8X15tavuE8dNV9b/ojCvXtSt3F
	 /qmxq+B/hEDiFvYVf1+pwfxpoT/BJ9uJYAxsblw0=
Date: Mon, 31 Aug 2026 18:55:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, samuel.holland@sifive.com, David Hildenbrand
 <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes
 <ljs@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
Message-Id: <20260831185519.66c6e6e83ce62d0fd9aee945@linux-foundation.org>
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 11:13:22 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> pxd_ERROR() macros have been provided by all platforms, which are very much
> identical and can be dropped off completely if these pgtable printing could
> be moved to callers in generic MM aka all pxd_clear_bad().
> 
> But first cleanups and re-organizations are required in some platforms that
> are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
> macros have been completely dropped from the entire tree.

All was going nicely until...

> This series is based on v7.3-rc1 after the following patch and has also been
> built tested on multiple platforms.

*what* following patch???

Oh well, I'll queue it all up and shall hope for the arch maintainer
acks to roll in.  Please.


Return-Path: <linuxppc-dev+bounces-24837-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB42C531CC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2026 08:24:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7FBd6H81z2yRl;
	Sun, 26 Jul 2026 18:24:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785054265;
	cv=none; b=MiRCbHuIZeokSFwAV7/LtlhKyl59b6aHwIfEy7V1VlAn2A9yHtJ/0fo3mPm/Da5fch89nNTAXwMaRgboN7RNZFe0F72JyDO9vzmshWjaGPvCY9lkV/BX4DdeXIqVNj/rkBnAzLFU8WnB7GYLyNj5p5JWEBumE91Y9ktxY0X+XCrC/EFvGL1QSy1gf/2VL7C+kKVJsUwu2VJfzFp33bEq9hzwKvliF9w+mqLpgfZsEWgMqJHvejfax8epLnk3988B3taH+tAtzCinBMEjLuuKt5vxs6RbdIJlqz0IdeMdtkVlEKl3SrVUnO3/75hOGYWGioMc9b4Yr5Plh6d0TtUCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785054265; c=relaxed/relaxed;
	bh=1h8J0+r+HKDH96f38eGX//+FYYpw9kc8NPw1oyEbaDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM9napSWNZZmhazx/Nu09NflZIKQZlTW5O+DhWYFFdkemTydUttUTxmGPIfqY6zpPeVk9L5JRe05ytZFteLePRIOdRZJrNr0FLmeLCWSaIIZn1tEwEcFuCZpLox/xmAc0r95dksZswHUqBPyD/2awLa0oxtpqufoo1QN+oBGqXdIDXV3WDJdfEkL8hR8tQ/GdO3UBV71ZOWjeACEUCgAuz4jOFO8WHGu5Pekbj3P2Ujhs4j9VgTY0l57VJKKCw0vP/MLlZ7n1aX+uYTy+srFqoDVbCg7U5Xa/k1ZsViLRyuB6q9DoENfUaj/mooRE/KxLG3tT37BaSMX6MJG/P5wKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=naYCHlv2; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=naYCHlv2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7FBc6Ylfz2yFP
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 18:24:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C015640AEE;
	Sun, 26 Jul 2026 08:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CFF1F000E9;
	Sun, 26 Jul 2026 08:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054262;
	bh=1h8J0+r+HKDH96f38eGX//+FYYpw9kc8NPw1oyEbaDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=naYCHlv2BL4Vo5IMZ+rucI1IUcm2W+5FvAdPLeFy/8TMfofkrUngKY0lHlo/vG6F4
	 Lrr+4uVz6/cfuXZg0bnFRsvN2neMPceWNnPfBHNLESE+J5QuKgZ1YioVZSyBz5oJtJ
	 ze2up/U4UFtMocCPZjFKPedCx8NGK25mUxbyfXm7gzZOOz/U5J95ePcwWQiSnduZia
	 ZyS0JORzuiIOFYHqZDSK6REAX4/Td3RhawVi2D5joirUlDtFDsZ6vA1RSYiIc4ixK9
	 4TddXhyhT4jfAdrJmhVXMLJFQ1qORwSvUj8wIbVzE81kkbXNMgjtbTKzuymVgH9sGl
	 Wlt66JKBy459Q==
Date: Sun, 26 Jul 2026 11:24:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Gou Hao <gouhao@uniontech.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	bharat@chelsio.com, jgg@ziepe.ca, namcao@linutronix.de,
	ynorov@nvidia.com, sshegde@linux.ibm.com, nilay@linux.ibm.com,
	clg@kaod.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, linux-mm@kvack.org, gouhaojake@163.com,
	kernel@uniontech.com
Subject: Re: [PATCH v2 0/6] remove dead NULL checks after GFP_NOFAIL
 allocations and fix xive use-after-free
Message-ID: <20260726082419.GF12003@unreal>
References: <20260724022851.466017-1-gouhao@uniontech.com>
 <20260725202632.dcb325658896a470df91cf57@linux-foundation.org>
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
In-Reply-To: <20260725202632.dcb325658896a470df91cf57@linux-foundation.org>

On Sat, Jul 25, 2026 at 08:26:32PM -0700, Andrew Morton wrote:
> On Fri, 24 Jul 2026 10:28:45 +0800 Gou Hao <gouhao@uniontech.com> wrote:
> 
> > This is a code cleanup series that removes unreachable
> > NULL checks (and associated error handling) that follow allocations
> > using __GFP_NOFAIL, which guarantees non-NULL return.
> 
> Sigh.
> 
> Back when Linux ran on an abacus, I added __GFP_NOFAIL because four or
> five sites (file systems) were infinitely looping on alloc_pages until
> it succeeded.  I figured we should move this operation into the page
> allocator so we could easily find those sites and fix them to Not Do
> That.
> 
> I made it very clear (changelog and code comments) that no new code
> should use __GFP_NOFAIL.  How did that work out?
> 
> hp2:/usr/src/linux-7.2-rc4> grep -r __GFP_NOFAIL | wc -l
> 241
> 
> So much lameness!   My immediate reaction to your patchset is "No.  Fix
> the damn code instead".  But I've resoundingly lost that fight.
> 
> 
> Thanks, I'll scoop up the entire series.  If individual patches pop up
> in linux-next then I'll drop the mm.git copies.
> 
> 
> 
> AI review has a shower of possible pre-existing issues.  I'm seeing
> use-after-free, double-free, leak, system hang, NULL pointer
> dereference, usual stuff :(
> 
> They're in powerpc and cxgb4, if maintainers are interested.
> 
> 	https://sashiko.dev/#/patchset/20260724022851.466017-1-gouhao@uniontech.com

Regarding cxgb4, yes, I'm looking into it.

Thanks



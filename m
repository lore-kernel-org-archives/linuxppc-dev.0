Return-Path: <linuxppc-dev+bounces-24833-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F78C531D0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2026 03:26:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h76b44v3Cz2xfB;
	Sun, 26 Jul 2026 13:26:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785036400;
	cv=none; b=gI3QbFdNxDVpWlneg814ZRZ9uEJO8ksocmQejY3idFvu0HnSGMwX4t0lgzFf9SCfQbhvawcxmd3gxuCJGl6vcPgas/W7Q/E1D3veZtkgSH1yT3q3ojl94o9BS3rpkcSiqyplSuCeGjZBekdwwDqA/EdxjIsAFS/Ew5LWzh6+JCMmhR902DnuOm+qy5o4c6PwMDquoonOSKXGillyjtkE048ibYbKS/pxVrVwfRClN41eMQ4CMu1xKhSSZ+rKVTE5Qw0cUXk39J46GBDDMvReMafXsNVWRE1rSiGYKJ30+JfMUpWgibEzeLZGLblQx1Pd1LX8/a9wW3Uh6N52lzODdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785036400; c=relaxed/relaxed;
	bh=ujoywRATcrbjMYNELLJctilgrlUcGvbj5yO2i928VnY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aCFmgaEFyEZg5vQX5awVyENjYY+MOYVjjCs7A/gVGE7jc6GBUDram6KcvPrD81MF947eRBpXVxXWCP4We3EY+tB536HzMNgFlxainN8mZI67la3dXG+2uzozMRvsHjHWwPGTHgC4YRiZTpFS7mg0GMa30O9BkbUNTTq3W9mpySpVuIKNnMxhFccCH0ZZoksejGkzq1j9N9FJ70y+s7a3Q5iRJTNQ20/WgEaOPVIyW7/fbfzquXOOdX7R9BfJ2wohN/Ws+No0EwWPcuCltWu6cPtc3TTOoM2Gq2hUN1+2YJVoN+huGG+LCD2Y98ar2qmsg7ycGW2lo3L0L/vytVRz9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=C5hXFeas; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=C5hXFeas;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h76b23jQ5z2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 13:26:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 96EC56011F;
	Sun, 26 Jul 2026 03:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FE51F000E9;
	Sun, 26 Jul 2026 03:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785036393;
	bh=ujoywRATcrbjMYNELLJctilgrlUcGvbj5yO2i928VnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C5hXFeasm97leSm2ZFfgZdr5aKD+zPJYh6c32nLRB1bv6kA4jy/H7lC8P2kfLh68z
	 hpzsypaqVIG8c0DNYMPxTwYHqTO3Zwx0j7wz5lFUlc7HCG17VugyR3yUSar6eLk5qo
	 hyEtqM+UNXtcBuSoDm6nCAbM8QzwSd9ylJaeAjqA=
Date: Sat, 25 Jul 2026 20:26:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gou Hao <gouhao@uniontech.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 bharat@chelsio.com, jgg@ziepe.ca, leon@kernel.org, namcao@linutronix.de,
 ynorov@nvidia.com, sshegde@linux.ibm.com, nilay@linux.ibm.com,
 clg@kaod.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, gouhaojake@163.com, kernel@uniontech.com
Subject: Re: [PATCH v2 0/6] remove dead NULL checks after GFP_NOFAIL
 allocations and fix xive use-after-free
Message-Id: <20260725202632.dcb325658896a470df91cf57@linux-foundation.org>
In-Reply-To: <20260724022851.466017-1-gouhao@uniontech.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
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

On Fri, 24 Jul 2026 10:28:45 +0800 Gou Hao <gouhao@uniontech.com> wrote:

> This is a code cleanup series that removes unreachable
> NULL checks (and associated error handling) that follow allocations
> using __GFP_NOFAIL, which guarantees non-NULL return.

Sigh.

Back when Linux ran on an abacus, I added __GFP_NOFAIL because four or
five sites (file systems) were infinitely looping on alloc_pages until
it succeeded.  I figured we should move this operation into the page
allocator so we could easily find those sites and fix them to Not Do
That.

I made it very clear (changelog and code comments) that no new code
should use __GFP_NOFAIL.  How did that work out?

hp2:/usr/src/linux-7.2-rc4> grep -r __GFP_NOFAIL | wc -l
241

So much lameness!   My immediate reaction to your patchset is "No.  Fix
the damn code instead".  But I've resoundingly lost that fight.


Thanks, I'll scoop up the entire series.  If individual patches pop up
in linux-next then I'll drop the mm.git copies.



AI review has a shower of possible pre-existing issues.  I'm seeing
use-after-free, double-free, leak, system hang, NULL pointer
dereference, usual stuff :(

They're in powerpc and cxgb4, if maintainers are interested.

	https://sashiko.dev/#/patchset/20260724022851.466017-1-gouhao@uniontech.com


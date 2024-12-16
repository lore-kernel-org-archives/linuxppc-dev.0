Return-Path: <linuxppc-dev+bounces-4140-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C65E7717F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2024 06:27:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBVN72zDbz2yS0;
	Mon, 16 Dec 2024 17:27:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734330423;
	cv=none; b=Gma4lBisixHl8kYHHC+y561NSAzfpHirUGIWgJm87LvqD3AbVpLhdi5Vl+4ZUg3DC0+d+3AnIjC0qetjAQDNuIoYDL5ivsricegFttiGpUHstu7HXE86XHTUW+jlz6W7BqNud37sLGbKl1SdeAyNLsGWYkQeYjjd4pel1qhtCX+Dnd0U8MRDlVD367FmBqMEvQtIY3OBDP+5m0iy3yix5iZqPvFGYrW8JVZ9XE1bmbR2NbgejqBv/dZFoQplByMGL+fyBeBtUkWVzjFxIrFqjq+pYx2UbQmkJR86zJii3lQFt7BuRyLu7c1kcTvtqgTGVtB1n3sChveIFAcR7GQrFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734330423; c=relaxed/relaxed;
	bh=YTeuGSh1CGSThRU7myc0e4PzU/URwKkheVQYIA9QTkw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f4ca2WLPu7vKLlPLZDAOqMS88BfpwN+157p7s2yCMEGht235ObHGHhiAKrwe3KvkxRmpfO2Q98mHW48//k/+7KThZBlu4+ylDUxELCMmoaAtX3xNUQqmGMajCe2OYSjqs374Kd+0WsPY1bmHCOdoFUNF8Bzpgzls0uqTn7QfLVOEkl3FC7zjz37MlWQMrBFPlrHRq9+NmI6OBluCtCwSIF2LzhDwdTGgVHSaKqdVrM9idm7tpEZPAktBhtxj34yA7mIiGHHgXURvfkH+516a1tZ96vaJwN4KYiWIKCprbtF/FCBMhTW/BNhkCJRyr9VbsNfiwhz0BxlGUsnf7XkhZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=GY0AZMxm; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=GY0AZMxm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBVN53zT8z2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2024 17:27:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 874665C5F33;
	Mon, 16 Dec 2024 06:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640B9C4CED0;
	Mon, 16 Dec 2024 06:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734330417;
	bh=YTeuGSh1CGSThRU7myc0e4PzU/URwKkheVQYIA9QTkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GY0AZMxmMTcjeSKYZE7GmeuX3SKjxwb/58gdhtCO5ezpDtS7gHlr8h702y1OHXEf3
	 vY6Jr3J4GAa6Wcr8zvbFGqgmpilb6SPi4mi0P9Bicw+/iyZasNONa8WkQjjSoDOyRm
	 3Dc5fonxtLGVn5tPwYlTUYvPZ0flblYJeuQt5VAY=
Date: Sun, 15 Dec 2024 22:26:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Dan Williams
 <dan.j.williams@intel.com>, linux-mm@kvack.org, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, sfr@canb.auug.org.au
Subject: Re: [PATCH v3 00/25] fs/dax: Fix ZONE_DEVICE page reference counts
Message-Id: <20241215222655.ef0b15148120a2e2b06b2234@linux-foundation.org>
In-Reply-To: <wysuus23bqmjtwkfu3zutqtmkse3ki3erf45x32yezlrl24qto@xlqt7qducyld>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
	<675ce1e5a3d68_fad0294d0@dwillia2-xfh.jf.intel.com.notmuch>
	<45555f72-e82a-4196-94af-22d05d6ac947@redhat.com>
	<wysuus23bqmjtwkfu3zutqtmkse3ki3erf45x32yezlrl24qto@xlqt7qducyld>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 11:55:30 +1100 Alistair Popple <apopple@nvidia.com> wrote:

> The remainder are more -mm focussed. However they do depend on the fs/dax
> cleanups in the first half so the trick would be making sure Andrew only takes
> them if the nvdimm.git changes have made it into -next. I'm happy with either
> approach, so let me know if I should split the series or not.

My inclination is to put it all into the nvdimm tree, with appropriate
MM developer acks.

But I'm having difficulty determining how practical that is because the
v3 series is almost a month old so my test merging was quite ugly.

Perhaps you could prepare a new-doesn't-need-to-be-final version for
people to look at and to aid with this head-scratching?


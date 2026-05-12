Return-Path: <linuxppc-dev+bounces-20790-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5ABCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 12:24:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFG4W3F31z2xlh;
	Tue, 12 May 2026 22:24:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778588683;
	cv=none; b=TSHNTXRYHzqs6epm8aDsuEI5z+Qbz4aC/qCSqFpr47j7GdLAgqDhHPAGEM71Ct4FGVB1kP61JT0ag0Jbg8s0hG9Z77x/BOWSAk68RVLnWp+viawUc7Mdd0e/ERXttbRQMXV2FODR5XtqsTGU+Kc/g/tIyfisHXVzCNep47TjKR2bZhMnUj6a3qCwH9tCY+6G82nkoA9q+qypYFdPgBrfnjDgaxE3AjIMTMbrSct/cnB4zZ53YgvhcLPL5MSStSzwi3+BmzHb+KBP3aZDjeXNJknCja/lb08zRdsaH2ibQqLyEwX8+Pz8EnEYiNOAu3pKi+9URVXBQwZ/z28cSG4Frw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778588683; c=relaxed/relaxed;
	bh=lkERFJFgNaSiBv0/ONzO+vECV2sJagltjFgKYe7DnDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpWAVES1+5Ea/nNOEFHlUB4fSrKfWkR63SJYKuZFNguMU2Pz7SK+koHnEqLoQwfxKEnAC0DASOvBbhYPblOlGK6pKqcqzbdkHZT3JleSJDK0y4g079k3BvXbCbWERN6/wIXFxI8hRoVCW7hDHNnL3MpDJWWp/3ZNHJYmCOOFiKlHZdwCYWU3KVl8xvuuWU+SpSYUOoj/6/9ll1St0yU8Dh7K9mTg5mJbm/QPDSPBayqd5dEHGY8nV6AzxSn6oSov2OBCRPX/xgrX+s2lKnKPi5NUAuvi2BsudYgL8yLR587EUXH1mCXbFNSFep/wD/7qFPvHZrUMPC2YOlpEGyT9aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g7z+LwFD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g7z+LwFD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFG4V3zhfz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 22:24:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2801860103;
	Tue, 12 May 2026 12:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F89FC2BCB0;
	Tue, 12 May 2026 12:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778588678;
	bh=0WjgXT8uGEuv2OmAhZFIdCShmadqOYqNR6SLU3pqcUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7z+LwFD9uRctO+XZBIgnYJ1JJ1TTPeLlWf5Hc10oJb98KOnqA+Zp4d0LyZSi9YOO
	 U2Qi8Un2g4DRRRl93DQ2kIH8Tmf/j37D9ZNSxIIuIS1OFyYmN5Qa7FQgR0/K6/aGLD
	 eVpYga7N1it0KN/yvBYTY4lmwzjVg2AExltyCati9nb5BVDJyb+LvnBMySxEUJ3T+q
	 fUF1QLdqr1J4jqqL7IFpqmuCkIqopzqK7DVb36DMqmVeYxSAnZJIHjdJFPSbcTiP6A
	 Wh/szX5KLC+7Qu2kGogmtOOpyLqgYKooKW/qiEbz5iLBemBj1LCGOanRlXBpnOPKil
	 ZOifu5xNaODQg==
Date: Tue, 12 May 2026 15:24:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
	driver-core@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Danilo Krummrich <dakr@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Donet Tom <donettom@linux.ibm.com>, muchun.song@linux.dev
Subject: Re: [PATCH v2] drivers/base/memory: make memory block get/put
 explicit
Message-ID: <agMb-fIGsOnUKxL6@kernel.org>
References: <20260512072635.3969576-1-songmuchun@bytedance.com>
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
In-Reply-To: <20260512072635.3969576-1-songmuchun@bytedance.com>

On Tue, May 12, 2026 at 03:26:35PM +0800, Muchun Song wrote:
> Rename the memory block lookup helper to make the acquired reference
> explicit, add memory_block_put() to wrap put_device(), remove
> find_memory_block(), and use memory_block_get() as the single block-id
> based lookup interface.
> 
> This makes it clearer to callers that a successful lookup holds a
> reference that must be dropped, reducing the chance of forgetting the
> matching put and leaking the memory block device reference.
> 
> Link: https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev/#t
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Tested-by: Donet Tom <donettom@linux.ibm.com>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> Changes in v2:
> - mention the removal of find_memory_block() in the commit message
> - drop the redundant extern from the memory_block_get() declaration
> ---
>  .../platforms/pseries/hotplug-memory.c        | 14 ++-----
>  drivers/base/memory.c                         | 38 +++++++------------
>  drivers/base/node.c                           |  4 +-
>  drivers/s390/char/sclp_mem.c                  | 17 ++++-----
>  include/linux/memory.h                        |  7 +++-
>  mm/memory_hotplug.c                           |  5 +--
>  6 files changed, 35 insertions(+), 50 deletions(-)

-- 
Sincerely yours,
Mike.


Return-Path: <linuxppc-dev+bounces-20817-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C46CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:10:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdkt2pFqz2xl0;
	Wed, 13 May 2026 13:10:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641846;
	cv=none; b=W0LdPPYzYZgGcEtsUeqhc/G4H8bYLeZiLC22eLNtgTYG69uhIDT+rKFAvjDnRD5Dc8wRidCeDmhQgOrTA0Wuazhml0sAzUgguk6rEfZdJjasipDfq2t+ppYHroCviVIzMyBfL93wmr52r+DAfjg8CLr3dtZ8Qjz2Tm1SxgYkwFNlAUS/nhiUZkcAw8wm7rnbQao4gcEJObqhDQat8RxEjNe516kKSYhZ2fT4Iyp47kZ6mcCnx56O3Oeb0/KlfXdC8laiLRot6VTfwKwLER1YVWDrSPpKDnoRs/wCaZQ5UbjAX9t8i32sjyt68UuOy9oomo5BEYkUqMiv7WJB3luRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641846; c=relaxed/relaxed;
	bh=P7kKJFnLH5zWPMiI6tuQud3W3xRBv90gsCpSNsNjWOA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kX7JSU9gl5m+f4fbmqeZCpSFx1fFNkoJXkpktyZkMs1dRAQfIdiGVy8/QaUnpo2XGq+Lxx9B2HbjeNriL2Ru0onA2Gz4PGcdCeYhSTgAuovCT8xti2fhjZ2IQxA/byZdsQYJQUSLJa9PCpMQ+RonmVdIaML5BbS2pMdNGTunO4vWsEHXEMYN0WJF3KNsXWkomzxQ4XKt1lPHOkEfVxqqoxhvnSyhFNiu6nkSwHxyPnpNvdTXdE/DHej+LTDDCig+crZRGPR+S15Pqkcep88xtBK78y96OwIYRZDUgMZ/a/WbMCH9I831o8ecDmmqCwozJ5GLToGXuP9RxX76b4qufQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=s5pS0SgF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=s5pS0SgF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdks3THsz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:10:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7AD2560121;
	Wed, 13 May 2026 03:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F97C2BCB0;
	Wed, 13 May 2026 03:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778641841;
	bh=vu0gwBDBN0+TJsY5BEup/tyag+dQOp0HKz2GTXrJUmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s5pS0SgFgTsKMvZSlWIJVsVVNwwQLETV3CkqJebs25P0NP6SKTAlrMLogWJ+5F5Ie
	 9bK7BSPaefeZ5fYVVhK4hmY8J3zk+FkHacbQeWQOl4NGtBQ/EMKPKFu6W6h6ZfNAAM
	 BwToAu8ocE3Dp5rVkVmy/sB0rxwHnSDeO1MGgKsc=
Date: Tue, 12 May 2026 20:10:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sayali Patil <sayalip@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Ritesh
 Harjani <ritesh.list@gmail.com>, David Hildenbrand <david@kernel.org>, Zi
 Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain
 <dev.jain@arm.com>, Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org,
 Miaohe Lin <linmiaohe@huawei.com>, Venkat Rao Bagalkote
 <venkat88@linux.ibm.com>
Subject: Re: [PATCH v6 00/14] selftests/mm: fix failures and robustness
 improvements
Message-Id: <20260512201040.5783a643a3ba23f42777debd@linux-foundation.org>
In-Reply-To: <cover.1777877814.git.sayalip@linux.ibm.com>
References: <cover.1777877814.git.sayalip@linux.ibm.com>
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

On Mon,  4 May 2026 13:54:37 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:

> Powerpc systems with a 64K base page size exposed several issues while
> running mm selftests. Some tests assume specific hugetlb configurations,
> use incorrect interfaces, or fail instead of skipping when the required
> kernel features are not available.
> 
> This series fixes these issues and improves test robustness.

Thanks, I'll add this to mm.git for testing exposure.

Did you see the Sashiko results?  It all looks fairly nitpicky to me
but perhaps there's something you'd prefer to change?

	https://sashiko.dev/#/patchset/cover.1777877814.git.sayalip@linux.ibm.com


Return-Path: <linuxppc-dev+bounces-20818-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9507CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:24:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFf303g0Zz2xl0;
	Wed, 13 May 2026 13:24:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778642684;
	cv=none; b=AEVsqV6dXSOw6euUpd2rn3Uf5fLgzyu8iYZVZjoF7W5VmqcYSrPYdfAZqkqAeO3r5+d2W7ovtWgNIiLGS3WOIGz241o4JfvXDisOO2j4+o5sp84aZVmtelAssoDVm4ODNRjxo+lPfSNfZWxbYX3pdPt/Sety2ZiDPxDxJRQO+0fXOqgAz3GPfb1K78r8tzofXcfKRE8J6XNckTLRJIpasC7pVkrrlJpqsP/ZguraSf9NRVN+xdhsrmIFohuI/7MQWfk7gvZIk11uOBBUoUGOZjxgQSPtRH0cNwO3aO50GVUuGbt02rYdoZPWFd6OU9N2pjdjWTLvDS1SWrFWQZ4dVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778642684; c=relaxed/relaxed;
	bh=MYZpouVE2OLehGyAa7PaE6T71GlIlZTGmcLnilYkS4g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nJKb8PRIAdcxe586pmfzs4gS7TQ8TJq36+FdtRXGW4iC9jHZnPFPN8M1UxfIkXwQRK1Q9OQydjRtxc6kJRFUz43kGEuEMMHkxYaGPmc575bnwQBzWz8iGlNtuqvMxwK2P1I23TsvqDG0oz8NHhV/lM+U5pV5Odh83z1Eoj2k/siUcAnZBLSM/wjWSXSplGCmlyq6/+baqK791Gup58KY4mhLOaWjg2Am4cYZYdFicYs9Q2bNyjg5I664v3zUMYKDeFW4jJTxocbyPLM46qw//vyWh7xuf/qOHWd9OpoKgYLrUD0G3D0d8svrF995wWbYNaQoRWS+pjvCWy5x2NhKDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=xd0V97Ck; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=xd0V97Ck;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFf2z6DtGz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:24:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BA3BA60121;
	Wed, 13 May 2026 03:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6B5C2BCB0;
	Wed, 13 May 2026 03:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778642680;
	bh=WeTxWCELMc05TsXWrycjVf+KrYRziDCqbR7joXkp6tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xd0V97CkQEyg8x1FCAD5O8fl3kaLAs6QTAlIzAN8i7h9BDqugDelSjLtLWiLpt82w
	 /lo32+w1a5m/ikHJozf7RS3jC3KMNyJPQRApM3skBLRvETu1vUSWOhogkx1RkNfRkY
	 WVNe7LEJIPK3i85YpX/8OCD2wwknb8wg1/pXfZt0=
Date: Tue, 12 May 2026 20:24:39 -0700
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
Message-Id: <20260512202439.e71f233281428ff596dab0b6@linux-foundation.org>
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

Sorry, bitrot.  Mike's monster series "make MM selftests more CI
friendly" has moved a lot of this code around then altered it.  Can you
please redo against mm.git's mm-new branch?

Thanks.



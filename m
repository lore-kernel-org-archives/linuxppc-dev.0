Return-Path: <linuxppc-dev+bounces-21342-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16DDCD5BAB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 21:54:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gM2JH0zNvz2xqJ;
	Fri, 22 May 2026 07:54:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779400495;
	cv=none; b=foXMq7FapDafGJpPHXcrCFYRwj5SLmQcyimkgT8ddk/AkIq+93ysXSoB/A4eU435tmTw15AQhgdwE3S+bLAfrUU/KxeKBeDWguEWTnSmbmt/KJUIi5MR6pbOcO2yuBwf7hk1Oms/hH8d+NcwwHfvNp2Oz0ZcSFVT5xiUzI/qk+tLrS1IBT3AzjuRnUyaukNJ9XHw+juk4Fec8GHZPloxvwvwFcTvCUNnLFddEMSDZxnVBFssDvVcs6pj6UIMnRE/Tv9ZZbWHiwCkQ5kg1fBl0mYuWJAeeYx+nsO7LkrSyTkhFWyqmLIAQRy8VB8CMWNHMP/pKYituWI9fMAo+d4/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779400495; c=relaxed/relaxed;
	bh=Nq2To0QuY4e7vdPARpZ8ihBrwwym+9Z/ywa3n/yj5WU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kwj4noMjkcLM+ql1kXBoNMTOP2WrRabHsCOI0/IFjvkBIE+WNDIco5niXHTLAS6vi/9RnODoq9qNNAOW38Y+nnq4Xf4sgWsWShE77glXeOXLmL5X0RAjWimyOMOirQENzIauZ1i48o59p7PIf9kWLkg1CYlJbPehFGBNXYoZZauiI2kmGsLJwo9XiM/hH3d69lNse7rDXI2koWLpyuTYRlypPgGSYnuqwz5mgrZH5bPoq6xOnPVme8LXJJrbVh7DeRry10W9EE8np1HPKR0kzVKh6Ap38u1YCF/1jrdq05HFiv0vx2j/kT4Yw2Iw+1s6rFnQd1HKdzpw6jY8BUDunQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=lqbCa13u; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=lqbCa13u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gM2JG29Tmz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 07:54:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A8F8144271;
	Thu, 21 May 2026 21:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189A61F000E9;
	Thu, 21 May 2026 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779400490;
	bh=Nq2To0QuY4e7vdPARpZ8ihBrwwym+9Z/ywa3n/yj5WU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lqbCa13udxE5HS+7g3+IdEidtP790M7oIPY27BNI0jhTG4rd9X0On4XXir20YE9K2
	 2SwG4ZPh3ENt4oNC3COhZrRGEpo84MdcGCwaSzLYHO0tuVvULVd0kpDGSHhG3o7CKj
	 RNDilYoy/hqzHsaArsqrJy+2+E03yKpf6ea86IKg=
Date: Thu, 21 May 2026 14:54:49 -0700
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
Subject: Re: [PATCH v7 00/13] selftests/mm: fix failures and robustness
 improvements
Message-Id: <20260521145449.ff6b050527ca494a7ba66e9c@linux-foundation.org>
In-Reply-To: <cover.1779296493.git.sayalip@linux.ibm.com>
References: <cover.1779296493.git.sayalip@linux.ibm.com>
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

On Thu, 21 May 2026 12:03:26 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:

> Powerpc systems with a 64K base page size exposed several issues while
> running mm selftests. Some tests assume specific hugetlb configurations,
> use incorrect interfaces, or fail instead of skipping when the required
> kernel features are not available.
> 
> This series fixes these issues and improves test robustness.

Thanks, I've re-added this series to mm.git's mm-new branch.

> I checked the AI review comments. Most of them appear to be relatively 
> minor.
> 
> I have sent one fixup patch ("selftests/mm: use ksft_exit_skip() instead 
> of KSFT_SKIP in uffd-stress") for the comment in "selftests/mm: skip 
> uffd-stress test when nr_pages_per_cpu is zero". The remaining comments 
> were either already discussed earlier or can be addressed later if needed.

Cool, thanks for letting us know where we stand with the AI review. 
It helps!


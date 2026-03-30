Return-Path: <linuxppc-dev+bounces-19034-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276A01061B18
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 22:11:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl57R3P8hz2yhP;
	Tue, 31 Mar 2026 09:11:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774908691;
	cv=none; b=BjLp5zMcukNTI+tiGbBeQGnJy1HsvEJ3wAyVnZ7VA4QIm3j0xKBiFmb3ujHzOBhB008baJK3URD9Lqpxtzu/TqoCiDlEwIJJhnCL4U+gNcQ6oNJt2J6oZKPy1poYoT7V10aLcTr1QCs0uBUkez08AQuFnPyV1/ZKwSEm02Bm6QiZYrQBKrsLG0hXHdwNje4QpXDRxHLaH4iYqOqwO4aPh/E0+GYMrzHZ4Q2BITjCv/7BJi3KZdGlk1E6pt9E4deWR0su53EJKX1lObrR0ROC1U6a5ENs+ChzOdE+QYR4VlnJkcc7FYeOG/g/nfzmIP5SPnL4pRVOWV5WlHtfHMzldw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774908691; c=relaxed/relaxed;
	bh=wL6yxEsEEwaULE5fDTTo2PQiypnv7Xy3xqjrIXoEnFo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VX05DwhJp3gnCX0SQ1bChdhiXXaooXMZTtEIkOGN3HBSoIhKDfLf+VPe2fACUCyxvTbIYyz3OlCjc1r3RuL+xmTeCCza7YM6WiWZFYZlfp68iTvrcCYm8TMgejI+1soOC/2YNsywOLP1/qL/BI7YwwVb9SInnqsVZWcJURKDl8+H64d+yiApNlpTjlgAbqmdfhgRrLVzgdQth63zs6jCvGPWaBJJn4rm5iwyBQcLfl5bOOUhwJgAUYr8dFNDshts7POnjxtl4lTeEpPIjcw2TbWsdFa2HI8hagQB4U/VrzwSL2nInRYCT23knfbe7hz/Q44U4b/62Rh3b0gixkU2jQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=HWZGK5pK; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=HWZGK5pK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fl57Q3GXTz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 09:11:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CC07542A4E;
	Mon, 30 Mar 2026 22:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341D1C4CEF7;
	Mon, 30 Mar 2026 22:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774908686;
	bh=8Flcs8wJZzrHI02Mt/eaFqZoitQYdsBAZWuFqX0qmpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWZGK5pKlAgxIRFuQ2YHfRFgJhoE1bVfCn62Pt4YcDXzAC7xJeU2J3eEJp2rU0xwz
	 3agFaCWBb7dwgLxEu96UIdiuNJ7Ue2JYlROiiVkGnBQYlURszQLspmbASxOM5OLNmf
	 fQacPOncyQL8Vwq9sYh709Z3g6HOm4lXzCmREr+w=
Date: Mon, 30 Mar 2026 15:11:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sayali Patil <sayalip@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Ritesh
 Harjani <ritesh.list@gmail.com>, David Hildenbrand <david@kernel.org>, Zi
 Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain
 <dev.jain@arm.com>, Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 00/13] selftests/mm: fix failures and robustness
 improvements
Message-Id: <20260330151125.d0b6cbb24b273bc963b05116@linux-foundation.org>
In-Reply-To: <09104413-483f-4852-9d7e-71e0f86a1754@linux.ibm.com>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
	<20260327111104.b8bc18be45172639f5b9226f@linux-foundation.org>
	<09104413-483f-4852-9d7e-71e0f86a1754@linux.ibm.com>
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

On Mon, 30 Mar 2026 11:27:04 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:

> > I don't want to risk breaking selftests so I'll set v3 aside until
> > you're confident we should proceed.
> >
> > Thanks.
> 
> This line continuation pattern has been used in selftests for quite some 
> time. For example, a similar usage exists in 
> |charge_reserved_hugetlb.sh|, introduced here:
> https://lore.kernel.org/all/20200211213128.73302-8-almasrymina@google.com/T/#u
> <https://lore.kernel.org/all/20200211213128.73302-8-almasrymina@google.com/T/#u>
> 
>   echo "$reservation_limit" > \
>      $cgroup_path/$name/hugetlb.${MB}MB.$reservation_limit_file
> 
> In this case, it was primarily used to keep line length within 100 
> characters. I’ve tested the script  and it behaved as expected.

Great, thanks for checking.

Series is nicely reviewed and an earlier version spent time in mm.git. 
And the bar tends to be lower for selftests.  So I *could* break my rule
(https://lkml.kernel.org/r/20260323202941.08ddf2b0411501cae801ab4c@linux-foundation.org)
but would prefer not.  What do others think?

Did Venkat's report
(https://lkml.kernel.org/r/cf815c21-138e-44c8-986d-d8496503ee32@linux.ibm.com)
get addressed?  I'm not seeing that in the v2->v3 changelogging.



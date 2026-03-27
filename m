Return-Path: <linuxppc-dev+bounces-18937-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C29D10F2863
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 18:11:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fj7xS42mdz2xmX;
	Sat, 28 Mar 2026 05:11:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774635068;
	cv=none; b=ofkTwAkVCSFPRKK5MOsMCe7gSq9JoMFLHgBjsOKSceo/Lk0TyZ/b1gnCr+1G7Ux6H2ra/2xTOSuxgUHatEYRHCHQBlt3XT4Cnovg/NE0LEErazmPDdwXPYGYIRdCfzlb0zMTNFf4uLpom3+/vdKQvmHHYoF/QygKaoRm1EPX8Xu0jHgNZrMZ637KGhf68QmT+NKd5ybFZlwjZe7LpJwYCL3VpSVjUxvQKTcE7wmXtAg/9PKhr2HqA8gAm8c9jdNUmsBG7pxWKQ8h8cpuQZS+qttsvpFuszqngMSrOHiew6iOOxF/920hvrKQ06/IVa/ZjWs7CsxDt6RiYBqqB3AM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774635068; c=relaxed/relaxed;
	bh=n9SFUKozSMR2ZLvGBLpF/dxrxKYuIksgjItSw16BeBo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YxT3VMm9YyyU/nK9EJHschAdrXTZjjl0JOT2InDvO9dFgJQwAkJxcIiuXNBo6PVwfKeZbPtIKdtrHGvi8Z0q8lfltFtNBVcz7LN4akIxSfMUr5xg2/skD/yfvsPiwjrzUvtJ7qQ4gADAudlxy7400BMRTj9i2ips6MqhpZBbpWwxghk1YHYyOUyXXiYdF6NaS/+HIJoM9pidIYxw0fcPRZv+diW0s7eXdSL9CBOz3ObiDBYS03KrzFBvpmVeH09PUKf3QrFGxHB/cYxfQcsyrPPkK0G8V/+1Glgr6nSCSveSMKgFlJqgWDcfAdj7EFSD01+UMZYPILNkHozFjzGa5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=cdYOayuP; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=cdYOayuP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fj7xR54w0z2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 05:11:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2E9F643E7E;
	Fri, 27 Mar 2026 18:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94449C2BC9E;
	Fri, 27 Mar 2026 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774635065;
	bh=D3tgGfmxSUuIKrF23B6dFn44AdNk1562eNoc2kIzF0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cdYOayuPJYi2aaxhAmAFgppjg5NFHZRBdYAYmVT0UcRjcTZjflLB/FGXTUb9V3lJx
	 OgYT97I6nd+lwOsBPiBlUFP0OCrdat5FF+6ghCrli/AY5UhTyMpR/3xUnK2jyN4H6W
	 38fwnTH1RNgXYVSZcfyBJ0jwwTiW+dxnu/XqmhNw=
Date: Fri, 27 Mar 2026 11:11:04 -0700
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
Message-Id: <20260327111104.b8bc18be45172639f5b9226f@linux-foundation.org>
In-Reply-To: <cover.1774591179.git.sayalip@linux.ibm.com>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
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

On Fri, 27 Mar 2026 12:45:54 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:

> Powerpc systems with a 64K base page size exposed several issues while
> running mm selftests. Some tests assume specific hugetlb configurations,
> use incorrect interfaces, or fail instead of skipping when the required
> kernel features are not available.
> 
> This series fixes these issues and improves test robustness.
> 
> Please review the patches and provide any feedback or suggestions for
> improvement.

AI review asks many questions:
https://sashiko.dev/#/patchset/cover.1774591179.git.sayalip@linux.ibm.com


I never knew about that bash line continuation thing.

hp2:/home/akpm> cat t.sh

foo=\
	bar
	
echo $foo
hp2:/home/akpm> bash t.sh
t.sh: line 3: bar: command not found

Huh.  But it presumably passed your testing so confused.


I don't want to risk breaking selftests so I'll set v3 aside until
you're confident we should proceed.

Thanks.


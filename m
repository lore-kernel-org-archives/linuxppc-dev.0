Return-Path: <linuxppc-dev+bounces-23029-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2418DC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 14:49:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmz8M3yHfz2yYd;
	Sat, 27 Jun 2026 00:49:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782485347;
	cv=none; b=W8K4fIanvtikvXntXaOVZjKsx0s+Fp7ZMB1/J2+6A9Rxo2A/Gevk7oLYaGsN9yyWbZB1viPz9bRBTn7E6BL1D3IAv4atEssdLlLnB9MJn3HZXODZ3s/mCichIxR3INAp5fl57BtNIf3jwEALw16Le82lBdjxlye+SkdxcXJCvzq/GuacQyGHX2236Ib/C24rxJ9vY+W9t02AZl19KGp2JLHI1KCe6dwm+R1kwrPGlyaQOpXK6y4UMO+kJfBaJ2YoJvUm8u+tBFyhsTp3dph6s/403Nh4GR1huVMssCSV0/ebFvKv2o9BK+BZFyUIPniWeTcShAH6iqZXHcPgOSjxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782485347; c=relaxed/relaxed;
	bh=+d/7ra1oyDy8FyFgz7QVlu1h97UzmlQOCBPgAiPibmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOSxft4xKegwRSeydKMgVqdA1l3ZW6+XmJKXSPa56mYIKagPrcyNYU2TFxo6dL4BoVz7jA3FyGeRNQyfF4DoJfhL3S7xNt12W86D7UnwwBh88+nJ+/TrAkdGyV9SXRHLrlCm5D/SekvIEebmN0W0wMX5vMf9BgeOVx3lM0QllAV4iVXPmsFKR4vAtZASRrP4MIsADdKVmm1p/xTiMAuydDim2WeiObWWa1sna11P5mkOo8djbgu/TiX0JwZupippbkC18dn/mUrZneuNTK+RDXnrpnXKmZmrzNtAIGnYtE5YPFlhuOHtD6eAnvLWPE+GOjuxUnMeZaJBeNWBEfjiyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AULFV8Br; dkim-atps=neutral; spf=pass (client-ip=95.215.58.188; helo=out-188.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AULFV8Br;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.188; helo=out-188.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmz8J6VCFz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 00:49:03 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782485323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+d/7ra1oyDy8FyFgz7QVlu1h97UzmlQOCBPgAiPibmc=;
	b=AULFV8BrKKN5qg0eXAyY3S0T2tsj5sBo1qe/+rhSgEyOxk9IOmvtAZUZSNWFEoOeIp3+7J
	uV28C/FVYwy93EHn91SRI/KiWMilogWBQ1OobydKjwgkM0LhkmLCxXEV2u1wbtqmXx1RP9
	yYiaj/nFzo6K/GXun1dSd3ogpt8KI+E=
From: Usama Arif <usama.arif@linux.dev>
To: Sayali Patil <sayalip@linux.ibm.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Michal Hocko <mhocko@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Dev Jain <dev.jain@arm.com>,
	Liam.Howlett@oracle.com,
	linuxppc-dev@lists.ozlabs.org,
	Miaohe Lin <linmiaohe@huawei.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH 1/2] selftests/mm: handle EINVAL when configuring gigantic hugepages
Date: Fri, 26 Jun 2026 07:48:34 -0700
Message-ID: <20260626144835.3759976-1-usama.arif@linux.dev>
In-Reply-To: <8bfa921e30eb94072685103f6496784aa23bb166.1782365671.git.sayalip@linux.ibm.com>
References: 
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
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu, 25 Jun 2026 18:10:16 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:

> Some MM selftests attempt to configure the amount of
> HugeTLB pages of different sizes by writing to nr_hugepages.
> 
> PowerPC hash MMU pSeries systems advertise gigantic hugepage sizes 
> but do not support runtime allocation of such pages, writes
> to the corresponding nr_hugepages file fail with -EINVAL.
> This causes the test to bail out even though the failure is due
> to a platform limitation rather than the
> functionality being tested.
> 
> Treat -EINVAL from the sysfs write as a skipped configuration request
> and continue running the test instead of failing.
> 
> Before patch:
>    -------------------------
>    running ./hugetlb-madvise
>    -------------------------
>    TAP version 13
>    1..1
>      [INFO] detected hugetlb page size: 16777216 KiB
>      [INFO] detected hugetlb page size: 16384 KiB
>     ok 1 MADV_DONTNEED and MADV_REMOVE on hugetlb
>     Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>     Bail out! /sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages
>     write(0) failed: Invalid argument
>     Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>     [FAIL]
> 
> After patch:
>    -------------------------
>    running ./hugetlb-madvise
>    -------------------------
>    TAP version 13
>    1..1
>     [INFO] detected hugetlb page size: 16777216 KiB
>     [INFO] detected hugetlb page size: 16384 KiB
>    ok 1 MADV_DONTNEED and MADV_REMOVE on hugetlb
>    Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>    /sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages
>    write(0) failed: Invalid argument
>    [PASS]
> 
> Fixes: 9d07250ea1eb ("selftests/mm: hugepage_settings: add APIs to get and set nr_hugepages")
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>  tools/testing/selftests/mm/vm_util.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 311fc5b4513e..a8f16eef5c7c 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -735,6 +735,13 @@ void write_file(const char *path, const char *buf, size_t buflen)
>  	saved_errno = errno;
>  	close(fd);
>  	errno = saved_errno;
> +
> +	if (numwritten < 0 && errno == EINVAL) {
> +		ksft_print_msg("%s write(%.*s) failed: %s\n", path,
> +			       (int)(buflen - 1), buf, strerror(errno));
> +		return;
> +	}
> +
This makes write_file() silently succeed for every EINVAL, not just the
gigantic-hugetlb setup case. Several callers use this helper for writes where
EINVAL is a real test failure, for example drop_caches or split huge page
setup. Those tests can now continue after a failed setup and report misleading
results.

Please keep the common helper strict and ignore EINVAL only in the hugetlb
path that is probing unsupported gigantic page runtime allocation.


>  	if (numwritten < 0)
>  		ksft_exit_fail_msg("%s write(%.*s) failed: %s\n", path, (int)(buflen - 1),
>  				buf, strerror(errno));
> -- 
> 2.52.0
> 
> 


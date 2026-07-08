Return-Path: <linuxppc-dev+bounces-23819-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510C7C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 13:49:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwKFx4H8bz2xll;
	Wed, 08 Jul 2026 23:49:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783518565;
	cv=none; b=OB9pv5wj3UFCJOwdL0o4yf84Dr3XRNtHptzHTE7e+F1b7W3dEnw/RknE3JC8KCgWlSf5o7YGEr2yQNrX5wwLZQrqu2zq1OvOliqbY/3nOWGTPeSxSmyaQrS4yFp1/JllPT4CzXy1rK4wec7MSQ6a2aVcEjF0FIBcZw0KmM5VDwZ0RET4go9dyNIRPLO5ac12Cut4s+iu5zeD2aozpzLC3btYX61uNaUTm/De4b2uNzssTe/acm5pii4/f4D6OGqueQiP2//zBrz4EAHy19wAl1qI+uHrRxLMueHip7aS/EQCyHBXXDpYGzuJ/cwifGCbyi/T2K3+Zwg5rlGH99pF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783518565; c=relaxed/relaxed;
	bh=TEGzzoFWcnNWGGmasKpR7vNO3wPHNttV6bHdoJJUeuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ba7L2cT5jtAsmtj37Fsc6CPjb03MO4caYD2Un7x6wsoNaT9RqDz0/nlwe5bat/LALqv6dNCY+qgLbPhZ7HIvTkyd/wnuJjFv4eXwSLYBPzh7doSXcydl8UX0Lq83vaqfUiJlMeq71ZtzBgZWbLUgqP35iNU8XBmdSNGGVUkH8xuZolqhv6Az9I5ZPsvaC0CXE277dvP/xF214oFYp2OcRlDUje4FNxzmnuQ99kP3EdR+GS6AiPVFjeOxTWvWL9RXrlIMeGh808zSFlItf0IuKeMs9bePyAMHn/WHhdhaAcOMkBwjUs5YhwHJpZfesgzOBcuqG+T6Z6wZqi7998aB4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mXbZxdXN; dkim-atps=neutral; spf=pass (client-ip=95.215.58.170; helo=out-170.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mXbZxdXN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.170; helo=out-170.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwKFs4c0zz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 23:49:20 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783518539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEGzzoFWcnNWGGmasKpR7vNO3wPHNttV6bHdoJJUeuk=;
	b=mXbZxdXNK8zwfiH+BaVAX/a14LKht5ZVC+Wv7EwJmNmgfH7LWboOjRCpvZuv44yqZ92n+L
	HTpOJmwORQJdus2K/nxg2k5sHDV24WBE1jpcCO3Xmgfz/8evz+Zw4qadzjqXk+l1Ie5Dkb
	HqYuO1oM26W/bUjStsW0rqIMNmJO8nA=
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
Subject: Re: [PATCH v3 1/3] selftests/mm: handle EINVAL when configuring gigantic hugepages
Date: Wed,  8 Jul 2026 06:48:50 -0700
Message-ID: <20260708134851.4153021-1-usama.arif@linux.dev>
In-Reply-To: <2e3b585cbb30b2fc495dcd49d75de6f6da61861c.1783446924.git.sayalip@linux.ibm.com>
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

On Wed,  8 Jul 2026 12:29:05 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:

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
> Ignore -EINVAL when configuring nr_hugepages so that tests continue to
> run on systems where gigantic hugepage allocation is unsupported.
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
>    [PASS]
> 
> Fixes: 27477b28b74f ("selftests/mm: hugepage_settings: add APIs to get and set nr_hugepages")
> Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>  .../testing/selftests/mm/hugepage_settings.c  |  2 +-
>  tools/testing/selftests/mm/vm_util.c          | 26 ++++++++++++++++---
>  tools/testing/selftests/mm/vm_util.h          |  1 +
>  3 files changed, 24 insertions(+), 5 deletions(-)
> 

Acked-by: Usama Arif <usama.arif@linux.dev>
 


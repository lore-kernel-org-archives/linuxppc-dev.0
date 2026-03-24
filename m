Return-Path: <linuxppc-dev+bounces-18745-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A333F54AD6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 23:56:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgRl05kRKz2yng;
	Wed, 25 Mar 2026 10:56:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774396572;
	cv=none; b=naWiE5iqI90h+TGpFvOjDlFqadkVpN4+t0ny0CFOyog3lUgbluZ1H64YzXK91Bi9JY32WqeYiIqyLkAYcEfiHH5w0hBiiUzAsNvR+PDS2S3i5MhSCRz2AKylYgUes0F4QOvNSuE2OABL0fn7VLTUHxqlmLB+Xv3Aq/XoIrA138f4R0biQsoV2ERIJFnCMTh9ptJNMWSgSvRCChHIVcAeAGciUlTzAvAJ933WuDn61KNsNdspDcaBXVWzk9lcIdxbve+xvO/7USF0Ba+vGKYhmmPvciW02otf0hyN36Xmoqh58YmwdGDBcQMVml0wIpNTChwaL2WyTZpuBZGDA8uOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774396572; c=relaxed/relaxed;
	bh=R0K/BeYyv/79GnAkQR3Pc+53//iQWf/atDo2TbDZAqU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G6GsbgqfpjStS093lEsjn8ZdMACHF4U8khS8c/z5l50yrV+NRZCOz724zQO7S9Fz0rbrGMOGQISBd+eq1OOqMGgspuyouCHEUeQS0yF3ACX3+ypVkKUaFvmKhMgc18t3RlAxFf7LFapGX82ElbUomUSSlxOfoYlkaWnIMcYVX11fcvpVL8z0VxXO/YngdkxS5Dv6c4reDdUk1j2mTmeRgr9+S+JMR74t4pl9SGY3uUzhBBVDOWlT/dSgYuxJq3IQi6b2NJG0PFttuvOqUnrCvcJcOw3iHhSDND9ImSywEO8E4TL3ja3DCFbwoGZNjwFAd5LBevrB2lqvpgqMH2ojeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=PBp9KCP+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=PBp9KCP+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgRkz6tq3z2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 10:56:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9DA7C600C4;
	Tue, 24 Mar 2026 23:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C5FC19424;
	Tue, 24 Mar 2026 23:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774396567;
	bh=4uNybzToUKp0EAa2ve7IC4o/Ki+L3VO4Pq1iJB1BAU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PBp9KCP+HTB22gb2kXON2RUvZihG+skEDsleFplTuA9hcaKXm0c7btgBY7E+je8tg
	 NG+mNtn94cmgHl2PQb/6bKQe+GDc2rtIqwKbuAtwmQF4eWKkM2znUoOTCvCkChd8Kv
	 KFtbZGAhe4u4GFoI17yLq9TIJObhfUfcF+yGHKds=
Date: Tue, 24 Mar 2026 16:56:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sayali Patil <sayalip@linux.ibm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Shuah Khan
 <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>, Zi
 Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain
 <dev.jain@arm.com>, Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 09/13] selftests/mm: skip uffd-wp-mremap if UFFD
 write-protect is unsupported
Message-Id: <20260324165606.d75200ac0e5458a5ffb83d5d@linux-foundation.org>
In-Reply-To: <0e9cea41-7c49-446a-b67b-256584960516@linux.ibm.com>
References: <cover.1773305677.git.sayalip@linux.ibm.com>
	<ed23ff57a80881c9d087d22709862af40addf49b.1773305678.git.sayalip@linux.ibm.com>
	<457dddf1-04ec-4d1e-8640-b04997fac4f1@kernel.org>
	<0e9cea41-7c49-446a-b67b-256584960516@linux.ibm.com>
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

On Fri, 13 Mar 2026 19:56:01 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:

> >
> > Because right now it reads as if it would be returning a bool.
> >
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> >
> Thanks for the review. I'll rename it to
> "check_uffd_wp_feature_supported()" in the next version.

There was no next version.  I added this:

--- a/tools/testing/selftests/mm/uffd-wp-mremap.c~selftests-mm-skip-uffd-wp-mremap-if-uffd-write-protect-is-unsupported-fix
+++ a/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -19,7 +19,7 @@ static size_t thpsizes[20];
 static int nr_hugetlbsizes;
 static size_t hugetlbsizes[10];
 
-static void uffd_wp_feature_supported(void)
+static void check_uffd_wp_feature_supported(void)
 {
 	uint64_t features;
 
@@ -347,7 +347,7 @@ int main(int argc, char **argv)
 	struct thp_settings settings;
 	int i, j, plan = 0;
 
-	uffd_wp_feature_supported();
+	check_uffd_wp_feature_supported();
 
 	pagesize = getpagesize();
 	nr_thpsizes = detect_thp_sizes(thpsizes, ARRAY_SIZE(thpsizes));
_



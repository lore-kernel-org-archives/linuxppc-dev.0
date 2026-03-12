Return-Path: <linuxppc-dev+bounces-18156-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDE1106ACEE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 22:05:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fX1rs5hSrz3cF4;
	Fri, 13 Mar 2026 09:05:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773353133;
	cv=none; b=LrPbmN4k9nJ5PGnte3zndF1spYf7X8AyKCdD36HrIdWwtCZdnHga3TFiNuoKG6rDmfVKWzSCCWqe9oZj2gH4I3T+Japdvjd4XKO/8oBB7pgIFofBEBSOflRONbuaS1qYH+XfpzjNuoSpd/bTR2XQDhskLTErcnGc10qMY35vumYIRk6QP/xCE2nIHFndetBxiIUb1zJj8PyHBUVMDUyrjeMcOj+7dda9iUhEOO3piHsejGJ9tstPJCn3Do12pLfnf/B065GLuv0OscnM1i/OCWITEgfx05/OzkX0vVbrIcLWqYuRFgA+xwctxhIQ1QBitVrejI0/N/1xx10G140Ccw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773353133; c=relaxed/relaxed;
	bh=zJCr2vGKsIHLS37rJqTuGj2Z8U6oKmj2uaVBuadFi8g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CM7nAF9vlQzkQdSSvEvSygpfdiwCHS6VMo6EGfRmqcJe7I7+YHmkxVWfGshv+Ib9cKbpB4GsxkWZhVzeSAqY27JeORmXBlzSCxEd8bVThe0dGbPRTtv68LbdDEmVDuYYrDHkICt7nEH9T6YJ5obCiPkf4doBtCgm6JaSYqkjbuHqHJCeNdu72f1Zh3991k0jKiRugliAtCj2rJkuIswT6gbX6gyv+xISf01YWRUSDC1o7wSJh1IyrOpQm5UVsDOjxWkx+Hqatxjsdg8FT40optIm7jAILpjqhME4pzcHwkxLmyde4v+lFUln7krVU4epgJlhi6zwCTSc3zRLeMUZww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ZsTJnAFO; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ZsTJnAFO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fX1rq6Y8Rz2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 09:05:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7BC2360142;
	Thu, 12 Mar 2026 22:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E28C4CEF7;
	Thu, 12 Mar 2026 22:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773353128;
	bh=kJpOMXmeVrgv0HG/rFG8bTekmGeeG6gm/5I211m0F2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZsTJnAFOvr36+k42PB7o8XC4L8ru8l4Pwk5EqtRL49hE3Afi6x8ed3VLafByWN8ek
	 b1Uh8rOn14iieth4yKSCmtemSITG3j5PoDpI762Vf2n+jiVAHL7MrnoQArrm5MWVyX
	 ao/3KIJbyb4xf/LbczAsiBmxmjquDbsgMM7uMdDs=
Date: Thu, 12 Mar 2026 15:05:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sayali Patil <sayalip@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Ritesh
 Harjani <ritesh.list@gmail.com>, David Hildenbrand <david@kernel.org>, Zi
 Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain
 <dev.jain@arm.com>, Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 00/13] selftests/mm: fix failures and robustness
 improvements
Message-Id: <20260312150526.3662b2717b9a91776a2e43f5@linux-foundation.org>
In-Reply-To: <cover.1773305677.git.sayalip@linux.ibm.com>
References: <cover.1773305677.git.sayalip@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Thu, 12 Mar 2026 17:55:27 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:

> Hi all,
> 
> Powerpc systems with a 64K base page size exposed several issues while
> running mm selftests. Some tests assume specific hugetlb configurations,
> use incorrect interfaces, or fail instead of skipping when the required
> kernel features are not available.
> 
> This series fixes these issues and improves test robustness.

Thanks, I updated mm.git's mm-new branch to this version.

> ---
> v1->v2
>   - For "selftests/mm: ensure destination is hugetlb-backed in hugepage-mremap":
>     update FLAGS definition to MAP_HUGETLB | MAP_SHARED | MAP_POPULATE and
>     used it for mmap() calls as suggested during review.

That was a really small change (below).  It's better to wait a while
(half to one week) before resending an entire series.  So as to
hopefully accumulate more changes.



--- a/tools/testing/selftests/mm/hugepage-mremap.c~b
+++ a/tools/testing/selftests/mm/hugepage-mremap.c
@@ -31,7 +31,7 @@
 #define MB_TO_BYTES(x) (x * 1024 * 1024)
 
 #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
-#define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
+#define FLAGS (MAP_HUGETLB | MAP_SHARED | MAP_POPULATE)
 
 static void check_bytes(char *addr)
 {
@@ -121,23 +121,20 @@ int main(int argc, char *argv[])
 
 	/* mmap to a PUD aligned address to hopefully trigger pmd sharing. */
 	unsigned long suggested_addr = 0x7eaa40000000;
-	void *haddr = mmap((void *)suggested_addr, length, PROTECTION,
-			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
+	void *haddr = mmap((void *)suggested_addr, length, PROTECTION, FLAGS, fd, 0);
 	ksft_print_msg("Map haddr: Returned address is %p\n", haddr);
 	if (haddr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap1: %s\n", strerror(errno));
 
 	/* mmap again to a dummy address to hopefully trigger pmd sharing. */
 	suggested_addr = 0x7daa40000000;
-	void *daddr = mmap((void *)suggested_addr, length, PROTECTION,
-			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
+	void *daddr = mmap((void *)suggested_addr, length, PROTECTION, FLAGS, fd, 0);
 	ksft_print_msg("Map daddr: Returned address is %p\n", daddr);
 	if (daddr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap3: %s\n", strerror(errno));
 
 	suggested_addr = 0x7faa40000000;
-	void *vaddr = mmap((void *)suggested_addr, length, PROTECTION,
-			MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
+	void *vaddr = mmap((void *)suggested_addr, length, PROTECTION, FLAGS, fd, 0);
 	ksft_print_msg("Map vaddr: Returned address is %p\n", vaddr);
 	if (vaddr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap2: %s\n", strerror(errno));
_



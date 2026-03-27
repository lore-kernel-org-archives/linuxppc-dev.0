Return-Path: <linuxppc-dev+bounces-18928-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A096A10F284B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 16:47:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fj65F6T3nz2xmX;
	Sat, 28 Mar 2026 03:47:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774630065;
	cv=none; b=LT40NrR+2PfwH2W5O1v/Sm1MhUa1wVM0SjihAShne8sjCcRRw1YTArQ4CGMgm5qbbsD/6KRdOnA0QK4LO46Itc0vUQm5FrQtLTq5SObU/n1cnjDkVr3HdcIuqxqIL62Ur20LItAO5D0ghNfnHqhUmo9RDOL2nx8vXwg0kUkQe5FOEdBqT264nuabLO3/QW5S9kCELotDaFZIcb+szhDFpiQ10KEgDyQ1Jhb4ulwRs52Bzy9K0nLNGphtdsEu4euP2ZDNJBQfCJuv6aCgz/q7UAZ4Nr1vyHGphNzeDhErP79WR1VhJ8sO7G+exu8r69EYCWH8g/b/ZTjsK+Vweb8iog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774630065; c=relaxed/relaxed;
	bh=A2GOXUcfCtO+hU/aS7MG7CRDyabivV54yc7GX1ZTR4Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P5oIi6hAdAiz4vKYfHB86bnZLKb4QBEJkcgiFSgcRco16e/rHvEhSFHetR/oSf8N7yn5CpsXihVyrQck88N5tVBQ2UC7C1M30hQlwAqNLJ8/NWUfQVLG8zYBqRmE6ZG7YNnf58BoLUJjphfTlHhYbQjv0c+vBvHbPiQ9OnU4EUysFH5PAEM38H9faGFbgJmwQMlWWFWk8JAZoYxZYcv+bLW7M1i4R35+2XTWczLkPtkbvZ8Giv8btbhXT6cw1uV69shAHLddOneX/AXjLoncFNmootP6QEAUQILdpKATn4iNvaszl94jnkHypnEWHlm6uvpta3Ob8qdkFJHcZJAlOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=n03tXMcp; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=n03tXMcp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fj65D6bBRz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 03:47:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4F94943C26;
	Fri, 27 Mar 2026 16:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0CEC19423;
	Fri, 27 Mar 2026 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774630060;
	bh=zCHu6vdwFKPQuNA2ItrsbdYzJ6DJHAS5OipAXB0fjEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n03tXMcpjjYNt0Hx9YQwbPGwEDXWZKfUKohUo5ohPUHbPx+f8qh+KDZeTzpBbg3/7
	 LokGmm0Pw75YvFbCHRFosn/8qYVSWw0qa92DFLMAQG6xmDRvM6NK+zWmACR7qoWvYF
	 QyWcblJX4j+wv1GSRREER4cGbV/YrZaU//IBoy1I=
Date: Fri, 27 Mar 2026 09:47:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org,
 mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com,
 npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
 borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
Message-Id: <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
In-Reply-To: <20260326080836.695207-1-surenb@google.com>
References: <20260326080836.695207-1-surenb@google.com>
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

On Thu, 26 Mar 2026 01:08:30 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Now that we have vma_start_write_killable() we can replace most of the
> vma_start_write() calls with it, improving reaction time to the kill
> signal.
> 
> There are several places which are left untouched by this patchset:
> 
> 1. free_pgtables() because function should free page tables even if a
> fatal signal is pending.
> 
> 2. userfaultd code, where some paths calling vma_start_write() can
> handle EINTR and some can't without a deeper code refactoring.
> 
> 3. mpol_rebind_mm() which is used by cpusset controller for migrations
> and operates on a remote mm. Incomplete operations here would result
> in an inconsistent cgroup state.
> 
> 4. vm_flags_{set|mod|clear} require refactoring that involves moving
> vma_start_write() out of these functions and replacing it with
> vma_assert_write_locked(), then callers of these functions should
> lock the vma themselves using vma_start_write_killable() whenever
> possible.

Thanks, I added this to mm-new.

It doesn't appear to fix anything and it has no
appreciable&measured performance benefits, so I just broke my own rule.

Weasel words: Lorenzo would like it in 7.0, unreviewed patches in
mm-unstable&mm-new are down to 62 and I'm a sucker for nice patchsets.

Three of your patches lack review tags so now it's 65!


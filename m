Return-Path: <linuxppc-dev+bounces-28657-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418A6CA5FCB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 15:10:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwb2V56l5z2yTQ;
	Fri, 02 Oct 2026 01:10:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::cf"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790867442;
	cv=none; b=QQJBi/46REyi4pO5+toqy3+zZguANxtWtk/3NhF6Bqa++pE0OHh2tiCMuRykqnh8i2AdKO7QNmVdtJu+OQYaWNwAiUDwuRDVkEV706ip6K6kbCkUxBI/Dml5OjrOOT1gOaK+4OfMsl5ja6MvBEUs6nwo0nMbnTW2JYaqBfGDAQ/NRaPi0GTGsZdIYjZD3ZO0Ju/EDNKamxHRSBabkGR6u1ooqVqJWXmrxMrW3H5RT6rMXzuvb93PtPb3jhJOOrhv6e2mQef+MPDGg3rMQm2+AHswB8CCoY8TFUAWd8/cLURuQsEkKM26IoYoZjlthsNlai4MUuEyKJec56axfqYXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790867442; c=relaxed/relaxed;
	bh=19fzsCobHrxn+R704cNeeLUdcI8tiMY4kZKgcePTcgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8U8ZDXuhwBLN1L5rqvPelAJ7VK6ZTAszfin9Gdln93uvDQJ2A2O3GccH3EU1ClVc8cEGGIlJIUU5nIK614YlmjCLHBgYNAV36Xr6ri4FNC8mdKE9xzWGNQeBD6seFdM2N7/uOE24BAyTS9uB4PVmCsZMpsVHG8gMkpYXqTKQs1j7/vd3bSrRPdYQhDSNuSzW3Mwj6ASJ8fEjs8oOGxwsy5ihBDY1Z1YxRasRvifO1IW07tAsSwAmUYVEienhlTGVAV2FOoANmhy8yaJwECR7Mkxk+4JYF6XolT/MLJ0e3GxglCFNJffQtNQuGq9D0zBh/y6nDJSPpEy6XGgc/94tQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mpADEyj8; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::cf; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mpADEyj8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::cf; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-207.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwb2S0l9Lz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 01:10:38 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=L2y3LjuG7/C5nMxsLJdD+ZkujhPKk48juGG0sm2xrlQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790867420; v=1; x=1791472220;
 b=mpADEyj8uQNZVkfjC29GZiKu9JxBNUHoFUXB0DH8b8ZwPIBiiF5EyYwcOAxm6FFVjEZLtNLI
 iBxbtO8Ko1Zs5p1kT5o8XQxp43WKB9YaAXdt4iGdty9D8X/n9blTRcrKf4Mrp0lJmH3CpWnSmA+
 tjuZ1CwRSCiIN8urlLWZzNoo=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id e5f0bdfb081f1dba;
	Thu, 01 Oct 2026 15:10:12 +0000
X-Mizu-Trace-ID: e5f0bdfb081f1dba
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: songmuchun@bytedance.com
Cc: maddy@linux.ibm.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	qi.zheng@linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	muchun.song@linux.dev,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v3 5/6] mm/sparse-vmemmap: open-code vmemmap_populate_address()
Date: Thu,  1 Oct 2026 23:10:01 +0800
Message-ID: <20261001151001.20393-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260929053231.66085-6-songmuchun@bytedance.com>
References: <20260929053231.66085-6-songmuchun@bytedance.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 29, 2026 at 01:32:30PM +0800, Muchun Song wrote:
>vmemmap_populate_address() no longer has any callers that need the
>returned PTE.  Its only remaining user, vmemmap_populate_range(), only
>checks whether population succeeded.
>
>Open-code vmemmap_populate_address() directly in
>vmemmap_populate_basepages(), remove the now-redundant range helper,
>and return -ENOMEM directly on failure.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Acked-by: Qi Zheng <qi.zheng@linux.dev>
>---

Much simpler without the extra wrappers :)

Reviewed-by: Lance Yang <lance.yang@linux.dev>


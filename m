Return-Path: <linuxppc-dev+bounces-29171-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE864CA6017
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 08:38:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1xvd14MKz2yqT;
	Sat, 10 Oct 2026 19:38:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::bc"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791621501;
	cv=none; b=jX9hw8YiTajvU7pa4sFkdgU1UnqVj6Ay10s2aR/M+LbYamAU07Eup58Hww0akkc39TDvBuDnX+EhyyPkmV2ezn2muCKS5F03zSSjW15Dtkd8to1/Syuwm0tbvYxw1zvPhMA2gFDABjMNudzKGdIkgxihWBaxBMHmLww/UP95CpzycLOr5OSPRqpSacJhU8BkJedU8xpk1zqY0wsPhEZs3/wyrB579jRhI3sO6o0T/VMs0G+rTJ8NWZ4BjrvhZeOK7NjKVWmqNfK7E2GjMkLs3TU0BLvoL5Kyl34DO7P+YrZ7aNhUmFbvaDhQl3CBucrFJL2DQKQiPU6qJZ4fWxPzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791621501; c=relaxed/relaxed;
	bh=+PRO4n3F+OyGen9J5HY+faBhF6ZEkZwsHa88ihF2mE0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SK565WZN6Rs6o1qfnhsnRZ5hVU66jUfIKRAmf/pnorDNeFHS2SMoxkc0iNv2lGlI54ZvA6ymwJcsBkankdX3LP2Cpq09I4KSoTJ2h4OfbZIPqib/u2huTqbGKcgnAcerMwege1AN4rs+3lrIiHALOdtA8znuNEbFj+iNzI5CGfQxALY2oF3tWGy7FkflANJS8pVao3Zdrx8ypQ9VDdGzV2eowm1D6ePQgdrayHRqThBNCoPnyo3Wdg6DWNJOWfvnnaA4DYktMekPCdJZceUzs6+ZJU97MmBFfb+cj18H6ANbb50c2uYQQrDIdCv7d6Zx4SbF4HpNAJuxkkHWyNpATw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oYmg7oPL; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::bc; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oYmg7oPL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::bc; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-188.mta1.migadu.com [IPv6:2001:41d0:203:375::bc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1xvW1cSzz2y2T
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 19:38:11 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=+PRO4n3F+OyGen9J5HY+faBhF6ZEkZwsHa88ihF2mE0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791621471; v=1; x=1792226271;
 b=oYmg7oPL2B1sRU24mKtUTDz76yapqAkf0qRDuaZ6W9MgKCmMXQKSaYrM/7vfR17b59irGfx7
 ghxjduwkMKUzw8xkETAJcC+mUvgAiQbsKiH7Ik+WdF91sULkH6/lKCBIpeOYidXWjJNMiGCTVpq
 YVVirn4kod/H/0ruVZT2Bo2w=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 15e719b1ad28d653;
	Sat, 10 Oct 2026 08:37:51 +0000
X-Mizu-Trace-ID: 15e719b1ad28d653
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v4 3/6] mm/sparse-vmemmap: drop Device DAX-specific
 population path
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261010075755.83339-4-songmuchun@bytedance.com>
Date: Sat, 10 Oct 2026 16:37:35 +0800
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Qi Zheng <qi.zheng@linux.dev>,
 Lance Yang <lance.yang@linux.dev>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <42099448-FB7B-4885-9DE3-DBB6C96B88FF@linux.dev>
References: <20261010075755.83339-1-songmuchun@bytedance.com>
 <20261010075755.83339-4-songmuchun@bytedance.com>
To: Muchun Song <songmuchun@bytedance.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 10, 2026, at 15:57, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> The common vmemmap path selects the shared page for optimized mappings
> itself, so Device DAX no longer needs =
vmemmap_populate_compound_pages()
> to find a shared tail page and pass its backing PFN through the =
generic
> population helpers.
>=20
> Remove the Device DAX-specific population path and let section memmap
> population always use vmemmap_populate(). The powerpc retains an
> architecture-specific compound-page implementation, so select it =
directly
> from radix__vmemmap_populate() for optimizable sections.

Regarding the issue mentioned by Sashiko [1], it does exist, but it
was not introduced by this series. I have already fixed it in another
series [2], but it has not been merged yet.

[1] =
https://sashiko.dev/#/patchset/20261010075755.83339-1-songmuchun%40bytedan=
ce.com?part=3D3
[2] =
https://lore.kernel.org/all/20260924025035.1265035-1-songmuchun@bytedance.=
com/

Thanks.=


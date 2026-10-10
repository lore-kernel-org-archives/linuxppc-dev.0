Return-Path: <linuxppc-dev+bounces-29172-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A22BCA9EBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 09:33:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1z7T6cnnz2yqx;
	Sat, 10 Oct 2026 20:33:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::62"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791624821;
	cv=none; b=ScrtpkDlwP3JydzczJBTIpu23QKlfFl3n7je2sG68LMcv100iDSat3llViBYS9nzqeWOf4TDpWD/SE49uh4FALlxhaHVWN3uj78CuBcCerEETXf5zvpR/k4O5jMOvzNn15n0pNTuhY1LM8UrrVkuu44BY5PCF4q4GC0R5yRdRXQttmfhZzDLIkYbDQ3xoteRJZIdMjvsMeGU1ZDtlyi9GesGA1YOvnj+StFDnehYfYWrx/QzilOuLIvRGf7KSFu93zDJcaeap92ElPFKpzMP4LM603wovjOvfKXrnJ8jY0K5ahs29rFkYQUph/mvG+f085m4P0dSFU+qi2WlBIZfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791624821; c=relaxed/relaxed;
	bh=PJo4tkODSAwLEOEkEK57eCbPFUflApjAg2dMJ+9QYw8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SAgjkGcqTC7K1LYclvyWnAVr/+Nl6CN0OGXE9cSTaPzfIELjpm+GSwidqsOuJm+XoDWhT3xoVEo5qWorKdDt8wuEfxHi5+Pa9k/D3toTOFg+VlRNx6+AYGYMD43eJWfOLD4JuYkXi5NI9pLyhUk4oS5lsuQJ5cDPtFj5yRMkObU/qR8RgljXUrUaMSl8j9tHJQfo6gPJh4yEOXU+bm+6AvLcORhk/Sbbb3nXKB4H2uM7/N66ZBJxZCnuwr4OmgA2oBbKh94tWekXO5cFPBYH/fAhWQd1XycMBJVK/I7iyOKBMgJmdQEJfoOgmmfSL6INNWDfkoqVWNJfQHSvtRr0ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OyPnlKQX; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::62; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OyPnlKQX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::62; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-98.mta0.migadu.com [IPv6:2001:41d0:1004:224b::62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1z7P4btvz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 20:33:35 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=PJo4tkODSAwLEOEkEK57eCbPFUflApjAg2dMJ+9QYw8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791624797; v=1; x=1792229597;
 b=OyPnlKQXDU0GjsJLx16l/N7aNyV8TV32uB9UZukrSCGkeF5RGj1NCuGGupG39RNppVPtQ5oN
 koTlLvsrJdtPj2rdeTmh+Tkf1ycbtOZ/cj0LLQ3sQemFmRfdKOU0jgiJ613ClP4P1Y1fShzIAWH
 IWs1Ig2eykQZ8GcgtKNfDXvc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id ae1b224da00926d1;
	Sat, 10 Oct 2026 09:33:16 +0000
X-Mizu-Trace-ID: ae1b224da00926d1
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
Subject: Re: [PATCH v4 6/6] mm/mm_init: add zone mismatch warning during page
 init
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261010075755.83339-7-songmuchun@bytedance.com>
Date: Sat, 10 Oct 2026 17:32:59 +0800
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
Message-Id: <434B0573-BF18-4413-9BDF-C5873CC13206@linux.dev>
References: <20261010075755.83339-1-songmuchun@bytedance.com>
 <20261010075755.83339-7-songmuchun@bytedance.com>
To: Muchun Song <songmuchun@bytedance.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 10, 2026, at 15:57, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> For vmemmap-optimized sections, tail struct pages may be backed by
> shared vmemmap pages. Those shared pages must carry the same page zone
> ID as the struct pages initialized for the section.
>=20
> Warn in __init_single_page() if the shared tail page has a different
> page_zone_id(), which would indicate inconsistent initialization.

Please ignore Sashiko's report [1], both are false positive. It didn't
realize that shared vmemmap pages are initialized early before =
__init_single_page().

[1] =
https://sashiko.dev/#/patchset/20261010075755.83339-1-songmuchun%40bytedan=
ce.com?part=3D6

Thanks.=


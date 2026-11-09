Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C99E606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YdOHLkm1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNKLl3tnxz2yMK;
	Mon, 09 Nov 2026 17:17:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794205023;
	cv=none; b=Wwvlvnh5ImAEPfpdu7b+Bcr+vSEiLFHFwMwCGSTIJMEvsvn3R0SX8P2VVkYf+o69VWPDoOTZnfibU/Fj7xCQ9zqLf518vf0vj8pciUvPe8pTO+sJX+6tc1K0phEgrMKSl2j93jV90tV22uEQxFFPSeTSkBolSPdiDc7yP9paXWcfduJdjHIVGHQcCLHbmhuBgjUIRuCDdcPLCCB3fMNNUJV3O2RCqQi3f2y1Kz939aJaSm34aD5P003LJKtU7yjsd2LK+0vfZmbYLw4Vsmi3w2vWz516Rkap9UY5mW7zR5+hdqvod1598OU05p93J+h2Uw38PRwPxmtaheltHDIUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794205023; c=relaxed/relaxed;
	bh=rLoo3d8wA/2dmWzlOHmZSdy7DBfGYigRliA9FCVCD2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfTF1eqF9oIsRV9Fj5D7qYKIDPgtFS1NaV3Cbk8dcFXdRCr0xepa3c6q1C/igyRhvpliYC7rLtChSDHgsMOEOR/9zhqGjbttK0G5nqUxq+DUeAG/BzRUWmWo1SmzqQyOcyATHU/ev7kUpRyREi2OFNZ+q4AMNW1hEAxfcHQv66o581J3vFXfrCOOx4ub4RgeYHPWKdsjVOCOQLy2zTPoTukz2wV/F2ZVGMLzCOYJbFU9xENrluKZ/Eh7na6EShvOARzF0GylK5gjJBmGsMADxHY91ww2TSW5xdBebUiOX7/SLB4rlbyHvn0qVjLy0q7+Hhgr9bxrfSz+qU7AADTuGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YdOHLkm1; dkim-atps=neutral; spf=pass (client-ip=95.215.58.177; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YdOHLkm1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.177; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNKLh3zKbz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:16:59 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=rLoo3d8wA/2dmWzlOHmZSdy7DBfGYigRliA9FCVCD2U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794205000; v=1; x=1794809800;
 b=YdOHLkm18ej0NUagkOx5fL3TEOgHMQ4gnUIWPRRwP2usH38o0YIcXOhwUKSi9HBHrLmHN3CF
 VnYMJvdPfaRR5Gnc4oHs25xqt4OL2JddMSYjRcOZQnm+keRRQyCMa8U5/cjU5k8uVN1qEiWUb8p
 luxB4nmOtrLFMWZo/OoPRgjQ=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id b7a98a3c4281100a;
	Mon, 09 Nov 2026 06:16:40 +0000
X-Mizu-Trace-ID: b7a98a3c4281100a
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: songmuchun@bytedance.com
Cc: david@kernel.org,
	maddy@linux.ibm.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	osalvador@suse.de,
	qi.zheng@linux.dev,
	muchun.song@linux.dev,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 5/5] mm/sparse-vmemmap: drop @pgmap from vmemmap population APIs
Date: Mon,  9 Nov 2026 14:16:30 +0800
Message-ID: <20261109061630.47601-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261107043122.25650-6-songmuchun@bytedance.com>
References: <20261107043122.25650-6-songmuchun@bytedance.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, Nov 07, 2026 at 12:31:22PM +0800, Muchun Song wrote:
>The vmemmap population and memory hotplug paths no longer need @pgmap
>to decide whether a mapping can be optimized. That state is now carried
>in mem_section, and the architecture-specific population code can make
>the remaining decisions internally.
>
>Drop the @pgmap parameter from the vmemmap population helpers and the
>related memory hotplug interfaces, and remove the remaining
>dev_pagemap-specific coupling from those call chains.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>---

I had another another another look and couldn't spot a missed caller :D

Might as well stop passing pgmap around now that nothing down there uses
it.

LGTM1 Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>


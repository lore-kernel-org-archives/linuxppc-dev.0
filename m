Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477D606A322
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 04:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u/Gx8aBg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNGw8111Kz2xKx;
	Mon, 09 Nov 2026 15:27:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.30
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794198440;
	cv=none; b=UBd8EPrXMBkW0AsuKfF4+WzFWaXNAGOq2+FCXQmsNOgMgEXW6fqNNEcUoPRJ87GjEgXgLUX+/T0yi+iWMK+uO0wDAdsN4hjl+DnZVbvhM7sDxX2IYogqREWXK9OR2w5UnCItcWStbhzr/J4F+rr3UWNv9HH/9oH0TRmP/k/d3F9vHvm/L4J/GakAPYbkUTHGUm5HJpTTbi33QoQ3pFn6FQiMgvHSVG2SssV4gq1OyuptDYO7aOYLS9GevA0c2ekKZ4O7bFvJ2ZtitlUpBmotA2YC407EpqpbgJ57MT1ODa+qFK0PnBnAJZqCwLEthOlItMHKRll/YuO7FwjK21WRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794198440; c=relaxed/relaxed;
	bh=0SVPjoU02fufplg6UCU1lm8OR+hTiBw+cX99Xog7iH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPEi+TyLDzU3BBHtcvF1IAwF3yavZDg+8//umfH4xfYIa6t4NaFRAARNYgPKQERiIERAc4/ZN1nn1lrJP/YS1c7JRn/gAd4Ppv0rQVmJ7e9YZsu9OTIRrdS41fvyt6aGXxEejHyOLhZxs9IbLVqoj6SQ7ddotf4foznngmiSWegfW1EmEQrunHJiRmHRdB2D4c9XAnfbDdeKAhw0Iwhj2VWW1ZnS9AOREFvHKHrW5QVO2QiX56pmnjOHO+wPsr9h19yj5X8GmLUJe9BGwjXQJsRokqK4C9MwksR/shn1u/0QnQHuRCBJa/QlKWTNIe1Jwq6aoNCbOF/TpiG17y8qnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u/Gx8aBg; dkim-atps=neutral; spf=pass (client-ip=95.215.58.30; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u/Gx8aBg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.30; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNGw51GNnz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 15:27:14 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=0SVPjoU02fufplg6UCU1lm8OR+hTiBw+cX99Xog7iH4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794198415; v=1; x=1794803215;
 b=u/Gx8aBgnHUkuXVi2+BQTYcTDxH8zFUmAR/TVFAy46WVUw8Lm9l8nbKAhmANIRo5EFy9lMew
 uqhCIgOleT3njpCY3/Dv7cMDqi4bwx/iXr8FHzCyP+4xEO4rb2Uae+SFRzrmb+HNtjjXKcUWcSf
 Benz8ZX3QBGriDvnxTFBIbfA=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id b6a087d0e32380d8;
	Mon, 09 Nov 2026 04:26:54 +0000
X-Mizu-Trace-ID: b6a087d0e32380d8
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
Subject: Re: [PATCH v3 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
Date: Mon,  9 Nov 2026 12:26:47 +0800
Message-ID: <20261109042647.37323-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261107043122.25650-3-songmuchun@bytedance.com>
References: <20261107043122.25650-3-songmuchun@bytedance.com>
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


On Sat, Nov 07, 2026 at 12:31:19PM +0800, Muchun Song wrote:
>Whether the optimized mapping can be used is now decided in the
>architecture-specific vmemmap_populate() path. When PowerPC has to fall
>back, such as on Hash MMU, it can disable optimization for the populated
>vmemmap range there.
>
>Add section_vmemmap_optimization_disable() to centralize this fallback,
>use it in the Hash MMU path, and drop the radix-specific
>vmemmap_can_optimize() override.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>---

LGTM, feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>


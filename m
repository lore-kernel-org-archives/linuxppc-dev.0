Return-Path: <linuxppc-dev+bounces-28551-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BCFCA5FBE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:03:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvrG75DJVz2yqT;
	Wed, 30 Sep 2026 20:03:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::9d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790762591;
	cv=none; b=QgT7ZZ2EnvuT7Wmqg8rvZ25sSdZC+KPcMhtSMOIizpTXYRlaPH2hwakCHU10IDksP9C9fM8HmovIYc5KE7wBun4oNY+GGAwNJyOP1xw4Fy7C+vWlgVqJoVhy83mh+eWqu/UnyjL0iKFbT2hOJckZPBJJ04wuLwL5tj2j46QnsHl0ky3xzVR9EVeu92twC5YnYL603IiBUrplH7NNsVHl647pCzF6Bucmpc3VAV4h8ofjQT/AKkBTgTcnrF2BmcOUEcxOsR5tKNQ+OmSHr2lPze3NnSCp6Uk2KPwdu4LffFJC+sKTCs1eBs9/Ggup6q/IhxohG6jdqkvPi4FngnVGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790762591; c=relaxed/relaxed;
	bh=6qRsSUfuBnTMx2Y9L6KCbkAYKGnB+pDv2tFE4p6k81k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5rKs+WaaDKICvCAeG69TmCxBMkQAJaxbg3jOJBiV/BqH0UerfMOd2AbDyO1Ss/mavBWYC50lURgP9zg2ijbBkSCYlQWPx9K0PsJ8ukkCT+8UOECFjPdD8TehXEpZJx/RmO+0efkjjTv6uXxHcbk9NUB+sZc0UOi743LL0LQUh/XRuY9MQeMjOrIFb7GfopbJ0g7PbnU8LB4to1P3yt6xhBX4PYm0/akhxhIIH+YIA9o59zmjICK01Eyb3PgOcsnzy3jScYk6gRuxSbewh1YY+PnafcPp3AAiL7GgYXbToriGtz2Ym2ebqsHXfEC8KOSKv/61FXW8H1ozqWZvq0foA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MfkHMdka; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::9d; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MfkHMdka;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::9d; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-157.mta0.migadu.com [IPv6:2001:41d0:1004:224b::9d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvrG44rWRz2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 20:03:06 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=6qRsSUfuBnTMx2Y9L6KCbkAYKGnB+pDv2tFE4p6k81k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790762567; v=1; x=1791367367;
 b=MfkHMdkaZFeZ63PXyuvaJ9E6glbryTwVflyII1EBXG9UvkZF5eI7Oq52rSTfVLjfFsC1DQGh
 2Z1dsZlDdoMPiQZ9UtihJSHd7yfDlfskF94GF2nKN7Ei2AWEmZaRkPTSU+XDaaTgGUvluLXgcky
 ZbwRYYmSbBhwEZmdmKbQRIbw=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 702ad52dc12a4244;
	Wed, 30 Sep 2026 10:02:36 +0000
X-Mizu-Trace-ID: 702ad52dc12a4244
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
Subject: Re: [PATCH v3 2/6] mm/sparse-vmemmap: support device DAX in common vmemmap path
Date: Wed, 30 Sep 2026 18:02:26 +0800
Message-ID: <20260930100226.23688-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260929053231.66085-3-songmuchun@bytedance.com>
References: <20260929053231.66085-3-songmuchun@bytedance.com>
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


On Tue, Sep 29, 2026 at 01:32:27PM +0800, Muchun Song wrote:
>The common vmemmap population path cannot yet handle optimized Device DAX
>mappings on its own. It uses pfn_to_zone() to find the shared tail page,
>but Device DAX populates its vmemmap at runtime before the ZONE_DEVICE span
>is initialized.
>
>Teach the common path to use device_zone() for runtime optimized vmemmap
>population while retaining pfn_to_zone() for early boot. This allows the
>same path to support both early boot mappings and Device DAX.
>
>The backing PFN supplied by the Device DAX-specific population path is no
>longer used, allowing the redundant lookup and population code to be
>removed later.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Acked-by: Qi Zheng <qi.zheng@linux.dev>
>---

Nothing jumped out at me, feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>


Return-Path: <linuxppc-dev+bounces-28656-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7CACA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 14:52:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwZdp2p9sz2yTQ;
	Fri, 02 Oct 2026 00:52:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::16"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790866366;
	cv=none; b=fzgK+zYLqEt/BAq28v9b45uENWjjX2aUSbBCcCSll6jyffJn8jjRunZqREjmN3UvwEm4sOuEt7uJe4duWb4teiZytXCBNiBT/wSQLZVcvkj71LPU35dDEqJLOXP7h5cWEk4T3BH8RF6uRNPFeDMC1iV53iOpto/tt+H3tIG9QBGGAYUMlH25h7dFEQdCRbj01JcNbT2pCa3IbqvlDe+R3qrS9bfGYeEYIQByHO5eEMNMU6IpIBOqe2Yd4Ig4qX0rq2Adm5uCPyHMkWEWm9ZF0MnbjXAq5T/mYZwbV9JafEg7NULaGkK2pvGL8PC44DGtOdOhxkx0O/RvrYR1KzZuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790866366; c=relaxed/relaxed;
	bh=YxNjso9KjpjP2pDGx7oGaiU+zaJJp4PBvs5wT3NhcQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byGfR+9qpy24HvT35hjNCgyfslGCCAGbYASBd6yTtF7lgdirysyqxS1jiXISBdc+RJBmwAmJAB52e5myAoHJg5uWXHVn2Zir2i/pc0Tgtz8nOat24QaIxPUSk8n/P/J6RCYLA5J4HT955LgqMYRJSk7cwoYwrSFMrqycNXhnCJpDHG4bCu6oo+upow6kNK2KdbAeHf1TxDEDSHmx4alq/hS2hG3Sg0YKJjrm87Js6SoQoS3JdxGjbjIp8s3LHDnX+cqnDr5gE/NhQUh/tEJKsVc5WyhapnmQwyu3C7we4mBhM25wPITZsddlbar0xxQssP/cWXH3KoKHKsytfvdL8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=acz08jLC; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::16; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=acz08jLC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::16; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-22.mta0.migadu.com [IPv6:2001:41d0:1004:224b::16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwZdl2x3Bz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 00:52:42 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=YxNjso9KjpjP2pDGx7oGaiU+zaJJp4PBvs5wT3NhcQQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790866344; v=1; x=1791471144;
 b=acz08jLCHokKKFFoktu7aVdnwKze8YfmCpzWps0Qfs6x7Iz04dgN2si88PqT+WHvE7diE2qF
 lhQiu9vG1t3YQgRzPX/RXUAmicoMsNLdvj/Jy5A3eM//nUT+E8t2xd9WIGnAjdDUyluNIX6LLvy
 fhKT/MmqGbdnTsDGkfTlcjVM=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 476754a991a89109;
	Thu, 01 Oct 2026 14:52:23 +0000
X-Mizu-Trace-ID: 476754a991a89109
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
Subject: Re: [PATCH v3 4/6] mm/sparse-vmemmap: remove the unused ptpfn argument
Date: Thu,  1 Oct 2026 22:52:17 +0800
Message-ID: <20261001145217.19370-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260929053231.66085-5-songmuchun@bytedance.com>
References: <20260929053231.66085-5-songmuchun@bytedance.com>
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


On Tue, Sep 29, 2026 at 01:32:29PM +0800, Muchun Song wrote:
>vmemmap_pte_populate() no longer uses ptpfn as an input. Drop the
>argument to simplify the code.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Acked-by: Qi Zheng <qi.zheng@linux.dev>
>---

Nice cleaup! Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>


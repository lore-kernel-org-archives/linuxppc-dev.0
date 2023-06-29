Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A035FEB64D9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jun 2023 15:18:32 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Nmd6u7CT;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QsMXl25HDz3bm2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jun 2023 01:18:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Nmd6u7CT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QsMWm0j7Mz3bT8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2023 01:17:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Br5lmtkM4xEPXhnEaSyMakyTIFN7fYK9NHh54UdMeT0=; b=Nmd6u7CTxl4EWCi8FGYXJ74Qpu
	bAcilZ1J7uer3chhnj9MN/wr3YlSmQwFKddAHjADFftWFDNj8j6wVmV9lmXVGQ7hbllm/xnZBWkTq
	D4nBq3DBaEIm3a4D31XhJNZJUtW8UZBSiQbR5kICGO0FzEElP70STZR/WqzWrBv2ahNjKTeLhA0qT
	TqiOifl12mHfnHDZC/ZVhU+ZeU778mdD+KSAUDczreAq54NcsJd/KO8z2utjgtS3O9Hk7COLoXsNq
	a3PX8GJ5wdi5mtjI20jqjKQ2ZHbYmh8T5Fa5v7tZ7A1guEVNONDXPygWDhvJwB50dt0TPckJKdwi+
	XXJFRrBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qEtOZ-004xdy-03; Thu, 29 Jun 2023 15:17:19 +0000
Date: Thu, 29 Jun 2023 16:17:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 1/2] mm: remove arguments of show_mem()
Message-ID: <ZJ2gfixfUBXCV/+P@casper.infradead.org>
References: <20230629104357.35455-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629104357.35455-1-wangkefeng.wang@huawei.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 29, 2023 at 06:43:56PM +0800, Kefeng Wang wrote:
> Directly call __show_mem(0, NULL, MAX_NR_ZONES - 1) in show_mem()
> to remove the arguments of show_mem().

Do you mean, "All callers of show_mem() pass 0 and NULL, so we can
remove the two arguments"?

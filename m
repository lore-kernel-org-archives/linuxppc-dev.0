Return-Path: <linuxppc-dev+bounces-21443-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE0ECD5BCB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 06:21:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gP5PZ29W0z2yQL;
	Mon, 25 May 2026 16:21:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779690098;
	cv=none; b=bUvuzg3IQTfd6dvtF/cQqQerNS9xMzIRtogxuHvaOlQNrIbxEVfpgXiyZCXXi+xP1uU1SF0fLKTOsbEF65zBypg30jp6zAlmipLn7C/55BGEnaW2lynXMAa3bimjIGWeGqo37J4GKi5sGLAGuAtj76vrG8dhy+/F46TRJ8xhNZBQ8AbS7nkaGAtOnqjZ2Ba19eheri/kMN9M2vTvi3eZl4LY98mvUQXaC88ezsAcfDRn1JomuZ22wkXNxMC2Xm+MVxqt0sbfx1yhCKihrmM+kL3fK3IE3VBDW4wXgvDtIpl89FdgQD/nhOTei/wa9RSsapLuStIndXLyMQ/KfxyEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779690098; c=relaxed/relaxed;
	bh=u6zKl9qnP1hXczaaMGz7ilm2seNJlSk+ObSn3+7a228=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b3zxx5V340+KHhkCk5/n0LtZ21hDjcMp26+lAuia0V2ndbSrlrIOO8qoQ0b6sUelncVnPQ/ScEmOAsAY12LSC3YZuGhImw32Ysa/T027VDw3Xfmy8vW/lXtoA7zaiC13vOoeVSsI+uHOzJaUJV7k6BSuybmOP5LP998l4G5pS+rG8o4rsp0rUvMKLPdtzOEdKxOOKm/sTcWtMfgSDDGpnfq81wnHdY2F8r/jodIYc4v9a4pZC6A+oEL4nRi0jW322SCx8Aoc1BoX7eIWgkHNWeVdXbokJH5d5S8wrVabDLyfxDoZ2Eki4kl/DT3AJMywKT4tZ8uCkuNvwImhPzPtSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Q6R84yEr; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+728b97dfb722ff21c2bb+8310+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Q6R84yEr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+728b97dfb722ff21c2bb+8310+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP5PY2rXTz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 16:21:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:References;
	bh=u6zKl9qnP1hXczaaMGz7ilm2seNJlSk+ObSn3+7a228=; b=Q6R84yErpMKmdghfAxPpEVTgXs
	ab/TkoPdqEtIzV6x3bBxmGJncObuVgjtqyQ3gNdFNG7yuHe/rbMaJ9RTuh67b+OtVcjSgxaoFJqtu
	1JTv/UhhwKAx7NuDaTobbogBSpwp/o3B8QyfRc2zXsT1KKKOKTQBkH0iFe6c/ih8/dA55uwpt+90X
	rXNsdb8u+fnhCutZOpwEGp8lVBVrANCGsgxoMPw6o1m7tG2857HRKojm+UcY/083Kxg9Zp3zguAfx
	qDlrtsDt2bUnvzFtsdd0976FboRKYNUjH4s9GYpquer8CePhq5I/ekgdAyMdXyKVPCkK5+XMzmMv8
	pw6UUTaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROgv-0000000GPAI-3Bil;
	Mon, 25 May 2026 06:21:33 +0000
Date: Sun, 24 May 2026 23:21:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
	mripard@kernel.org, sumit.semwal@linaro.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <ahPqbfH54R3JJyaV@infradead.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522225853.878411-1-tjmercier@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
> module") the system dma-buf heaps can be built as a module. The
> system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
> but those functions are not exported on powerpc. This can result in a
> build error like:

I'd much rather revert the above commit.  Yes, x86 has exported these
since 2017, but that's a really bad idea, and we should fix it instead
of spreading the export.

Setting memory decrypted is a dangerous operations and should only
be available to core code.  We should have various allocators for
decrypted code, but not export the functionality to random code.



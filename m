Return-Path: <linuxppc-dev+bounces-20342-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08C7FF8873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 12:36:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5tvF6l9Nz2xjk;
	Thu, 30 Apr 2026 22:36:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777552569;
	cv=none; b=RzxzvQDiVavbzrPqxa9A0sUuMCafMB++h2UpGNA9cbMbhfVJZngOBJ6NrnAD0XMv+OqAbTiYOlQkPUXkrJR8oQYazAz9N7QHYI+NKHRmyp/eF4p88s4GPH64LgYmtE1Abr6cG9skm5cswFOyx5FTKsaDGrUMOn1R3WM1yuBzudTM1rvOIsb+2i5BgUgeEmwLFKN+UlADRusJ5be86CxnHdUqVg53xy7Zm+dm+FOxfDtSb595l+O0PDoOeZYmdHmaCHCyGDyZMKsXoG71OTRTmI3QsSVfVQ1UBZALoY3qn2/ZkgDHUseumX3FTiIpS+DD1Mnud71oA4FtGKNcl2vH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777552569; c=relaxed/relaxed;
	bh=Z+Z3DKsnSFmL8ihuU1z6jpmoa/PGowkZGNbOeWbnqGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMC7Zav7U3cNo+zS3uPvHeorfKI+4Adjwc2lVeHqstydggyouLUarTQTT1EJ1/CtFpssuj/YRjj+iQeJ7En98GIKJzBe9iGBufLFcSi2aqljtVPqusbJMDXSBzYy6SIlClnH6oZLzojQyTap9vqS0roi3V2Xa3CucnIJvD81OPDBfST29/wjFgeUdLZDV02+kIxijWgGS2yk7sceZ52lP99osWGvhcWCBaq318qdDAGmRj15tcKvkJzTW13XDF91/s/SPI3/QN/1MLGJ/atXx+dpziNqzRcTiRP9vANvYcqe3lwcvgRIGyXnaG3fChLUOFC/umLo1NrVsE1BBjHSRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5tv60fXyz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 22:35:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z+Z3DKsnSFmL8ihuU1z6jpmoa/PGowkZGNbOeWbnqGA=; b=iAUflMNTY8s90bOygRPipE/x2+
	2rqGdbTRLii/gKwyDrwP3nkrR0VatKKYld/V/816iJ1P+tXhX+d+idNR+EHjQMboflVsiybW8W+j8
	eYWs7JCkiHvjY2IB2zf7TqoA45+x4aQ6qJmQlmCWvqYPr8NfFayhBn2Yo/Fe4ZPpdXhwYsAJOnz9D
	fjrOixede6cq1gwHChteZEiQiJMRusCYSEQAeQfmUhSpF81serK2xu7B77/VvMp8ZkRnZOjTGarSl
	f2YwbxhX7fGYNMGzMT5rb3gdo1ooWSq/7jwDHw+A2onKlKlIcG5HcwM0Ymw87xAmNi9iGAAb7Q4sY
	9LSfVJFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIQc7-00000007Dpy-0PSw;
	Thu, 30 Apr 2026 12:35:31 +0000
Date: Thu, 30 Apr 2026 13:35:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz,
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn,
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com,
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com,
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm: Don't retry page fault if folio is uptodate
 during swap-in
Message-ID: <afNMkqwxC00OT134@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <20260430040427.4672-5-baohua@kernel.org>
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
In-Reply-To: <20260430040427.4672-5-baohua@kernel.org>

On Thu, Apr 30, 2026 at 12:04:26PM +0800, Barry Song (Xiaomi) wrote:
> If we are waiting for long I/O to complete, it makes sense to
> avoid holding locks for too long. However, if the folio is
> uptodate, we are likely only waiting for a concurrent PTE
> update to finish. Retrying the entire page fault seems
> excessive.

I think the idea is good, but the implementation is misplaced.
The check for folio_uptodate() should be inside folio_lock_or_retry()
rather than tampering with FAULT_FLAG_ALLOW_RETRY in its caller.

Similarly for your next patch.

> Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> ---
>  mm/memory.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 0c740ca363cc..a2e4f2d87ec8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4949,6 +4949,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	}
>  
>  	swapcache = folio;
> +	/*
> +	 * If the folio is uptodate, we are likely only waiting for
> +	 * another concurrent PTE mapping to complete, which should
> +	 * be brief. No need to drop the lock and retry the fault.
> +	 */
> +	if (folio_test_uptodate(folio))
> +		vmf->flags &= ~FAULT_FLAG_ALLOW_RETRY;
>  	ret |= folio_lock_or_retry(folio, vmf);
>  	if (ret & VM_FAULT_RETRY) {
>  		if (fault_flag_allow_retry_first(vmf->flags) &&
> -- 
> 2.39.3 (Apple Git-146)
> 
> 


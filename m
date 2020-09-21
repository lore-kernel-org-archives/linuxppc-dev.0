Return-Path: <SRS0=a2eB=C6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89533C43466
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2020 15:51:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4C52220C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2020 15:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S8rXcGNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4C52220C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bw87b5WFkzDqQK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2020 01:51:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=S8rXcGNB; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bw6kc4vKKzDqTN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2020 00:48:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=GrLgQ81RMs4yZLkbL25hSswMVubhakBrsXk6y8LUTp8=; b=S8rXcGNBi4i4qPD575hId32KQP
 nqI0uPNrzjdQyj4vl0WSsJjqoLdiHU15JD1QivHJE4gsE9/TJFijUkmzx5PTowCkBnlyPqxob4RLC
 g2OXJsSYMe2XxF/qrlzQ7lUj5CLowOZfdUeitiDgvjL0vok0YlCDOptjFYkIwRz2amnUfKLAMpxWs
 2L9E7YRIK5ucqdS/0WgivYaSwDXpH/HNj0bdbbrCRjJyIOhnR4envxalVmDy7Nd3SjyV7VPX22s6G
 He+tEU28SCP4TsdzxKZjtGYCdDpqu2O8SYVePA8n7SQLKmiA0QJhgmYonOPb/A76qlqHpCJlQFCa1
 Z1eFhQPA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1kKN6v-0001MT-TO; Mon, 21 Sep 2020 14:48:09 +0000
Date: Mon, 21 Sep 2020 15:48:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/11] mm: call import_iovec() instead of
 rw_copy_check_uvector() in process_vm_rw()
Message-ID: <20200921144809.GV32101@casper.infradead.org>
References: <20200921143434.707844-1-hch@lst.de>
 <20200921143434.707844-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921143434.707844-3-hch@lst.de>
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
Cc: linux-aio@kvack.org, linux-mips@vger.kernel.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 keyrings@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 io-uring@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, David Laight <David.Laight@aculab.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Sep 21, 2020 at 04:34:25PM +0200, Christoph Hellwig wrote:
>  {
> -	WARN_ON(direction & ~(READ | WRITE));
> +	WARN_ON(direction & ~(READ | WRITE | CHECK_IOVEC_ONLY));

This is now a no-op because:

include/linux/fs.h:#define CHECK_IOVEC_ONLY -1

I'd suggest we renumber it to 2?

(READ is 0, WRITE is 1.  This WARN_ON should probably be
	WARN_ON(direction > CHECK_IOVEC_ONLY)

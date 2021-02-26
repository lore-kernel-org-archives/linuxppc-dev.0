Return-Path: <SRS0=07gb=H4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B3AC433E6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 16:04:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9EE64F03
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 16:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9EE64F03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DnDxj5j6Bz3cly
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Feb 2021 03:04:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ONNF7yjd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DnDxD2Fppz3cG2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2021 03:04:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nlrPN6RKsKi94KSjI+2dR6vaJd54WtU/wGcRKq1SGac=; b=ONNF7yjdRI1tRIpo0PQk8cAljg
 u3YfDpfRVp8NNTh+ucghqkv8ngoXtpV/axBTq+P3Js4/AgyZgZ+aekEOAxYXOgmJ79Hs1Dv9GhdgP
 lX3X4f0Fk5rpkhvUZD135Bxge8SpbXgAWybC2Mc3IKg3MN09I5BSb50Xa+8zU8k06Bq9FTNaxAdo+
 3yACY5ecnhSeenvfblbCjWFkZUpNoCN1FOipQcGGa0h3ERmwuB8zyX+2Ub/weelZ0uph9wN5CPbRO
 SBH78t+9xvcw1R03B/mfNcNRPENtIas77/vSrsXz649FAQPO+oDNpa6wrW/A0DObSZ2Hw+inIYCx9
 /OSQsC6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lFfas-00CDLc-Ux; Fri, 26 Feb 2021 16:03:59 +0000
Date: Fri, 26 Feb 2021 16:03:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Freeing page tables through RCU
Message-ID: <20210226160354.GE2723601@casper.infradead.org>
References: <20210225205820.GC2858050@casper.infradead.org>
 <20210226144200.GV2643399@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226144200.GV2643399@ziepe.ca>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 26, 2021 at 10:42:00AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 25, 2021 at 08:58:20PM +0000, Matthew Wilcox wrote:
> 
> > I'd like to hear better ideas than this.
> 
> You didn't like my suggestion to put a sleepable lock around the
> freeing of page tables during flushing?
> 
> I still don't see how you convert the sleepable page walkers to use
> rcu??

I don't want to convert the sleepable ones to use RCU ... I want to
convert the non-sleeping ones to use RCU.  A page_table_free_lock might
work, but it might have its own problems later (eg a sleeping lock can't
be acquired under RCU or spinlock, and it can't be a spinlock because
it'd have to be held while we wait for IPIs).

I think it would solve my immediate problem, and I wonder if it might
solve some other problems ...

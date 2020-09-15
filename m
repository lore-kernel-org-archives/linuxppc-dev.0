Return-Path: <SRS0=6Pj3=CY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D64EC43461
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 18:19:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCF4205F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 18:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iQt0Wubj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCF4205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BrWhK59TXzDqTg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2020 04:18:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=iQt0Wubj; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BrWfJ46DzzDqMW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2020 04:17:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TpXFc9y8wD3r1ZuGpqIyIgD31aYfhCp2Mbvu/dVpBHo=; b=iQt0WubjIBcofUDJWMFR7iUupl
 lk2xCKtz3F5Vm17nRnPtlqXMG8bS9S4kr8GvCw66sUZuuFMsx0LivRNIclHnQCWgwXsm8uIkR7Wd+
 iEiiMuPsAkoCL5U8Smqu+4oDMrVwam49jLQ26TRnafXau1S8TNxQPiuCpIMvdUC8xA/xw9bnrKcjC
 mVQ66WngyHdSuno6nChX6yZRsmxhTb3+mPoo2ZHNrd+Nnhb8gJM121PUBjw1UPGG6Ki+05Pp6nmsE
 73Xeffy5TiPXq0rB92Dd6gB24GE0m1Bpmy4o7o3ALn1PuyQjptlVLR3eXnfaIrTfpn7QOtdy3gR81
 IqFLjWow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIFVb-0002aX-1S; Tue, 15 Sep 2020 18:16:51 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 827993006D0;
 Tue, 15 Sep 2020 20:16:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 4DBE3299BA20F; Tue, 15 Sep 2020 20:16:42 +0200 (CEST)
Date: Tue, 15 Sep 2020 20:16:42 +0200
From: peterz@infradead.org
To: Michal Suchanek <msuchanek@suse.de>
Subject: Re: [PATCH] Revert "powerpc/64s: machine check interrupt update NMI
 accounting"
Message-ID: <20200915181642.GF2674@hirez.programming.kicks-ass.net>
References: <20200915084302.GG29778@kitsune.suse.cz>
 <20200915180659.12503-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915180659.12503-1-msuchanek@suse.de>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Santosh Sivaraj <santosh@fossix.org>, Alistair Popple <alistair@popple.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel@vger.kernel.org, Jordan Niethe <jniethe5@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 15, 2020 at 08:06:59PM +0200, Michal Suchanek wrote:
> This reverts commit 116ac378bb3ff844df333e7609e7604651a0db9d.
> 
> This commit causes the kernel to oops and reboot when injecting a SLB
> multihit which causes a MCE.
> 
> Before this commit a SLB multihit was corrected by the kernel and the
> system continued to operate normally.
> 
> cc: stable@vger.kernel.org
> Fixes: 116ac378bb3f ("powerpc/64s: machine check interrupt update NMI accounting")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Ever since 69ea03b56ed2 ("hardirq/nmi: Allow nested nmi_enter()")
nmi_enter() supports nesting natively.

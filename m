Return-Path: <SRS0=BFlh=LR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26326C4743C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 08:33:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7504A6112D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 08:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7504A6112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8xP05vvcz3bvp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 18:33:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=WgK4pEnm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=WgK4pEnm; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8xNR20rwz2yXb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2021 18:32:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=16jxg++O1mxsCUO4HYCxFH729seFeNe19fGHRxVgw+U=; b=WgK4pEnmYC2eHSWXSChThGWZOf
 9/dHHL8laLKzptMdLlg2Al9t/6lEkpK9mZUWZe5mzsNzps7qvmpi2W55rjQaqketvLPrObTfNixZQ
 e12amrEyMBk3lGBHrvJqAA+0Mivp0njGzfzavq2Sjmo3arVv0sWsy9qBHv1o5JWuaPbkn/9Z1RyM2
 WBe0IAkpdFDszyQ5PrDpIWLNqQfJQWZofZ+askRlLZoYWhLgA04+jlWodfr1oRrLHfzpcSDf35pGT
 vYw3PGmSXzFoN9ULz+o3Ux8k+JaOFqVJtJqSup0qw1CITNbfLdozAcerP/OnJFN9u6Bko0Lxmf4Uf
 qFsBHEeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvyHs-00FDIM-Kd; Wed, 23 Jun 2021 08:31:27 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81023300204;
 Wed, 23 Jun 2021 10:31:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 8C1D020412F7D; Wed, 23 Jun 2021 10:31:03 +0200 (CEST)
Date: Wed, 23 Jun 2021 10:31:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] Add perf interface to expose nvdimm
Message-ID: <YNLxRz1w9IeatIKW@hirez.programming.kicks-ass.net>
References: <20210617132617.99529-1-kjain@linux.ibm.com>
 <YNHiRO11E9yYS6mv@hirez.programming.kicks-ass.net>
 <cea827fe-62d4-95fe-b81f-5c7bebe4a6f0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cea827fe-62d4-95fe-b81f-5c7bebe4a6f0@linux.ibm.com>
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
Cc: nvdimm@lists.linux.dev, santosh@fossix.org, maddy@linux.vnet.ibm.com,
 ira.weiny@intel.com, rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org,
 atrajeev@linux.vnet.ibm.com, aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jun 23, 2021 at 01:40:38PM +0530, kajoljain wrote:
> 
> 
> On 6/22/21 6:44 PM, Peter Zijlstra wrote:
> > On Thu, Jun 17, 2021 at 06:56:13PM +0530, Kajol Jain wrote:
> >> ---
> >> Kajol Jain (4):
> >>   drivers/nvdimm: Add nvdimm pmu structure
> >>   drivers/nvdimm: Add perf interface to expose nvdimm performance stats
> >>   powerpc/papr_scm: Add perf interface support
> >>   powerpc/papr_scm: Document papr_scm sysfs event format entries
> > 
> > Don't see anything obviously wrong with this one.
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> 
> Hi Peter,
>     Thanks for reviewing the patch. Can you help me on how to take 
> these patches to linus tree or can you take it?

I would expect either the NVDIMM or PPC maintainers to take this. Dan,
Michael ?

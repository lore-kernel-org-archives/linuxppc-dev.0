Return-Path: <SRS0=gJAX=2I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309F1C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 09:03:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1215218AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 09:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cEjAIefo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1215218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47d8FR0ZCJzDqQH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 20:03:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="cEjAIefo"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47d8Bx57KmzDqSQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2019 20:01:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t9//2RqMFCl0kVnQJETmKMopzrjo3RCGeRkT7almLNk=; b=cEjAIefo00+LZGzxc9G92MeGD
 /zw7RWEJqTZ6iKP1NsqYFTn/YCaU86ieVZypvpzSRQ31hLIK35Cn131sWUl44or7N+QUSgNBg8py6
 P04oRIA2Bw4yOol9yYQtdFW5k1aeogAlwU7HIuftzS3fog2rsMt+AKP7WyAON6seOpgKIMSxMt9VM
 rId7rHci0daivY3k911WQ1FM5FE9gMVEPsh9VfQuKrA+fdMnvD3T2Lij4X1O/o+cPRwYKwwMtnL71
 BvN2lCH/7kETpQkyJXIgphrfyF3spc17K4nlir8F+gmmxlsW4RY1yFc/ndOdE6yeO4L76JF7HbtjE
 I3QDGBDKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihVD6-0007aW-B6; Wed, 18 Dec 2019 09:01:36 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6738300F29;
 Wed, 18 Dec 2019 10:00:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 6010B2B2CECE0; Wed, 18 Dec 2019 10:01:33 +0100 (CET)
Date: Wed, 18 Dec 2019 10:01:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC PATCH 1/2] mm/mmu_gather: Invalidate TLB correctly on batch
 allocation failure and flush
Message-ID: <20191218090133.GM2844@hirez.programming.kicks-ass.net>
References: <20191217071713.93399-1-aneesh.kumar@linux.ibm.com>
 <20191217090914.GX2844@hirez.programming.kicks-ass.net>
 <3d250b04-a78d-20a7-d41e-50e48e08d1cb@linux.ibm.com>
 <20191217123544.GI2827@hirez.programming.kicks-ass.net>
 <874kxymclu.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kxymclu.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-kernel@vger.kernel.org, npiggin@gmail.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 18, 2019 at 10:52:53AM +0530, Aneesh Kumar K.V wrote:
> Upstream ppc64 is broken after the commit: a46cc7a90fd8
> ("powerpc/mm/radix: Improve TLB/PWC flushes").
> 
> Also the patches are not adding any extra TLBI on either radix or hash.
> 
> Considering we need to backport this to stable and other distributions,
> how about we do this early patches in your series before the Kconfig rename?
> This should enable stable to pick them up with less dependencies. 

OK I suppose. Will you send a new series?

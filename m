Return-Path: <SRS0=nRCD=LC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C4AC47094
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 01:48:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3F961168
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 01:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3F961168
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FzY6t3dp2z30HP
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 11:48:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=woVcnjT2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux-foundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=korg header.b=woVcnjT2; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FzY6M5vG6z2yR4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jun 2021 11:48:10 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8208860FE4;
 Tue,  8 Jun 2021 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1623116886;
 bh=Q+5SvaOmqmPqR5Wg8GMpvtupvlOuAHY76M4MzKRjOlg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=woVcnjT2gvMlMWupzbm2RW1aHD1OpFrxMPpGTUAlHEqwXyI+cqSEqpahSce9sUa23
 PX7XyEWUPXze2G2Xc83G0Hs999jBFcv3Pkf8Fj6xeYUV1QWlNdJO3BDpVcAT4dcFoC
 SQ8y+ueymlzsAPBdddPwS27YmwAOpFQ5DXJ/VzSQ=
Date: Mon, 7 Jun 2021 18:48:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 1/4] lazy tlb: introduce lazy mm refcount helper
 functions
Message-Id: <20210607184805.eddf8eb26b80e8af85d5777e@linux-foundation.org>
In-Reply-To: <1623116020.vyls9ehp49.astroid@bobo.none>
References: <20210605014216.446867-1-npiggin@gmail.com>
 <20210605014216.446867-2-npiggin@gmail.com>
 <20210607164934.d453adcc42473e84beb25db3@linux-foundation.org>
 <1623116020.vyls9ehp49.astroid@bobo.none>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-arch@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andy Lutomirski <luto@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 08 Jun 2021 11:39:56 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

> > Looks like a functional change.  What's happening here?
> 
> That's kthread_use_mm being clever about the lazy tlb mm. If it happened 
> that the kthread had inherited a the lazy tlb mm that happens to be the 
> one we want to use here, then we already have a refcount to it via the 
> lazy tlb ref.
> 
> So then it doesn't have to touch the refcount, but rather just converts
> it from the lazy tlb ref to the returned reference. If the lazy tlb mm
> doesn't get a reference, we can't do that.

Please cover this in the changelog and perhaps a code comment.

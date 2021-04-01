Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521F5C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 05:42:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC8E6112F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 05:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC8E6112F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9sWq1CXXz3bsb
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 16:42:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=LqPTHOsq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=paulus@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=LqPTHOsq; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9sWK1QCVz2y0B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Apr 2021 16:41:48 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4F9sWH5jg5z9s1l; Thu,  1 Apr 2021 16:41:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1617255707; bh=wr1Uv5X9gRQte7XjxSM4uvrWDpXTMCsWYTlSf8nDGoQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LqPTHOsqdcb+aYuWf9n3Wvj7rxIeQ8ArR5mhCAc+Y/V28vIwftXnZpbDCn+PZgWI4
 nHihrJrM2Se6CuVO8E8m7l5IKoMnc5Sez7FPHWUIYoDZ6+A9DtDf/jt4saEIjj1/xN
 dHi2Nvi6AmrOVTS7Xchv39621M5jQs8sZyBKQQ3cgt8Zaft7KmN20YZJ9WUoW0Q58X
 VMzvk/VRKcSRdzhXlupCP/5LNTkvni8MVlI7qNPT25ezOq8J/89AZ7KYh/aBohV7f3
 IHra0jyxd1IvM9E7rmbRI/4P2+xiQJ7sX0rXFLgeYp4BWNCx9ya9qoDhy3YQta5GVn
 wky5W8n9Red6A==
Date: Thu, 1 Apr 2021 16:41:42 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 15/46] KVM: PPC: Book3S 64: Move hcall early register
 setup to KVM
Message-ID: <YGVdFrsEtD88oB90@thinks.paulus.ozlabs.org>
References: <20210323010305.1045293-1-npiggin@gmail.com>
 <20210323010305.1045293-16-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323010305.1045293-16-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 23, 2021 at 11:02:34AM +1000, Nicholas Piggin wrote:
> System calls / hcalls have a different calling convention than
> other interrupts, so there is code in the KVMTEST to massage these
> into the same form as other interrupt handlers.
> 
> Move this work into the KVM hcall handler. This means teaching KVM
> a little more about the low level interrupt handler setup, PACA save
> areas, etc., although that's not obviously worse than the current
> approach of coming up with an entirely different interrupt register
> / save convention.

[snip]

> @@ -1964,29 +1948,8 @@ EXC_VIRT_END(system_call, 0x4c00, 0x100)
>  
>  #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
>  TRAMP_REAL_BEGIN(system_call_kvm)
> -	/*
> -	 * This is a hcall, so register convention is as above, with these
> -	 * differences:

I haven't checked all the code changes in detail yet, but this comment
at least is slightly misleading, since under PR KVM, system calls (to
the guest kernel) and hypercalls both come through this path.

Paul.

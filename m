Return-Path: <SRS0=NZKl=CM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474E3C433E7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 01:21:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B9F20709
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 01:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="cDG8uHNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B9F20709
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BhjhF3kj3zDr2q
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 11:21:49 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bhjdy1Vy3zDr0m
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2020 11:19:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=cDG8uHNG; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4Bhjdx724Jz9sTS; Thu,  3 Sep 2020 11:19:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1599095989; bh=MQf33E+nxFrNJ3RYM11AkVoNC6j49gIxd1Ujljt7DCs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cDG8uHNGSlqU99bOOrnz3GgXaVw0VfpyOfei5UzuvfEzrOCttTRdwGbqZ8aoLCNWc
 F423v7VDSXCaksm45020uc25jqQiAXXuKw/+wZpwqzgx+3XSQo+I1x8j8OxT3RcwSr
 5IesXUSH2HaCjBn+arkGbb8NZP4WT45/wA5geiAK83bHns3uj8uOTba/dUO8QFRDqv
 I0w/Q9qDkzOziKmi763aQOqy/3tPBWs452/m/kekWvFOO/ihDzmaOCpWFRiIN8/La1
 cKWe1BDuSD2XbAQ7Q8BhkDYH5AnWfXErMUDmRgpVzfhGxScLMHBbyZGlsQx0X3sjq9
 TEzBlfdXF6KRg==
Date: Thu, 3 Sep 2020 11:19:40 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: handle ISA v3.1 local copy-paste context
 switches
Message-ID: <20200903011940.GH272502@thinks.paulus.ozlabs.org>
References: <20200825075535.224536-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825075535.224536-1-npiggin@gmail.com>
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

On Tue, Aug 25, 2020 at 05:55:35PM +1000, Nicholas Piggin wrote:
> The ISA v3.1 the copy-paste facility has a new memory move functionality
> which allows the copy buffer to be pasted to domestic memory (RAM) as
> opposed to foreign memory (accelerator).
> 
> This means the POWER9 trick of avoiding the cp_abort on context switch if
> the process had not mapped foreign memory does not work on POWER10. Do the
> cp_abort unconditionally there.
> 
> KVM must also cp_abort on guest exit to prevent copy buffer state leaking
> between contexts.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

For the KVM part:

Acked-by: Paul Mackerras <paulus@ozlabs.org>

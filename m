Return-Path: <SRS0=CtgL=JD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D70C433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 04:37:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD098613F9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 04:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD098613F9
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDvs95kJ9z30GV
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 14:37:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=E6H8JPGe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=paulus@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=E6H8JPGe; dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FDvrm1zpfz2xYv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Apr 2021 14:37:27 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4FDvrk4nhlz9sWQ; Tue,  6 Apr 2021 14:37:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1617683846; bh=VZuzCILOIRol37URhiobWfkupK9ny+NNPs7jOctkUWc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E6H8JPGeVXPRjLNkwWre49EODd8kqB8Y1GbQLw8uoJubll2G0oKHugO6gjR420zuZ
 A8lFrrhfVlaBTW17mjapYpSucVuRgUzQAjIlSNr5+/aniZDfZ1rV+emkzVmkvgMqgs
 cwBVUKbJj42ewMvfEscpRhRi6ZyhE8rGuptvXD83VTtZgkMHTkG15f7r2PuMf/Bezt
 r2sYZec50+KkIwdCAjfvZ0UTC3fEgnfSM7kWndzzPedy0I0BLHchmBirANX2xkFfvE
 P2C0NoRyqgx0wd6KctnL8f03bFQ4wtu5fv6gPPykZxf7F547aVos3vol0Hb+Uvir1p
 cdENlc3Ky/hCQ==
Date: Tue, 6 Apr 2021 14:37:22 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 16/48] KVM: PPC: Book3S 64: Move interrupt early
 register setup to KVM
Message-ID: <YGvlguoc6IjjwybE@thinks.paulus.ozlabs.org>
References: <20210405011948.675354-1-npiggin@gmail.com>
 <20210405011948.675354-17-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405011948.675354-17-npiggin@gmail.com>
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

On Mon, Apr 05, 2021 at 11:19:16AM +1000, Nicholas Piggin wrote:
> Like the earlier patch for hcalls, KVM interrupt entry requires a
> different calling convention than the Linux interrupt handlers
> set up. Move the code that converts from one to the other into KVM.

I don't see where you do anything to enable the new KVM entry code to
access the PACA_EXSLB area when handling DSegI and ISegI interrupts.
Have I missed something, or are you not testing PR KVM at all?

Paul.

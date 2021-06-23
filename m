Return-Path: <SRS0=BFlh=LR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F752C48BC2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 05:46:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D4B6100B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 05:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D4B6100B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8shL3DTQz304C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 15:46:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ayFUw5sR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ayFUw5sR; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8sgm3YRWz2xv5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2021 15:45:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4G8sgW4nkBz9sVm;
 Wed, 23 Jun 2021 15:45:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1624427145;
 bh=sXhcp1RB5kLyzObQe3C2zDzTOXxU5fzWiYuFkRLId/M=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ayFUw5sRYFxzw/vSiU7c+4d+5MvSRPkxW7K6N4a8O71m1Vz0TV4kbCeYwsyKnmokT
 Q3y9tZ04R0DGWMmIEDlFkK80T4IpXfn23uUVWj2TA4CpuY6exw+6Xl5MJrKGYt2JNg
 kvQD20DF5hoQHBBKJAB5kG7jN2pD+1rJcKcrKLinJ2aUjKDb1AI1zqQaV9jQhwmGZd
 QjhJaeHofYn+lBWkELBB3MzrOkPpBg28kjf0r/r+CdwPqYP+qJGMgNqVbSnMt5NNF4
 kG13bbr3K6F6ZfK2/pTqgn3W2dNKLHWMvEcSakRMugUtsovkjbZ4fPqDytPGIDwJRm
 lmqwweHUh0nNQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki
 <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH V4 3/4] cpufreq: powerenv: Migrate to ->exit() callback
 instead of ->stop_cpu()
In-Reply-To: <e40e57a97735614941e9ca7fa2f221f8db9a12b2.1624421816.git.viresh.kumar@linaro.org>
References: <cover.1624421816.git.viresh.kumar@linaro.org>
 <e40e57a97735614941e9ca7fa2f221f8db9a12b2.1624421816.git.viresh.kumar@linaro.org>
Date: Wed, 23 Jun 2021 15:45:38 +1000
Message-ID: <87v96516d9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, Vincent Guittot <vincent.guittot@linaro.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Viresh Kumar <viresh.kumar@linaro.org> writes:
>
> Subject: Re: [PATCH V4 3/4] cpufreq: powerenv: Migrate to ->exit() callback instead of ->stop_cpu()

Typo in subject should be "powernv".

cheers

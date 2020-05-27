Return-Path: <SRS0=LEFZ=7J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62669C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 04:32:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8ADE207E8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 04:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="NvjFzCgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ADE207E8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Wybq47CGzDqWL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 14:32:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WyLj5P4MzDqRC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2020 14:21:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=NvjFzCgo; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 49WyLj0Yf1z9sPF; Wed, 27 May 2020 14:21:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1590553261; bh=eCU8X9wRDZzbEoypesdQISc5J/H8gswzhje60culhhQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NvjFzCgoGwZfWfZdWhowsFPcEgbAthogqz43Wu55JJek+CecgA1Vm1V0OyMsEhwGg
 k5nfMcfDV1cr/Jmias9LVJGbLcBNwdX9ZzEIuPp5CEiYbxj5B3AsCb+Zn5Cl9rvHQn
 uMYjYkkrMzGQEyjHsnf62EZl9xNQxr+kdUW9B2gq6ufLlBJv8frN3XRCBb5OU43KuA
 MW18mCF3nStwTN5fhg/CtZbxa/yrCRAc7FfeyCepzs7O2gft4INYZ7HY+VnKfUHZdY
 dCMm83AVzDA2vXCaCkSo4a2yra4j7f75PeuBZLfmmwYYcImvBu0zmZsnpnGE0BpDC9
 skr0LlwvVdzWA==
Date: Wed, 27 May 2020 14:15:30 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Chen Zhou <chenzhou10@huawei.com>
Subject: Re: [PATCH -next] KVM: PPC: Book3S HV: remove redundant NULL check
Message-ID: <20200527041530.GB293451@thinks.paulus.ozlabs.org>
References: <20200401130903.6576-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401130903.6576-1-chenzhou10@huawei.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 01, 2020 at 09:09:03PM +0800, Chen Zhou wrote:
> Free function kfree() already does NULL check, so the additional
> check is unnecessary, just remove it.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Thanks, applied to my kvm-ppc-next branch.

Paul.

Return-Path: <SRS0=Lnkm=BC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085E6C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 06:26:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8BA206E3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 06:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="YJwt5yAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8BA206E3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BC2Rf0ThfzDr2r
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 16:26:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BC2KB6PLPzDr1X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2020 16:21:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=YJwt5yAO; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4BC2KB4wWlz9sSd; Thu, 23 Jul 2020 16:21:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1595485278; bh=hGrvJAeLMwyf4mPSmA682i1yCRFbWUf7OLSrJ5iuVZw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YJwt5yAOjGnlFFYImlzIfZ7VswyXCo8onkCAC47MWHKliIgarhdGtPf5vVhXRdfUT
 CxNVSr1O9bfLS7vm4TYrTx/3gKcaWCr7fbZ9b8jURUbhn1rFSj2cMJyLaqSxfJPoNt
 8cPD2q/zUMf3hEuRlDmlR9URjwyPfUDxwz3Olg0I0cl7Q1SpB2LQgswAtEJjW0Mj4x
 0wV5g3OHn+wBEVmjWWDqzZVAB1wwdOyss/Qp0lzLWmkcY0BbtwwbXGVTmXp+Kd/Nhi
 wf5KbMZrTpbaZ2CxjZYZcz9fM5FqfG3DFOk4DIwAcX+dKWp2RfylqlrDT9b3dEH49a
 6EMA7EpaIbSgg==
Date: Thu, 23 Jul 2020 16:21:14 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH] powerpc/kvm: Enable support for ISA v3.1 guests
Message-ID: <20200723062114.GF213782@thinks.paulus.ozlabs.org>
References: <20200602055325.6102-1-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602055325.6102-1-alistair@popple.id.au>
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 ravi.bangoria@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 02, 2020 at 03:53:25PM +1000, Alistair Popple wrote:
> Adds support for emulating ISAv3.1 guests by adding the appropriate PCR
> and FSCR bits.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Thanks, patch applied to my kvm-ppc-next branch.

Paul.

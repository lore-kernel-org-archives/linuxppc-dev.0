Return-Path: <linuxppc-dev+bounces-27999-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90303C9830D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 09:11:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqWSF1tPzz2xGr;
	Wed, 23 Sep 2026 19:11:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790154717;
	cv=none; b=JocgVyW3NggIElSznzywyNS0X4yy6JkRM9OcDYkQ6fdpk8HzwrIjMQ9U4t5SnZo+DTd/b4t3ABDvplWYkIWUY/o7qZkEjqlxHCNIRUqWiPl8HDgo3W0o4g6OnNtoAHoWqT1r3R6EyVPgf0CGIAgQJ75baheWO2OiWSOVLbUKCo4pQBUznp8k780XqtpmqJm6k220dptgQRO7HzWmY+GtpKC6lHruKFLmc+v0PJjtkaJkYo5+5WHUdszyr+kF439FDOwuSU20A8s617V22FpbHyxDmMPmjQ9b+cSlejKLDFewaVSCvxhmjUbPY3MxHj9nlLs85RsUTpP9Fif3KgRs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790154717; c=relaxed/relaxed;
	bh=DKwHpNfD+fFL3JytQZJq2OXObw0NMpBCMGz3UBEDPyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdUX180HjzPmRpL/QZywn0rh1HZMhIVX2gJ9KrXnV2gPp4CSuT6XZzv/hOdpBOQrjnW6ioF9p4o9TCudg/U6CQKEo7/Mdg+WpwVsNO/vWlKYr2eWnvL7ItfUtXCZexsZK3xTImk2DP4oZTzv3Ka/XC2f1Tiij3n95XL1JM+FiikocBAYjilBRIpnFUOSQB5mBmALaqsfhx0lM9Panj5yfDCiKwhtUXTORMCLZKxxn5dCP08hK3PvWIdMM7b4s79LcTIWHARS+hGLHL7Fx7SfWhGPJg131F31eND7MczdFbKMegnGeInxBswydVEwOg34wR4Csc0m/NOpCP1+pxq4Cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=LqFrMxqz; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=LqFrMxqz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 1414 seconds by postgrey-1.37 at boromir; Wed, 23 Sep 2026 19:11:54 AEST
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqWSB0ywtz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 19:11:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=DKwHpNfD+fFL3JytQZJq2OXObw0NMpBCMGz3UBEDPyE=; 
	b=LqFrMxqzP3pav1+ceQtnVoGnrLxW9IgtZ0Us0jw/Th2tyvTjC9h15uh4N97B7uOuZfP3rPmI+bK
	sB0W0XiyaVHGFNqguUHOirjx1gKRTnZ8fFAqnHcbHiLA6c2GI+wBZ8HdbYl+M85B6APTrMTXGGgnx
	e8TuTc6JGH5QJHN2vGgRt3thMTRZK5AaKCmF4ZUcsyqnzzDjp+RlCvbQlbh6CTyKCRtnQB0bsWwIZ
	EKdcRTliUJIt5OJU3/XEGeC/Jr9V4U2PZxRm2ZfbseJlW9nfxsHSd5Ube8HQaYqfq71/t0bZf1O/H
	qR71j8Wq8XfMnUAFwWBHzT+PaLZ62ALmKRgg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1x9Ie7-0000000GyAR-2cQQ;
	Wed, 23 Sep 2026 16:48:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Sep 2026 18:48:07 +1000
Date: Wed, 23 Sep 2026 18:48:07 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <blum@kernel.org>
Cc: Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: powerpc/vmx - clean up includes, metadata, and
 p8_init()
Message-ID: <arOSR3rO1seclSBb@gondor.apana.org.au>
References: <20260914081500.65737-2-blum@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914081500.65737-2-blum@kernel.org>

On Mon, Sep 14, 2026 at 10:15:01AM +0200, Thorsten Blum wrote:
> In p8_init(), remove the goto statement and return ret directly.
> 
> Remove any redundant includes, add a missing space in MODULE_AUTHOR(),
> and join the MODULE_DESCRIPTION() strings for better grepability.
> 
> Also remove MODULE_VERSION(). It has never been updated and the kernel
> release better reflects the module version.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  arch/powerpc/crypto/vmx.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


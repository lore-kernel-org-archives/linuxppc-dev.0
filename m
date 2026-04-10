Return-Path: <linuxppc-dev+bounces-19558-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB33AF36BA1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 11:10:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsYxG304Lz2yZ6;
	Fri, 10 Apr 2026 21:10:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775819410;
	cv=none; b=onWp+wdmcm2zoRAUp6ukF/hrY70xAVGxGUiHVHLEBYMKkuenQ9ImEJkMSc03OyjQa7Q6cxGnXNyavWoJgUehgHmBxED16OmzoaVHSYU7n2ScOzxceFcRumqTZzGK8Xze0FmLfAe11TGt0/4qFzVYAvkWM9PEq3hLy3ExeuxjmHrgnMLzk4GARH6PbYtUSR0PTy35qivwRQ6yshc1vWe1N383tc3wYJmxhXp+MA6+JxHs9z1KgQz145+fEWdOAtQCiPHPbs+3vwgir+zUBOHhTtyUpH2B99SVoHLX2o7gKGESXG8J4poXV3FVQ8FkW2JIWIm80M0QA16Ui2s2UpLBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775819410; c=relaxed/relaxed;
	bh=yJwq2JLveAbgpcDyiS3SaUa9fNcTfhoxXyNF1+OxAEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aub9VUBUTDB5Gy5n7BbCEu3MSnnt5kyhXwWiY4uDl0GwoWdEWVxA9lMC7iqg1RfKsW9K9z3m78Z4wRRAc0aFLqyGb32SL2bHJS4CmIy2Zkm5WEVX1ymGfwZJD7u8GeXPM6VWmm2vLSg4sxHI2FMov1h0Rt359lfpng4XohD1FNDsb/Ghic39EJSJMqsmxp6p9abLDGUSBvb1HGDVkdzvh6uAVzXaS2XDHO8ydeoliBfDphzqv2PP+wppScdecjsB0iAUrZm0sbOoBkc1eW1+XSRsJeoaup+hTz1VuDznt8dEtU7JGCJFx9H12MY5NGiWgQoasOTOK0fHXsxOtJPFag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HfvGo9op; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HfvGo9op;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsYxF1FT2z2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 21:10:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D987460154;
	Fri, 10 Apr 2026 11:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F97AC19421;
	Fri, 10 Apr 2026 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775819405;
	bh=J9CQoX7GTnEen2B2gzOk+uOsLwI3v0SjpCO+RqDM+0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfvGo9opSrGDxa/afsb88WuMvZhMT79PSWGaCkUCXr+PWuyTIlqzJku/vQIfjwWzL
	 j2vA53DlizDMUF4zGV35/RZldLiqoGohXZq6jnSNOk01PxuBBZUCXkjRNlagG6ky4a
	 MXb0vT3zawPDmi/1awFBO/99cerh8h1xZTxJfColV8aXphUT0XSSO0DLJkexxwh2ga
	 ppeWV2HjA3itU5agbnn2tKpIsJPnDq3FnXy/j0/yEbBbFZes7bKtcmd5SIU0SXLjYM
	 zOiNgiowSHB/nNlZglFxRlfwkT6zSGpE8Db96Qj+Mhs5V1Kpl2dpMBp08WZXhKF6/3
	 Bvk2bfIBUQynQ==
Date: Fri, 10 Apr 2026 20:10:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 10/20] alpha/PCI: Add security_locked_down() check to
 pci_mmap_resource()
Message-ID: <20260410111003.GA1750802@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-11-kwilczynski@kernel.org>
 <93f81aa9-ce74-92bb-5227-d2ccb0a3e06c@linux.intel.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93f81aa9-ce74-92bb-5227-d2ccb0a3e06c@linux.intel.com>

Hello,

> > Currently, Alpha's pci_mmap_resource() does not check
> > security_locked_down(LOCKDOWN_PCI_ACCESS) before allowing
> > userspace to mmap PCI BARs.
> > 
> > The generic version has had this check since commit eb627e17727e
> > ("PCI: Lock down BAR access when the kernel is locked down") to
> > prevent DMA attacks when the kernel is locked down.
> > 
> > Add the same check to Alpha's pci_mmap_resource().
> > 
> > Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> 
> Maybe add Fixes: eb627e17727e ...

Good call, will do!

Thank you!

	Krzysztof


Return-Path: <linuxppc-dev+bounces-20488-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D72CD3427
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 21:47:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Btd5902z30HQ;
	Wed, 06 May 2026 07:47:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778017625;
	cv=none; b=hp5YxFyRq1h9cKWDLQgI+uyOCUhvpGT1WeYJHUOhwtJUJD5GiJu4DGdJHHze0ENBJNxl21nIfaHXPXSjh0KqdsKzIr5yRnybiWnsZuqQFxQRFgoYN4SOZ+Bo8NIr1oiyE3c+gqWvrQLp6+p3/M4RjhtYwOdDmSdOeItfZDMTtRx9Rl5ZZxOlhzBIlI86UP40mJbZpy/Z95C1kOfoLC8iW57PZ9DvcKPLbq3vqp2Olu1B9fnJQWfnStKEBCQsDWHLBeATG3aVuE+jH9BC6eDstX4nz18mY/9/NjcJM5M6Sb54nmpjrzkH35HvxqQzwnMNvqkP1Z9U3zY73BLI31324Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778017625; c=relaxed/relaxed;
	bh=Mr/NT56TuEx7y8oJVjQSfOrTYKyR5fXa0wMnMObBOmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n9JAKNCyFo64niQ3Q3cA6Rl7z/xzyed036cZkwdz4WTwfCQZ+exnd9A7wbswIu1+8cfuMX6NmLreg88Srzw5zPLGlVJdLe7m8kmFpUwaKELOzDFb4WRbvQ3KsyT/+Z8QFURyQuZQ+lNdCUQYSP4HIMR+iyFmKTkV2CA1HC8OkTOxbs+wxPiV/7S/urrxaxI+WLziBIHeIpTR+sG7IXMybNaMtS5TISRdyXSM5Aj4K4VmvVK+3MDSzqQu9JBYGnZXCjWCHA81m6v/Rm2yPYNdXQ8R3xdl7TDYooozjm5ZNwy9zLIva/0bQMaSCbsQJGPi//hl99mPJmeYTUzmbWLj/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sAIHS+PU; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sAIHS+PU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9Btc4VC6z2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 07:47:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A40B46057A;
	Tue,  5 May 2026 21:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31300C2BCB9;
	Tue,  5 May 2026 21:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778017621;
	bh=qsL/iknu6G3liYrZ5EdG82Vz3MNhyz1DjA+tvVEl6k8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sAIHS+PU8Ddz+furGMFG37JN1odDxUXDGvcDt7EcU2QTfC5rxzxeAjQzW1qacijlv
	 /xfkxuS/URjUCOQaAZzsw3yE1QzgES/nS8kIen3VpqlJ0G3yD750NGrSolGTbGb5bd
	 G+kUno0CISoAtk4ovFkRS8YLp8OEwItn6Ib3NLqq4z10eF683vNVaci3fen1EPj3Rj
	 USuk12fwHEa8b/ETCxNOTnTssU2O0S1vTMlznx+UTow0FGRc2vFEywIYZsHytoPAr5
	 aRWDZKCkzV6arFeHfF/AZ15kOsjjM2KWvO2GEsJ1I6BaQv/OrM11nK8W+BxsdeezOA
	 GCOMIDs7tketw==
Date: Tue, 5 May 2026 16:46:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 04/24] PCI/sysfs: Use BAR length in
 pci_llseek_resource() when attr->size is zero
Message-ID: <20260505214659.GA752301@bhelgaas>
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
In-Reply-To: <20260430232202.GA3577346@rocinante>

On Fri, May 01, 2026 at 08:32:30AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > The alternative would be separate llseek callbacks for both the legacy
> > and resource attributes, which we can add if this would be the preference
> > here.
> 
> If we were to do this, then it would be as follows:
> 
>   static loff_t pci_llseek_resource(struct file *filep,
>                                     struct kobject *kobj,
>                                     const struct bin_attribute *attr,
>                                     loff_t offset, int whence)
>   {
>         struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
>         int bar = (unsigned long)attr->private;
> 
>         return fixed_size_llseek(filep, offset, whence,
>                                  pci_resource_len(pdev, bar));
>   }
> 
>   static loff_t pci_llseek_resource_legacy(struct file *filep,
> 					   struct kobject *kobj __always_unused,
>                                            const struct bin_attribute *attr,
>                                            loff_t offset, int whence)
>   {
>         return fixed_size_llseek(filep, offset, whence, attr->size);
>   }
> 
> Each callback would be placed within the corresponding #ifdef block, so one
> for HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE, and the other for the
> legacy attributes, so behind the HAVE_PCI_LEGACY guard.
> 
> Note, the names need to be different, as some architectures offer both
> type of resource files, like PowerPC, which defines both the HAVE_PCI_LEGACY
> and HAVE_PCI_MMAP.
> 
> With this split, we can also drop the __maybe_unused annotation.
> 
> While I wanted to keep the changes to only what was needed for the
> pci_llseek_resource() to cover both type of resources, it would be
> also fine to have two distinct callbacks, too.

Yes, I think this is much more readable than the "if (attr->size)"
check.


Return-Path: <linuxppc-dev+bounces-20490-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F166FF8855
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 23:19:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Dx759z9z2xpn;
	Wed, 06 May 2026 09:19:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778023163;
	cv=none; b=FV4gNoqXD3KqlRZ5ZZa/XNURMYp3Gt0SCN8rZ409rfUR21V7Kz9Muamgk5ksKUTkk+jrPwVgTZtw3C5/nTU3OeaQjpb70qR5cH4yHL0drBPyrpIAJd3wsGvNgRd3i/Z1+k8EIXfq/w/kyMx2B9cIS4X96GdQH3Bgj/CfKlBJucufqghK2RQtJpGevH0J9WX6+p05uptCct2biRmMFMhQ/eX7F8ZMwKisd3v5c90mVTxUjKI20O+X9Prm1JZ2o3y5Pw3MuTs1D/fmRFau6tMNJnqMeEYDNx6h+ZLRuQE1eBu5eUCVVkabuO8nWHfgpa1kDTqTwCnCR4y0Q/2WV9D0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778023163; c=relaxed/relaxed;
	bh=HZ4gn1rr9AVXjYUoB/X1IpTnMgVFMxfH7FZdMW7qAQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1Ol/Eu2cg75Nu4YhVEMZ8Uf/+LjNFMgM01CbNs2zz51rqZxcmgz5+RLTglM/qJUnvoXyd0Sg1k0siT2Mgg8K/fmzkM1xbE1gVL4gFiVRz7kDgTZLPbBvBN8Uc2qxCGhjlsn34FELZ19MGp07vZZMuIZ+Yan2G0spBUusZb27HSF1bmqa99V8MUGRCSBfNXxcmJo+C23kUHjZhijkDFOM2Y5iUCSbqpdOlhqaX+WccrW/zf3XJwqkB+t/tJDntnl0/aieD0lC+JQrTRd4kpIB/oiTCEyUjeq9v9Wd9r1oa16Jj8aDlHqrQNjF7NntgBarXqKEdaZDecoQsesqRd+5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H1irtPcp; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H1irtPcp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9Dx63zK3z2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 09:19:22 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4413E60123;
	Tue,  5 May 2026 23:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4AAC2BCB4;
	Tue,  5 May 2026 23:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778023159;
	bh=aSUWwvC/Z4hL7kLLz0uyOBLteb3wXBC4iS5QzbWk3v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1irtPcpfqHFY1VDM3K8ELysNJFq/zwjdjMpTSwrQSsgIhrG3hD4jfvtldFC0r+B1
	 Qv32FF7xVtw6QRvptdGazbpcqIAhhypVAB8rtdLVu6PxiwFnf4vjsyV7QJL1J2CRmP
	 gaGXGGDc/YsWmrSzjTsD9VdsETYnebTmntkloGM1/R9AvdXITa0lDE606YYADj3Y3b
	 l6G78KuaByZtWVEudnARiWkGJ1SlPCckAQciDPSAjljBHmkz3gabvnVoKik1123AyO
	 HnhTR4xt3ZxAaSeWmecxnGt13CJqKt+ps/vRL8UBweVmXQNoh0w9tjSKs0/NAH8uX4
	 nVitbO6Aijv0A==
Date: Wed, 6 May 2026 08:19:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Christophe Leroy <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Dexuan Cui <decui@microsoft.com>, 
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, Lukas Wunner <lukas@wunner.de>, 
	Oliver O'Halloran <oohall@gmail.com>, Saurabh Singh Sengar <ssengar@microsoft.com>, 
	Shuan He <heshuan@bytedance.com>, Srivatsa Bhat <srivatsabhat@microsoft.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 04/24] PCI/sysfs: Use BAR length in
 pci_llseek_resource() when attr->size is zero
Message-ID: <20260505231700.GA1410272@rocinante>
References: <20260430232202.GA3577346@rocinante>
 <20260505214659.GA752301@bhelgaas>
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
In-Reply-To: <20260505214659.GA752301@bhelgaas>

Hello,

> > > The alternative would be separate llseek callbacks for both the legacy
> > > and resource attributes, which we can add if this would be the preference
> > > here.
> > 
> > If we were to do this, then it would be as follows:
> > 
> >   static loff_t pci_llseek_resource(struct file *filep,
> >                                     struct kobject *kobj,
> >                                     const struct bin_attribute *attr,
> >                                     loff_t offset, int whence)
> >   {
> >         struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> >         int bar = (unsigned long)attr->private;
> > 
> >         return fixed_size_llseek(filep, offset, whence,
> >                                  pci_resource_len(pdev, bar));
> >   }
> > 
> >   static loff_t pci_llseek_resource_legacy(struct file *filep,
> >					       struct kobject *kobj __always_unused,
> >                                            const struct bin_attribute *attr,
> >                                            loff_t offset, int whence)
> >   {
> >         return fixed_size_llseek(filep, offset, whence, attr->size);
> >   }
> > 
> > Each callback would be placed within the corresponding #ifdef block, so one
> > for HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE, and the other for the
> > legacy attributes, so behind the HAVE_PCI_LEGACY guard.
> > 
> > Note, the names need to be different, as some architectures offer both
> > type of resource files, like PowerPC, which defines both the HAVE_PCI_LEGACY
> > and HAVE_PCI_MMAP.
> > 
> > With this split, we can also drop the __maybe_unused annotation.
> > 
> > While I wanted to keep the changes to only what was needed for the
> > pci_llseek_resource() to cover both type of resources, it would be
> > also fine to have two distinct callbacks, too.
> 
> Yes, I think this is much more readable than the "if (attr->size)"
> check.

OK.  I will switch to two llseek callbacks in the next version.

Thank you,

	Krzysztof


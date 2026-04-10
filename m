Return-Path: <linuxppc-dev+bounces-19567-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEACF44841
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 11:48:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsZp21Y6yz2yl2;
	Fri, 10 Apr 2026 21:48:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775821738;
	cv=none; b=XbmfUfeCVN5pZJuVq9lX6biRjG2lt6fUy4S7CT+tEAp6oyVNQqgrz6aot51GMjejKqpSc70DxHNQpLuHPyd0lriO09JLBFUTYJbxiKaQAXYFW+dVKF4KhAahzVAV+lRXoFaDJ+z/ILp50NsSDj+YlfV39IeWopaeotbrPDr3C7lG78lgwQU5VqaoOqeAZxpa24xQOdk5xHhMD9USsSTAlgUtsnq6ZSA8ra3MqFCMqk7BvIvJUU9aZmP50akkm8JDJJmO9TN14/q8nNmhB5tQGGNEgLVlhe2hyFlXROykrDHcY+4ezpgda2qj4etTzRbgcmu1Fzse78eVOXMvYcCCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775821738; c=relaxed/relaxed;
	bh=lXho10NfxFYQNTCj0BquJbvQuh3nGDrVIFITdTBSMus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6Qe5xBZHIeC1sf5/DmI0XWbi4c18SnRWDTuluRusizHBMqE6QsyOdIkL6aMu09bJ8sKV2e3mcMjFHQAPhqIx/WpEhy3P4UElfUsa9KQ2W1CqmRR8zCo/GNMTt7e/p39+f2Z4vf7eCbIfMVBHbluUhS4zgssBtE2lSmYSJ1n4QENOl1obYJb8Onzriv3czNTQ2fiT+glQBXWrq1VjzK9lfEzK99IBj36XukIEL3cZ+krXVdVErmVcD0IGeu1UGZ5WOjVaFoxY/PGUq2NUNpPWNuYAXNkjqWqKDTyRgj+mxE6KDjflTE7lJvBstpF3CpJlJ18uf3IgS6+DE2MDcUAEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TbE+TtYG; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TbE+TtYG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsZp14CqNz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 21:48:57 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CFF9A443F2;
	Fri, 10 Apr 2026 11:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C988C19421;
	Fri, 10 Apr 2026 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775821734;
	bh=LZilPulN3qlgDY3IxRp/Zcm4TbaTOPqVA6WSuY47T5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbE+TtYGOr1Hy4myyKWvvk1P2h7Vxhu8skNaAGe/jW4iBxEEXsK4jt8HwjFzOfbfg
	 V4wQvrxksT9bTS+Ge4keWG1lgcI9FpM+5LZOyo9TcUoB2qPyLMtbnrDGbHNLJPtCSq
	 4IiH5OKUaNI0b9oY2dK1MZA+QquqKwoxA8OMYgRsd6L5/A2Ofe9UNBAjsPd3EfKtCi
	 oYdcZcyaQGv33aiJSdEzhOehJjwJjkzBRTS70S/bCsFy8m4ifTze2+TeeWnC00xN8X
	 49zICxu10mM5Bo7ALz0On5lo6oB7Z6qdXSzOD8v0NKftzd6B80g90n04HBaLinJuhg
	 NuTZwUKrQPU/w==
Date: Fri, 10 Apr 2026 20:48:52 +0900
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
Subject: Re: [PATCH 14/20] alpha/PCI: Add static PCI resource attribute macros
Message-ID: <20260410114852.GA1761359@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-15-kwilczynski@kernel.org>
 <2c5b50c7-b357-025d-e0de-1fce1fcddf20@linux.intel.com>
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
In-Reply-To: <2c5b50c7-b357-025d-e0de-1fce1fcddf20@linux.intel.com>

Hello,

> > +#define __pci_dev_resource_attr(_bar, _name, _suffix, _mmap)		\
> > +static const struct bin_attribute					\
> > +pci_dev_resource##_bar##_suffix##_attr = {				\
> > +	.attr = { .name = __stringify(_name), .mode = 0600 },		\
> > +	.private = (void *)(unsigned long)(_bar),			\
> > +	.mmap = (_mmap),						\
> > +}
> > +
> > +#define pci_dev_resource_attr(_bar)					\
> > +	__pci_dev_resource_attr(_bar, resource##_bar,,			\
> > +			    pci_mmap_resource_dense)
> > +
> > +#define pci_dev_resource_sparse_attr(_bar)				\
> > +	__pci_dev_resource_attr(_bar, resource##_bar##_sparse, _sparse,	\
> > +			    pci_mmap_resource_sparse)
> > +
> > +#define pci_dev_resource_dense_attr(_bar)				\
> > +	__pci_dev_resource_attr(_bar, resource##_bar##_dense, _dense,	\
> > +			    pci_mmap_resource_dense)
> > +
> >  /**
> >   * pci_remove_resource_files - cleanup resource files
> >   * @pdev: pci_dev to cleanup
> > 
> 
> Wouldn't this belong together with the next patch, or is there some good 
> reason why you added them separately?

No specific reason other than to make it easier to review.  The pattern
here is: macros first and then users later (when converting things over).

Thank you!

	Krzysztof


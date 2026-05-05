Return-Path: <linuxppc-dev+bounces-20491-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7582ACD3427
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 23:42:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9FRQ05jTz2xjd;
	Wed, 06 May 2026 09:42:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778024529;
	cv=none; b=bcXTTq9ZOKQiSRLvLJ5A0JeDqqbfAk7QlZpZQyzca8U7Q1fnKIITz0u1EISr1r3VflVEYHlLahF0HQK2gISqz2itCw6vYecP35ZLcs10RbrpuRlLH/rMuwQaOuUi1LjD5EP0DDJQspTZcXke+uClJ1ZCdUEFaTi1zyOXxVTgB7RBLnInTYTdGO5WssaQeoBM8x+njuwdlo0a7dA4NtuPtddV0S3LSjcPK7qres72N8Av63o9tDgJuAWlmf3hjQEsaXi+gYszqjHPrzw+3FqP/Jvi6TEHF2SrhCI88qAGIfNm1CJVQuSIlunGkQ4erX2njLP+MVtqSLj/YAZpAC0dNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778024529; c=relaxed/relaxed;
	bh=yd8vC1oAbzwMygF00TDN9cbfZNmNUzU8RXGbs+G91oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkd+hfIl8I1v0MLfE/O89Fm+w9wWOq2s5QBZe6VxOTU9EvS97+P0VkuiHDJ+7t9wzMrM7qpP1moM0jROtFxDsZ3J/xe3D5QZokSWOSHfiacfegtvP2bQr01O8eKIzQ1NenXHs8uXCUPBE/dB2Q/Ud0Us9D+phGUXU5KuuBpytOwnlHO6OUFV32w48MoiNiCCmIncFeuDrSCI4Ec++lDGvE7Gi7PJ86A3O4+6Y5YUMfIe/ph/Dnp9nur+CKulOJzavboZgC/951UAZCWB5891EsdTj/lu9HxKXP5/hpVfKrqqU158VgDyeD72RfJZ70k26e+AxlyB4llrL9EnczkgPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uHV7SKol; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uHV7SKol;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9FRJ4wqBz2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 09:42:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2AAF5403A6;
	Tue,  5 May 2026 23:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FD8C2BCB4;
	Tue,  5 May 2026 23:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778024522;
	bh=1+LqtftsVIosaHSl04Cer7GCqmGqOkVQufDLaggxVfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHV7SKol0CAsenoLhmkp0r6exuLnPtN/CCCpf7Il98BCLYLj4pi5bt9uxiANXYhb5
	 GalDzDowOpCKkjApBkyKZB4epvkQUbNVU46MjLDx0OotsQC+WkYsNC7xlJriSRRV1y
	 uuOto96W9fnc4u9NW80gZneUfNbrcxZtVB5po3VXB+OMmzgYscw4D7Z/BsPvUlE558
	 6/ms70vHd86rlzdNIlZDuXB2c8oI+sCkIaJ5kaRsdRi9TjNq8nfTp4yzObBh/qvq/7
	 LofCPMS4PCe3qdGCVLayBL4PuJ5WkN1qW5JMShfnxxzOz4IHRK0qHbr3XPeMwKPmhV
	 8y7C2hGk4zXWA==
Date: Wed, 6 May 2026 08:42:00 +0900
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
Subject: Re: [PATCH v6 24/24] PCI/sysfs: Limit BAR resize attribute scope to
 platforms with PCI mmap
Message-ID: <20260505231945.GB1410272@rocinante>
References: <20260430020648.GA3923076@rocinante>
 <20260505220135.GA752411@bhelgaas>
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
In-Reply-To: <20260505220135.GA752411@bhelgaas>

Hello,

> > > The only platform without these aforementioned defines is Alpha, which is
> > > conventional PCI only and cannot have ReBAR.  So this guard removes dead
> > > sysfs code on platforms where it can never be executed.
> > 
> > Having a closer look:
> > 
> >   resource_resize_attr_is_visible()
> >     pci_rebar_get_current_size()      <- returns -ENOTSUPP, so is_visible callback returns 0
> >       pci_rebar_find_pos()
> >         pos = pdev->rebar_cap         <- set to 0 on a conventional PCI
> >         if (!pos)
> >           return -ENOTSUPP            <- no ReBAR support
> > 
> > The pdev->rebar_cap is set during PCI enumeration:
> > 
> >   pci_init_capabilities()
> >     pci_rebar_init()
> >       pdev->rebar_cap = pci_find_ext_capability()
> >         pci_find_next_ext_capability()
> >           if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
> >             return 0;                 <- dev->cfg_size set to 256 here for conventional PCI
> > 
> > The PCI_CFG_SPACE_SIZE is 256 here.
> > 
> > When the platform has support for PCI Express, the dev->cfg_size is then
> > set to 4096.  On an architecture that supports conventional PCI only (such
> > as Alpha), the pdev->rebar_cap will be set to 0, the is_visible callback
> > will then return 0, and the resize sysfs attribute is never created, as
> > such, the __resource_resize_store() callback will never be executed.
> > 
> > To make the connetion here to the #ifdef guards:
> > 
> > For the pci_rebar_get_current_size() to return >= 0, the device needs
> > PCI Express and extended configuration space support.  As of today,
> > every architecture with PCI Express support defines HAVE_PCI_MMAP or
> > ARCH_GENERIC_PCI_MMAP_RESOURCE.
> > 
> > I hope the reasoning here works.
> 
> We're talking about this #ifdef:
> 
>   +#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
>    static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
>    ...
>   +#endif
> 
> I follow the reasoning now but by next week I won't, so I think it
> requires too much background knowledge.  Future changes involving
> HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE could easily break
> this.
> 
> IIUC it's basically doing what "#ifdef CONFIG_PCI_REBAR" or even
> "#ifdef CONFIG_PCI_EXPRESS" would do, if we had such a thing.

We don't sadly have such guards at the moment, so using the guards like
HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE would be the next best
thing.  We already rely on these throughout the pci-sysfs.c already, and
will also rely on either for the static sysfs attributes, so if there was
some issues with either of these, if these "broke" somehow, then we would
have other more severe problems.  Note, that architectures rely on these
macros to let us know about what "feature" is expected to be enabled, so to
speak, so I would imagine nobody would break this accidentally (famous last
words) and perhaps with extreme caution would do it on purpose.

> How terrible would it be if we just accepted this dead code on Alpha?

I would prefer not to build any dead code anywhere if it can be helped,
especially with as little as two lines of code added.  Plus, most of the
code setting up resources that are not specific to Alpha, would have been
disabled using exactly the same guard as the one proposed to be added
here, not like this sets any precedent or adds something new.

That being said, I will drop this from the next version.

Thank you!

	Krzysztof



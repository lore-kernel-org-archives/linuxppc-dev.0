Return-Path: <linuxppc-dev+bounces-20528-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8ADCD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 17:48:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9jYG0pFkz2xYw;
	Thu, 07 May 2026 03:48:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778089730;
	cv=none; b=Rpw0nVVceA1XvUOMQKRDwy7MmK4ySwbiZGvjzN8lvL8mIDXuVKIAUqmc+hTnL302H/YYLIezVa+kBKz3sf7A7OkAelJkqJsg0GKzc08lzwlS0VRkICpLNDUwYBNujLaPq2dj84HZ3CpVDAEpiUTMKX0aiPlmYSz78mb5AHRj33AZCnA0XwP5w4N8efJXWjn4ES1DhUIQ378hOXWcTz0y4IapWaCt8C88DLvbScvDermCbG3ZwuEW4m7bs6sLk82QuTwSIfKsiDFwWmW+QjClAOdcHo16EyJlSmKOwG8G1AShR2MVuXFPVcQiiuGZ3bp+/a8pAV5H7Wb2aqWrl85VOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778089730; c=relaxed/relaxed;
	bh=DeJqaA5XRYpJZCQdzMiPOBPoc5hv13MWzzVIMrs2jpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JanHYpQXdOjjOGfrcsFBjBUKzdHqe65IEyWs9ieK+OM6W3mE6o14kd4874L9KgO1RizmzaByPDtnlsL0NQeY/A1vPOEHj2MUXMrEW1S/GyLDfblRHytklED+r3va08GGAtUZMwTbgZsqveFf47U6IBbqvMC23zHi4gVEncbqrAai+xVM3QJdZb5KC4OboEYsUxebso08g33qoPn1aonY4J7kmi8+UvygSC/sTO0aRS/0jZ/HXi0/Xxgcuvux7Bi3MR0wuzA+9f6TjSpYrvNJC9/blIIIsQj6cBopaX768iQcXsAt1OUW1cN0COBC7B1K+4+tA94VcPL87R6lQPn2kA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L5WmSJSg; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L5WmSJSg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9jYD2YXsz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 03:48:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EEB1B6013B;
	Wed,  6 May 2026 17:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D173C2BCB0;
	Wed,  6 May 2026 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778089725;
	bh=cfE/nyxXJocKO1O7pZ91ACi5Q1vHGPeBdIDXW/fileA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=L5WmSJSgBp9CROV2OHCeUtlcnNEjgXbMK0hfQbxPLkKUINNC/rzw1xlJ1PO0ffzNW
	 e7Ge5gg6idpYzv2yCbE5KUtKsQqVyVLhMSEh6swycc/WtPoVTE8o4rKaBhShVuNW/t
	 97ivXP9yFXg7Z0dFnETVEEcnI7RsRCMNxJWfiU0p43hBnNUJGLBB6uOUJNEY5M844O
	 Qq14sClcFECoNJq0ev5P3miyBRH7rNgnuJZ9tgmUvWQh3aqHEAgfo0w62bxBlA5uge
	 Y/O1SIz0K8x6pDbegDm2H+X0iTQKOC2ewr7TH1zljvhgjB0pFIPyjl213/Wv0bj/Vn
	 DJQ4mmcoNDmxQ==
Date: Wed, 6 May 2026 12:48:44 -0500
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
Subject: Re: [PATCH v6 24/24] PCI/sysfs: Limit BAR resize attribute scope to
 platforms with PCI mmap
Message-ID: <20260506174844.GA792825@bhelgaas>
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
In-Reply-To: <20260505231945.GB1410272@rocinante>

On Wed, May 06, 2026 at 08:42:00AM +0900, Krzysztof Wilczyński wrote:
> > > > The only platform without these aforementioned defines is Alpha, which is
> > > > conventional PCI only and cannot have ReBAR.  So this guard removes dead
> > > > sysfs code on platforms where it can never be executed.
> > > 
> > > Having a closer look:
> > > 
> > >   resource_resize_attr_is_visible()
> > >     pci_rebar_get_current_size()      <- returns -ENOTSUPP, so is_visible callback returns 0
> > >       pci_rebar_find_pos()
> > >         pos = pdev->rebar_cap         <- set to 0 on a conventional PCI
> > >         if (!pos)
> > >           return -ENOTSUPP            <- no ReBAR support
> > > 
> > > The pdev->rebar_cap is set during PCI enumeration:
> > > 
> > >   pci_init_capabilities()
> > >     pci_rebar_init()
> > >       pdev->rebar_cap = pci_find_ext_capability()
> > >         pci_find_next_ext_capability()
> > >           if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
> > >             return 0;                 <- dev->cfg_size set to 256 here for conventional PCI
> > > 
> > > The PCI_CFG_SPACE_SIZE is 256 here.
> > > 
> > > When the platform has support for PCI Express, the dev->cfg_size is then
> > > set to 4096.  On an architecture that supports conventional PCI only (such
> > > as Alpha), the pdev->rebar_cap will be set to 0, the is_visible callback
> > > will then return 0, and the resize sysfs attribute is never created, as
> > > such, the __resource_resize_store() callback will never be executed.
> > > 
> > > To make the connetion here to the #ifdef guards:
> > > 
> > > For the pci_rebar_get_current_size() to return >= 0, the device needs
> > > PCI Express and extended configuration space support.  As of today,
> > > every architecture with PCI Express support defines HAVE_PCI_MMAP or
> > > ARCH_GENERIC_PCI_MMAP_RESOURCE.
> > > 
> > > I hope the reasoning here works.
> > 
> > We're talking about this #ifdef:
> > 
> >   +#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
> >    static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
> >    ...
> >   +#endif
> > 
> > I follow the reasoning now but by next week I won't, so I think it
> > requires too much background knowledge.  Future changes involving
> > HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE could easily break
> > this.
> > 
> > IIUC it's basically doing what "#ifdef CONFIG_PCI_REBAR" or even
> > "#ifdef CONFIG_PCI_EXPRESS" would do, if we had such a thing.
> 
> We don't sadly have such guards at the moment, so using the guards like
> HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE would be the next best
> thing.  We already rely on these throughout the pci-sysfs.c already, and
> will also rely on either for the static sysfs attributes, so if there was
> some issues with either of these, if these "broke" somehow, then we would
> have other more severe problems.  Note, that architectures rely on these
> macros to let us know about what "feature" is expected to be enabled, so to
> speak, so I would imagine nobody would break this accidentally (famous last
> words) and perhaps with extreme caution would do it on purpose.
>
> > How terrible would it be if we just accepted this dead code on Alpha?
> 
> I would prefer not to build any dead code anywhere if it can be helped,
> especially with as little as two lines of code added.  Plus, most of the
> code setting up resources that are not specific to Alpha, would have been
> disabled using exactly the same guard as the one proposed to be added
> here, not like this sets any precedent or adds something new.

OK, let's leave it as-is.  It's confusing to read, but no more so than
other existing uses.


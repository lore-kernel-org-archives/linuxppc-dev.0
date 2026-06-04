Return-Path: <linuxppc-dev+bounces-22068-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE3DCD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 23:53:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWhGw0krLz2xnK;
	Fri, 05 Jun 2026 09:53:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780617224;
	cv=none; b=FwKzhJtEEzFGj1ZMAfN1+k5a5pLVJGlipXzK0Oyjp8eyINgHyRC926cYm4lJjbVRvx0OicH4OvnOlX2ZQISN0GhruiNKALO8i4QDnhiUaiR/GH9nzkhjomFUlREvIQ64Bo94/2dno1o2Nxq+GdVJT7yojRCDYSSkzTitboTvX3KQVusBu1aNL/pdSkWg6xNhuZNwgZb47yL2jQXjHKx4YI+S94EAdr1YtTXkMSBcgQwCzhz33mGep8Eih6Sr78a39bv8RDu+Bf+9WM+g5FYrQWa1xMl30v2Ilq4QtOi+dE+Q/A/MgoVvw1uX4nPUjK+/TZDEWnG7X1gX8VIqro9wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780617224; c=relaxed/relaxed;
	bh=pmt/JkLWWliz/NxTk163pbkZkRgDeZpSMIwPpktcw8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeyQURfGiAL/NUET0vgCGDXxgoiNBIz6D5y4q3Nq7yvnhv3yHik1gE1cdI9RrJG+L40HZv/KBjbbbYGXG8DHi/fomLMLsNlRWF+TJXHKT/1VSp9jAcldwSt7rVmbg3yi7WFv6f/cNqe+gIWl2OrwCX00hYLRBamwaqRAvA2sCpLrRXyrilQduOxGm/dqXrReKTR0vFLCfHBwoBJMxnXAvL0J7yvfic5wop0vi+5kctk7bF3C+NQt2SBPTe/DSQzwDKcv1Owk7zUb/ngfggM0cUjxWSYpRBXWdMr/VhSOXCGPM5mBH7W5YUm63w/is6kkBlCZFPkiynrqpUVPuvhlMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MwA2sKHv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MwA2sKHv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWhGt6X30z2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 09:53:42 +1000 (AEST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-5175eab3a93so9819811cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 16:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780617220; x=1781222020; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmt/JkLWWliz/NxTk163pbkZkRgDeZpSMIwPpktcw8U=;
        b=MwA2sKHvsAi0A7Vy7NxJsocPv6IEyNYa8e1ZHcSr23o6jkHkoNLhaytGv5MaaUKztw
         AWIzeMY/4AiyMhcWO4Y+ekdlHlad4HPeuoz4zSxT8KjSNAJsCK+6e/HmdyJ1jp3msuGT
         872nWHgEUS5vO5+9+jVrYvNNbMv3xGYVJhUgqy2JWgEUaZDYmJ3t5bd9u4s7zHUr50Y1
         ON2pqXgnMyfFS1xfLYZ6ossoWdgXKcG9l+o0OlIkJAviCaWT4rJOgJK1mT30ck1QkQxk
         9W3M5BFVrVKU0fX538kQFt6GeaLJbIPdarmBlcQFnfMOg8wIWCpBPpi7kNXhsDLROleC
         1BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780617220; x=1781222020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmt/JkLWWliz/NxTk163pbkZkRgDeZpSMIwPpktcw8U=;
        b=qXNBp/oKF+nparGo684u9m9eB3kkl+IosF4UVU5SMeAxWmiikST5iuf+aWrQbcVGWF
         t/LXIOa8ozORA1ngBL4QH0shZ0XnL+JXBqkGrl/WFjgpnqUnKQinEXRrw9FxCCDGXEtY
         1SnyCc1oeqI2LuzdubsFjFlnQsR6tpkoIOr17/CtEqxjhWWsvP3gJz32EGY0p+Y+jgET
         6HZUXhBISS2Uwlpu/0T5tFywX57MK3LGDpBK8vCrtaVuXZx+PnhK7tYpP5Gjjf4hATMm
         f3M+IMv1R3/5uSpkPqYq//EcM73ahF4If6elESmdn284LkVzu14Cp51BjxQCMWGrp1v6
         8Lqw==
X-Forwarded-Encrypted: i=1; AFNElJ/LQQLhmSxcYvHfzwJrrTxjenKZMxsNSuTZUaBNmZwkNtFokoJ5ImtuLaHyw1spI2PrqZXFYeESy1yfI/w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy02tyWjHv+rX47J0r0sjfqn/uinMkrYLg8HfEf1JZ6si6HMQ14
	NWZ9XypQdwmy3zt4LLmVm/I4goMOGfnJ1LhD6oUpecNnu7nngskL0/s3rL7wgRsls1U=
X-Gm-Gg: Acq92OGbtK1SY+dKd1mxCp7T+3InPQnapuxTjV5x2GmaDfYcU9u+BHOr8maRlDRNN8R
	+O6jlrM4GekhxX36LaSV/3DLZyfxW00SF9n9g7tJ7vOnXyJbg9+WLbA564MJ79mS0kAblIwOQA/
	1EnzVdgRSMgY1VAAj0M0nhTmpdzdY06CFojh88X7R3M7Ez1nYfKW0fFwmGLOJ5m5xdBy2IXHGEX
	uTy99jofCXvz7GmFyDVaUjf0RaiYZtZmlnPeUqOzLOWOB5Xk0zJdj1n3My44PmcPdztmkWDOQ8x
	7ap7P4PabHBTuBmBrutSoXDP2MoLV3vocQqMWLnGtiZ/s5PZnikgAjTEQZF5oDUJUUOgXsDnn7k
	NuMEeu+TODcVk8TKvHzx+519kqSK+kJK3ew827DwXibwA46TRIEID6LioBostAeda3j3LPSy/+B
	RTAs7zPHqTRpfPZDeoiNneI3qtO5bv1NF8t41gus0EfPx+DKwHGN8MpZsraQXQ6U9CIp4S/ltNK
	RiX7kFRVPZgdZva
X-Received: by 2002:a05:622a:6187:b0:517:6b31:8048 with SMTP id d75a77b69052e-51795bccda6mr17320401cf.35.1780617220214;
        Thu, 04 Jun 2026 16:53:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd051facsm64970176d6.32.2026.06.04.16.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:53:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wVHsZ-0000000A3UP-0kpK;
	Thu, 04 Jun 2026 20:53:39 -0300
Date: Thu, 4 Jun 2026 20:53:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
Message-ID: <20260604235339.GE2487554@ziepe.ca>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
 <20260604182031.GB2487554@ziepe.ca>
 <a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>
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
In-Reply-To: <a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>

On Thu, Jun 04, 2026 at 04:49:05PM -0700, Dimitri Daskalakis wrote:
> 
> On 6/4/26 11:20 AM, Jason Gunthorpe wrote:
> > On Thu, Jun 04, 2026 at 08:01:41AM -0700, Dimitri Daskalakis wrote:
> >> With this patchset core enumarates the SIOV capability and can identify
> >> SIOV PFs. But there is no central mechanism to allocate/manage SIOV VFs.
> >> To support device pass through, devices will need to add a vfio-mdev
> >> driver with IOMMUFD support (or something similar).
> > 
> > There is an enormous amount of missing work to do something useful
> > with the SIOVr2 stuff. IIRC there is even supposed to be BIOS
> > components in this plan and there are some missing PCI SIG topics too
> > IIRC.
> > 
> > So, I'm not sure how much value there is in merging just the cap
> > discovery without a roadmap for the missing parts..
> > 
> > Also, I'm quite surprised to see this out of the blue, there is an OCP
> > workstream that was building out a standard that outlines how all the
> > different components have to act to successfully implement it.  What
> > is in PCI SIG was just some minor foundational adjustments without any
> > context on how to form them into a solution.
> > 
> > I think it is extremely premature to merge anything related to SIOV to
> > the kernel. Join the OCP work stream if you are interested. I think
> > the general feeling was there is not sufficient interest in the
> > industry to do this and it has gone quiet.
> > 
> > Jason
> 
> Hey Jason, thanks for the feedback. We (at Meta) are definitely
> interested in SIOV-like capabilities for device passthrough to containers.
> 
> For those scenarios, having PCIe transactions per RID plus IOMMU
> isolation is enough, but I can imagine hypervisors/VMs requiring more
> platform support.
> 
> I hear you on the broader support story being premature. But on the
> other hand, this series unblocks experimentation at the driver level
> for basic data path validation.

And you can do your experimentation OOT :)

Go to the OCP workstream and finish the standard if you want to get
something merged.

There is zero need for SIOV if all you want is containers. containers
do not require iommu isolation or unique RIDs.

Jason


Return-Path: <linuxppc-dev+bounces-22060-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849FFCD6E77
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 18:20:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWXtY5K53z2y8p;
	Fri, 05 Jun 2026 04:20:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780597237;
	cv=none; b=G03dcM8IFBYMPt4wYeyG5l0zEl2lK32yqp9Pz2Rlj7YI0hxxSUzQgw5umi6o9i4y6fBgmI3n5QSwZgELeoFaaQMg0Gwz6vOnnHMF1vnXGAWwnBbG7BHQFsNnmayG4yFJHvROqCSo6RsUjN+HPcXdnv9yoH9mX6pjY1L0FZIpMj/VvblkIkOLWjJeRYK7SwZFZAk8a5aflthshdJXghM+2pSBaBO4ZVacGLzk1I7nklZUfYrCfA4uq9tw2YUsqbChvCW/P9IjH+AJpyyC9HAr9VC3b/ue4xD+b3CYpFmOzZFX2f5BDlVnWP/U03jSM4pN+aYkYzZngjGRXqR5wXNf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780597237; c=relaxed/relaxed;
	bh=cznawapF5vO4PWrDdsZF/fc6qNY58JTcnmMkw1TddjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtkAfasbxX4Nlr5zc7Se3NPuNcv3mCvlWU5/Z0R8J3mANeihfSIfkEGwMbr5YGMnVA5BtKlxup19qzUhNsx8zw0m7iKqTYB5BRn7kL7FrqdQcXunUOYiz0XceEwdWVhDSgK4KLVsXRhCEpi8FOZjFtdYNE82nbTDadxrhiFaEKZa2/uCohYxdSP3MdIs8IdfpL3uoMc/ohQ8gp8p7N/NcWDFUvH7vLaxnexYUU3y6zc6M1Hym/Tb8rdKEfc0fgJTW5GACN4MIDp/6Cq2vBAo7tpESoeu9I8l8/CdBx4kHYHG8xWKAPXodt4YPbkGDXDz3J1ABPYBz8Xjc71N5BWKCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UGz/sfkn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UGz/sfkn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWXtX0FC3z2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 04:20:35 +1000 (AEST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-915906a4becso120866085a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780597233; x=1781202033; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cznawapF5vO4PWrDdsZF/fc6qNY58JTcnmMkw1TddjY=;
        b=UGz/sfkn/GnMn4T1+s0o5VgTLcsY2O4sKe21H3uUyy4Xx2vDcAlhEMIIJ2Lp0rNahK
         IYZG42uUMkzl5tKHiEHKxloQFCOdJ7wEPu7cVwlDbQ5/ZdJuluMTN1JWWHY5xGiNPTHT
         oorlv9mhNlvvm8HKJNPV9+BOriDGiiLthlBndddave3WK8aVJD8YkCODQxW96kDsHrxU
         8XvhYZ6owsnY/a++TM4Ch2EtxJP6769XCZxmS/bUl9pCu9soGNL/3t3qAnmKOcT47IS5
         VsQ/T8oAFLyH7JMR4D0EPNSwKFIT1lKWsJfXhpHgKmN1Hdcj50gKaZVL/9qflT9IKhXx
         RW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597233; x=1781202033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cznawapF5vO4PWrDdsZF/fc6qNY58JTcnmMkw1TddjY=;
        b=X/RuOWdUbjP+YPUkHdn08gIxdByndwmWC7hLZCOLSi8DfO0faJpRTvN91dpKjHYKsX
         7B7hECByjtxT8R9xH8C9+sUYZ7yqwlHuwXy/zXFN6j+mLcvzcmfUP1iVql8ofnMouRiH
         KA1kvjqfAPWBSgQ6lFgx0tr5PL+kz+gEo0VvyHhciJeTlx5ROQ9TQELF8cBrmRofxnLG
         ThsCGXuwxPCzOlMV3sWlV4l/P8Wcj5C3NmqEux9hcnE0xvHN3QxaTjLVd2r6kO00bfE9
         iinPUY/UuJM997ahi0Kid+U769ZR4P7ditKLxpfH7WNfue5qe7HBceFXUErrHHLyAWIj
         FNpA==
X-Forwarded-Encrypted: i=1; AFNElJ/S4Xjlk6sCh3qPr9eOdbEOD17Lf1W0Czb6tcYHhEjmXS1Gkf3+puKC2TaVFoo24q1v61xBjljxqC6Btxs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwK7nAxg4slH7wDR4t3DwlLuH5iwmyxbyjmxmHjJ4VKnWgNd1/3
	GgIu4YILrIVcgqAFLEuhDd583durXt+ORQPmL+Sf/5IhqnNRgMbaoJTBro8jfzWxlVg=
X-Gm-Gg: Acq92OFXgiO+3bcxw+/h8DxfpDTfSmN7zt12tb0EVhsBRltEe81ARY5Ef3yZBTnC8Xs
	JTbLe5eIvZpfI4Wt1oBO+PJgI+sMtuDoScp7HukXDwue2TvbZEYxPOo3MHYNBknMs0VqcHFXb5E
	2QjM9PAao/+YsmiC+KSao+b9MeqwaN5C+/S4i2/BnvP/wFffQ/AgP5vQe0Rb6f4A/24SU8PvQdf
	ucG2+l7nDDd0U1r6yO2VDJMGXUn0GgLtjioQ/df9Vy7IXiPSy2Q3HSs711ZIMEkWEiwsAGZERFu
	EvRxw6GfMWUQb7XOotdKw4CnJnSj0PQ3eaEyELhTfvG+czAUq8m01A4VvQ8PXTh2l1Dw7UTQKlw
	y8G9BnNk8jwG3q/mJWKeqL0pdMvwVH2FqDqkO9+APi9ucKm6WJLRWEjtx1hS7efCNTE6X83Ahq7
	Ldhu2j0GWdFAfGxHNf4dzynZyczmsQnG7DSom6krvDYJznr6mX0f7CP2A4FN5ncdrQLJOQE1CE3
	lcSoWb2AJp4SDf5
X-Received: by 2002:a05:620a:a414:20b0:914:afc1:c66d with SMTP id af79cd13be357-915a9c75c96mr40356185a.11.1780597232897;
        Thu, 04 Jun 2026 11:20:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd051d61sm58430626d6.29.2026.06.04.11.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:20:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wVCgB-00000008erz-2jW4;
	Thu, 04 Jun 2026 15:20:31 -0300
Date: Thu, 4 Jun 2026 15:20:31 -0300
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
Message-ID: <20260604182031.GB2487554@ziepe.ca>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
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
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>

On Thu, Jun 04, 2026 at 08:01:41AM -0700, Dimitri Daskalakis wrote:
> With this patchset core enumarates the SIOV capability and can identify
> SIOV PFs. But there is no central mechanism to allocate/manage SIOV VFs.
> To support device pass through, devices will need to add a vfio-mdev
> driver with IOMMUFD support (or something similar).

There is an enormous amount of missing work to do something useful
with the SIOVr2 stuff. IIRC there is even supposed to be BIOS
components in this plan and there are some missing PCI SIG topics too
IIRC.

So, I'm not sure how much value there is in merging just the cap
discovery without a roadmap for the missing parts..

Also, I'm quite surprised to see this out of the blue, there is an OCP
workstream that was building out a standard that outlines how all the
different components have to act to successfully implement it.  What
is in PCI SIG was just some minor foundational adjustments without any
context on how to form them into a solution.

I think it is extremely premature to merge anything related to SIOV to
the kernel. Join the OCP work stream if you are interested. I think
the general feeling was there is not sufficient interest in the
industry to do this and it has gone quiet.

Jason


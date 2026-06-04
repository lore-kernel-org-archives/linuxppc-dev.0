Return-Path: <linuxppc-dev+bounces-22094-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0F9CD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:26:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlgd5xjfz2xdb;
	Fri, 05 Jun 2026 12:26:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780616961;
	cv=none; b=hmgawLBOcVoZ1DpKRkUQkb1L5g6SPcRnatisGk+OEvR+m4/TUKYS+gwt0DprbIpeSXdpjXDxFImtAoJgzoRLM9I9+1phLAhejebgAROHbwx3vQm6HqGSkjpADmbqePqark2Oy9EbyNqjbVWVL5YUrIljG3WmSxB+EfrpatGHT1CklN5IbW8gZRnKPy8n4r4rDGwzKJeJR8cTfrVwZriY3bSCyLRKHXKrPeiHAglslhiEaBAvqRup4u1/KuZdPbXB49ivedWfGVNF2IjEqMxgz6MJJSOu+TGW4nfIbWKcTvYovgoa/UYg64rRkMrAy4MMGfdIT6O/ZBgffqGSp2bZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780616961; c=relaxed/relaxed;
	bh=FnTnrGN1rDoPr2XWYDmMjIU6l0/cMGNmMp999cHq+3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgG3kgswog1esvBIntumKnpyDG2WdX0ZXy4CtP+8TqV3oiWhj2AS3GyKgDXZ1pfzBdOl0X6FPfo0uJf/38TtQJ9jNs6N9DU31WSofGJTbmJqXTzCqzj8gl6W0bgVwjN4Ffx8MKYwpBT2yUOCyO5OOC8/Ci7rmYzlp3TXUx4j3+AvL+/RXwcH4XDYSd7d77kNy4sGjvvDhIVo8K4mWYIHwdT37CCEbzg0bEp64FUwgVkMl9zlct455uDiOGSYoDoTc11vPOwqCghMSGAUSjsLUMf7tSd/vY3dQU/e4VVglPsRICe4+TVRnVyWNA4JfzfoY43cg3tHVNFnRT0KE66b8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S0zZ0T/1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S0zZ0T/1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWh9r2hfmz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 09:49:19 +1000 (AEST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-7dca5a81be2so12753747b3.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 16:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780616956; x=1781221756; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FnTnrGN1rDoPr2XWYDmMjIU6l0/cMGNmMp999cHq+3Y=;
        b=S0zZ0T/18ddxbaPioYvQSTi+00o/ss57j3DH5zRP3m9WDSOoVHlWUdmctJ9dAvZrjD
         KXmxcTLSN4mS6W4Eos4PH6bgO/cjQrihAhFtuaynXMQhf0HiQb1aTho4IoNUNpV6D+h3
         ilXRbeJy3ZDEb3ySNvggidV25JlCo5NuDaqFUy5exwGXiGibU2nYCpDGT3exvv5H1jgY
         d7eadYWTPuEc+QIqP6vT+QMKZDo4AoAU6HMuFdoCSJq2Tm4Iimzz70f1Xf1LZR9aYVim
         I5NGsxMi910iGtKqk6IjHmCV6JKcuavZXMzSanwxxesk3mPfHlFFPQGpH3wS+uKCNAmG
         2kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780616956; x=1781221756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnTnrGN1rDoPr2XWYDmMjIU6l0/cMGNmMp999cHq+3Y=;
        b=Pyvi1dMJBHfGdHkSlVZZlE8XnPmCEW9lqDa6eyQbP5lLuYiHYWS58tEZI2QKaM+LrV
         Lf2cnNCvpSh3uMEUk6h9EYNmMJqv/GGf/s5EyJ1lj9+Lm/bTa06G1ksYkEXKrO8KShZe
         oVuSjImxihlFhjHFkYWEFsSgKKsnsRFLI7G3fQKmMkZCofF4TygUXrPLjo7Xh+kLsv9h
         Oe+LuQ6H02fTFyWZc1apZXuQjP2YR24Lh4i9RafQiJOHMqQ050vEKuahTx4cp45D/a3O
         hKgjk+pEw3IgMxKhao5+Gso5hrz1DU8P0pBdxk/gmUPGjbOmXfsczYj/KZAbdT+mjrOr
         izsw==
X-Forwarded-Encrypted: i=1; AFNElJ/Jprl35jV3OIDbX2pn0MGC8ABURmnddWZbDrLmT4cCfjy1x588gUFEalp1AVuS7vODE/nmOY85SJ+eD/s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywtdh8AJ7ey+06GXSOUQ63QMeg5JVFyi1L4gV8ddlcoNYiwS32I
	GeSacqiDd1SZzQ1Q/3vQ7q8ZLeLyfdO2NWU0Z1nxgXKEUwAVwznYsgPV
X-Gm-Gg: Acq92OElN49FuQPGne5u8hN/Anf02RQINP99iCdH0UtuzM+VbiodJVbKFGOSeVFirl6
	MHZUGk/SXc7YqiH0KPoDCjU+3KBgTWS9DQwIYdpUYtaY0S49CntjxhLEQHATR2lXZqMvwFQLGWV
	nw3wp6476VaLLMyk9i8tDa72L9OSqIfyG0jR9hTn8fcDXwKxhY0Xpz5xLN7DcaeLIxkUoqd9HZJ
	FdENh5dSMWCDkwvxi1DObRhv9cVWFgLwVObJ3A+b+F634uxBXp2LIEq5+D0p91vhn4ERsxE12sP
	5Xpye70IY39E+zrZsmlT/3mJtx0RcyVu8Cx063hIdaEH7fx4beTNWDrakmyLVwGMK+jRpVSMg3G
	p3eKXntPFTpn6i+9XSu05N16wNmRikCjdF0qvbkcDsTW5QrYBuJhyjBiKz3Zyx8JwvJrcqA64w0
	uN98NgFNHAAabBklZINbzeC5IYtQagE7rOFhlGcr3gQgZ9qH6nBpWXyL9Ynn9Vri9Pfrm82E4GX
	9mfUsXH1OBBR+XL71ilA9MPpR2ZJZdgZXPibfe2vWLn
X-Received: by 2002:a05:690c:c4e6:b0:7ec:5c2c:1d27 with SMTP id 00721157ae682-7ed0afadc30mr12160017b3.15.1780616956146;
        Thu, 04 Jun 2026 16:49:16 -0700 (PDT)
Received: from [192.168.4.45] (76-224-22-216.lightspeed.sntcca.sbcglobal.net. [76.224.22.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23492a24sm42082017b3.27.2026.06.04.16.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 16:49:15 -0700 (PDT)
Message-ID: <a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>
Date: Thu, 4 Jun 2026 16:49:05 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Keith Busch <kbusch@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, Dimitri Daskalakis <daskald@meta.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
 <20260604182031.GB2487554@ziepe.ca>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260604182031.GB2487554@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/4/26 11:20 AM, Jason Gunthorpe wrote:
> On Thu, Jun 04, 2026 at 08:01:41AM -0700, Dimitri Daskalakis wrote:
>> With this patchset core enumarates the SIOV capability and can identify
>> SIOV PFs. But there is no central mechanism to allocate/manage SIOV VFs.
>> To support device pass through, devices will need to add a vfio-mdev
>> driver with IOMMUFD support (or something similar).
> 
> There is an enormous amount of missing work to do something useful
> with the SIOVr2 stuff. IIRC there is even supposed to be BIOS
> components in this plan and there are some missing PCI SIG topics too
> IIRC.
> 
> So, I'm not sure how much value there is in merging just the cap
> discovery without a roadmap for the missing parts..
> 
> Also, I'm quite surprised to see this out of the blue, there is an OCP
> workstream that was building out a standard that outlines how all the
> different components have to act to successfully implement it.  What
> is in PCI SIG was just some minor foundational adjustments without any
> context on how to form them into a solution.
> 
> I think it is extremely premature to merge anything related to SIOV to
> the kernel. Join the OCP work stream if you are interested. I think
> the general feeling was there is not sufficient interest in the
> industry to do this and it has gone quiet.
> 
> Jason

Hey Jason, thanks for the feedback. We (at Meta) are definitely
interested in SIOV-like capabilities for device passthrough to containers.

For those scenarios, having PCIe transactions per RID plus IOMMU
isolation is enough, but I can imagine hypervisors/VMs requiring more
platform support.

I hear you on the broader support story being premature. But on the
other hand, this series unblocks experimentation at the driver level
for basic data path validation.


Return-Path: <linuxppc-dev+bounces-21157-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508ACCD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 13:41:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKbSK75R5z2yF7;
	Tue, 19 May 2026 23:41:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779198113;
	cv=none; b=Lu7IJDbc5YlS41K2kBYq+pY6Co/xJz/OEMNqp8qQMpe4ucls4eUbPCvXslSV24nRXSKAoD8pXi47UMFKVW4zpRqy/oGUzyAVi6OiGaSd0cJ2KiMp9iE/K+ZmnXDGRZefBOKk7F6ZzrYt5u9Ky4P9kcLZlmZzez/Eg1vGEShZs9/GaJKEFf0XfiQnhrAnfp8vru5d1MyzFR2KhOQGv1cjiZgRvzTicCQwfqHAaqPwy3b5EGAS+DCoxfgJd/vHkU64uW3qiIaqln/bZIajanubkLYsEbysIutw63Z913wpEZoaOJ7pyw8BcJx/TKEtwVkRjZCdySjw6fZfx0aW9rj0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779198113; c=relaxed/relaxed;
	bh=b0rbd5r2XPU85ZjN9Z8MDWtjzmRcNTYnxCurh+UMIug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUYWuKgJpUdLAee2BiKHfisdYSxcwXnSVCNhyY+jqQBjlrz57pOTgDKz6UxPHV+W2Hq8Rd/+JVimRTJHFv0HZt20FEEBE3843mXVttdSwjoql6EKSTDpHsfrfdecJIYWlZ/0H3d+ER3E4DWl8CQ2f0QKbCmrcsOVMZ4Mw83tMxe9IeO4tT1guOPvVLYc/qVy77hQ/RiOWQvZRUJmuRPzXcySZzKwHODUC7pLpedBaIqssX1TDd79JkmT5DS1DB6mBfqElwcdeuLchMqHHKozJSSPwn1EqHD2s+2QJKMvp0QG1TZfCwyJxTTtAgDiLFAYvVgMafK5PjsC1Bt+wasFFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ueAS51TP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ueAS51TP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKbSJ2241z2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:41:51 +1000 (AEST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so223a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779198108; x=1779802908; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b0rbd5r2XPU85ZjN9Z8MDWtjzmRcNTYnxCurh+UMIug=;
        b=ueAS51TPilUfjlmWP4iS0LMPZsV4GM9Lz4F6Ua8/kiMjYhHkNok0SNJaUJMYRAr7Hf
         LFj6P/GoUf+4mCB3YRvUZwEQZF9K7pBv3IyeNw4pzWlBJ5KCKx8EAxLVRVpELVHq5O3w
         7pcealWMIge4Fwgicj4sJE+bXjTXW2vt4TuwA+SlHTKTnfAByZojID2+isNJ6JfUdmre
         aHLgKdKxy/V+/XO5l+rJEhSn1wMtid4y3wMH3BdlMZpND0C9gZnyGUKfi7+Y6wFUj3el
         xLvCanFxRZOz46j7hPAKBbPJEsHPuPOoGMrPZNonIgVsn78dsRIYqDIprS4HIASYdABJ
         q63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198108; x=1779802908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0rbd5r2XPU85ZjN9Z8MDWtjzmRcNTYnxCurh+UMIug=;
        b=hqzjZteum5rnMXa1x+qo4dcVPgiL+bRvloXaf85tsGwn5a3y71zdKmRy1NKkFAKoHH
         PLckuMHbtXSyW04fEEhLK22A7plqgHI4LXz1yu94b3q7W6oJDpUwCDhX0JBDxB7BB9zZ
         lTE59CQ9BpX42rVeiW3SAVoiemdPvwHDRk+fVPFSH1c2nIgnGXCddjjAtPYnTm2XRzKX
         sYlVQakTcAEHP0jF3diB+UBZBB+cxye0ZVLO0xUwLeYRZVDln81P4Xf/EAjiZGpJEjWK
         tXA6g9oU8hTlNq+h+nwU/1gAMwUGz/JOq4SI2p69nw8tjB4vVo+3osF7XfwVwWN2PHTm
         bzAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sFTbuaPpMFwRIIGAoFj7fUZp7xxlCq0VMQ3DfBDAfOXoob6YwAtPF/O0OaNlYahzmaf5MJmvpwnmj5cY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8gfa8LhJ0ZqDXaexTnO/6j3TrHIpEVTPwMtCk5oi3tmEzb736
	wIU3Hg0gQrE85N2UzxLko/dnS6S85rT735lxmxQdC49C5h/0ACaCR9yGbruwu7CbJA==
X-Gm-Gg: Acq92OHdT6Xh+deT41t3OhTdr8pJS6Y7t/OfI7XU3cdlJH9W0gfX+AfGWegYMRj5ZXF
	i10U1199moThaxfsqZrAtrfV3H8am7+jF9PCtkPx4wvfxDdASzq+XegWMHM3sWyFkrx5cS6onh4
	e+H0+1j06QghBXKJecIY27Ok8lcfsef49sCsP5E5fnUVe/8pH/VehMJZsL9tfIYKfRHx23hY7yD
	J5buC726sI4rciWBQYJBElZH23ZRc2WBG72tS5v/UWU1q6RL9h8vN2NTAvx7DAvQDAtY392FDhw
	5Qnyyu6Duc6UbZgC8c0INaRAE3XA9CKGO7AipJdLrNa3uenZBICFFtAsvCcv2FHMYsSJxRCqSLI
	MRUdwoZpiTtMGIiE0G8gHCCip0XyA1Utuy4sfwwA5IkL8mXh0mdXa1mAUrCXBc0BQ0Lof89N/Kf
	hiRENVpCPD+5MTl+6kXk8XXV0RabWoONg3UP0Lp9ayVynJDDy42fQKLrZfQevnVTH9zcf8Dbtze
	/U=
X-Received: by 2002:a05:6402:21d3:b0:672:9c8f:910a with SMTP id 4fb4d7f45d1cf-6848a7425fdmr177638a12.8.1779198107616;
        Tue, 19 May 2026 06:41:47 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ded942sm705903166b.36.2026.05.19.06.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:41:46 -0700 (PDT)
Date: Tue, 19 May 2026 13:41:42 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agxolksC_1nfO34X@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
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
In-Reply-To: <20260519132911.GA7702@ziepe.ca>

On Tue, May 19, 2026 at 10:29:11AM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
> > On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> > > >> 
> > > >> What I meant was that we need a generic way to identify a pKVM guest, so
> > > >> that we can use it in the conditional above.
> > > >
> > > > I have this patch, with that I can boot with your series unmodified,
> > > > but I will need to do more testing.
> > > >
> > > 
> > > Thanks, I can add this to the series once you complete the required testing.
> > > 
> > 
> > I am still running more tests, but looking more into it. Setting
> > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> > guest shouldn’t try to decrypt arbitrary memory as it can include
> > sensitive information (for example in case of virtio sub-page
> > allocation) and should strictly rely on the restricted-dma-pool
> > for that.
> 
> ??
> 
> Where does force_dma_unencrypted() cause arbitary memory passed into
> the DMA API to be decrypted? That should never happen???

Sorry, maybe arbitrary is not the right expression again :)
I mean that, with emulated devices that use the DMA-API under pKVM,
they will map memory coming from other layers (VFS, net) through
vitrio-block, virtio-net... These can be smaller than a page, and
using force_dma_unencrypted() will share the whole page.
And as discussed, that leaks sensitive information to the untrusted
host.
I am currently investigating passing iova/phys/size
to force_dma_unencrypted() and then we can share pages inplace only
if possible without leaking extra information.
I am trying to get some performance results first. But the tricky part
is to get the semantics right, I believe in that case those devices
shouldn’t use restricted-dma-pools as those should always force
bouncing. Instead bouncing happens through the default SWIOTLB pool,
if not possible to decrypt in place.

Thanks,
Mostafa

> 
> Jason


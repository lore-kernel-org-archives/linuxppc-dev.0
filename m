Return-Path: <linuxppc-dev+bounces-21167-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DD2CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 14:45:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKct164gwz2yRF;
	Wed, 20 May 2026 00:45:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779201945;
	cv=none; b=QS0OE4z2VJwwLrE/4QSTR2lVHx3hIx0OthGGHQ7ngnAm0+uE//HMsgiLOCg0IFJprXSIPmrRPR0DvlmZdRkO7sL0Nn55FM+jppjGpza1Hr38rjChuL5ne/w8HU2wFM1V0mLzu8q+xLZ3Hd78seE/xvNVbzWE/dM86idLktrUmjXmxMoKB08PjaTjnqXvt2uZUeeht5l4KSPiKZoo8opQrFmTYhcblTNAPoXPPfawKFwFFWiPPrlQbk66GzOZRtqrFLIIRutlkdsHPdR0+Al05fuckSPnQezydsqkoNKe4JXK2bNT33AXZQ8dYuS0C3o/6y43PSg1hhTX8Eng4OQ9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779201945; c=relaxed/relaxed;
	bh=h7Nz6XFDKFDcI1TVcowrB8v0PKJyf/qnRnOMl+2I2pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqsolwMOMh4WE2d6qNMtXPzhB+P4NDXq2P6LUPQQyWojpH0TcxCqYEy6LpbhD9WdIhPmgr6V9Cq7p9Wwtqtw4xHX4UJeD2rGJfWBySZDN3G6qatCZGYEYbPUTyO12xDGCZfEJm7P4Wl9eH8anNFVwRUJqRWcheEISh8V/2bAK82RjcGXjOmhy+Cjwb2l9OMas3rAbvwd7rTQfpHwRgJOQ0wn0URtvCX3d2DZiyE7ZsQZCgO81VpDfx1WyDiFyZl8qwp3HkXFMhE5lrqLMEZMhMOY3Hp1Upwm3LWsX9BFhLgC/rxCbZJiErKS3lSC97AQbr16aw39It4A34t5zZmDRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kYC5z7PY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kYC5z7PY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKct00B1rz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 00:45:43 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso575e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779201940; x=1779806740; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7Nz6XFDKFDcI1TVcowrB8v0PKJyf/qnRnOMl+2I2pU=;
        b=kYC5z7PYRQBSa5zBLIA8Iev0Ic/+Zy3Rwh7CUi2ePO+nByyLvVoprR88SDkqul/mem
         OJQe7Slb0LSuBOUMlYMGO4wHX21kCSh8MRJ1xcM4K83msms8g5EiWfdYjxOWH+hxC8W8
         ATJNSqHAantnsGnB2z15ohJuO59qWZli7K2KBF8UsCj2XX/1TJ57C4EY++t7S7r1oMFF
         8X0Dmiitc+j87ntnC7XVVUgn9HcO3tPjfTjjX327VnJnFfpIR3Izlo2OBopsFZpg3Aoy
         0hlu6BBSt3KciuAGGfshG7ixOasGrtDQstNWSUkfFQjGefEU763GMBthMU1iQ9xLoVAC
         h9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201940; x=1779806740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7Nz6XFDKFDcI1TVcowrB8v0PKJyf/qnRnOMl+2I2pU=;
        b=IOXC8oIAWIxi8o9OOei641Q45zwbWJKT7EYaf93FijMIK0rilyBDEaR+LcbmSYwK/T
         O9isvJQtjliAxx5TDoGxTJnnYCY8OVXTl1sRkh3t4vsQ60q8a1Deaf0YlPP4iJpLhHAv
         2AR6eFhreoq+yHs2wIR3BhPo92pFZOKCrDRqGLhuJYrMVjldw2de4/Vbr+N3nbnkmqQ9
         4X1v2QJNty2i0bIMtDxayjEJup/3xn2MoZlkL0dh2G2rwZZhdk2jcLMyfU3v+yBbAT8b
         y6hfIVaWS5k/OzD+8G8P2q70Ja5Xfk5SU2/40Ch+iSgM9ikd9v3oo4zDlhazU42PLhCR
         tbtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+v4iUWhS9kJp0tRI3MAM8Th7jF42f2UcoLODy0wEKxdrMCpydbg0s0ULqnjqwcbY6+36akoWyEifTMI+c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzSveH92IOGQqa5socxdwDExDmxtgjplFZY14/7L1IcJQsLEI0q
	IRhVf82TBRdtxPOweVrW2U52s2vv5cEuCqEirYPvyPQCAJlQe6qBh5vOmgRWLu9aqA==
X-Gm-Gg: Acq92OGNbZ/ISZSIYAOkbRin2MqymUa562Ux0QLzp0cUDEiK6i8ixEqubgwLSJ59h5Z
	9iekBRvFos4INEaMlYd6MQ2/ugoolP4xH6sfUcaddbQhwPIUkI23IKX9oE7UABMHKIP5loxRkqV
	xI0f969/L7pjg/Mgse+iYBp6Am9QiOPyH8Mm1tSCQqdnw6LDiNCpDdluf3kJEVL+QnM938W/Baa
	RLSuBFR6cAIGtkiss0J8lM3qeEUph7rBh57PQ7pOPohZp6ORFay30RMQQRRhEtrTOBEwxsdqNCm
	Vo0pb054KNZ4mEAabkm5lY9zBSFT8f/d6Rk2ocMjniY0KSRq5DlP9rZxTYi64jFeFRGKBwStBNO
	kLXaobHC7k0kuWPQcNGIe10nUOcti3H3oOLEnHDJVw6cFnFlaInuO15SugIvb2PTVEC0NfJPCb8
	NTJKPxpcu0JNmse79FEvdAoUSNhZ+oqZfwxZyPdPYWRxZBXeG9WgeZMVERd3gr7wOd/sU0HVDTE
	Cw=
X-Received: by 2002:a05:600d:6401:20b0:489:1f6a:4ac0 with SMTP id 5b1f17b1804b1-48ffa0627e7mr3099895e9.0.1779201939945;
        Tue, 19 May 2026 07:45:39 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a178adsm48721081f8f.18.2026.05.19.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:45:39 -0700 (PDT)
Date: Tue, 19 May 2026 14:45:35 +0000
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
Message-ID: <agx3j6Oc8QivZ3RG@google.com>
References: <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <20260519143529.GD7702@ziepe.ca>
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
In-Reply-To: <20260519143529.GD7702@ziepe.ca>

On Tue, May 19, 2026 at 11:35:29AM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 01:41:42PM +0000, Mostafa Saleh wrote:
> > On Tue, May 19, 2026 at 10:29:11AM -0300, Jason Gunthorpe wrote:
> > > On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
> > > > On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> > > > > >> 
> > > > > >> What I meant was that we need a generic way to identify a pKVM guest, so
> > > > > >> that we can use it in the conditional above.
> > > > > >
> > > > > > I have this patch, with that I can boot with your series unmodified,
> > > > > > but I will need to do more testing.
> > > > > >
> > > > > 
> > > > > Thanks, I can add this to the series once you complete the required testing.
> > > > > 
> > > > 
> > > > I am still running more tests, but looking more into it. Setting
> > > > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> > > > guest shouldn’t try to decrypt arbitrary memory as it can include
> > > > sensitive information (for example in case of virtio sub-page
> > > > allocation) and should strictly rely on the restricted-dma-pool
> > > > for that.
> > > 
> > > ??
> > > 
> > > Where does force_dma_unencrypted() cause arbitary memory passed into
> > > the DMA API to be decrypted? That should never happen???
> > 
> > Sorry, maybe arbitrary is not the right expression again :)
> > I mean that, with emulated devices that use the DMA-API under pKVM,
> > they will map memory coming from other layers (VFS, net) through
> > vitrio-block, virtio-net... These can be smaller than a page, and
> > using force_dma_unencrypted() will share the whole page.
> 
> force_dma_unencrypted() should only trigger swiotlb and that never
> memcpy's more than necessary?
> 
> Where does it do otherwise? That sounds like a bug?

Agh, I got confused and thought that it can be triggered from dma_map()
too. I need to figure out why that made pKVM guests boot with broken
restricted-dma-pool then.

However, it should not alway use SWIOTLB? It can trigger decryption for
any memory returned from __dma_direct_alloc_pages() which can come
from alloc_pages_node().

Thanks,
Mostafa


> 
> Jason


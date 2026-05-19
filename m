Return-Path: <linuxppc-dev+bounces-21153-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51ECCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 13:29:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKb9q1Rdkz2xwH;
	Tue, 19 May 2026 23:29:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779197359;
	cv=none; b=E42ewY0jUsL08kCDKZa50XKrJQ/TrKvw1pX5SdHEANW/lizCa8wZ4HMJu6NcQx2KcWiCcl61Cr4rXE/Lzpdo/myS52UrG1f8P7QqGsOjUYBF+XjzLV5aHh7/1xQ5oVSU/W6IVW3/Q1Vy9FmAuXNb075vskwrUNtwlpYJxVhP48AhzGRJOTHSGPvyGmSRlcB+pKIdOntyt8WI0ZhCDlIv4byrtMfhmyryS9IKxXegFgn/ecw66KRe8ThvvVZ3+yFzogfsH48ADpgfhujtaIrqR94HD2gTtC2WmWkiRWw+BfQNQ9jM5PTiUgVdtBuSn5WCOMY4JaNpYjMZQelK7GTUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779197359; c=relaxed/relaxed;
	bh=LrtAP8Eaa/f2vd8w85VzyR8xqf5rOlnG9+YArbfK2NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6mSZNv3HZMAofmF1KQLdNG7pS86uaIq0h9jPh4Eiu34sm+4rArqdMsmTW4LTDYenPWGqF+B8aSoWIkalINZvB1E5undHpbihBJh3JSavLg8rp7BrW9dKQhxtoYvm5ztFbOoYepklXUWBmPCDwuvWufzFWpQTvlFvJ+N/J7lLuukmMiEljI+1BsMm1aWToKI6R1uU+Mi0/OmWDXmZIvLqKfIUsk6QZAcHTTzm0+Nq5KBjR8OlDNiMAIG+FQmAd0d4FeEEcCS4V0EiRk8HzodG7fKKTWqWKPKVLRkY84+SkYvxFey4E5cEtrk1rCxfhgeiKGeUxWEavdvDLgDgR87kA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QuRCo1K6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QuRCo1K6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKb9n206tz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:29:16 +1000 (AEST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-90d1f03238bso437317785a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779197353; x=1779802153; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LrtAP8Eaa/f2vd8w85VzyR8xqf5rOlnG9+YArbfK2NQ=;
        b=QuRCo1K6Os3h8wNFLkdWTdANaBnwpqkhc997+fBCX5jMOlUhYyR4cunY0/iTW41SrE
         cQqYC+Stv+oVgAkdXY5aDjsPP5isEX0IVsizYbggv45UrvQTkEy/klPZ77qrTHpB4A9Q
         0ZqZMiYTvGbg0tiMEef/Kv97GukYQ9Ks0Cmnok50m7pyOZjjb5gAFGNhPf7UTNkjPaE4
         u8swT8ECwuDx3k2uc/iw+Sc22+N9N33cg7f8lqxZIiy6uXg2Fq3ddYvJdRBJuNNSzYhV
         lM4iQvAUNxNXJkG9HAi026Uq7wr9p0WZODgZHaLIFNRChERh5ex0gJUXXyNq0svGb9//
         bJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197353; x=1779802153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrtAP8Eaa/f2vd8w85VzyR8xqf5rOlnG9+YArbfK2NQ=;
        b=MokBCEnPfUQp0g+Z1aazOZPjngD5aRk5EytuqRObzF5NtzbdBo5iS38zEA7VNV4Mb8
         P73Iv/+2TCFLVRm6lX25mrb8puJ8sh4vnxRkxwlfr7IImWigpVlvs3NSSFr9bZDXXRPR
         bCDJNVPU2TWRV6ex9NArc5s58qN1CZBHgjk4VYphO1ryre+N2DtXZfzTGMqsO5nFicNM
         6ZjIKjJj0ldDZ/ohRTP5JUuVAZ7bK18UuoWGZH81UIEUff5sBemnRbySs4TuCCXlXam0
         bGfy1o10fmOIMaDx2J9Gw41tWyfbgV8ZoOGA+sLgWTTkfheXxJTwuYApba/Dm6I1yCF1
         W6yQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zKJvwOfSeO9Nkm1jZmblpWZhmpCmpgu0eBEOlrMfZDaTpa0UHDw16rNammyB4NLeITDBhtX8VC116FUA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyAKqbDJJ+fEcsnW6wP5Y9ze2ASMV8+OZYyfxoBuAKyLn8byGdX
	DgkxcomQ86KZWYA/PUKZQvUQPjZm5+ek3hD5xWB2g0Gz3uLPuMMwXGJkfHLd+N9qgL8=
X-Gm-Gg: Acq92OHHHtjcPmwp1svrms/ZXNRMmrF9w6UPUhaVI8mc53dW3HnWxAe9erXenQjUIEb
	Ziw6WPNJg/FWr0SS+2MPs12r6RZGsI/ZZg6rXVX/DB+Dw0Vz2UcRl5yxZGFycrq+IiHoPiWKNMi
	OyypCijzkKHyhX1kkIwTR9sq3unoGII801Xmbf7LFVk49Ny8tw0Wi5Zcr7YNsHglNdZs9+/69Xc
	KCXyvyjHzpRwAQWQ9i6hxmH/XS7dzDU1OQqQTgCDsq8Jo+xoFFa+j3j9FwiR6HS3MVxU7fdaGlq
	H/tXKoTBcIeQYBuzqhlTsqA0O52AocefO0t6oblg78NBunC7rIiyrbr3EiMOVvoOSA1z+pmggeL
	RYkgRl4p22x7MQU9HDhLm2Awf2e4x3KcTSKjnONXy9D7SvqJyijBQ/VWXGoJ7rAXJXDRi8Q/4io
	jZYo5xTml42AHATvhVwfOTSnZPW4bOqQkl+qNwX6UE1up5CdkQZdpqmoBznRqS/t3VFuHEDCcbK
	nnBPBj4RhEZ0Ji/
X-Received: by 2002:ad4:5ca9:0:b0:8c2:7cc5:b5d5 with SMTP id 6a1803df08f44-8c8fda1ccb0mr344078466d6.17.1779197352561;
        Tue, 19 May 2026 06:29:12 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360979c2sm90678436d6.18.2026.05.19.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:29:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPKVT-0000000EubB-2Vp2;
	Tue, 19 May 2026 10:29:11 -0300
Date: Tue, 19 May 2026 10:29:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
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
Message-ID: <20260519132911.GA7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
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
In-Reply-To: <agxDxdxynp4KEovA@google.com>

On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
> On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> > >> 
> > >> What I meant was that we need a generic way to identify a pKVM guest, so
> > >> that we can use it in the conditional above.
> > >
> > > I have this patch, with that I can boot with your series unmodified,
> > > but I will need to do more testing.
> > >
> > 
> > Thanks, I can add this to the series once you complete the required testing.
> > 
> 
> I am still running more tests, but looking more into it. Setting
> force_dma_unencrypted() to true for pKVM guests is wrong, as the
> guest shouldn’t try to decrypt arbitrary memory as it can include
> sensitive information (for example in case of virtio sub-page
> allocation) and should strictly rely on the restricted-dma-pool
> for that.

??

Where does force_dma_unencrypted() cause arbitary memory passed into
the DMA API to be decrypted? That should never happen???

Jason


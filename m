Return-Path: <linuxppc-dev+bounces-25605-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E0FC5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 15:35:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGpB35w0rz3c78;
	Sat, 08 Aug 2026 01:35:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786116907;
	cv=none; b=MgZgLtAFDBvCbje/Uvh1siqdshmmSxV+F6+qcTB8fQvApRzn5jr7XO+C/F9M9dG0wPjNVCqaU5b/YpJgFT1pyyZwbM7UDcT4Yp9GfEUo/kkWjzJBZLL/wncIicjFECMKKFc+aCQYJfo8sEbQsOmN1hWV/3j60lkUoDjMtBktA6dA500KayK7X4GbSS7laS0+OGyvrsAtdVsGrQ93aWok+iY/Wm8xiSnnZZWqYWZV9MfVTJlt/VxAxEBn3s+RTNopKwfnxyZjM7RWD4cuKaqav7gsvFfjmdYuRrVvExqJQayFszXiJSWXF1SpFaRwPDfZRe5mGZyuL+dzPHdcB+KV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786116907; c=relaxed/relaxed;
	bh=Az5wp+kAsSbtOjG5rv8pQmucG2yE4e6DGCCgwM57rEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCF1MMamxkEBLnOgHF6w2fjKdecdq/IOD5CMQxLnRopSBdeVwT56HKqNqzWrP28xWAb75VwdrpVrWqeYS30G+QIj3bwomrL25dCZRI5XR0noTPsdR1Jg4uQvmhFFam2mldHlXm3Xe7yIfPnI1/kvJJg7NS9JqL9YOQVoMc7rB7uyrNXrmOb9kfFc56FpctbmYj5mD1647z8mGi5snPUdybmakFKWuw7+ALJYbdfckHMWurWNc95eKqqOiXgQN/iK375vT3oHSPnUwLjsKh4FaCqwtzsulP0oOydsZXqF2lPM9wp50X7TQSC8y4ZfHscfFVMbjYleKWU7mVo7QFrAqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UvA4znT+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UvA4znT+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGpB22gc3z3c75
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 01:35:05 +1000 (AEST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-6a17c7c3c6eso10436a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786116897; x=1786721697; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Az5wp+kAsSbtOjG5rv8pQmucG2yE4e6DGCCgwM57rEM=;
        b=UvA4znT+1PVO/Tkxc1BZX+3eVHGBvRqeJpb5GydgMB9qIh/gkchsvyoD1QRaWgCViQ
         y2a7S/ahC752U9JKVAeACM9nYeLW/5gOb1pUtPoyQUySLwDNU8KvUocvm9uFDqf5+LNW
         p0soXOVCKEsf7HSwVX9yY1DynXTJD5D2IsAyzG5jzjjcIaN2Iv7ru3sKNHx4w3bPJ5kV
         OZSHMzQVlOCEH7W35H65NGLinTHkzpoQko62VhDLaz0wkJIc2+Y4og1aEDmvH8Oc+AOY
         mILBa4TcZ6u2ukrE+bJTPv9gs/pJMFmTr3K1ON2Jk1JNAZtdoyoc4PdJ9Lbr2Jyuuic5
         YlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786116897; x=1786721697;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Az5wp+kAsSbtOjG5rv8pQmucG2yE4e6DGCCgwM57rEM=;
        b=JhmF59CfK3aG/ONmP3+C4OmBPv4AGve5ay3tVf8QUrhsKB1epdf2V6PY9c7Z6TpyO0
         R+8Yl1o6KE/MPsQLRFUtiXkU+LmxlgyCwqkS/9wwBv9anivJxMMjyxDuN9+3d/SeSEpM
         GjeHWMyL9I8gjGpOYMjAkFlqsDpNTTKkryzpliYnJRXWKJpaGvVHH2PrVCdaLyijvXGI
         1OCru94xlCrJvBekJ/q073GGh/HmA/L/NXwEa+5RTOSUrxf7SH/nMRP9I93oVcewDKWX
         elDkAdmKzyprslEUEArwgA7Odr5VZkie9MPnd3zZqmBeRpD2z/XwY9rjqORBqEjgPK3T
         rBig==
X-Forwarded-Encrypted: i=1; AHgh+Rr8WfLdRMW9K1JFzGNu6Q9loQGALapPTAbxOKNT/R0xtbz/eMPdNBlHRm5ZwIXlX0CkgoWLbgb8RH9PNGQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyO1qE6OR2T47BLp9l8d9bdHoOJAmw1VOMq03ClFEZjupbOztHq
	fdQVX4YhoxWwgh/9Y/Nr+JbbiR/EzWMivdMrmugGMDgdxEcxartB1NTr0hdxYkwDkg==
X-Gm-Gg: AR+sD12b8NGwhKI6OnbB4n0Q+1VljiKI3djL2qfKZNUTWZKYPYylxFF4ci8lqhSOuRh
	jUte3lPnFc74Boi7Harg9oX43RgTGyCbw4Yih+Xvh26AN0iOVd2d/Avi3xpbkYH+KUolvy5Y5BN
	9MvxJV53IPDJqBYovef4qI15ZvLLC9MIImfgICTyJib/bMIigWHKDcY8cidIIJDAnC1w1JqObwZ
	lpeDjTsl7LluYqkahyOejzwfr7R29NORZ1cj+ilNRSv2pwj9leyvrf08nf/IWs65gqsO69ssmAL
	uPiHapsNzRCzgOB2SZx0RLNQSJag63dZA+ZjESv4PjA2xNBfLzzlyeXkujHZIK5flcnOOTuKozb
	aLF/tsttHxgU1SEYzMlXdclicgF7JVsQxgJ2pznG1/nxqNoxAzJogMV9mC3+ApMTtsBAo9SV2iV
	dozjMh/USnYokl8DtZ9WR86ZKZuHY48donQRA0hsSZWIYFKAD3wTgNth0cuGSeV29ASRCFnm0CS
	p8RAcVZhxW5ldFcukH8zfSD/T8CsQ==
X-Received: by 2002:a05:6402:65a:b0:6a1:f088:9486 with SMTP id 4fb4d7f45d1cf-6a1f088972amr16113a12.4.1786116896722;
        Fri, 07 Aug 2026 08:34:56 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7d48f8dsm708475a12.17.2026.08.07.08.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:34:55 -0700 (PDT)
Date: Fri, 7 Aug 2026 15:34:47 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
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
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <anX7F7dnKOtAOIIe@google.com>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
 <20260807135810.GA200537@ziepe.ca>
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
In-Reply-To: <20260807135810.GA200537@ziepe.ca>

On Fri, Aug 07, 2026 at 10:58:10AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:
> 
> > > I was under the impression that there is a possibility of using swiotlb
> > > instead of restricted-dma-pool with pKVM.
> > 
> > Yes, that patch enables swiotlb as a possibility for protected guests
> > but with your patch we avoid shrinking the swiotlb buffer even when
> > restricted dma pools are being used and that's a waste of memory.
> 
> I also thought we switched pkvm to use CC-like swiotlb as part of the
> alignment in this rework? Mostafa ?

Yes, now protected VMs can use the SWIOTLB for bouncing. However for
Android (and kvmtool), use restricted DMA. so SWIOTLB is not used.

However, I do not think we should over engineer this in the code,
swiotlb can be set from the cmdline and now through Kconfig also.

Thanks,
Mostafa

> 
> > > If that is not the case, then we could change:
> > > 
> > > !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> > > 
> > > to
> > > 
> > > !is_realm_world() &&
> > 
> > Perhaps, or you could just pass the swiotlb= option if the defaults don't
> > work for you. Can you give more details about the slots exhaustion you're
> > seeing under CCA?
> 
> We see badness with swiotlb too, it basically doesn't work out of the
> box if you have to use it 100% for real devices. It easily runs out
> of memory.
> 
> Auto tuning to higher levels makes sense to me, but I'd rather the
> core code handled adjusting its size to the estimated need, not arch
> code.
> 
> Jason


Return-Path: <linuxppc-dev+bounces-22348-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722CDCD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:15:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZWCl4mj3z2ySf;
	Wed, 10 Jun 2026 00:15:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f34"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781014547;
	cv=none; b=cCqAfaNxHrcZxJ83kwSKZ0hmjHl6Ql4ZEazwqfKB/q4qmdB6Tm5XClJz7lFgqd53G54+3jaMpZD06T62QZrus2F6zIvTonwzHNr8epkz4kAEe9cX+XTBYmGlhqIYlkBRseOmTNpRKXtfBfcup8MYaQwVxyC0xZ6AoWzXB9+mB1HdyrgKFA+R8SK/MQ8h2KbmV0Lw5OR8HJ68AnrYfxP61TeG4MzZtic+4KJh1SoVzYpP/nMXo4Ds8jel++dqwX8PtsvyROsT44cSDsCmta92nKMaLP75ZP9NN1OpmG8Tyuii93kYBpAfBrpPpAgVujssLeypsw3WIw0vti1qVBAFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781014547; c=relaxed/relaxed;
	bh=/t/KVtkqwokTt2oNchcdf4xUUArUEApR4RsM4t4GGaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKmYeHqRTj4ephqHtJdvLLDRMar9KT00x9mFIy9BwAqMA9C56Do3a6t8CxsxGlYrwDRDX3Ui8il6HuIK/tYM+Gey9l9/Nk4HwSaG0n2nPKkC/wSmnArtf55WEYfgS/1E86dR7QB8JRfR5/hPgA0KkozmmbwyctDnBxa1vAf/R2R7IH8jTH3aq3I3476WHLhuxCIMcSoFDNoe1j2O6UEvukR8W/OvbICZC4kji6p2BHSfg+ZvQ82Z2f4662Xbk+xK64AlUicTMTGIC/0EaU5qxlwbKPUbaLsWt3r8yZ/JATGNlaYj/o0UEjibWY6xhVr6BUan0BHCMOu7LnD4klhWMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Rp2gLyvw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Rp2gLyvw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZWCk1j4Nz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 00:15:45 +1000 (AEST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-8ce9df31130so87734656d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781014543; x=1781619343; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/t/KVtkqwokTt2oNchcdf4xUUArUEApR4RsM4t4GGaI=;
        b=Rp2gLyvwBQKzpvnMX0oV6Tfa7pAHXrtsCRN5FecGa6lTLzZ7W64y+HLWAyDSuVhk7Z
         9ExpDhcLz6zay3t8tUIzvdgsUdBDGhMPo3VyvJGPVwyXX6wNbahu++1K+DDzEy2J1lIl
         HJIz++WkutFxZA/PfTKPcki4UQwWSAHhuOkh7PFwh/fNWe7ue7LwLOSKvKrB/vnunamT
         12ULp1//jWR/aaD3hwznSifew1pq9o8hLfr8N6nAwmD9Xyb9NmCA0qWePnyTxah49f2E
         Nce6t5i/LZ3D+ASCmWlKB3KG12lviXqDtshEQi3MwoTZh/LnnT7M5+ZmWwVAbLc5odu1
         7WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014543; x=1781619343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t/KVtkqwokTt2oNchcdf4xUUArUEApR4RsM4t4GGaI=;
        b=EhNe0GDiaIqAWZSo77LAdv36YkxyJcBdsr9MxCzOfOoo8dpt6bwBbjqniUDIUOxjFh
         +hPWUPg1eks2qEALDGjc/2W4aQE7C+rDwZxd8D40rQgT709OHAthzPZ+TA0LNy/nzphS
         u2qGhVHkHK52qjPm6ax5mm4MU2/YdDLjoCXyMtHOpMUR3DZSNCM76KAgC04zvSTAiJCj
         eeI0nXOuXt0N1E0jF7XodOOb2lcrdHi93fwck/UdYFnKiMRWG0YCYzy+tols/R5ao4rf
         jzGQy3PYLCpzFLjkCY4xsNBz5x+8qwdYpEzXvsPAygjSFdtFe8YjOTmp++LzpHd+3pOA
         oXww==
X-Forwarded-Encrypted: i=1; AFNElJ9o0TSwThoP68IEoYXLrpj0YzB3JC3ROZojBuEyGNyZcTe8pBtAQvqKDFTbrJaPQEZ4bdbrfIK6nPHXTMs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy6nWAdLiCarPvwjq2RDaX2EySsmC0AHuhG8dLnbdZHl09iWWa4
	AJGrN/BfQCa1XUYcJwynurJcbe5unHDvEX+hGEXvpKG65br++Z97QDpsXwczH66Uchk=
X-Gm-Gg: Acq92OF/ubSMe+jcZn1IaNjtXfzaPsRpDKa6RP/hrkbDv+aeDge4EVXozm7z222Vx4O
	vtHWugkmFCOLB5rEJ3QvWXWWdD/nEe1An6Bbttawyp1RWpfZly8JQZWz11fvT/sbKqFZdiNsf1X
	upY97yfChkjeGlGH3uR/YtNVG2VysEXAIyrlRxJrvhK4wTSMKFrpIizK9FXJHOISCKHQIAe4A8a
	Z2wJuTQYGS/PU/1ogW2h7F++ATmhxusI99UtuIFTpO1ujnN7j4egqob75+O2CSYpXUTITC3YzOK
	F63Vb9/gqFsFTkIzAg/Eq9FLT9d2vlCXT47wM6g4WoHain/ZIZJ5qVPRZJg4y9gwxgLBQoRwNOA
	3jdYTnrQay47JD08NxOn2VT/StndQy4+4y9kJegeC5Xca07+ODhg7OpBpDQPTuJ1xODAybu0nZ/
	pSF2wKGz/jBQ4/UmmMDityKyFPmEs68TKWUFt/uHNWOm3878Sq/WJTux5AqIRAXkPJfMqarbZ6f
	4u9/RiJ79kOWTJa
X-Received: by 2002:a05:6214:626:b0:8ce:ba04:7bc2 with SMTP id 6a1803df08f44-8cee626f0eamr293032506d6.38.1781014535341;
        Tue, 09 Jun 2026 07:15:35 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd077be8sm204702746d6.40.2026.06.09.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:15:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWxEs-000000021xL-0mOX;
	Tue, 09 Jun 2026 11:15:34 -0300
Date: Tue, 9 Jun 2026 11:15:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 14/20] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <20260609141534.GJ2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-15-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260604083959.1265923-15-aneesh.kumar@kernel.org>

On Thu, Jun 04, 2026 at 02:09:53PM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -270,9 +270,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
>  	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
> -	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> -						  gfp, attrs);
> +	    dma_direct_use_pool(dev, gfp)) {
> +		page = dma_direct_alloc_from_pool(dev, size,
> +					dma_handle, &cpu_addr,
> +					gfp, attrs);
> +		return page ? cpu_addr : NULL;
> +	}

You should probably put this at the start of the series so it can be
backported

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

To Petr's question I think this just shows nobody is really stressing
the PCI dma paths on CC VMs today.

	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);

For instance the places even calling dma_alloc_pages() don't look like
things people would use in a CC VM.

Jason


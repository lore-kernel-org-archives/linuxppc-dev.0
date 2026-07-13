Return-Path: <linuxppc-dev+bounces-24126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225EEC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 17:54:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzVSb28JKz2yfD;
	Tue, 14 Jul 2026 03:54:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::736"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783965279;
	cv=none; b=e6OquWIE+BjdYNnOBzTkuh/5mBPaXgKG6wlkltr6EJXZaijqYih/jDw2DeI17arSa7Rtsjiz/R+0K2bQlOvfZMJP3svt4595fKBTrKYHlTG5nJ1rjvQMGdOJTpgFnF1cqvdfGCQIzBrYlYvkpJd4uTLjc8vwrq/xFa4HH2ZYcvdm4NiUglQf0Z3lv/5dCG6i4Ay98kATV5spXeCllRDDvnLFFe6ixCmM8kBU0N7mLg6jWeH3IfDYALH1lebaMhjC5aOVqtxGcqlFOz9abQBgBlldzcZzbrB5oirdE5jbxwwkB/fXQc7iFzqpN391izIUWVDdsPK/nVMkmmIGn8Whag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783965279; c=relaxed/relaxed;
	bh=Yflr35iQtozkrKsWPSXMB3haiCYqPE+VDxf/660hH9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6cWryOukDbG4Tn8v7ITkv80zr40HsAfxKCA7+xutp5Jz/3+d4n667fYOzBo5UzjTT+Xmio+x5+ugCqLzzEOE8WkNierr1FlUAIvb3K9S48PckpfFKCwpb5nszEhxYXvd1NiF4Wjxg57FSEL/w14h9tXtQMzzU31swPTbiT8O+ml8lkypyv+R0AAulL5vMSQlaxIcN+Cic9LQGjUKtAhf5/ZNpC6TGYOlqzHpkfOipgjzYUVsylhRpL6ajhjgudswUn1igPn3RrXe+O+3AxvUe5nE3QiG/gdQuX3qaIWr2pqiHwxkceWM0zwwXCe37JBhUehnIE5CnNLJvw+WoHhjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=k2B4su4w; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=k2B4su4w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzVSZ1r2sz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 03:54:37 +1000 (AEST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-92e50979c71so338136085a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783965275; x=1784570075; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yflr35iQtozkrKsWPSXMB3haiCYqPE+VDxf/660hH9k=;
        b=k2B4su4whF+xVEfprbscEwcIrtBSheYVKDOwd8IkwJL2Cpgi+Osl3M9LyfJ3qk6Fql
         BpQM+R1uykZ+9cphjQH3oFSlgAp/dX00Jlfl2tca5RKQG/+1yWLCuIw4H7N4v5lDi2jv
         yO4kFUdlh20YcZ3YyE1iIBLh9eVRUvTMzztgnmhAbj+Fguo61vRQwyCUyohusOHuc0fT
         CWiFNP3MVqsYsjx010eAeaOqDo8ZQXy1JPMjXXLSVmT2gW76KJQrHNkkijN/GYazLWW/
         tdV/HrirtJTlEvjrhgh4zTdRttYIFENeGxT3tg6MKmt7LpwpzMYuDJgAhXzgho7hVFtS
         ZpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965275; x=1784570075;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yflr35iQtozkrKsWPSXMB3haiCYqPE+VDxf/660hH9k=;
        b=NUTW8MTSQ+rw0SGw9Vx7EZeknPZmVq2clKg8bDVM+en6np04yOSvAKoytsEhR3Ro7r
         d6AUWmYrQQOM+5RcXt0v29zk3Mt3y9/FWT6+E2NDUZYLrk7//pSgGjfL3YJ4WHiMYsP1
         pS6gCCquFQDCZXpBYBZEhKxm2KanqZqEDKx9Uh1drVAXwd7/0fWxs3DyoqSf8Tx3kMg2
         ZYkaVDmHkOMbOxDDsfmQNvmolJjdo4mXqZ8XDa0NPJCR4gXVnFS2tmIC4C9xbzVxfRwj
         9Knq+REKruoGY9htQfIXKTG7uhp0TSKpB9zo8ue93mqgyrIMOf01UelCpeBdHoVANEZ4
         TnRw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+SNy0YnQV0ZZT3AXzG6QS0IKQ71LhnuSJA9HxfXbYnoraTzRxOI/MN2lG0EAsReGVyAMTYFEMCnGotuk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy/MwPMPFO/8U0G8A3q0ta9istp+ycH0VgsckvMlBHvTZJjnDWB
	NJjUWlzjh+jSfOQfK5BuaniAiF1q2sLc5aubeGrqFi2SjW7igb3mP/4fYci/CLQ5koc=
X-Gm-Gg: AfdE7ck4oc0KjFuJh/bsFLYfk2ofGnCLeWOAPnKZJX9fetc28LT3TXTwY6LUYiuR1O7
	R0dUjJt0JzHMvIkxzGjfIpXQ3aObgLsnwnT+wwuA82e0n73VaaO2vEqE489kwZ7dW/QVdTCW92D
	BVx6RFHVzxDH98CjdI/LAmPX0h8HmjRxpBKUZWUx4n9iPAq5MNDIp/bXrbdiuxqbJXyp/o658Qi
	8espBA6wN+ADym73zOjj42jkmaVvoo3v6tbG/IJO2Kfggf2BYzqocBdiRoMeHe/ExqvEiShMCMg
	9Z3HZiNTTrfu7WdOYoXYFVxe75nk+8mERWKVa7jH4nhYUOSGuGmFQtvH2/6XMS/n24fyq4bmFWN
	563WU/Y7NfUo/htAS1+ZTYsIz6cvzPCU23yBAqSIPZ0kjCGGI2uSLhZ2yXLdy
X-Received: by 2002:a05:620a:469e:b0:915:94f7:55df with SMTP id af79cd13be357-92ef2bd609cmr983527785a.20.1783965274729;
        Mon, 13 Jul 2026 10:54:34 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfdf6fsm1229104285a.24.2026.07.13.10.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:54:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjKrR-0000000DwzJ-2as1;
	Mon, 13 Jul 2026 14:54:33 -0300
Date: Mon, 13 Jul 2026 14:54:33 -0300
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
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 02/22] dma-pool: fix page leak in atomic_pool_expand()
 cleanup
Message-ID: <20260713175433.GI3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-3-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-3-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:06AM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	 */
>  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>  				   1 << order);
> -	if (ret)
> +	if (ret) {
> +		leak_pages = true;
>  		goto remove_mapping;
> +	}

Truely these _set_memory_decrypted() things are an insane API. So a if
it fails to decrypt it can be in any messy state?

> @@ -130,14 +133,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  				   1 << order);
>  	if (WARN_ON_ONCE(ret)) {
>  		/* Decrypt succeeded but encrypt failed, purposely leak */
> -		goto out;
> +		leak_pages = true;

At least this one makes some sense..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason


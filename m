Return-Path: <linuxppc-dev+bounces-28506-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC58FCA5FAC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 15:58:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvNBT6NhYz30WJ;
	Wed, 30 Sep 2026 01:58:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790697505;
	cv=none; b=KMw5xJ91RW6VnqcFIpzfsx6HU44+BF1lBm2YAYVfNkdxUtOAxA3qiswher9HEeaWprb+Ar4EQxrhGSKK8gWO9iibKBKaCE78dF9GCshHb9Dvm8XtJWXTn+9vVfbIt2NZzbJWmM/WPSoixjS1dLCox7kMlMeh/TohlnJjYC2TvPg0ppX3Xye5q22diL7xuVzGn1ptfqwgTC5znJAbevRXMiHxCj2+NFeMygkOeqYLiiHQ2bCAe0ClHkxlh1/hNhGfUz96Bgw8/Rx905fx6/dr3JvdEDQVxidyJ1J53PqJVtNijzXtnKNrc100gL1IULwElafOuMSwTrbKwNiZnn9yvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790697505; c=relaxed/relaxed;
	bh=Gf4CL38l7K7zHB2Jr75kV3VIF1+DE+Av3C/FhqhlLqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIFwohFacufR+kgjwZgPBLsysAZ7GzYcC1hDGNMagXw3/N+Zx/2HFw5Bb7hi7k4n8whOuxq1osGlOF3Vx++CsFabqIpDFAcrXGox7M8K/MI2eMVxj2mv/3wARvIpqEtHxnDrKSyMmvAcD8PImd+1nqYpaZkuOY3dRQHKxKxbikmdhmq0CxaJUqBEymiVC06qkPF/Pw7tKcoFcgWaZAinhAf8hT2Ac39AXAQsKdCKNQvFFZcJoXGGl2IKckg4iKF/7Ypi2/skvm+m6AfFkukBri58GXu0iEra8kDo5JkKt37IWuKXoE+1RFf4I2nXUm9UwLsiZfBgOuXdh+RE+6/5Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net; dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=YCU35Bd8; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org) smtp.mailfrom=gourry.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=YCU35Bd8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gourry.net (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvNBR6SYBz30WF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 01:58:22 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49b912d391aso33281465e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790697499; x=1791302299; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gf4CL38l7K7zHB2Jr75kV3VIF1+DE+Av3C/FhqhlLqk=;
        b=YCU35Bd8GTq3jwkK0bzxrrqo2JnDMTtLDOFOvOcXbt2jRTSGjhUlWoFx8CP309LCtl
         uY3dyyaf3vPnluvynWItviXT1MrrQHfVmcXsBaGOIEQRvuATF6leh1/TdwcfW2deeM3C
         udxEo2R/V3N8agNSS/H+SFdfHZmK51rTxCstaH1Jk3hhyOvyqYf/1tJZJES8KOMR6Y/a
         Iz6e6lkhyxErZFYPrtDblLq49/WgVJcw7nseE5d2FvPQfGlBMiNKVk9mXdcKxYQKL94z
         +moaqVn98ZrodRgeAmSw6zWEaxDKorl1cKgFwlRcUIdl4R5iP84vG7l8+gbXR6awjrQm
         J9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697499; x=1791302299;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gf4CL38l7K7zHB2Jr75kV3VIF1+DE+Av3C/FhqhlLqk=;
        b=hP9HbuAUYeiOs2DuoNFjXb30pPPXAnl6NWlkB9cICxyxQ6NiqRpElH63CF2oRBiuJ0
         Rix4LPt8ETSp/W9mjBH617HYl5aDwC0+bOR0ReTbNiZQ+Kqyflja3nI/zk9UBMnNmrNK
         iZ5qxOi3n8XS8a6qGn50PyQo5zRGmvKDRnUVK49wOXiO9rbshZiNPydtTsKrjTn0gKUq
         9crNKVTftWipE2dxCAPLY8Svsy1aW3hd+F9PmaLrHHW4c7DHvizRPrNSHybe45yQPNud
         AmlPZmZY2tTe8txFDSqVWIHWB1+PgYyiN2QLaAclTw6QxcW8ZPsAmkCUufbv594FrPaq
         79rA==
X-Forwarded-Encrypted: i=1; AKwUvBxgL3x/P39MjjUkzRs7YtOimTnd/YgUy3pFyRCjt7neCvtTMxKHx5tzDWTlgJ+CC7RcdIHJx5zuCiMm5Os=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mtjVyh+3vcleyyqByQWT5hhxjxnGqUqVlaR0kfhwbhhRiOMRxR
	iE9Q+zpPBssnZiYJxdm7u0LxsZI0BzNmG/RpnVd2F0j6v6a15sBekZBQBNb1EXruHJU=
X-Gm-Gg: AYBFou2TYZINDBJJFcKBLiTUnBV2pzAsjZZaUIQCW8b2P3Uro+6+UU4+vnOJUrwM4lT
	bPpZwCHzjnqCBOpc39N9wxVEuyQpJa3UEOWohF7gD7Km+VRuArynHKXHA3RfLfJjNbxDgisBbRI
	hNnFpzYhrBk53R96sqz1feUC7kTdcC3O6yS9Jc//wHKFBkoUMPZ6rMqa/tGzkP14Ll4HBaCwoJx
	sBdmtMfnnZ4JbJ8ZFf/eQ43UPbj4UsQ8fkvwW+wChtHOjWoBzRdXliPxWEmOUrxJ1Bya+01/SS3
	AQ0Z6It29xV4PYaFT2rzH9EbmcZyXjrjVPYVi7waGrRO0dO3LKmV5VBlFIFIs4JRJZnTiG1+lqP
	Y6Lk0fzcQh2BDnWXyLFiI3vgREeXDrLREw/GJhs34GS70NEbepS/vpUyw9oRA4edip4VETMf3S6
	M0b3gpBnppm24za5CioPhz1gIqYOwZhdn8w4LYl+JGku2QiI1mPIsOyu7Jry8lqgLIh9RU7CCra
	NNG
X-Received: by 2002:a05:600c:1d1c:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49fe66c9ae3mr284330975e9.3.1790697499193;
        Tue, 29 Sep 2026 08:58:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:5c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9dfdbsm127631095e9.1.2026.09.29.08.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:58:18 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:58:16 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 06/40] mm: make map_kernel_pages_[prepare,complete]
 internal and unexported
Message-ID: <arvf-dEnIzsXhzkL@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-6-4583d8a23bca@kernel.org>
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
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-6-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:15PM +0100, Lorenzo Stoakes (ARM) wrote:
> There's no reason to export the symbols for these functions which are only
> called from internal mm logic, additionally there's no reason for them to
> be declared in mm.h.
> 
> This patch therefore removes the exports and moves the declarations to
> mm/internal.h.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>



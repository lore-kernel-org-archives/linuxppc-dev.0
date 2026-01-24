Return-Path: <linuxppc-dev+bounces-16273-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E364D715E3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Jan 2026 10:47:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dys2G5jyMz2xqj;
	Sat, 24 Jan 2026 21:47:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::443"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769251654;
	cv=none; b=Ksf3MrE++RjLpkLEMSL82oMxBOvQ5hb3EtoLG57PlXPQRWD3CFVEK+OQtN6YKkf/vOaaDPWNFWsmJbOwoXQnKZxIvssz/jWwsr40d6azb5KBZqTnLnpXHkU0GJkdFzTZox3kjxthSHBunAZQHsycZmznkSILysO1rSEnG9kdJ4vuJQX2hftCHksYZAd6A5AiEIjSiLJr14pbpEk0fb6O1SsyrfPTDk3ox/Hi9A6tdW91AdvoXXIXHOFcm9DgAk3CXGkikuT3GBXtj8bBrIO+mNDG6GVzUk8+yzv8nTTv1I7t8P4ximWDLJnJg44DCsjRIvMVyjaEVifAKJstyQ/K6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769251654; c=relaxed/relaxed;
	bh=PDUcuGLtSATdOwWmJYbA7S8LzZRTPKGXoW+hiKHosIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJzWe+wGEi+sYz+lnmfsLvtc5m8UH4C0jo2khjSkSCQSastQ4HXlgRkiYsOfnUSVIoKEzniLuNF1hXxQtYCr5OEue+KgCiUJC76fq5sf9DumVqcvmemlIaeKJFTtrIv0m7tdfchHBOHltZTGsLHMem87sqRqSNajiP8s2GaLY/7cBaM+EYjiKxl++mvJpbNq9GQ+Mw1Ozp11MoOIZnkHTOwHvZPWw/3BWVCLUBi7aQytzUq566PgrludCnrnHLeJR6WrcHQo4V1lTWmjtkV+Ms1QCow0imAQ4Z67Q7Q4DhuSvdDGcpGpZBG0rWD+VK7lm8PXU0RKA2Nfy/RDtVz6pA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gjwkh5L0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com; envelope-from=dan.carpenter@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gjwkh5L0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com; envelope-from=dan.carpenter@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dys2D5clzz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jan 2026 21:47:32 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id ffacd0b85a97d-42fbc544b09so2241594f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jan 2026 02:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769251648; x=1769856448; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDUcuGLtSATdOwWmJYbA7S8LzZRTPKGXoW+hiKHosIk=;
        b=gjwkh5L0t0BYignI3BJd8CQMbSJ5Rfa1JwCxcHmDyKCBu0lPX9fsRyxZyR77KvC8bj
         yVEEdbaxZtyYiuGh7bTaw2pjiGYaN9QLhQd4tdH6JojsZh9ydreu9pjfqGJzCdrNt+fA
         G0EhBOPSLFc2SL6apy9UxoKFPUy3DSxXF+lgy26iqESageDObzfYydCtGDzffi8yJGcd
         PNLKdhagNKi4x+xwHucYHUHf5ArmBuA745n746un6dZzsi40XP7ioofwp4gAJNbaTA0l
         yG6vJJXA2WN5k9zTNnYqHQuBgxVuAj0ue0IBlKBgvPdubYicTR23ZlUKeBTkee5+XpPV
         spjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769251648; x=1769856448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDUcuGLtSATdOwWmJYbA7S8LzZRTPKGXoW+hiKHosIk=;
        b=FFYuGCblwF8r4YCZGoYb815A+SURciiLRcZphd8kf0L1UdvYsrYwP+oj5fVeB/S8g+
         YGa89wQgNsv1JxdE6RTTb5oPu2byBbcqyyEyu3xUPXulntkASuIlliWlP+wWxxPkuflV
         CIUMDNcDhhVzaK1apxd4f0/3XiEs278nSUA7QmgSdJaVvr43EGH2jf3/9bkV21gI4oOa
         3j3EED43jl1OpA52v+Wi2FoC65bVsMfSkwWzUQpA4I6zA1Z+kExiYSevhiyyaHtUn6Sd
         rZn1Sc9E5n+n58O3McjPNpiPgwbJHDIdQIBN4qHhn77pdLBX6wFn7SdoZMgZWbl/bXF2
         IY2A==
X-Forwarded-Encrypted: i=1; AJvYcCXGJ3mk7DxF9umyKeEIDufOqNHQY74VN9OsyZDVW814vT5wxz7i2BUHS4ju/9ABI+xZXUk23P27FBgVMLQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyx/dkCdjgBZdvzMilxPSj++QBSdrUF2jm9GMfMAcvHeZ599wa/
	MF20DBVNFhqv4tPqtHAVnNiBV8Rtt+7On2W/FtKWn50i9UZLA1RHzvcaTFP3IqCihEU=
X-Gm-Gg: AZuq6aKi5iAEu/TCbpNRt2LLkBuveAVaIpz7LIc/wt/+WD7XJqcLKbNUEEuwyt/PIhg
	HhKPhf5n2xJqEWjGu03SJKrEGFwpg6ZHHWCELhoO3C+Rsbm/KwpBiapUjCwS9ifZgWeZLmSzUCj
	C3zYesT5XdFH9oPPqyjo3EsI7MjcuKsy+H6bWmq4dRT4Rb59nUccbHei4EJzhPRHTDxJSIFi7ke
	vs/Xdh0PTuxhWldtyUMeEy4qRGQMbxq+9PuO6AyRKNZS4Vx0xC5eo2Oqw9pT559Aa8wUn5eqXGT
	6jbYTtSsBNeeOKG+Jywq0M9PxLYJPfwLduzpoOLOJi+GPE4VSkXY8Ey21gRFxk9Q5eLUUzTfUMy
	ASgnojGDQQt4HLXZyxOYsOjbG4Ctltt5lOXkkfxU5hrrhgPN3TYEIe1Uca1QQEjcMyt7A4XQLzn
	ZeAwuB5B6sSqO6yVXLUJNN4CyVCAQ=
X-Received: by 2002:a05:6000:40dd:b0:435:a2f8:1515 with SMTP id ffacd0b85a97d-435b1587983mr9884751f8f.10.1769251647634;
        Sat, 24 Jan 2026 02:47:27 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e7156dsm13469488f8f.20.2026.01.24.02.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 02:47:27 -0800 (PST)
Date: Sat, 24 Jan 2026 13:47:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: ioana.ciornei@nxp.com, stuart.yoder@freescale.com, agraf@suse.de,
	German.Rivera@freescale.com, gregkh@linuxfoundation.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Su Hui <suhui@nfschina.com>,
	Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH v3] bus: fsl-mc: fix an error handling in
 fsl_mc_device_add()
Message-ID: <aXSjPNWzsEPhYhv6@stanley.mountain>
References: <20260124102054.1613093-1-lihaoxiang@isrc.iscas.ac.cn>
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
In-Reply-To: <20260124102054.1613093-1-lihaoxiang@isrc.iscas.ac.cn>

On Sat, Jan 24, 2026 at 06:20:54PM +0800, Haoxiang Li wrote:
> In fsl_mc_device_add(), device_initialize() is called first.
> put_device() should be called to drop the reference if error
> occurs. And other resources would be released via put_device
> -> fsl_mc_device_release. So remove redundant kfree() in
> error handling path.
> 

It is true that we shouldn't free things directly after calling
device_initialize().  I don't know the impact of this bug in
real life.  Is it a leak?

> Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
> Cc: stable@vger.kernel.org
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/b767348e-d89c-416e-acea-1ebbff3bea20@stanley.mountain/

Heh.  What was I even talking about when I wrote this???

In my head I remember the code as looking like this:
https://lore.kernel.org/all/20251222074958.992911-1-lihaoxiang@isrc.iscas.ac.cn/
But that's not the version of the code that I copy and pasted into my
email.

The release function looks like this:

drivers/bus/fsl-mc/fsl-mc-bus.c
   757  static void fsl_mc_device_release(struct device *dev)
   758  {
   759          struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
   760  
   761          kfree(mc_dev->regions);
   762  
   763          if (is_fsl_mc_bus_dprc(mc_dev))
   764                  kfree(to_fsl_mc_bus(mc_dev));
   765          else
   766                  kfree(mc_dev);
   767  }

The problem is that if this function call fails:

	mc_dev->dev.type = fsl_mc_get_device_type(obj_desc->type);

Then the is_fsl_mc_bus_dprc() check might not work.  In the current
code the to_fsl_mc_bus() pointer math is a no-op because mc_dev is
the first struct member of mc_bus.  So it works for now, but it
feels wrong.

The fsl_mc_get_device_type() function can't really fail in real
life.

regards,
dan carpenter



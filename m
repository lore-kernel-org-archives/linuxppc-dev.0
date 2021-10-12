Return-Path: <SRS0=dmdX=PA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E11CC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Oct 2021 15:44:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F94561076
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Oct 2021 15:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F94561076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HTKhx31NBz2ygC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Oct 2021 02:44:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aXxWWEmI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f34;
 helo=mail-qv1-xf34.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256
 header.s=google header.b=aXxWWEmI; dkim-atps=neutral
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HTKh64GClz2yMg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2021 02:43:31 +1100 (AEDT)
Received: by mail-qv1-xf34.google.com with SMTP id z3so13110123qvl.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Oct 2021 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pYzGaaVTDb6cjnLawGS3ll6xPJPKRnUFVY4pJMEW1qQ=;
 b=aXxWWEmI7otvwPSXfEK6Hzf87wzKANGFEo45FY8A5C5F/h6dYa4niGwH6wB4OefJP7
 5rjqaqb+N1m6rYoY232wpw522TUOaeDueRMMQpwLt/TU1Djr6C3feMO6grpFtugxJD45
 x2IoyBLU8DjZkcFVlxjV7cbdXr3LfaofguD3yiwlMIA0KDUguZsm/uI4Bwfo4yIFQDqW
 VXa5ysmgc8uaDXjB+oKfD6wSswbZ6CJ4CFGHrclrSq/NpFwb31T1p6HixV+iX8t0Fswg
 GbHvcsIfXK9lbO+NOAhnljTfUI+InlE5qHq/udfKbcZI+B0LQzCrjaUtW3q7IlJR56EY
 CBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pYzGaaVTDb6cjnLawGS3ll6xPJPKRnUFVY4pJMEW1qQ=;
 b=ln9aitQMKtW8dVW5azizOZtVzLMvxKgu6ecOwaHqxoG8e6Onw7H5JXgY5r5CbsxvSy
 +oGPhFPvEmBFjdLYegUuTqdqjiM0GSZkOXrkKDKD5rxOIkRCev3J8sVlK3sCfkCOSi3u
 8GNY0YMHUbMsWgb16fGLwvHCNm29bJky2mJd8XijDgimCESGtWXxo9YLjA3QZxnNHlEK
 Gs5c0ETtVUj1Seqa4+bKBT4QpvE/38rYWhBdFa86uvOe519Nm4oRkt41l30FlElRWhcZ
 J8Ln7bDT132wpgFPxHG4Xr2ZiLEq+Pyjbm+sq4qWeoQqQAHQX11QBuQPkOOzB5GLAaWE
 k2Fw==
X-Gm-Message-State: AOAM530qnNq7SLFZH8YrY0+336GJaG+UJDSUsFypDio6j3sztG4DkZZg
 t3gz8pQehPDQiz8j7lNZ4VIB3w==
X-Google-Smtp-Source: ABdhPJwPhb77RUSTUgx+dYlcH/kH6JCVlV0vZdQvL4ujvMOtPs7lOUE6uHP/FvBNXymMTKqHTHHqlg==
X-Received: by 2002:ad4:476a:: with SMTP id d10mr30843885qvx.20.1634053406063; 
 Tue, 12 Oct 2021 08:43:26 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id p9sm3138728qki.51.2021.10.12.08.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 08:43:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1maJw5-00E4Wt-0H; Tue, 12 Oct 2021 12:43:25 -0300
Date: Tue, 12 Oct 2021 12:43:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Make use of dma_alloc_coherent()
Message-ID: <20211012154325.GI2688930@ziepe.ca>
References: <20211010160147.590-1-caihuoqing@baidu.com>
 <31619f2f192a4f1584e458f468422cf6e8f7542f.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31619f2f192a4f1584e458f468422cf6e8f7542f.camel@kernel.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, Cai Huoqing <caihuoqing@baidu.com>,
 Paul Mackerras <paulus@samba.org>, Peter Huewe <peterhuewe@gmx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 12, 2021 at 06:29:58PM +0300, Jarkko Sakkinen wrote:
> On Mon, 2021-10-11 at 00:01 +0800, Cai Huoqing wrote:
> > Replacing kmalloc/kfree/get_zeroed_page/free_page/dma_map_single/
>   ~~~~~~~~~
>   Replace
> 
> > dma_unmap_single() with dma_alloc_coherent/dma_free_coherent()
> > helps to reduce code size, and simplify the code, and coherent
> > DMA will not clear the cache every time.
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> 
> If this does not do functionally anything useful, there's no
> reason to apply this.

At least in this case it looks like the ibmvtpm is not using the DMA
API properly. There is no sync after each data transfer. Replacing
this wrong usage with the coherent API is reasonable.

Jason

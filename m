Return-Path: <linuxppc-dev+bounces-22983-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D053CDB479
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 14:56:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmMMc4llGz2xM7;
	Fri, 26 Jun 2026 00:56:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782399404;
	cv=none; b=Ckq/ZV3iOaj2juuXjo4+qt8Fg166w3ej5C1BXCVnLLe4NC/w40JZJPOr2lGLgrIZ+po42F+PKh46LYKdxr9BBdHR4O9QdUfcT+7K7xbyUCPJVoEyjEwRaCwI4x50OQQ3n9jYzPaSCdHbsr2BpbnXIAFdCmwaK4DnM1DZJx4o2LJtCEfJ1rK9JIL6AbJ6/CkrkQE3YvJ1yT88Q4hMwNOaxWcChlQW8A/Ljm+z1Ca+4DSxDET2umYR6laZJvMmOFn84LzHvOcCN+N7U+PFHZLkpCOks8T5uI6ls0YFGOUAoWCY3jb1JInXnNcsWu/n6t651rYYhMg2L/b1utFUyHHcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782399404; c=relaxed/relaxed;
	bh=80z3qdr1Ri+GX2ZpVWhKDkBHRsxbX1EdK+IIUrsw1PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf7v54CL9yBhFV6tJ/OaGIjGZKYP9NOVK9LuqmxijFs71XYOLvtf4VPzCSFHm5CxyJQjFZchp9HaH3ZCQ0psHzHsFNHn3UEX3mWrMU/HGmSiW/CUWgYGUVQfMuNsC8MJm3xdUjtLvQP0Ymeidu5F8BXvgLiWJNK5qqLBAhNGgtxhoTeF4XtqVz56BSwZ5tz62HhxWF5SOCGwYOUIDisHzfy3hRfG2t9ECCK+2Pnzqa7qXoxxWKHzhKaasleW+HN2aPK/b+7ULG4tbyuVqh2XCVMf5kN3Ox6mwWnUKJ12MR7qo6fGyovFnWx4vZkKEhePwJ6EEK/y9neXTaHgnQQ7OA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1JVLv8/W; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1JVLv8/W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmMMb2Fh6z2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 00:56:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CB0E6600AE;
	Thu, 25 Jun 2026 14:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07811F000E9;
	Thu, 25 Jun 2026 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782399399;
	bh=80z3qdr1Ri+GX2ZpVWhKDkBHRsxbX1EdK+IIUrsw1PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1JVLv8/WnfpoZFLRt1IedSCno2nVh7GfnUOghogiyIdavCxO010sXTVaR4HjLN1pJ
	 vvD05dPJ2xkc82p4EMxHBNpYtT6g9nV2QGdm4HaDDMJ4Jssw8SCB+LUfl9OvYpdDQ9
	 fitTkeZQYduCvUQiyrBMgiUXDuw9weqri26lR6u4=
Date: Thu, 25 Jun 2026 15:55:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: kees@kernel.org, balbi@ti.com, sebastian@breakpoint.cc,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] usb: gadget: fsl_qe_udc: fix gadget lifetime on
 registration failure
Message-ID: <2026062552-danger-slug-bc0d@gregkh>
References: <20260622140610.1140558-1-haoxiang_li2024@163.com>
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
In-Reply-To: <20260622140610.1140558-1-haoxiang_li2024@163.com>

On Mon, Jun 22, 2026 at 10:06:10PM +0800, Haoxiang Li wrote:
> usb_add_gadget_udc_release() drops the gadget device reference when
> registration fails. This invokes qe_udc_release() while qe_udc_probe()
> is still unwinding. Since udc->done is not initialized during probe,
> the release callback dereferences NULL in complete(). It also frees
> the qe_udc object before the remaining probe cleanup accesses it,
> resulting in use-after-free and double-free risks.
> 
> Initialize the gadget device explicitly and register it with
> usb_add_gadget(), which leaves the gadget reference owned by the
> driver on failure. Unwind the IRQ, DMA mappings, endpoint resources
> and registers before dropping that reference with usb_put_gadget().
> Make the completion notification conditional because it is only
> installed by the remove path.
> 
> Similarly, use usb_del_gadget() during removal so the final gadget
> reference remains held while the controller resources are released.
> Set the completion pointer immediately before dropping the reference,
> then wait for the release callback to finish.
> 
> Fixes: d77c1198666d ("usb: gadget: fsl_qe_udc: convert to new style start/stop")
> Cc: stable@kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/usb/gadget/udc/fsl_qe_udc.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
> index bf87285ad13c..f9a59b32e272 100644
> --- a/drivers/usb/gadget/udc/fsl_qe_udc.c
> +++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
> @@ -2459,7 +2459,9 @@ static void qe_udc_release(struct device *dev)
>  	struct qe_udc *udc = container_of(dev, struct qe_udc, gadget.dev);
>  	int i;
>  
> -	complete(udc->done);
> +	if (udc->done)
> +		complete(udc->done);
> +
>  	cpm_muram_free(cpm_muram_offset(udc->ep_param[0]));
>  	for (i = 0; i < USB_MAX_ENDPOINTS; i++)
>  		udc->ep_param[i] = NULL;
> @@ -2489,6 +2491,9 @@ static int qe_udc_probe(struct platform_device *ofdev)
>  		return -ENOMEM;
>  	}
>  
> +	usb_initialize_gadget(&ofdev->dev, &udc->gadget,
> +						qe_udc_release);

Odd coding style, why not just one line?

thanks,

greg k-h


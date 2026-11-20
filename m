Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D82606A331
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W4KSeOo/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWDh61DQ8z2xmh;
	Fri, 20 Nov 2026 23:11:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795176662;
	cv=none; b=JHR+iApiCnZzIW1GyUMHOKQPY6mnBQRRKWNhjJDTI3Ku97qFkTHY7wbBlUWCl/4X8mF3YKRLT5A0y4/kmJSWd59G66JCRRQY7bONnezyh0B1vahGHHKf7LBM+4x1ZupOCIrOyBK90ZvCkigOAQIFAjG/KdpHChVvN8Yv4b8uagw0JjRaRifixTVRYG3SsTIxLHhyRv+HPW0mMMPdm+k66Aj9Tb5o6LqyyBb4i2rnicQDm81k+WzRGAC2rdIud+ZfoKQ1Yo+VgDMCe6NuvBaW0EucrHWj1g0kv+ZLlVK+MiOIWTdD2Gx/xBgOeqX2MPpOhtmAqAo+6MzwYEZzwFadTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795176662; c=relaxed/relaxed;
	bh=yEn6hZoR27mO6l9Fwd74ebjt2Qc9Bj6f7MuKEtEDDIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urfix0kBoImIzHuq+O1hR50Xo+5jwxPEDm7dWVM0MUdJMVY8u+PiXODcm52NGYYKfGv9UEDBeu2k0i6o2ayssRMmDeTR/7zKodVtkC7jwq9KmYWgbq2fkna1Ne9QNix54UwT6uOyIGuY/VdT0gAAUqaqMgAnkPt1s1Q8BUw87Ba9R84HtFjtXi6Dzs2k9YulqZt3trVYSRMavcNezJVmYQQPRy7g8vNE6RtaL0O8jq1n6IZ2jI+u9zxsNgJsdhJBV6qGOds/pLBKsNy13wLcRVulSYjwuqs85tmCWP0tP1kb7nZYkKQNi6rfty2iec92oi/9p3MH169m1ZE1/biNRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W4KSeOo/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W4KSeOo/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWDh46d0rz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 23:11:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 59E13612C3;
	Fri, 20 Nov 2026 12:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6912A1F000C4;
	Fri, 20 Nov 2026 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795176657;
	bh=yEn6hZoR27mO6l9Fwd74ebjt2Qc9Bj6f7MuKEtEDDIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W4KSeOo/uGIm9oUK3TLcmpQgx47fddndPesoC0nJtyrER5Y7EfSo/sibJ1pTUrwfM
	 PFpxyRnzP1ea15lHlIEtoGuRbR1PmEweRFaur4hrrPZAszBXbB69WsOITok2AXD49W
	 hMHx4pubni6hzv1HWJxABR+SK0HDOKhOn2IzcLE4=
Date: Fri, 20 Nov 2026 13:10:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Neill Kapron <nkapron@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: fsl_udc: Fix potential use-after-free
 during removal
Message-ID: <2026112015-lumber-flyer-d8f6@gregkh>
References: <20261118-324f82bd41-usb-gadget-0@mail.sdu.edu.cn>
 <20261118-324f82bd41-usb-gadget-1@mail.sdu.edu.cn>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-324f82bd41-usb-gadget-1@mail.sdu.edu.cn>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 10:10:53PM +0800, Guangshuo Li wrote:
> usb_del_gadget_udc() can drop the last gadget device reference and call
> fsl_udc_release(), which frees udc_controller. The remaining remove path
> then dereferences it to release its requests, endpoints and DMA pool.
> 
> Hold a gadget device reference until this cleanup has finished.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: eab35c4e6d95 ("usb: gadget: fsl_udc_core: let udc-core manage gadget->dev")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> ---
>  drivers/usb/gadget/udc/fsl_udc_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
> index 878d70b55530..9d9d2164c5bf 100644
> --- a/drivers/usb/gadget/udc/fsl_udc_core.c
> +++ b/drivers/usb/gadget/udc/fsl_udc_core.c
> @@ -2537,6 +2537,7 @@ static void fsl_udc_remove(struct platform_device *pdev)
>  	DECLARE_COMPLETION_ONSTACK(done);
>  
>  	udc_controller->done = &done;
> +	get_device(&udc_controller->gadget.dev);

This feels wrong, why are you needing a fake reference here?

>  	usb_del_gadget_udc(&udc_controller->gadget);

This is where it should all go away.  If not, then reorder the code
properly.


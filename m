Return-Path: <linuxppc-dev+bounces-28649-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2446CA5FCB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 12:08:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwVzk1Vf9z2y2Z;
	Thu, 01 Oct 2026 22:08:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790856482;
	cv=none; b=PdNwFZxk1J4Ef3DcOZg2rhu2BV7sfehg4hxG5bEbqa4W+LMX2sIJmOCp2uXmETkpTZiZyhTNiTyJkwhsbjR5w35R4G2+QLPpo4fQytyOufg70niybMuuGGyGHqstJtc5Coni9jrxiewf41dywWVzgSd/KkF7e3nDvQcdWuDmqXgBlpOKWH3uRWLgzBFMCvkg2YH+Z2kHjXe0qvwvcqjG+s5vDXBqBBGtqXROjPGMDRuiOzZeuwYMza4lLg5aVBAo0ZoN5PvwDT9LEFShQMaP+5Og5CTjSzwZoHbl+QC8jFZJySXdei48KacL5cbXAvHNXvdnVwZUHpPS5RkGJpgIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790856482; c=relaxed/relaxed;
	bh=BOpRc4Gujf+vgaFDNdrz84+SoAyHVrXrvNXn8Cv7QJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dkc2p8F1D+1KUkig36E+WKjHdW79qx6nSp/IO/yV7r5XbXlIBPSWES9jmslqeUdCBrV1yeMFXC98xU7gqc6VFELuB3caVmYlTU4REi9yW+l3uK5PWrckEoUyQwAFTtvWAbbgs4QAjDFmnPAcboIaER+KUNtKBC3KSNF/o2HURFFNCemBRW9vLZD1uQmtHPq3IeHPp2H5cBJ+SjQQfT7lS6sP69YjNGyo3vLUyD3PVGtjeLllyjfz/YUZJUTy25ZIc7S50KHiGYzXLt9nZEIfitOdqkHzCPDIxTz+Z7iR2/G5H8bWP6cutuNCZMKsCvUhl00tO8KFQt5vabJuzIiStQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1fj50fCn; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1fj50fCn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwVzj0kmgz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 22:08:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E2C9440D81;
	Thu,  1 Oct 2026 12:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A231F0089A;
	Thu,  1 Oct 2026 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790856477;
	bh=BOpRc4Gujf+vgaFDNdrz84+SoAyHVrXrvNXn8Cv7QJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1fj50fCn7or84UD2Xbr+W5dU2/TOMPogJDz3uoKkqEIw6S+f04FgqM1dqisKQGDdn
	 fNnnzFsmXRS50Sp/HEXqzTmG3jtvLk7GZ9TDatazIG3JUUrJpbo/pmnzR6pSqatfSz
	 ENXzmG3bpFx5jevTyNIQe2LYnXaq7jUgahumb5xs=
Date: Thu, 1 Oct 2026 13:46:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: mahesh@linux.ibm.com, andrew+kernel@donnellan.id.au, arnd@arndb.de,
	kees@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] misc: ocxl: cancel XSL fault work before freeing SPA
Message-ID: <2026100102-clerical-underrate-cc5d@gregkh>
References: <20260928134110.227-1-getshell@seu.edu.cn>
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
In-Reply-To: <20260928134110.227-1-getshell@seu.edu.cn>

On Mon, Sep 28, 2026 at 09:41:10PM +0800, Hongyan Xu wrote:
> The XSL fault interrupt takes an mm reference and queues fault_work
> embedded in the SPA. free_irq() stops new interrupt handlers but does
> not drain an already queued worker, allowing free_spa() to release its
> container first.
> 
> Cancel the work after freeing the interrupt. When cancellation removes a
> pending instance, also drop the mm reference that the worker would have
> released.
> 
> Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  drivers/misc/ocxl/link.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index 7749dcd16117..8146e98e77e7 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -335,6 +335,8 @@ static void release_xsl_irq(struct ocxl_link *link)
>  
>  	if (spa->virq) {
>  		free_irq(spa->virq, link);
> +		if (cancel_work_sync(&spa->xsl_fault.fault_work))
> +			mmput(spa->xsl_fault.pe_data.mm);
>  		irq_dispose_mapping(spa->virq);
>  	}
>  	kfree(spa->irq_name);
> -- 
> 2.50.1.windows.1
> 

How was this found and tested?

thanks,

greg k-h


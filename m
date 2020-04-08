Return-Path: <SRS0=I3TE=5Y=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AA4C2D0F4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2020 20:26:44 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88E520753
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2020 20:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XoxkBf1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88E520753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48yG5Y3lljzDqXG
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2020 06:26:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=armlinux.org.uk
 (client-ip=2001:4d48:ad52:3201:214:fdff:fe10:1be6;
 helo=pandora.armlinux.org.uk;
 envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256
 header.s=pandora-2019 header.b=XoxkBf1b; 
 dkim-atps=neutral
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48yG3Y73GVzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2020 06:24:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FCin5CxUiqOa42dOBAJeAv8hLhn4PzxcsTEw9e4NZJY=; b=XoxkBf1bGxRc+ttmmvia5OvZE
 oitOH2Yx9geESlq3nazl+qwL1Zcf4HXXYRApOnK0i4z8MNlEFJt2LTp+u/ERpFq03tgqzs7llZQap
 cVk83dH1h6HRrumDZSkAtJgvPqQO66fXqOIcB5Q68w3pPPEHI5k5ZEcghDm8DVCHT54DCGxe1o8cq
 jhfarDU/C7T60Vf4T11sKFZNZK7YgjCb1UE/pU1wXm2MVZAQfHzfqTjeRG0bPOtHHOVKntwYNr9Ol
 qAA9d4r8PbrRWrO7nUwQQpmj1vzZlPyOv45WxEnHXV7WODgTgGxs3J/xXOsefCD0EU2J8SlMI7rnw
 DLBHbG05g==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47442)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1jMHFO-0008KP-0G; Wed, 08 Apr 2020 21:24:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1jMHFF-00027f-Jb; Wed, 08 Apr 2020 21:24:21 +0100
Date: Wed, 8 Apr 2020 21:24:21 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] soc: fsl: dpio: avoid stack usage warning
Message-ID: <20200408202421.GU25745@shell.armlinux.org.uk>
References: <20200408185834.434784-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408185834.434784-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
List-Id: <soc.lore.kernel.org>
Cc: Roy Pledge <Roy.Pledge@nxp.com>, linux-kernel@vger.kernel.org,
 Youri Querry <youri.querry_1@nxp.com>, soc@kernel.org,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 08, 2020 at 08:58:16PM +0200, Arnd Bergmann wrote:
> A 1024 byte variable on the stack will warn on any 32-bit architecture
> during compile-testing, and is generally a bad idea anyway:
> 
> fsl/dpio/dpio-service.c: In function 'dpaa2_io_service_enqueue_multiple_desc_fq':
> fsl/dpio/dpio-service.c:495:1: error: the frame size of 1032 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> There are currently no callers of this function, so I cannot tell whether
> dynamic memory allocation is allowed once callers are added. Change
> it to kcalloc for now, if anyone gets a warning about calling this in
> atomic context after they start using it, they can fix it later.
> 
> Fixes: 9d98809711ae ("soc: fsl: dpio: Adding QMAN multiple enqueue interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/soc/fsl/dpio/dpio-service.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
> index cd4f6410e8c2..ff0ef8cbdbff 100644
> --- a/drivers/soc/fsl/dpio/dpio-service.c
> +++ b/drivers/soc/fsl/dpio/dpio-service.c
> @@ -478,12 +478,17 @@ int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
>  				const struct dpaa2_fd *fd,
>  				int nb)
>  {
> -	int i;
> -	struct qbman_eq_desc ed[32];
> +	struct qbman_eq_desc *ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);

I think you need to rearrange this to be more compliant with the coding
style.

> +	int i, ret;
> +
> +	if (!ed)
> +		return -ENOMEM;
>  
>  	d = service_select(d);
> -	if (!d)
> -		return -ENODEV;
> +	if (!d) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
>  
>  	for (i = 0; i < nb; i++) {
>  		qbman_eq_desc_clear(&ed[i]);
> @@ -491,7 +496,10 @@ int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
>  		qbman_eq_desc_set_fq(&ed[i], fqid[i]);
>  	}
>  
> -	return qbman_swp_enqueue_multiple_desc(d->swp, &ed[0], fd, nb);
> +	ret = qbman_swp_enqueue_multiple_desc(d->swp, &ed[0], fd, nb);
> +out:
> +	kfree(ed);
> +	return ret;
>  }
>  EXPORT_SYMBOL(dpaa2_io_service_enqueue_multiple_desc_fq);
>  
> -- 
> 2.26.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up

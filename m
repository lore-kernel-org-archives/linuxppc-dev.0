Return-Path: <SRS0=mlYb=D3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5CEC4363A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 16:30:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033352224A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 16:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+iOUOOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033352224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CFzcl2jwszDqg3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2020 03:30:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=R+iOUOOr; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CFzZG3CVGzDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2020 03:28:05 +1100 (AEDT)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E06E122242;
 Tue, 20 Oct 2020 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603211282;
 bh=Q3yKsQuTMrcCf0pwDqkIgVljF9mzA/TS1grr6L4FtrU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R+iOUOOr2Xrs9zjFAHwZ8brvdqar2y0zqIlt8H+D3GRTfTAjnUfC7mA5Z7eJ5BCiK
 bLWvQfZZtncflquf6cgbIS33mqTyw3vEc8Wkwkm9PS1Uw/llJ6sZzwc+KsBuB7SWQ2
 aCra1cHp0/IoYh0qA2M1Y8Hm7eE/g8SsUNkZsaA8=
Date: Tue, 20 Oct 2020 18:28:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] serial: pmac_zilog: don't init if zilog is not available
Message-ID: <20201020162844.GA865546@kroah.com>
References: <20201020162303.1730562-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020162303.1730562-1-laurent@vivier.eu>
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
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 20, 2020 at 06:23:03PM +0200, Laurent Vivier wrote:
> We can avoid to probe for the Zilog device (and generate ugly kernel warning)
> if kernel is built for Mac but not on a Mac.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  drivers/tty/serial/pmac_zilog.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
> index 063484b22523..d1d2e55983c3 100644
> --- a/drivers/tty/serial/pmac_zilog.c
> +++ b/drivers/tty/serial/pmac_zilog.c
> @@ -1867,6 +1867,12 @@ static struct platform_driver pmz_driver = {
>  static int __init init_pmz(void)
>  {
>  	int rc, i;
> +
> +#ifdef CONFIG_MAC
> +	if (!MACH_IS_MAC)
> +		return -ENODEV;
> +#endif

Why is the #ifdef needed?

We don't like putting #ifdef in .c files for good reasons.  Can you make
the api check for this work with and without that #ifdef needed?

thanks,

greg k-h

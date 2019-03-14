Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ACDC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:52:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57202217F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJvj5RlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57202217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L5903MKpzDqJV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:52:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="eJvj5RlD"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3qr3QDhzDqP9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:52:08 +1100 (AEDT)
Received: from localhost (unknown [12.27.65.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4BD7520854;
 Thu, 14 Mar 2019 22:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1552603925;
 bh=st0n8huOzjMrnMwi0sOu0eXuetmWdRgRQHuh30jQPpw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eJvj5RlDqIcQn41nriRHlw2/8g+bsQPxKTc+WWz90BZVMr5AmJW/OzZVzd2JAR+pG
 7lEMTvrx1RUCPvbZij+l1qAaQiUNn/0TE0v0U6MrLGP1aAKsUw7NtFNO/5dzgiCUDl
 0dDi9vMNO8CzuO6upy0fnqYe5SOW+O+9FjTiUAe4=
Date: Thu, 14 Mar 2019 15:52:04 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
Message-ID: <20190314225204.GB1795@kroah.com>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552602855-26086-11-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: linux-arm-msm@vger.kernel.org, yamada.masahiro@socionext.com,
 macro@linux-mips.org, jacmet@sunsite.dk, festevam@gmail.com,
 stefan.wahren@i2se.com, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
 linux-serial@vger.kernel.org, slemieux.tyco@gmail.com, andy.gross@linaro.org,
 tklauser@distanz.ch, david.brown@linaro.org, rjui@broadcom.com,
 s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, vz@mleia.com,
 matthias.bgg@gmail.com, andriy.shevchenko@linux.intel.com, baohua@kernel.org,
 sbranden@broadcom.com, eric@anholt.net, richard.genoud@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Mar 14, 2019 at 11:33:40PM +0100, Enrico Weigelt, metux IT consult wrote:
> Use the safer devm versions of memory mapping functions.

What is "safer" about them?

> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/tty/serial/zs.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
> index b03d3e4..0b1ec2f 100644
> --- a/drivers/tty/serial/zs.c
> +++ b/drivers/tty/serial/zs.c
> @@ -984,16 +984,17 @@ static const char *zs_type(struct uart_port *uport)
>  
>  static void zs_release_port(struct uart_port *uport)
>  {
> -	iounmap(uport->membase);
> +	devm_iounmap(uport->dev, uport->membase);
>  	uport->membase = 0;
> -	release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
> +	devm_release_mem_region(uport->dev, uport->mapbase, ZS_CHAN_IO_SIZE);

Isn't the whole goal of the devm* functions such that you are not
required to call "release" on them?

If so, are you sure this patchset is correct?

And also, why make the change, you aren't changing any functionality for
these old drivers at all from what I can tell (for the devm calls).
What am I missing here?

thanks,

greg k-h

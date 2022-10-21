Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E192C4332F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Oct 2022 13:23:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mv4sh3fjRz3dw9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Oct 2022 00:23:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=gdVZ4fSv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.28; helo=smtp-out1.suse.de; envelope-from=pmladek@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=gdVZ4fSv;
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mv4rh2Vcyz3drf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2022 00:22:28 +1100 (AEDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 1B17C219C9;
	Fri, 21 Oct 2022 13:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1666358538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VumRopmkMGi42CeTbKazupolMyzZhURL00ZfaW4xkE=;
	b=gdVZ4fSvrckrlGvFlTSb40MpTj1ZsqvTB7WK7LgbNOk+VtT8zH0CiWHKKRfqD+Tclsv4xI
	0mEmRZ+ChIZ5Pf66NbeD2oaws4fTZkCO4EnKliGVzXJrofHQZ2xuUYdxuikY3XaH2JhyLq
	GrpRfBiRz1oFHrjEoTuYOhMVYh3Jd+o=
Received: from suse.cz (unknown [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id BEB062C141;
	Fri, 21 Oct 2022 13:22:17 +0000 (UTC)
Date: Fri, 21 Oct 2022 15:22:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH printk v2 10/38] tty: hvc: use console_is_enabled()
Message-ID: <Y1KdCes7Ag6wJ3DE@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-11-john.ogness@linutronix.de>
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
Cc: linuxppc-dev@lists.ozlabs.org, Xianting Tian <xianting.tian@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shile Zhang <shile.zhang@linux.alibaba.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jirislaby@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed 2022-10-19 17:01:32, John Ogness wrote:
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/hvc/hvc_console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index 4802cfaa107f..6d1d7b72488c 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -265,7 +265,7 @@ static void hvc_port_destruct(struct tty_port *port)
>  static void hvc_check_console(int index)
>  {
>  	/* Already enabled, bail out */
> -	if (hvc_console.flags & CON_ENABLED)
> +	if (console_is_enabled(&hvc_console))
>  		return;

The check is not reliable. The console might be disabled even when
it is already registered.

I would be nice to fix this. But it might be done later.
Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

>  
>   	/* If this index is what the user requested, then register

Best Regards,
Petr

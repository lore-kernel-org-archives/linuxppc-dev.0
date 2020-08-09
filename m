Return-Path: <SRS0=N30B=BT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EFFC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Aug 2020 19:03:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055A3206A2
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Aug 2020 19:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhcvqaTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055A3206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BPpQl1jDbzDqT2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 05:03:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=groeck7@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=fhcvqaTm; dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BPpNn6CnHzDqRf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2020 05:01:44 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id r11so3956785pfl.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2020 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dCQmffw/i58ICs4V65P0Gmx0jlfMHsHEylHgWzK3pBQ=;
 b=fhcvqaTmn2sVgbdLQ8Q30+/nra5OheM++NBD41UQhMjeydwWokLZcZWkFU2vqd8lhd
 7z/r0bbwCRJFT1+SjKEfbF9/4pVo6toRdfx+D4Wds03ZIpZwwukif2ngVWtJpZWLFnuM
 zT1qKc8xQ2QpIc352ypogFc2e6VOU1kBZd5fjbfrg8M8p5+xdvNl/j9xY9PM48Exg1M1
 HZTgSpJd7asX5fx1T4fLbZrPWrwBerGIlq7stIsnW5fuXEfz6V5AeA37LVzJBXmtYKq7
 M8OOXTKrjmCMjA1/sXDXRbCP+mSf7iZUf/2gYUQ4UhPmyFbWqkLrDNcOhfnpg7BzAA+8
 PZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=dCQmffw/i58ICs4V65P0Gmx0jlfMHsHEylHgWzK3pBQ=;
 b=PXPBh8zlMOQLl3W7MeH6WVERnlkP/TaMVa0KWTKaPa6uWNtenmWMVaCDcSB2pbQgm6
 KdY65RIJbFSNnPvk18iTXVkR1vyFac/Hepu1lqOuONPya2i3yK0dEckKae7T5v5o+b9Z
 jDhAqFKzCxaQAsjqQMxLx+yG5qvr0mQ0VPV+N/qmsaDsz2Q7ibepEL7Uc/T1EgMMd011
 4mBNCo1TLJoOUVCgtZ2O6j3cHgWIIvPVMLlZv3Kvo40uahxjebpvl9lWxa3rS43+r3Oa
 oNUoTfMvmapYCO2fXjQoMmalW3mexODXM++/1AB0CdXk3QW2+MfQYDpAHiaA8Dtwg1wG
 kQ6Q==
X-Gm-Message-State: AOAM533YzetDKJkzb7Vnm6WquvJ1NEOL5A+8TIZtIKT1m1Xj1fyzY0RO
 xEer+NelHRitt9qo1tjTlPw=
X-Google-Smtp-Source: ABdhPJwlLXY+ljlvzCGdp+QZRJzeQ/vj/qHJBv+EBWhmfNMBhXm9UCzuLTPrGe0KTx6Uo3BLidy1uQ==
X-Received: by 2002:a63:e747:: with SMTP id j7mr1085881pgk.107.1596999700635; 
 Sun, 09 Aug 2020 12:01:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id b13sm18409857pjl.7.2020.08.09.12.01.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Aug 2020 12:01:40 -0700 (PDT)
Date: Sun, 9 Aug 2020 12:01:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 1/9] macintosh/via-macii: Access autopoll_devs when
 inside lock
Message-ID: <20200809190138.GA133890@roeck-us.net>
References: <cover.1593318192.git.fthain@telegraphics.com.au>
 <5952dd8a9bc9de90f1acc4790c51dd42b4c98065.1593318192.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5952dd8a9bc9de90f1acc4790c51dd42b4c98065.1593318192.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Sun, Jun 28, 2020 at 02:23:12PM +1000, Finn Thain wrote:
> The interrupt handler should be excluded when accessing the autopoll_devs
> variable.
> 

I am quite baffled by this patch. Other than adding an unnecessary lock /
unlock sequence, accessing a variable (which is derived from another
variable) from inside or outside a lock does not make a difference.
If autopoll_devs = devs & 0xfffe is 0 inside the lock, it will just
as much be 0 outside the lock, and vice versa.

Can you explain this in some more detail ? Not that is matters much since
the change already made it into mainline, but I would like to understand
what if anything I am missing here.

Thanks,
Guenter

> Fixes: d95fd5fce88f0 ("m68k: Mac II ADB fixes") # v5.0+
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  drivers/macintosh/via-macii.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
> index ac824d7b2dcfc..6aa903529570d 100644
> --- a/drivers/macintosh/via-macii.c
> +++ b/drivers/macintosh/via-macii.c
> @@ -270,15 +270,12 @@ static int macii_autopoll(int devs)
>  	unsigned long flags;
>  	int err = 0;
>  
> +	local_irq_save(flags);
> +
>  	/* bit 1 == device 1, and so on. */
>  	autopoll_devs = devs & 0xFFFE;
>  
> -	if (!autopoll_devs)
> -		return 0;
> -
> -	local_irq_save(flags);
> -
> -	if (current_req == NULL) {
> +	if (autopoll_devs && !current_req) {
>  		/* Send a Talk Reg 0. The controller will repeatedly transmit
>  		 * this as long as it is idle.
>  		 */

Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1656AC282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 22:00:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3049D222B1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 22:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3049D222B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zc6J1HKDzDqN7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
X-Greylist: delayed 1273 seconds by postgrey-1.36 at bilbo;
 Wed, 13 Feb 2019 08:59:01 AEDT
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zc4P3WQ5zDqMb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 08:59:01 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gtfiH-0007nV-Dq; Tue, 12 Feb 2019 15:35:33 -0600
Message-ID: <86a59a19d817826f7efca5fab253bddb732eb9d1.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 12 Feb 2019 15:35:32 -0600
In-Reply-To: <4d531fb8828.51b92386@auth.smtp.1and1.co.uk>
References: <4d531fb8828.51b92386@auth.smtp.1and1.co.uk>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: darren@stevens-zone.net, linuxppc-dev@lists.ozlabs.org,
 chzigotzky@xenosoft.de
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] powerpc/85xx: Activate Cyrus disk-activity LED
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: chzigotzky@xenosoft.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2019-02-09 at 23:14 +0000, Darren Stevens wrote:
> The disk activity LED on the Cyrus board is attached to a gpio pin,
> add the required device-tree node for the kernel driver to use.
> 
> Signed-off-by: Darren Stevens <darren@stevens-zone.net>
> 
> ---
> 
> diff --git a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
> b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
> index 15e8440..348cfdb 100644
> --- a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
> +++ b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
> @@ -82,6 +82,15 @@
>             gpios = <&gpio0 2 1>;
>         };
>  
> +       leds {
> +           compatible = "gpio-leds";
> +
> +           hdd {
> +               label = "Disk Activity";
> +               gpios = <&gpio0 5 0>;
> +               linux,default-trigger = "disk-activity";
> +           };
> +       };
>     };

This patch is whitespace-mangled (as is your other one).  Could you try
sending with git send-email?

-Scott



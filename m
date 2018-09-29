Return-Path: <SRS0=aJM7=ML=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3757CC43143
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 18:24:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705552073F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 18:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgcxtZiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705552073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MxlM40LnzF3D1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 04:24:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KgcxtZiW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KgcxtZiW"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MxfJ49lSzF3Df
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 04:19:52 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id b7-v6so6432441pfo.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RK7lmXdnzFYxg5omuWKypkgu5ApkfOL23ghs9ownmdA=;
 b=KgcxtZiW2GTgiQfzcgDQLbL4P14Fcq+fflwu1ocoWItVuRoJGdlry0H0Jzn8FWdEn4
 n3s2jrXxW0daScKhwfkfx3dNNyDPDtrrAeL1EqvjgjixsWtqDUK/7cbEHpCKEP3s9PLj
 oD1BHSVYyAUjiQ11LUPVIAvt4Fpb3sa3pVvqhqOZX9qUOamsR5Ur9wrGuXGm9fp4SCL4
 fRxLV2NiPY2tqrxm4wHNBT/cyP1MDpEEoEsE12IEnFbzEWWJpWrqamDSOr4NUZxOx//z
 GQPMmSXCvIJ209fnLkXWnaV0F/c8M0rEkpB4oOmyhhcPLfZB9BliQ+5vp7zls3uV/UvB
 PTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=RK7lmXdnzFYxg5omuWKypkgu5ApkfOL23ghs9ownmdA=;
 b=kGgYQHVD5UdKV2/ixegITZK9DHnypGxwnd6E6j0BOObMOQWp0ef8KVC2wTAtRXTwAy
 WVJ1qDoUndwQ58HDMUPoi2ZXkfqqKOKLDki96uhjYvaBKC9r6iJGhkOXPbK50DFTh0ii
 yIXPv7ZaR3wdIQSrsiIcXrgDH3JGsjT2kMFuWxMwAezZsT4l5c6jUCs6uedB7fCNO72H
 DIuM7wdBqHiQfkeycHEHNOI+Sm9xDfDnzl/8Q65qQc3vo1mpvVWlglcVZZLJD9KfWvzQ
 qVcpQTfBIvuj8EP3XGhZUV53NB6u4UykvZEGNVQzzvyx9tNRV+n+N0Vn252AwMpqX3za
 0v1A==
X-Gm-Message-State: ABuFfoiZ78+Jk0kQTT1EaBc6MK11Q65t+UwrvFcAvsru4oqtFSeFoor0
 5M6me60iQsnkU3zDOh2qM0k=
X-Google-Smtp-Source: ACcGV62ulzYAyTMpEMW5jhm3AiXeSEVZGBQHajHBKxI4w89uSqqE9aWlPWZroFJn3XBhcPVG9Q68QA==
X-Received: by 2002:a62:184a:: with SMTP id
 71-v6mr2344593pfy.246.1538245190568; 
 Sat, 29 Sep 2018 11:19:50 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net.
 [108.223.40.66])
 by smtp.gmail.com with ESMTPSA id i184-v6sm11943487pgc.9.2018.09.29.11.19.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Sep 2018 11:19:49 -0700 (PDT)
Date: Sat, 29 Sep 2018 11:19:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [v3,3/3] dt-bindings: watchdog: add mpc8xxx-wdt support
Message-ID: <20180929181949.GA4420@roeck-us.net>
References: <e3e0bcfd7b779b978d07e088a8bd667ea9ddf4aa.1537163780.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3e0bcfd7b779b978d07e088a8bd667ea9ddf4aa.1537163780.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Radu Rendec <radu.rendec@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Sep 17, 2018 at 06:22:53AM +0000, Christophe Leroy wrote:
> Add description of DT bindings for mpc8xxx-wdt driver which
> handles the CPU watchdog timer on the mpc83xx, mpc86xx and mpc8xx.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../devicetree/bindings/watchdog/mpc8xxx-wdt.txt   | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt b/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
> new file mode 100644
> index 000000000000..e176face472a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
> @@ -0,0 +1,25 @@
> +* Freescale mpc8xxx watchdog driver (For 83xx, 86xx and 8xx)
> +
> +Required properties:
> +- compatible: Shall contain one of the following:
> +	"mpc83xx_wdt" for an mpc83xx
> +	"fsl,mpc8610-wdt" for an mpc86xx
> +	"fsl,mpc823-wdt" for an mpc8xx
> +- reg: base physical address and length of the area hosting the
> +       watchdog registers.
> +		On the 83xx, "Watchdog Timer Registers" area:	<0x200 0x100>
> +		On the 86xx, "Watchdog Timer Registers" area:	<0xe4000 0x100>
> +		On the 8xx, "General System Interface Unit" area: <0x0 0x10>
> +
> +Optional properties:
> +- reg: additional physical address and length (4) of location of the
> +       Reset Status Register (called RSTRSCR on the mpc86xx)
> +       		On the 83xx, it is located at offset 0x910
> +       		On the 86xx, it is located at offset 0xe0094
> +       		On the 8xx, it is located at offset 0x288
> +
> +Example:
> +		WDT: watchdog@0 {
> +		    compatible = "fsl,mpc823-wdt";
> +		    reg = <0x0 0x10 0x288 0x4>;
> +		};

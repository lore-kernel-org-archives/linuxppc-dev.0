Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BF5C10F03
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 11:43:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC9420643
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 11:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOs8WaPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC9420643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FTKH0FyCzDqDP
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 22:43:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iOs8WaPp"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FTHC6VM8zDqCT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 22:41:27 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id l139so15257757ita.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Mar 2019 03:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yt4ImMd4UiUr9L+1JpyytFPDRP99tjCCtRs13V82BNc=;
 b=iOs8WaPpeTxhn8OW4awB1rHzd2LfUVEuX991FKpaviDo+1uslE1DK6qMXjIkbC6n5c
 1nU5ugBWIAnyXQGUnzYLkOMTZepz0hfHQQMJ4AoT5RT6vVMt1vfquB7tniwsCdLSBKXO
 FEoyqx7936ZjUHBH5c0mHi/o+BqimlrU8hbpwZfWAuakXbl+Fz9avxdKslm51AfWLYLJ
 M5auj9nLpzZvQdtNsuSPbQobHEhlb37rc4V98RoAHNPNt7ZoM5RDQ+yXJwUPop+BLTGe
 K29IU0e19u7JDYJ9rLc+R+yUioECknV/V/JRXcn7B0f/JFcn7L49J6isLDd6WY+muTYG
 IDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yt4ImMd4UiUr9L+1JpyytFPDRP99tjCCtRs13V82BNc=;
 b=pEvlkzEq6pw3xnuIFsVpRxqUcwNJJGaqxJuRf4t7WvLLLWWNBXdXqpIU5iRf5oWOEc
 tZphh1qP5UEHaxZGfybVHRP6oiG2yxSbon5y8yqUGQXQC8B4MA1ftKmgdbMRLP6/f94w
 zoi7Gs65xvf8pINNsxlw+aVZtzNELIXJGMlkZp52r/Xgpwj/W3lOWkU3vFrGMoDQqU0A
 XJX0xBfDBVjjuQu+4UgNgGWELBP8vUukkCZm8Qhbz/EPCtG9Z9brYPPsDn3cRa2xNh5Z
 nZJ+qlgnBFvwmjFGLLEYuPrQxf6GXX55PFzYRrFCDT6pZHtAorzTCNgsLRn5JCI1KEbu
 9A1g==
X-Gm-Message-State: APjAAAW7Yo9sY2gEkLcm+sUAlFfPYT/L26X8f8Br3sXswDeBSWZECH0X
 PIonvF4UQPyusee6HSeh2ro=
X-Google-Smtp-Source: APXvYqw+Yg5zPLnreoTZdp/pQrUgsZapB0fDJBYFqQ5oqvasP/UiCmmfN/lxAKmQXwyfsajuUFui5w==
X-Received: by 2002:a02:308:: with SMTP id y8mr7405988jad.142.1551958884079;
 Thu, 07 Mar 2019 03:41:24 -0800 (PST)
Received: from icarus ([2001:268:c0a4:120d:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id x84sm2241979ita.32.2019.03.07.03.41.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Mar 2019 03:41:23 -0800 (PST)
Date: Thu, 7 Mar 2019 20:42:16 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH v2 6/7] counter: ftm-quaddec: Documentation: Add specific
 counter sysfs documentation
Message-ID: <20190307114216.GB7851@icarus>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
 <20190306111208.7454-7-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306111208.7454-7-patrick.havelange@essensium.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
 Jonathan Cameron <jic23@kernel.org>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Esben Haabendal <esben@haabendal.dk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 06, 2019 at 12:12:07PM +0100, Patrick Havelange wrote:
> This adds documentation for the specific prescaler entry.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> ---
> Changes v2
>  - Add doc for prescaler entry
> ---
>  .../ABI/testing/sysfs-bus-counter-ftm-quaddec    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
> new file mode 100644
> index 000000000000..2da629d6d485
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
> @@ -0,0 +1,16 @@
> +What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
> +KernelVersion:	5.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available values for the respective Count Y
> +		configuration are listed in this file. Values are delimited by
> +		newline characters.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/prescaler
> +KernelVersion:	5.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Configure the prescaler value associated with Count Y.
> +		On the FlexTimer, the counter clock source passes through a
> +		prescaler that is a 7-bit counter. This acts like a clock
> +		divider.
> -- 
> 2.19.1

Hmm, prescalers seem common enough among counter devices to permit these
attributes to be listed in the sysfs-bus-counter documentation file.
However, I'd like to wait until we get another counter driver for a
device with a prescaler before we make that move. From there, we'll have
a better vantage point to determine a fitting standard prescaler
attribute behavior.

So for now, we'll keep these attributes documented here in the
sysfs-bus-counter-ftm-quaddec file, until the time comes to broach the
discussion again.

William Breathitt Gray

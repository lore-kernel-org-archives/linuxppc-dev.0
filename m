Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDBDC2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 18:26:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A372081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 18:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHFXJGWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A372081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42l0K03hFbzF27J
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 05:25:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kHFXJGWZ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kHFXJGWZ"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42l0GG0yCYzF1RG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 05:23:34 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id n4-v6so5383391plp.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GAux+0psBSoJyTO71A/RhOPXt77/q0qpmdzeczJuq4g=;
 b=kHFXJGWZibCqmUnq0gxnQbESPeXTsppIF+8ODsEbJsUkyLBZp/z8zSsP9P91Zym5Tx
 4bHKPfvWdNN3b4IPmKImqhfPZGpy8to3J25xAkeAVP4xeembGi6ATagIdrSwp77dgVFi
 tAqy6F4f6GPbGThAnBvNaNwSej2vr6Sy0XCAEUzOwBsxKIoxu6WL3jVxPx1TVhK3Ulmu
 ZxQODp11YeEEFLyv2PBNMHNTHLw4xy8GD0WehuqPkdDSWlPr2hWLQVonn1Ip1wfGmDZw
 wA7P/aod0T1issofJXG9FRCzxZsw8AeiTuJPzmx+tP/IQokPyFRxlzgsi05Kwv1h/6ZH
 PQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=GAux+0psBSoJyTO71A/RhOPXt77/q0qpmdzeczJuq4g=;
 b=WU4sksrmtkCB0vD5W9nLjnpuzuPmO0+iFCjjFzVGqbhqPLp08M0sx0wH9Fbm0rOF/b
 qtXOiqT6GvwTdl4uCZTv0jTFW6cbRoBmVzILsZ3hmm2d/CwKfQDLwhu5feG5QlTOhRu2
 faQHT/iUL5JGvuipmkL6nedfmjjWTIJBY24pHnLSBHg0njcPJZAd3A4oveC/Vlr2ewlL
 F3K56jBc+wakfTRaxV8c3xcBQ8hVs742W7vj8mrrqPZDiTM96dX5YRAiDeNuah2ZKX6v
 eXsERBnmU+OtBrllAb44SSq2VmWhXnqL9zb9R0mfI2Y+k2Ny3L01XStF8dpctYKgyuLJ
 7kGw==
X-Gm-Message-State: AGRZ1gJw6IRxsMXZVe51Alqa+4N1YmWZERNcNknCm3qVnIdrGnsp9mvh
 pK/JstJ+XeVyPktROkbBTK8=
X-Google-Smtp-Source: AJdET5dATtw7ZmO4L3a3+WHp2aFUFrICbbWKfA3jkWEA4yH3sdy+5rrHmZcCFfMcZ7tWsvZV7n7iIw==
X-Received: by 2002:a17:902:9f83:: with SMTP id
 g3-v6mr20118462plq.27.1540923812071; 
 Tue, 30 Oct 2018 11:23:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id c7-v6sm24805354pfh.25.2018.10.30.11.23.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Oct 2018 11:23:31 -0700 (PDT)
Date: Tue, 30 Oct 2018 11:23:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] hwmon: (ibmpowernv) Remove bogus __init annotations
Message-ID: <20181030182330.GA25641@roeck-us.net>
References: <20181028171651.30751-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181028171651.30751-1-geert@linux-m68k.org>
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
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 linux-kernel@vger.kernel.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Oct 28, 2018 at 06:16:51PM +0100, Geert Uytterhoeven wrote:
> If gcc decides not to inline make_sensor_label():
> 
>     WARNING: vmlinux.o(.text+0x4df549c): Section mismatch in reference from the function .create_device_attrs() to the function .init.text:.make_sensor_label()
>     The function .create_device_attrs() references
>     the function __init .make_sensor_label().
>     This is often because .create_device_attrs lacks a __init
>     annotation or the annotation of .make_sensor_label is wrong.
> 
> As .probe() can be called after freeing of __init memory, all __init
> annotiations in the driver are bogus, and should be removed.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied.

Thanks,
Guenter

> ---
> Compile-tested only.
> ---
>  drivers/hwmon/ibmpowernv.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 0ccca87f527191dc..293dd1c6c7b36ef2 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -181,7 +181,7 @@ static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
>  	return sprintf(buf, "%s\n", sdata->label);
>  }
>  
> -static int __init get_logical_cpu(int hwcpu)
> +static int get_logical_cpu(int hwcpu)
>  {
>  	int cpu;
>  
> @@ -192,9 +192,8 @@ static int __init get_logical_cpu(int hwcpu)
>  	return -ENOENT;
>  }
>  
> -static void __init make_sensor_label(struct device_node *np,
> -				     struct sensor_data *sdata,
> -				     const char *label)
> +static void make_sensor_label(struct device_node *np,
> +			      struct sensor_data *sdata, const char *label)
>  {
>  	u32 id;
>  	size_t n;

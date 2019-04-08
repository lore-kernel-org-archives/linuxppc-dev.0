Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D83C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 14:27:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F42020663
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 14:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="qY5Aj+jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F42020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dCSR0L1CzDqMT
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 00:27:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="qY5Aj+jj"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dCQ55YlQzDqDf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 00:25:49 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id i17so4595681pfo.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=P4vKQmbK14vtbIuUEndCl5MfnUaB3hSyiz0CQzCAQZw=;
 b=qY5Aj+jjp/s1OSKgwZzU3l7+6LRruW6kkAAmrM7wKfUAdxwjQQxdeNZ/RTPhazCg3J
 H+cnE0oznA7ZjQ86s8U5XSbCO9iuZBNwagfDSqpGOeGZQ2AnyTGLShNvbaQaPBb+iw/K
 Hdkouht+z8nSthWNBPdK2PD3K/MmxfyYTaxsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=P4vKQmbK14vtbIuUEndCl5MfnUaB3hSyiz0CQzCAQZw=;
 b=t1JbWMNhmdQ/xKsry//UBofhFlS7F8GObqc38gjh5u/cHYZkerLg0GYnrfPRGcpwTZ
 BGlSPSNdMzR5uFDTSfALzYXUuMpu5cuBRVCO1yb4tJUAkG4WTXSTBE2u5rV8OGuOti7x
 vIQYzpJfREaH6ZrakZvfEIc3tZhrklhD5TPtUIAyL1p+Bq/AV+SVnK3KzZe/0KVrUzqI
 bnk0FpJbMQT2tgBzNh3Xlx3KmjEY9TG7wI3+5OisjZwUseQW2yeh4pwDlRh7ifFRN1uG
 tfBIn/o+zKKbTZYsU1PbcQt2obMWj1I2divmXf4A8JjwC1on4ob7pGzDiyv0mf4X/fUo
 gb0g==
X-Gm-Message-State: APjAAAXIUKlOFtbvwRlvZJBH19qQWomJLYZtwihshp4dh2aFcTl+CVoa
 xNLn/vjr4Vvh3GRo0sA2YHPrrA==
X-Google-Smtp-Source: APXvYqzsA1AXiPykN+pw3sx+WRcap8ev3d4GcOkTSI8xZZNomj0hdsu8k/FPqteD9t9mt5/PsBrx4A==
X-Received: by 2002:a63:f212:: with SMTP id v18mr27873814pgh.231.1554733547282; 
 Mon, 08 Apr 2019 07:25:47 -0700 (PDT)
Received: from localhost (124-171-136-51.dyn.iinet.net.au. [124.171.136.51])
 by smtp.gmail.com with ESMTPSA id z13sm43143504pgc.25.2019.04.08.07.25.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Apr 2019 07:25:46 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpuidle : auto-promotion for cpuidle states
In-Reply-To: <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
 <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
Date: Tue, 09 Apr 2019 00:25:42 +1000
Message-ID: <87lg0kwp3t.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>, daniel.lezcano@linaro.org,
 rjw@rjwysocki.net, ego@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

Sorry, just realised another thing I wanted to ask:

> @@ -442,6 +442,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		}
>  	}
>
>
> +#ifdef CPUIDLE_FLAG_AUTO_PROMOTION

Why is this based on CPUIDLE_FLAG_ rather than CONFIG_CPU_IDLE_? Won't
this always be true, given that the flag is defined regardless of the
config option in the header?

> +	if (drv->states[idx].flags & CPUIDLE_FLAG_AUTO_PROMOTION) {
> +		/*
> +		 * Timeout is intended to be defined as sum of target residency
> +		 * of next available state, entry latency and exit latency. If
> +		 * time interval equal to timeout is spent in current state,
> +		 * and if it is a shallow lite state, we may want to auto-
> +		 * promote from such state.
> +		 */

Regards,
Daniel

> +		for (i = idx + 1; i < drv->state_count; i++) {
> +			if (drv->states[i].disabled ||
> +					dev->states_usage[i].disable)
> +				continue;
> +			*timeout = drv->states[i].target_residency +
> +					2 * drv->states[i].exit_latency;
> +			break;
> +		}
> +	}
> +#endif
> +
>  	return idx;
>  }
>  
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 3b3947232..84d76d1ec 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -72,6 +72,13 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
>  #define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
>  #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
> +/*
> + * State with only and only fast state bit set don't even lose user context.
> + * But such states prevent other sibling threads from thread folding benefits.
> + * And hence we don't want to stay for too long in such states and want to
> + * auto-promote from it.
> + */
> +#define CPUIDLE_FLAG_AUTO_PROMOTION	BIT(3)
>  
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> @@ -243,7 +250,8 @@ struct cpuidle_governor {
>  
>  	int  (*select)		(struct cpuidle_driver *drv,
>  					struct cpuidle_device *dev,
> -					bool *stop_tick);
> +					bool *stop_tick, unsigned long
> +					*timeout);
>  	void (*reflect)		(struct cpuidle_device *dev, int index);
>  };
>  
> -- 
> 2.17.1

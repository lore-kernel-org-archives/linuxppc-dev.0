Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C890DDE21
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 03:47:03 +1000 (EST)
In-Reply-To: <1182358772.5674.383.camel@rhino>
References: <1182298510.5674.358.camel@rhino> <1182358772.5674.383.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <64a22620446fccee1d52b7fc0e845b84@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] Create add_rtc() function to enable the RTC CMOS driver
Date: Wed, 20 Jun 2007 19:46:54 +0200
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	/*
> +	 * RTC_PORT(x) is hardcoded in asm/mc146818rtc.h.  Verify that the
> +	 * address provided by the device node matches.
> +	 */
> +	if (res.start != RTC_PORT(0)) {
> +		of_node_put(np);
> +		return -ENODEV;
> +	}

You can place the of_node_put() here and remove the
previous one, and the following one.

> +	pd = platform_device_register_simple("rtc_cmos", -1,
> +					     &res, 1);
> +	of_node_put(np);

Code looks fine, with or without that change.


Segher

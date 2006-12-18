Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B14567BAD
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 08:24:01 +1100 (EST)
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061215115902.688f1a34@pb15>
References: <20061213190408.1d4ddd93.kim.phillips@freescale.com>
	<B38E3DDE-A18F-4319-A968-B0C22C001391@kernel.crashing.org>
	<20061215115902.688f1a34@pb15>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 08:23:53 +1100
Message-Id: <1166477034.19254.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +static int __init genrtc_rtc_hookup(void)
> +{
> +	/* Don't init if the platform has already set up rtc functions. */
> +	if (ppc_md.get_rtc_time || ppc_md.set_rtc_time)
> +		return -1;
> +
> +	rtc_dev = rtc_class_open("rtc0");
> +
> +	if (!rtc_dev) {
> +		printk("genrtc_rtc_hookup: Failed to open rtc0\n");
> +		return -1;
> +	}
> +
> +	ppc_md.get_rtc_time = genrtc_get_rtc_time;
> +	ppc_md.set_rtc_time = genrtc_set_rtc_time;
> +
> +	return 0;
> +}
> +late_initcall(genrtc_rtc_hookup);
> +

This should be called by the platform code. Not all platform want to
hook on genrtc. Even worth, some of the RTC drivers provided by genrtc
aren't suitable at all because the NTP code will call them at interrupt
time (like the i2c ones).

Ben.

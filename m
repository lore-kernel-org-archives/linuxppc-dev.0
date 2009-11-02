Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95E57B7BFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  2 Nov 2009 16:13:58 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nA25DrYF025667
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Nov 2009 23:13:54 -0600
Subject: Re: [PATCH] powerpc: Avoid giving out RTC dates below EPOCH
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1257138663.7907.32.camel@pasglop>
References: <1257138663.7907.32.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Nov 2009 16:13:52 +1100
Message-ID: <1257138832.7907.33.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-11-02 at 16:11 +1100, Benjamin Herrenschmidt wrote:
> Doing so causes xtime to be negative which crashes the timekeeping
> code in funny ways when doing suspend/resume
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

> +void read_persistent_clock(struct timespec *ts)
> +{
> +	__read_persistent_clock(&ts);

Should read

+	__read_persistent_clock(ts);

Forgot a quilt ref ;-)

Cheers,
Ben.

> +	/* Sanitize it in case real time clock is set below EPOCH */
> +	if (ts->tv_sec < 0) {
> +		ts->tv_sec = 0;
> +		ts->tv_nsec = 0;
> +	}
> +		
> +}
> +
>  /* clocksource code */
>  static cycle_t rtc_read(struct clocksource *cs)
>  {
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

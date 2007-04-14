Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 7FBB4DDE28
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Apr 2007 05:42:15 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <1176450459.4734.32.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <97762565fcdccbf85d1d04cd055b1197@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] hvc_console polling mode timer backoff
Date: Sat, 14 Apr 2007 14:42:02 -0500
To: Michael Ellerman <michael@ellerman.id.au>,
	Will Schmidt <will_schmidt@vnet.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:

> + * msleep until we reach the max.  This may be noticable as a brief 
> (average
> + * one second) delay on the console before the console responds to 
> input when
> + * there has been no input for sometime.
> + */
> +#define MIN_TIMEOUT            (10)
> +#define MAX_TIMEOUT            (2000)
> +static u32 timeout = MIN_TIMEOUT;

Did you consider making MAX_TIMEOUT a module parameter?   It could then
be changed at runtime through /sys/modules/.

> +
> +                               if (timeout < MAX_TIMEOUT)
> +                                       timeout += (timeout >> 6) + 1;

Keeping MIN_TIMEOUT a define is okay with me, and the code will
naturally ignore max < MIN.  It may overshoot timeout by 1/64th.

I doubt we would worry about the overflow case, because by then
the timeout would have been quite long, and the user would like
it to be short again.

milton

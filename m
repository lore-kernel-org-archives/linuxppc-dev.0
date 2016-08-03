Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s445t1cRFzDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 17:12:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: neelegup@linux.vnet.ibm.com, Stewart Smith <stewart@linux.vnet.ibm.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] rtc-opal: Fix handling of firmware error codes,
 prevent busy loops
In-Reply-To: <1470102616-18346-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1470102616-18346-1-git-send-email-stewart@linux.vnet.ibm.com>
Date: Wed, 03 Aug 2016 17:12:49 +1000
Message-ID: <877fbytjf2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stewart Smith <stewart@linux.vnet.ibm.com> writes:

> According to the OPAL docs:
> https://github.com/open-power/skiboot/blob/skiboot-5.2.5/doc/opal-api/opal-rtc-read-3.txt
> https://github.com/open-power/skiboot/blob/skiboot-5.2.5/doc/opal-api/opal-rtc-write-4.txt
> OPAL_HARDWARE may be returned from OPAL_RTC_READ or OPAL_RTC_WRITE and this
> indicates either a transient or permanent error.
>
> Prior to this patch, Linux was not dealing with OPAL_HARDWARE being a
> permanent error particularly well, in that you could end up in a busy
> loop.
>
> This was not too hard to trigger on an AMI BMC based OpenPOWER machine
> doing a continuous "ipmitool mc reset cold" to the BMC, the result of
> that being that we'd get stuck in an infinite loop in opal_get_rtc_time.
>
> We now retry a few times before returning the error higher up the stack.

Looks like this has always been broken, so:

Fixes: 16b1d26e77b1 ("rtc/tpo: Driver to support rtc and wakeup on PowerNV platform")

> Cc: stable@vger.kernel.org

And therefore that should be:

Cc: stable@vger.kernel.org # v3.19+

> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> ---
>  drivers/rtc/rtc-opal.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
> index 9c18d6fd8107..fab19e3e2fba 100644
> --- a/drivers/rtc/rtc-opal.c
> +++ b/drivers/rtc/rtc-opal.c
> @@ -58,6 +58,7 @@ static void tm_to_opal(struct rtc_time *tm, u32 *y_m_d, u64 *h_m_s_ms)
>  static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
>  {
>  	long rc = OPAL_BUSY;
> +	int retries = 10;
>  	u32 y_m_d;
>  	u64 h_m_s_ms;
>  	__be32 __y_m_d;
> @@ -67,8 +68,11 @@ static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
>  		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
>  		if (rc == OPAL_BUSY_EVENT)
>  			opal_poll_events(NULL);
> -		else
> +		else if (retries-- && (rc == OPAL_HARDWARE
> +				       || rc == OPAL_INTERNAL_ERROR))
>  			msleep(10);
> +		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
> +			break;
>  	}

This is a pretty gross API at this point.

That's basically a score of 2 on Rusty's API usability index ("Read the implementation
and you'll get it right" - http://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html).

The docs don't mention OPAL_INTERNAL_ERROR being transient, nor do they mention
OPAL_BUSY.

Can we at least do a wrapper function in opal.h for drivers to use that handles
some or all of these cases?

cheers

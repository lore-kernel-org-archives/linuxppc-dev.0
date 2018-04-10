Return-Path: <alexandre.belloni@bootlin.com>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 40L5X84FYPzF1vZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 22:07:32 +1000 (AEST)
Date: Tue, 10 Apr 2018 14:07:28 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/3] powerpc/powernv: Fix OPAL RTC driver OPAL_BUSY loops
Message-ID: <20180410120728.GC2745@piout.net>
References: <20180410114933.24581-1-npiggin@gmail.com>
 <20180410114933.24581-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410114933.24581-3-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicholas,

I would greatly appreciate a changelog and at least the cover letter
because it is difficult to grasp how this relates to the previous
patches you sent to the RTC mailing list. 

On 10/04/2018 21:49:32+1000, Nicholas Piggin wrote:
> The OPAL RTC driver does not sleep in case it gets OPAL_BUSY or
> OPAL_BUSY_EVENT from firmware, which causes large scheduling
> latencies, up to 50 seconds have been observed here when RTC stops
> responding (BMC reboot can do it).
> 
> Fix this by converting it to the standard form OPAL_BUSY loop that
> sleeps.
> 
> Fixes 628daa8d5abfd ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks"
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linux-rtc@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/platforms/powernv/opal-rtc.c |  8 +++--
>  drivers/rtc/rtc-opal.c                    | 37 ++++++++++++++---------

>From what I understand, the changes in those files are fairly
independent, they should probably be separated to ease merging.

>  2 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platforms/powernv/opal-rtc.c
> index f8868864f373..aa2a5139462e 100644
> --- a/arch/powerpc/platforms/powernv/opal-rtc.c
> +++ b/arch/powerpc/platforms/powernv/opal-rtc.c
> @@ -48,10 +48,12 @@ unsigned long __init opal_get_boot_time(void)
>  
>  	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
>  		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
> -		if (rc == OPAL_BUSY_EVENT)
> +		if (rc == OPAL_BUSY_EVENT) {
> +			mdelay(OPAL_BUSY_DELAY_MS);
>  			opal_poll_events(NULL);
> -		else if (rc == OPAL_BUSY)
> -			mdelay(10);
> +		} else if (rc == OPAL_BUSY) {
> +			mdelay(OPAL_BUSY_DELAY_MS);
> +		}
>  	}
>  	if (rc != OPAL_SUCCESS)
>  		return 0;
> diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
> index 304e891e35fc..60f2250fd96b 100644
> --- a/drivers/rtc/rtc-opal.c
> +++ b/drivers/rtc/rtc-opal.c
> @@ -57,7 +57,7 @@ static void tm_to_opal(struct rtc_time *tm, u32 *y_m_d, u64 *h_m_s_ms)
>  
>  static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
>  {
> -	long rc = OPAL_BUSY;
> +	s64 rc = OPAL_BUSY;
>  	int retries = 10;
>  	u32 y_m_d;
>  	u64 h_m_s_ms;
> @@ -66,13 +66,17 @@ static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
>  
>  	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
>  		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
> -		if (rc == OPAL_BUSY_EVENT)
> +		if (rc == OPAL_BUSY_EVENT) {
> +			msleep(OPAL_BUSY_DELAY_MS);
>  			opal_poll_events(NULL);
> -		else if (retries-- && (rc == OPAL_HARDWARE
> -				       || rc == OPAL_INTERNAL_ERROR))
> -			msleep(10);
> -		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
> -			break;
> +		} else if (rc == OPAL_BUSY) {
> +			msleep(OPAL_BUSY_DELAY_MS);
> +		} else if (rc == OPAL_HARDWARE || rc == OPAL_INTERNAL_ERROR) {
> +			if (retries--) {
> +				msleep(10); /* Wait 10ms before retry */
> +				rc = OPAL_BUSY; /* go around again */
> +			}
> +		}
>  	}
>  
>  	if (rc != OPAL_SUCCESS)
> @@ -87,21 +91,26 @@ static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
>  
>  static int opal_set_rtc_time(struct device *dev, struct rtc_time *tm)
>  {
> -	long rc = OPAL_BUSY;
> +	s64 rc = OPAL_BUSY;
>  	int retries = 10;
>  	u32 y_m_d = 0;
>  	u64 h_m_s_ms = 0;
>  
>  	tm_to_opal(tm, &y_m_d, &h_m_s_ms);
> +
>  	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
>  		rc = opal_rtc_write(y_m_d, h_m_s_ms);
> -		if (rc == OPAL_BUSY_EVENT)
> +		if (rc == OPAL_BUSY_EVENT) {
> +			msleep(OPAL_BUSY_DELAY_MS);
>  			opal_poll_events(NULL);
> -		else if (retries-- && (rc == OPAL_HARDWARE
> -				       || rc == OPAL_INTERNAL_ERROR))
> -			msleep(10);
> -		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
> -			break;
> +		} else if (rc == OPAL_BUSY) {
> +			msleep(OPAL_BUSY_DELAY_MS);
> +		} else if (rc == OPAL_HARDWARE || rc == OPAL_INTERNAL_ERROR) {
> +			if (retries--) {
> +				msleep(10); /* Wait 10ms before retry */
> +				rc = OPAL_BUSY; /* go around again */
> +			}
> +		}
>  	}
>  
>  	return rc == OPAL_SUCCESS ? 0 : -EIO;
> -- 
> 2.17.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

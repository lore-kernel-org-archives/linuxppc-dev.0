Return-Path: <shuah@kernel.org>
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXlVz3Rw9zDqYV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 09:12:43 +1000 (AEST)
Reply-To: shuah@kernel.org
Subject: Re: [PATCH v2 1/1] rtc: rtctest: Improve support detection
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 a.zummo@towertech.it, linuxppc-dev@lists.ozlabs.org, sboyd@codeaurora.org,
 linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com,
 linux-kselftest@vger.kernel.org, john.stultz@linaro.org, tglx@linutronix.de,
 linux-rtc@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
 Shuah Khan <shuah@kernel.org>
References: <20170815084600.6285-1-ldoktor@redhat.com>
 <20170815084600.6285-2-ldoktor@redhat.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <45cfdaa8-685a-4a7f-89c8-ed55d90c95c8@kernel.org>
Date: Wed, 16 Aug 2017 17:06:24 -0600
MIME-Version: 1.0
In-Reply-To: <20170815084600.6285-2-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/15/2017 02:46 AM, Lukáš Doktor wrote:
> The rtc-generic and opal-rtc are failing to run this test as they do not
> support all the features. Let's treat the error returns and skip to the
> following test.
> 
> Theoretically the test_DATE should be also adjusted, but as it's enabled
> on demand I think it makes sense to fail in such case.
> 
> Signed-off-by: Lukáš Doktor <ldoktor@redhat.com>
> ---
>  tools/testing/selftests/timers/rtctest.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/timers/rtctest.c b/tools/testing/selftests/timers/rtctest.c
> index f61170f..411eff6 100644
> --- a/tools/testing/selftests/timers/rtctest.c
> +++ b/tools/testing/selftests/timers/rtctest.c
> @@ -221,6 +221,11 @@ int main(int argc, char **argv)
>  	/* Read the current alarm settings */
>  	retval = ioctl(fd, RTC_ALM_READ, &rtc_tm);
>  	if (retval == -1) {
> +		if (errno == EINVAL) {
> +			fprintf(stderr,
> +					"\n...EINVAL reading current alarm setting.\n");
> +			goto test_PIE;
> +		}
>  		perror("RTC_ALM_READ ioctl");
>  		exit(errno);
>  	}
> @@ -231,7 +236,7 @@ int main(int argc, char **argv)
>  	/* Enable alarm interrupts */
>  	retval = ioctl(fd, RTC_AIE_ON, 0);
>  	if (retval == -1) {
> -		if (errno == EINVAL) {
> +		if (errno == EINVAL || errno == EIO) {
>  			fprintf(stderr,
>  				"\n...Alarm IRQs not supported.\n");
>  			goto test_PIE;
> 

Applied to linux-kselftest next for 4.14-rc1

thanks,
-- Shuah

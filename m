Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wd7296QtLzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 21:06:09 +1000 (AEST)
Date: Wed, 31 May 2017 13:05:58 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH] drivers/rtc/interface.c: Validate alarm-time before
 handling rollover
Message-ID: <20170531110558.tcvl42wvaeazmbgp@piout.net>
References: <20170519164855.11747-1-vaibhav@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170519164855.11747-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/05/2017 at 22:18:55 +0530, Vaibhav Jain wrote:
> In function __rtc_read_alarm() its possible for an alarm time-stamp to
> be invalid even after replacing missing components with current
> time-stamp. The condition 'alarm->time.tm_year < 70' will trigger this
> case and will cause the call to 'rtc_tm_to_time64(&alarm->time)'
> return a negative value for variable t_alm.
> 
> While handling alarm rollover this negative t_alm (assumed to seconds
> offset from '1970-01-01 00:00:00') is converted back to rtc_time via
> rtc_time64_to_tm() which results in this error log with seemingly
> garbage values:
> 
> "rtc rtc0: invalid alarm value: -2-1--1041528741
> 2005511117:71582844:32"
> 
> This error was generated when the rtc driver (rtc-opal in this case)
> returned an alarm time-stamp of '00-00-00 00:00:00' to indicate that
> the alarm is disabled. Though I have submitted a separate fix for the
> rtc-opal driver, this issue may potentially impact other
> existing/future rtc drivers.
> 
> To fix this issue the patch validates the alarm time-stamp just after
> filling up the missing datetime components and if rtc_valid_tm() still
> reports it to be invalid then bails out of the function without
> handling the rollover.
> 
> Reported-by: Steve Best <sbest@redhat.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>  drivers/rtc/interface.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

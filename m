Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zb7dR6xCqzF0sn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 13:27:06 +1100 (AEDT)
Date: Tue, 6 Feb 2018 03:26:46 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, neelegup@linux.vnet.ibm.com,
 stable@vger.kernel.org
Subject: Re: rtc-opal: Fix handling of firmware error codes, prevent busy loops
Message-ID: <20180206022646.GP3404@piout.net>
References: <1470102616-18346-1-git-send-email-stewart@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470102616-18346-1-git-send-email-stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 02/08/2016 at 11:50:16 +1000, Stewart Smith wrote:
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
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> ---
>  drivers/rtc/rtc-opal.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Just a note to let you know that this patch should have gone through my
tree but it was not sent to linux-rtc or me.

I guess what happened is that Michael cleaned up the Linux PPC patchwork
queue.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

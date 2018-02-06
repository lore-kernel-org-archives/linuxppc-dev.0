Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zbCXC2cHbzF0t9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 16:22:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, neelegup@linux.vnet.ibm.com,
 stable@vger.kernel.org
Subject: Re: rtc-opal: Fix handling of firmware error codes, prevent busy loops
In-Reply-To: <20180206022646.GP3404@piout.net>
References: <1470102616-18346-1-git-send-email-stewart@linux.vnet.ibm.com>
 <20180206022646.GP3404@piout.net>
Date: Tue, 06 Feb 2018 16:22:47 +1100
Message-ID: <87bmh24rq0.fsf@concordia.ellerman.id.au>
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

Alexandre Belloni <alexandre.belloni@bootlin.com> writes:

> Hi,
>
> On 02/08/2016 at 11:50:16 +1000, Stewart Smith wrote:
>> According to the OPAL docs:
>> https://github.com/open-power/skiboot/blob/skiboot-5.2.5/doc/opal-api/opal-rtc-read-3.txt
>> https://github.com/open-power/skiboot/blob/skiboot-5.2.5/doc/opal-api/opal-rtc-write-4.txt
>> OPAL_HARDWARE may be returned from OPAL_RTC_READ or OPAL_RTC_WRITE and this
>> indicates either a transient or permanent error.
>> 
>> Prior to this patch, Linux was not dealing with OPAL_HARDWARE being a
>> permanent error particularly well, in that you could end up in a busy
>> loop.
>> 
>> This was not too hard to trigger on an AMI BMC based OpenPOWER machine
>> doing a continuous "ipmitool mc reset cold" to the BMC, the result of
>> that being that we'd get stuck in an infinite loop in opal_get_rtc_time.
>> 
>> We now retry a few times before returning the error higher up the stack.
>> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
>> ---
>>  drivers/rtc/rtc-opal.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>> 
>
> Just a note to let you know that this patch should have gone through my
> tree but it was not sent to linux-rtc or me.

Sorry, I saw it had been languishing for a long time and assumed you'd
missed it.

Happy to revert/rework it if you're not happy with it.

> I guess what happened is that Michael cleaned up the Linux PPC patchwork
> queue.

Yeah I did.

In future I'll ping you if there's something that seems to have fallen
through the cracks.

cheers

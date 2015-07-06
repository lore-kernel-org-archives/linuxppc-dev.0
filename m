Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41E511A0452
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 17:28:10 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 6 Jul 2015 12:58:05 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id ED9F4394005B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 12:57:59 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t667RvZq61669584
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 12:57:58 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t667RtZN024467
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 12:57:56 +0530
Message-ID: <1436167667.3332.23.camel@localhost.localdomain>
Subject: Re: [RESEND] powerpc/configs: enable RTC class support
From: Vaibhav <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Mon, 06 Jul 2015 12:57:47 +0530
In-Reply-To: <20150703065901.696F21402AE@ozlabs.org>
References: <20150703065901.696F21402AE@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-03 at 16:59 +1000, Michael Ellerman wrote:
> You still haven't told me what happens on a pseries machine when this
is
> applied.

Was finally able to get my hand over a pseries guest lpar today so
dumping the results below. I have aggregated results for each
configuration namely host & guest version; with each with/without the
patch. So in all results for 4 different configurations.

-------------------------
*host-kernel/without patch
-------------------------

Without the patch the hwclock fails with an error message:

[root@tul169p1 ~]# hwclock
hwclock: Timed out waiting for time change.
hwclock: The Hardware Clock registers contain values that are either
invalid (e.g. 50th day of month) or beyond the range we can handle (e.g.
Year 2095).

Debug message of hwclock reveal that hwclock cannot detect any tick in
the RTC clock. This is due to older genrtc driver being used instead of
newer rtc-opal driver.

-------------------------
*host-kernel/with patch
-------------------------

The patch enables the rtc-opal driver by enabling CONFIG_RTC_CLASS. So
the hwclock starts working. Below is the command log:

[root@tul169p1 ~]# hwclock -r
Fri 03 Jul 2015 03:54:31 AM CDT  -0.876949 seconds

--------------------------
*guest-kernel/without patch
---------------------------
Without the patch hwclock still works but uses the legacy generic-rtc.
Below is the output indicating that:

linux-3bot:/ # hwclock -r
Sun Jul  5 21:19:51 2015  -0.885070 seconds

linux-3bot:/ # ls /dev/class/rtc
ls: cannot access /dev/class/rtc: No such file or directory

--------------------------
*guest-kernel/with patch
---------------------------
With the patch, which enables the new rtc_class framework, the legacy
behavior is still used preserved. Below is the output indicating that:
linux-3bot:~ # hwclock -r
Sun Jul  5 21:36:53 2015  -0.704169 seconds

linux-3bot:~ # ls /sys/class/rtc
rtc0

~Vaibhav

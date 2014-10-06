Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A9B41A01F4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Oct 2014 16:26:30 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Mon, 6 Oct 2014 10:56:26 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3B2FE3940048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Oct 2014 10:56:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s965QqTv63897764
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Oct 2014 10:56:52 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s965QLvb017118
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Oct 2014 10:56:21 +0530
Message-ID: <543227B6.7010707@linux.vnet.ibm.com>
Date: Mon, 06 Oct 2014 10:55:10 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: devicetree@vger.kernel.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, rtc-linux@googlegroups.com,
 a.zummo@towertech.it
Subject: Re: [PATCH v2] rtc/tpo: Driver to support rtc and wakeup on PowerNV
 platform
References: <20140930101448.9310.32342.stgit@localhost.localdomain>
In-Reply-To: <20140930101448.9310.32342.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: benh@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09/30/2014 03:46 PM, Neelesh Gupta wrote:
> The patch implements the OPAL rtc driver that binds with the rtc
> driver subsystem. The driver uses the platform device infrastructure
> to probe the rtc device and register it to rtc class framework. The
> 'wakeup' is supported depending upon the property 'has-tpo' present
> in the OF node. It provides a way to load the generic rtc driver in
> in the absence of an OPAL driver.
>
> The patch also moves the existing OPAL rtc get/set time interfaces to the
> new driver and exposes the necessary OPAL calls using EXPORT_SYMBOL_GPL.
>
> Test results:
> -------------
> Host:
> [root@tul163p1 ~]# ls -l /sys/class/rtc/
> total 0
> lrwxrwxrwx 1 root root 0 Sep 30 04:58 rtc0 -> ../../devices/opal-rtc/rtc/rtc0
> [root@tul163p1 ~]# cat /sys/devices/opal-rtc/rtc/rtc0/time
> 10:01:51
> [root@tul163p1 ~]# cat /sys/devices/opal-rtc/rtc/rtc0/time
> 10:02:07
> [root@tul163p1 ~]# echo `date '+%s' -d '+ 3 minutes'` > /sys/class/rtc/rtc0/wakealarm
> [root@tul163p1 ~]# cat /sys/class/rtc/rtc0/wakealarm
> 1412071532
> [root@tul163p1 ~]#
>
> FSP:
> $ smgr mfgState
> standby
> $ smgr mfgState
> ipling
> $
>
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> ---
>
> Changes in v2
> =============
> - Added Documentation/devicetree/bindings/rtc/rtc-opal.txt
> - Explicitly turn off RTC_UIE mode by setting 'rtc->uie_unsupported'
>
> Dependency
> ==========
> This patch depends upon the below patch posted on 'linuxppc-dev@lists.ozlabs.org'
> [PATCH 1/4] powerpc/powernv: Add OPAL check token call
> Signed-off-by: Michael Neuling <mikey@neuling.org>
>
>   Documentation/devicetree/bindings/rtc/rtc-opal.txt |   16 +
>   arch/powerpc/include/asm/opal.h                    |    7 -
>   arch/powerpc/kernel/time.c                         |    1
>   arch/powerpc/platforms/powernv/opal-async.c        |    3
>   arch/powerpc/platforms/powernv/opal-rtc.c          |   63 +----
>   arch/powerpc/platforms/powernv/opal-wrappers.S     |    2
>   arch/powerpc/platforms/powernv/opal.c              |    6
>   arch/powerpc/platforms/powernv/setup.c             |    2
>   drivers/rtc/Kconfig                                |   11 +
>   drivers/rtc/Makefile                               |    1
>   drivers/rtc/rtc-opal.c                             |  261 ++++++++++++++++++++
>   11 files changed, 325 insertions(+), 48 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/rtc/rtc-opal.txt
>   create mode 100644 drivers/rtc/rtc-opal.c

Hi Alessandro,

The patch depends upon few things in powerpc tree so could you please 
Ack the
patch so that we can take it through the powerpc tree?

Thanks,
- Neelesh

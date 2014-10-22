Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80B361A0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 19:49:46 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Wed, 22 Oct 2014 18:49:45 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0B51E2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 19:49:41 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9M8pfPZ25428116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 19:51:41 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9M8nejd004159
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 19:49:40 +1100
Message-ID: <54476F4B.8050108@linux.vnet.ibm.com>
Date: Wed, 22 Oct 2014 14:18:11 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: devicetree@vger.kernel.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, rtc-linux@googlegroups.com,
 a.zummo@towertech.it
Subject: Re: [PATCH v3] rtc/tpo: Driver to support rtc and wakeup on PowerNV
 platform
References: <20141014083447.7505.89771.stgit@localhost.localdomain>
In-Reply-To: <20141014083447.7505.89771.stgit@localhost.localdomain>
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


On 10/14/2014 02:08 PM, Neelesh Gupta wrote:
> The patch implements the OPAL rtc driver that binds with the rtc
> driver subsystem. The driver uses the platform device infrastructure
> to probe the rtc device and register it to rtc class framework. The
> 'wakeup' is supported depending upon the property 'has-tpo' present
> in the OF node. It provides a way to load the generic rtc driver in
> in the absence of an OPAL driver.
>
> The patch also moves the existing OPAL rtc get/set time interfaces to the
> new driver and exposes the necessary OPAL calls using EXPORT_SYMBOL_GPL.

Hi Alessandro,

Awaiting Ack from your side, so that we can take this through the 
powerpc tree.

Regards,
Neelesh

>
> Test results:
> -------------
> Host:
> [root@tul169p1 ~]# ls -l /sys/class/rtc/
> total 0
> lrwxrwxrwx 1 root root 0 Oct 14 03:07 rtc0 -> ../../devices/opal-rtc/rtc/rtc0
> [root@tul169p1 ~]# cat /sys/devices/opal-rtc/rtc/rtc0/time
> 08:10:07
> [root@tul169p1 ~]# echo `date '+%s' -d '+ 2 minutes'` > /sys/class/rtc/rtc0/wakealarm
> [root@tul169p1 ~]# cat /sys/class/rtc/rtc0/wakealarm
> 1413274345
> [root@tul169p1 ~]#
>
> FSP:
> $ smgr mfgState
> standby
> $ rtim timeofday
>
> System time is valid: 2014/10/14 08:12:04.225115
>
> $ smgr mfgState
> ipling
> $
>
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> ---
>
> Changes in v3
> =============
> - Rebased to the latest tree.
>
> Changes in v2
> =============
> - Added Documentation/devicetree/bindings/rtc/rtc-opal.txt
> - Explicitly turn off RTC_UIE mode by setting 'rtc->uie_unsupported'
>
>   Documentation/devicetree/bindings/rtc/rtc-opal.txt |   16 +
>   arch/powerpc/include/asm/opal.h                    |    7 -
>   arch/powerpc/kernel/time.c                         |    1
>   arch/powerpc/platforms/powernv/opal-async.c        |    3
>   arch/powerpc/platforms/powernv/opal-rtc.c          |   65 +----
>   arch/powerpc/platforms/powernv/opal-wrappers.S     |    2
>   arch/powerpc/platforms/powernv/opal.c              |    6
>   arch/powerpc/platforms/powernv/setup.c             |    2
>   drivers/rtc/Kconfig                                |   11 +
>   drivers/rtc/Makefile                               |    1
>   drivers/rtc/rtc-opal.c                             |  261 ++++++++++++++++++++
>   11 files changed, 325 insertions(+), 50 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/rtc/rtc-opal.txt
>   create mode 100644 drivers/rtc/rtc-opal.c
>

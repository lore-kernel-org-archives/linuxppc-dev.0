Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 906D82C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 12:45:06 +1000 (EST)
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E4EA43EE0C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 11:45:03 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id CFB2945DE59
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 11:45:03 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9A41F45DE57
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 11:45:03 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 827D31DB8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 11:45:03 +0900 (JST)
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local
 (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id EDD4B1DB8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 11:45:02 +0900 (JST)
Message-ID: <522006F6.2060206@jp.fujitsu.com>
Date: Fri, 30 Aug 2013 11:44:06 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v2 0/4] Unify CPU hotplug lock interface
References: <1377822129-4143-1-git-send-email-toshi.kani@hp.com>
In-Reply-To: <1377822129-4143-1-git-send-email-toshi.kani@hp.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: fenghua.yu@intel.com, bp@suse.de, gregkh@linuxfoundation.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl,
 linux-acpi@vger.kernel.org, mingo@redhat.com, srivatsa.bhat@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, tglx@linutronix.de, hpa@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2013/08/30 9:22), Toshi Kani wrote:
> lock_device_hotplug() was recently introduced to serialize CPU & Memory
> online/offline and hotplug operations, along with sysfs online interface
> restructure (commit 4f3549d7).  With this new locking scheme,
> cpu_hotplug_driver_lock() is redundant and is no longer necessary.
> 
> This patchset makes sure that lock_device_hotplug() covers all CPU online/
> offline interfaces, and then removes cpu_hotplug_driver_lock().
> 
> v2:
>   - Rebased to the pm tree, bleeding-edge.
>   - Changed patch 2/4 to use lock_device_hotplug_sysfs().
> 
> ---
> Toshi Kani (4):
>    hotplug, x86: Fix online state in cpu0 debug interface
>    hotplug, x86: Add hotplug lock to missing places
>    hotplug, x86: Disable ARCH_CPU_PROBE_RELEASE on x86
>    hotplug, powerpc, x86: Remove cpu_hotplug_driver_lock()
> 
> ---
The patch-set looks good to me.

Acked-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks,
Yasuaki Ishimatsu


>   arch/powerpc/kernel/smp.c              | 12 ----------
>   arch/powerpc/platforms/pseries/dlpar.c | 40 +++++++++++++---------------------
>   arch/x86/Kconfig                       |  4 ----
>   arch/x86/kernel/smpboot.c              | 21 ------------------
>   arch/x86/kernel/topology.c             | 11 ++++++----
>   drivers/base/cpu.c                     | 34 +++++++++++++++++++----------
>   include/linux/cpu.h                    | 13 -----------
>   7 files changed, 45 insertions(+), 90 deletions(-)
> 

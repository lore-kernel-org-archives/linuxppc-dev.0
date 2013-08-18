Return-Path: <rjw@sisk.pl>
Received: from hydra.sisk.pl (hydra.sisk.pl [212.160.235.94])
 by ozlabs.org (Postfix) with ESMTP id 186AC2C0148
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 10:51:55 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 0/4] Unify CPU hotplug lock interface
Date: Sun, 18 Aug 2013 03:02:25 +0200
Message-ID: <1449558.tneKXFMIWE@vostro.rjw.lan>
In-Reply-To: <1376768819-28975-1-git-send-email-toshi.kani@hp.com>
References: <1376768819-28975-1-git-send-email-toshi.kani@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: fenghua.yu@intel.com, bp@suse.de, gregkh@linuxfoundation.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, isimatu.yasuaki@jp.fujitsu.com,
 mingo@redhat.com, srivatsa.bhat@linux.vnet.ibm.com, tglx@linutronix.de,
 hpa@linux.intel.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday, August 17, 2013 01:46:55 PM Toshi Kani wrote:
> lock_device_hotplug() was recently introduced to serialize CPU & Memory
> online/offline and hotplug operations, along with sysfs online interface
> restructure (commit 4f3549d7).  With this new locking scheme,
> cpu_hotplug_driver_lock() is redundant and is no longer necessary.
> 
> This patchset makes sure that lock_device_hotplug() covers all CPU online/
> offline interfaces, and then removes cpu_hotplug_driver_lock().
> 
> The patchset is based on Linus's tree, 3.11.0-rc5.

Nice series, thanks a lot for taking care of this!

Rafael


> ---
> Toshi Kani (4):
>   hotplug, x86: Fix online state in cpu0 debug interface
>   hotplug, x86: Add hotplug lock to missing places
>   hotplug, x86: Disable ARCH_CPU_PROBE_RELEASE on x86
>   hotplug, powerpc, x86: Remove cpu_hotplug_driver_lock()
> 
> ---
>  arch/powerpc/kernel/smp.c              | 12 ----------
>  arch/powerpc/platforms/pseries/dlpar.c | 40 +++++++++++++---------------------
>  arch/x86/Kconfig                       |  4 ----
>  arch/x86/kernel/smpboot.c              | 21 ------------------
>  arch/x86/kernel/topology.c             | 11 ++++++----
>  drivers/base/cpu.c                     | 26 ++++++++++++----------
>  include/linux/cpu.h                    | 13 -----------
>  7 files changed, 37 insertions(+), 90 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

Return-Path: <toshi.kani@hp.com>
Received: from g4t0014.houston.hp.com (g4t0014.houston.hp.com [15.201.24.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4D2882C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 03:26:44 +1000 (EST)
Message-ID: <1377796510.10300.868.camel@misato.fc.hp.com>
Subject: Re: [PATCH 0/4] Unify CPU hotplug lock interface
From: Toshi Kani <toshi.kani@hp.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 29 Aug 2013 11:15:10 -0600
In-Reply-To: <1449558.tneKXFMIWE@vostro.rjw.lan>
References: <1376768819-28975-1-git-send-email-toshi.kani@hp.com>
 <1449558.tneKXFMIWE@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Sun, 2013-08-18 at 03:02 +0200, Rafael J. Wysocki wrote:
> On Saturday, August 17, 2013 01:46:55 PM Toshi Kani wrote:
> > lock_device_hotplug() was recently introduced to serialize CPU & Memory
> > online/offline and hotplug operations, along with sysfs online interface
> > restructure (commit 4f3549d7).  With this new locking scheme,
> > cpu_hotplug_driver_lock() is redundant and is no longer necessary.
> > 
> > This patchset makes sure that lock_device_hotplug() covers all CPU online/
> > offline interfaces, and then removes cpu_hotplug_driver_lock().
> > 
> > The patchset is based on Linus's tree, 3.11.0-rc5.
> 
> Nice series, thanks a lot for taking care of this!

Hi Rafael,

Per the recent your changes in lock_device_hotplug(), do you think it
makes sense to integrate this patchset into your tree?  I am also
considering to add one more patch to use lock_device_hotplug_sysfs() in
cpu_probe_store().  I will rebase to your tree and send them today if it
makes sense to you.

Thanks,
-Toshi


> 
> Rafael
> 
> 
> > ---
> > Toshi Kani (4):
> >   hotplug, x86: Fix online state in cpu0 debug interface
> >   hotplug, x86: Add hotplug lock to missing places
> >   hotplug, x86: Disable ARCH_CPU_PROBE_RELEASE on x86
> >   hotplug, powerpc, x86: Remove cpu_hotplug_driver_lock()
> > 
> > ---
> >  arch/powerpc/kernel/smp.c              | 12 ----------
> >  arch/powerpc/platforms/pseries/dlpar.c | 40 +++++++++++++---------------------
> >  arch/x86/Kconfig                       |  4 ----
> >  arch/x86/kernel/smpboot.c              | 21 ------------------
> >  arch/x86/kernel/topology.c             | 11 ++++++----
> >  drivers/base/cpu.c                     | 26 ++++++++++++----------
> >  include/linux/cpu.h                    | 13 -----------
> >  7 files changed, 37 insertions(+), 90 deletions(-)
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

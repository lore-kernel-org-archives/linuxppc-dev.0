Return-Path: <B35336@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A22292C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 21:26:24 +1000 (EST)
Date: Thu, 13 Jun 2013 19:25:52 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/sysfs: disable hotplug for the boot cpu
Message-ID: <20130613112552.GC7536@localhost.localdomain>
References: <1369727984-21505-1-git-send-email-chenhui.zhao@freescale.com>
 <1369727984-21505-2-git-send-email-chenhui.zhao@freescale.com>
 <1370036984.3928.144.camel@pasglop>
 <20130603104315.GA1365@localhost.localdomain>
 <1371007522.8250.169.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1371007522.8250.169.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 12, 2013 at 01:25:22PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2013-06-03 at 18:43 +0800, Zhao Chenhui wrote:
> > On Sat, Jun 01, 2013 at 07:49:44AM +1000, Benjamin Herrenschmidt wrote:
> > > On Tue, 2013-05-28 at 15:59 +0800, Zhao Chenhui wrote:
> > > > Some features depend on the boot cpu, for instance, hibernate/suspend.
> > > > So disable hotplug for the boot cpu.
> > > 
> > > Don't we have code to "move" the boot CPU around when that happens ?
> > > 
> > > Ben.
> > > 
> > 
> > Currently, the code in generic_cpu_disable() likes this:
> > 
> >         if (cpu == boot_cpuid)                                                 
> > 	                return -EBUSY;
> 
> But the code in pseries/hotplug-cpu.c doesn't, we just "move" the boot
> CPU around when that happens. Any reason we can't do that generically ?
> 
> Cheers,
> Ben.
> 

Some multicore SoCs firstly boot up the cpu0 after warm reset.
In some suspend/resume cases, SoC will do a warm reset when resuming.
In order to ensure that the suspending and resuming is running
on a same cpu, cpu0 should be the last cpu to suspend. Here, cpu0 is
the boot_cpuid.

-Chenhui

> > If the dying cpu is the boot cpu, it will return -EBUSY. In the subsequent error handling,
> > cpu_notify_nofail(CPU_DOWN_FAILED) in _cpu_down() will be called. Unfortunately, some
> > cpu notifier callbacks handled CPU_DOWN_PREPARE, but not CPU_DOWN_FAILED, such as sched_cpu_inactive().
> > So it will cause issues.
> > 
> > If we set the hotpluggable for the boot cpu, we can prevent user applications from disabling the boot cpu.
> > 
> > -Chenhui
> > 

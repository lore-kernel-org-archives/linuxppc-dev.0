Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwyTQ73wkzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 12:34:50 +1000 (AEST)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Fri, 29 Apr 2016 08:04:48 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9CF31125805B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 08:06:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3T2YjQP22609966
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 08:04:45 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3T2Yf8l005244
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 08:04:44 +0530
Message-ID: <5722C834.1030209@linux.vnet.ibm.com>
Date: Fri, 29 Apr 2016 10:34:28 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Waiman Long <waiman.long@hpe.com>
CC: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
 Boqun Feng <boqun.feng@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, jeremy@goop.org,
 chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au,
 gwshan@linux.vnet.ibm.com, adam.buchbinder@gmail.com,
 tglx@linutronix.de, marc.zyngier@arm.com
Subject: Re: [PATCH resend] powerpc: enable qspinlock and its virtualization
 support
References: <5721EC0E.8040506@linux.vnet.ibm.com> <57227BAA.7040807@hpe.com>
In-Reply-To: <57227BAA.7040807@hpe.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 2016年04月29日 05:07, Waiman Long wrote:
> On 04/28/2016 06:55 AM, Pan Xinhui wrote:
>> From: Pan Xinhui<xinhui.pan@linux.vnet.ibm.com>
>>
>> This patch aims to enable qspinlock on PPC. And on pseries platform, it also support
>> paravirt qspinlock.
>>
>> Signed-off-by: Pan Xinhui<xinhui.pan@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/qspinlock.h               | 37 +++++++++++++++
>>   arch/powerpc/include/asm/qspinlock_paravirt.h      | 36 +++++++++++++++
>>   .../powerpc/include/asm/qspinlock_paravirt_types.h | 13 ++++++
>>   arch/powerpc/include/asm/spinlock.h                | 31 ++++++++-----
>>   arch/powerpc/include/asm/spinlock_types.h          |  4 ++
>>   arch/powerpc/kernel/paravirt.c                     | 52 ++++++++++++++++++++++
>>   arch/powerpc/lib/locks.c                           | 32 +++++++++++++
>>   arch/powerpc/platforms/pseries/setup.c             |  5 +++
>>   8 files changed, 198 insertions(+), 12 deletions(-)
>>   create mode 100644 arch/powerpc/include/asm/qspinlock.h
>>   create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
>>   create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
>>   create mode 100644 arch/powerpc/kernel/paravirt.c
>>
>>
> 
> This is just an enablement patch. You will also need a patch to activate qspinlock for, at lease, some PPC configs. Right?
> 
yep, I want to enable these config and makefile at last.
it just looks like

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2da380f..ae7c2f1 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
 obj-$(CONFIG_PPC_P7_NAP)	+= idle_power7.o
 procfs-y			:= proc_powerpc.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
+obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= paravirt.o
 rtaspci-$(CONFIG_PPC64)-$(CONFIG_PCI)	:= rtas_pci.o
 obj-$(CONFIG_PPC_RTAS)		+= rtas.o rtas-rtc.o $(rtaspci-y-y)
 obj-$(CONFIG_PPC_RTAS_DAEMON)	+= rtasd.o
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index bec90fb..46632e4 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -21,6 +21,7 @@ config PPC_PSERIES
 	select HOTPLUG_CPU if SMP
 	select ARCH_RANDOM
 	select PPC_DOORBELL
+	select ARCH_USE_QUEUED_SPINLOCKS
 	default y
 
 config PPC_SPLPAR
@@ -127,3 +128,11 @@ config HV_PERF_CTRS
 	  systems. 24x7 is available on Power 8 systems.
 
           If unsure, select Y.
+
+config PARAVIRT_SPINLOCKS
+	bool "Paravirtialization support for qspinlock"
+	depends on PPC_SPLPAR && QUEUED_SPINLOCKS
+	default y
+	help
+	  If platform supports virtualization, for example PowerVM, this option
+	  can let guest have a better performace.
-- 
2.4.3

> It has dependency on the pv_wait() patch that I sent out extend the parameter list. Some performance data on how PPC system will perform with and without qspinlock will also be helpful data points.
> 
For now, pv_wait defined in ppc is static inline void pv_wait(u8 *ptr, u8 val)
My plan is that waiting your patch goes in kernel tree first, then I send out another patch to extend the parameter list.

yes, I need copy some performance data in my patch's comments.

thanks
xinhui
> Cheers,
> Longman
> 

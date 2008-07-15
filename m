Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id D4BFFDDEEA
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 00:16:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 82xx performance
Date: Tue, 15 Jul 2008 09:16:43 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04AE662E@ismail.innsys.innovsys.com>
In-Reply-To: <200807142244.07450.arnd@arndb.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807142244.07450.arnd@arndb.de>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This is certainly significant, but a lot has happened between the two
> versions. I few ideas:
>=20
> * compare some of the key configuration options:
>   # CONFIG_DEBUG_*
>   # CONFIG_PREEMPT*
>   # CONFIG_NO_HZ
>   # CONFIG_HZ

2.6.25:
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_FS is not set
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SHIRQ is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_INFO=3Dy
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUGGER is not set

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
# CONFIG_PREEMPT_RCU is not set

# CONFIG_NO_HZ is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=3Dy
CONFIG_HZ=3D1000


2.6.18:
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=3Dy
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_BKL=3Dy

# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=3Dy
CONFIG_HZ=3D1000


>=20
> * Try looking at where the time is spent, using oprofile or=20
> readprofile

Doing this now.
>=20
> * Try setting /proc/sys/kernel/compat/sched_yield to 1, to=20
> get the legacy
> behaviour of the scheduler.

Made perfromance on .25 a few percent worse. (84 minutes on kernel
compile instead of 81 minutes)
=20
> * Maybe there is a kernel version that supports your hardware in both
> arch/ppc/ and arch/powerpc. In that case, you could see if=20
> the platform
> change had an impact.

Will try. Last port in ppc branch was 2.6.18 and first in powerpc was
2.6.24.
I should be able to port ppc to .25 also I think.

Thanks!

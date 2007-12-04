Return-Path: <mgreer@mvista.com>
Date: Mon, 3 Dec 2007 22:37:36 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [RFC 0/7] powerpc: Rework pm_power_off &
	machine_[restart|power_off|halt]
Message-ID: <20071204053736.GA27862@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We seem to have the pm_power_off hook wrong in arch/powerpc.  From the
other arches and from how its used by the rest of the kernel (e.g., ipmi),
it should point to the lowest-level power off function not to
machine_power_off().  Actually, machine_power_off() should call pm_power_off
since AFAICT it is the one and only interface used by the rest of the kernel
to power a machine off (with one exception which I believe to be a bug and
have a patch in this series to fix).

While looking at this, I found several bits of code that needed minor
rework and/or cleaning up.  These bits include: refactoring some
common code used by the machine_xxx routines, having machine_power_off
call ppc_md.halt if there ppc_md.power_off is NULL or returns, having
machine_halt call ppc_md.power_off it ppc_md.halt is NULL or returns,
and removing some useless xxx_halt and xxx_power_off routines in
platform code.

With the new usage of pm_power_off, the ppc_md.power_off hook is
no longer needed and pm_power_off will be assigned in the platform
probe routine.

The end result of all of these patches should make the check of
pm_power_off being NULL in kernel/sys.c:sys_reboot useful for powerpc,
eliminate the need for platform halt routines to call the power off routine
(and vice versa), allow things like IPMI to take over pm_power_off
when they need to, and make the power off/halt related code a bit cleaner
& consistent.

I still have to make sure I didn't miss anything and I haven't compiled
all the files I've touched so these aren't submission candidates yet.

I'd appreciate any feedback.

Thanks,

Mark

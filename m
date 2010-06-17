Return-Path: <brking@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ABEDE1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 07:53:52 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5HLnRnp023153
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jun 2010 15:49:27 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o5HLrikS103676
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jun 2010 15:53:46 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o5HLrhH0026109
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jun 2010 15:53:44 -0600
Message-ID: <4C1A9966.7040002@linux.vnet.ibm.com>
Date: Thu, 17 Jun 2010 16:53:42 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: [PATCHv2 0/2] powerpc: pSeries Partition Hibernation
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is a refresh of partition hibernation support for pSeries.
It includes a fix for a regression in the partition migration
support. Barring any objections, I think these patches should
be ready to merge.

Overview
---------
Partition Hibernation on pSeries is a new platform feature that
allows for long term suspension of a logical partition much like
suspending a laptop to disk. The primary difference is that writing
the memory image out to disk is driven by system firmware and the
Virtual I/O Server rather than from the LPAR itself. Partition
hibernation on Power is initiated from the Hardware Management Console.
The user selects the partition, then selects the suspend function.
This results in a command (drmgr) getting sent to the Linux partition,
indicating it should prepare for suspension. A "stream id" is sent
to the Linux LPAR which is used by the OS to correlate with firmware.
In the Linux LPAR, the drmgr command then writes this stream id to
a new sysfs file: /sys/devices/system/power/hibernate. The kernel
then takes over, calling H_VASI_ENABLE with the stream id as
long as firmware indicates it is suspending but not ready for
the client LPAR to enter the final phase of the suspension.

Once H_VASI_ENABLE returns a state of H_VASI_SUSPENDING, the client
OS is expected to enter the final phase of hibernation. To do this,
we then simply invoke the pm_suspend code and mimic suspend to ram.
We mimic suspend to ram rather than suspend to disk, since firmware
and the VIOS takes care of writing everything out to disk. We are
then able to leverage all the existing suspend code in the kernel.
Once we enter the prepare_late phase of suspend, we set a flag which
we check when disable_nonboot_cpus gets called. When the nonboot
CPU gets offlined and placed into the inactive state, we hook
into pseries_mach_cpu_die in order to call H_JOIN, since the
nonboot CPUs need to be in H_JOIN state when we finally suspend.
Once all the nonboot CPUs have been offlined and are in H_JOIN,
and we get to the "enter" state, we make the ibm,suspend-me RTAS
call on the remaining CPU which then completes the hibernation.

When we resume, there is very little platform code required to
execute. enable_nonboot_cpus already sends an H_PROD as part
of bringing up the nonboot cpus, so this will kick the CPU out
of H_JOIN. I've already added resume handlers to the virtual
I/O drivers to check for any dropped interrupts. drmgr then
handles updating the device tree just like it does today
for live partition migration.

These patches have been tested with repeated suspend/resume
cycles. Partition migration has also been regression tested
since the first patch touches that path.

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center

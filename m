Return-Path: <ahuja@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1692DDE18
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 06:27:04 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0MJR1oi028398
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:27:01 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0MJR13b148648
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:27:01 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0MJR0Sn015549
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:27:01 -0500
Message-ID: <47964382.1030305@austin.ibm.com>
Date: Tue, 22 Jan 2008 13:26:58 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>,
	linasvepstas@gmail.com
Subject: [PATCH 1/8] pseries: phyp dump: Docmentation
References: <4796401D.5010907@austin.ibm.com>
In-Reply-To: <4796401D.5010907@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Larry Kessler <lkessler@us.ibm.com>,
	Michael Strosaker <strosake@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Basic documentation for hypervisor-assisted dump.

Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>
Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>

----
 Documentation/powerpc/phyp-assisted-dump.txt |  129 +++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

Index: 2.6.24-rc5/Documentation/powerpc/phyp-assisted-dump.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.24-rc5/Documentation/powerpc/phyp-assisted-dump.txt	2008-01-07 18:05:46.000000000 -0600
@@ -0,0 +1,129 @@
+
+                   Hypervisor-Assisted Dump
+                   ------------------------
+                       November 2007
+
+The goal of hypervisor-assisted dump is to enable the dump of
+a crashed system, and to do so from a fully-reset system, and
+to minimize the total elapsed time until the system is back
+in production use.
+
+As compared to kdump or other strategies, hypervisor-assisted
+dump offers several strong, practical advantages:
+
+-- Unlike kdump, the system has been reset, and loaded
+   with a fresh copy of the kernel.  In particular,
+   PCI and I/O devices have been reinitialized and are
+   in a clean, consistent state.
+-- As the dump is performed, the dumped memory becomes
+   immediately available to the system for normal use.
+-- After the dump is completed, no further reboots are
+   required; the system will be fully usable, and running
+   in it's normal, production mode on it normal kernel.
+
+The above can only be accomplished by coordination with,
+and assistance from the hypervisor. The procedure is
+as follows:
+
+-- When a system crashes, the hypervisor will save
+   the low 256MB of RAM to a previously registered
+   save region. It will also save system state, system
+   registers, and hardware PTE's.
+
+-- After the low 256MB area has been saved, the
+   hypervisor will reset PCI and other hardware state.
+   It will *not* clear RAM. It will then launch the
+   bootloader, as normal.
+
+-- The freshly booted kernel will notice that there
+   is a new node (ibm,dump-kernel) in the device tree,
+   indicating that there is crash data available from
+   a previous boot. It will boot into only 256MB of RAM,
+   reserving the rest of system memory.
+
+-- Userspace tools will parse /sys/kernel/release_region
+   and read /proc/vmcore to obtain the contents of memory,
+   which holds the previous crashed kernel. The userspace
+   tools may copy this info to disk, or network, nas, san,
+   iscsi, etc. as desired.
+
+   For Example: the values in /sys/kernel/release-region
+   would look something like this (address-range pairs).
+   CPU:0x177fee000-0x10000: HPTE:0x177ffe020-0x1000: /
+   DUMP:0x177fff020-0x10000000, 0x10000000-0x16F1D370A
+
+-- As the userspace tools complete saving a portion of
+   dump, they echo an offset and size to
+   /sys/kernel/release_region to release the reserved
+   memory back to general use.
+
+   An example of this is:
+     "echo 0x40000000 0x10000000 > /sys/kernel/release_region"
+   which will release 256MB at the 1GB boundary.
+
+Please note that the hypervisor-assisted dump feature
+is only available on Power6-based systems with recent
+firmware versions.
+
+Implementation details:
+----------------------
+In order for this scheme to work, memory needs to be reserved
+quite early in the boot cycle. However, access to the device
+tree this early in the boot cycle is difficult, and device-tree
+access is needed to determine if there is a crash data waiting.
+To work around this problem, all but 256MB of RAM is reserved
+during early boot. A short while later in boot, a check is made
+to determine if there is dump data waiting. If there isn't,
+then the reserved memory is released to general kernel use.
+If there is dump data, then the /sys/kernel/release_region
+file is created, and the reserved memory is held.
+
+If there is no waiting dump data, then all but 256MB of the
+reserved ram will be released for general kernel use. The
+highest 256 MB of RAM will *not* be released: this region
+will be kept permanently reserved, so that it can act as
+a receptacle for a copy of the low 256MB in the case a crash
+does occur. See, however, "open issues" below, as to whether
+such a reserved region is really needed.
+
+Currently the dump will be copied from /proc/vmcore to a
+a new file upon user intervention. The starting address
+to be read and the range for each data point in provided
+in /sys/kernel/release_region.
+
+The tools to examine the dump will be same as the ones
+used for kdump.
+
+
+General notes:
+--------------
+Security: please note that there are potential security issues
+with any sort of dump mechanism. In particular, plaintext
+(unencrypted) data, and possibly passwords, may be present in
+the dump data. Userspace tools must take adequate precautions to
+preserve security.
+
+Open issues/ToDo:
+------------
+ o The various code paths that tell the hypervisor that a crash
+   occurred, vs. it simply being a normal reboot, should be
+   reviewed, and possibly clarified/fixed.
+
+ o Instead of using /sys/kernel, should there be a /sys/dump
+   instead? There is a dump_subsys being created by the s390 code,
+   perhaps the pseries code should use a similar layout as well.
+
+ o Is reserving a 256MB region really required? The goal of
+   reserving a 256MB scratch area is to make sure that no
+   important crash data is clobbered when the hypervisor
+   save low mem to the scratch area. But, if one could assure
+   that nothing important is located in some 256MB area, then
+   it would not need to be reserved. Something that can be
+   improved in subsequent versions.
+
+ o Still working the kdump team to integrate this with kdump,
+   some work remains but this would not affect the current
+   patches.
+
+ o Still need to write a shell script, to copy the dump away.
+   Currently I am parsing it manually.

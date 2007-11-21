Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9454EDDE1A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 09:37:52 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lALMbnc5005838
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 17:37:49 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lALMbnSl118646
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 15:37:49 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lALMbmJ6014169
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 15:37:48 -0700
Date: Wed, 21 Nov 2007 16:37:48 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH/RFC 1/6]: phyp dump: Documentation
Message-ID: <20071121223748.GA26122@austin.ibm.com>
References: <20071121223639.GB4374@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071121223639.GB4374@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: mahuja@us.ibm.com, lkessler@us.ibm.com, strosake@us.ibm.com,
	mahuja@austin.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Basic documentation for hypervisor-assisted dump.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 Documentation/powerpc/phyp-assisted-dump.txt |  126 +++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

Index: linux-2.6.24-rc3-git1/Documentation/powerpc/phyp-assisted-dump.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.24-rc3-git1/Documentation/powerpc/phyp-assisted-dump.txt	2007-11-21 16:26:44.000000000 -0600
@@ -0,0 +1,126 @@
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
+-- Userspace tools will read /proc/kcore to obtain the
+   contents of memory, which holds the previous crashed
+   kernel. The userspace tools may copy this info to
+   disk, or network, nas, san, iscsi, etc. as desired.
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
+General notes:
+--------------
+Security: please note that there are potential security issues
+with any sort of dump mechanism. In particular, plaintext
+(unencrypted) data, and possibly passwords, may be present in
+the dump data. Userspace tools must take adequate precautions to
+preserve security.
+
+Open issues:
+------------
+ o User-space dump tool integration is completely unresolved.
+
+ o The various code paths that tell the hypervisor that a crash
+   occurred, vs. it simply being a normal reboot, should be
+   reviewed, and possibly clarified/fixed.
+
+ o The real-virtual mapping is awkward and unaddressed. There
+   is currently no clear way of matching up the contents of
+   /proc/kcore to the values that need to be sent to
+   /sys/kernel/release_region
+
+ o Instead of using /sys/kernel, should there be a /sys/dump
+   instead? There is a dump_subsys being created by the s390 code,
+   perhaps the pseries code should use a similar layout as well.
+
+ o Saved system registers and HPTE tables will be located in high
+   memory. There is currently no way of telling user-space where
+   these are located.
+
+ o The post-dump procedures are incomplete. In particular,
+   after a dump as been taken, the system should re-register
+   with the hypervisor, so that a subsequent crash can be handled.
+
+ o The hypervisor may have an error preserving the dump data.
+   The current code does not check for this error, and does
+   not handle it.
+
+ o Is reserving a 256MB region really required? The goal of
+   reserving a 256MB scratch area is to make sure that no
+   important crash data is clobbered when the hypervisor
+   save low mem to the scratch area. But, if one could assure
+   that nothing important is located in some 256MB area, then
+   it would not need to be reserved.
+

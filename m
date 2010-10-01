Return-Path: <nfont@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B269FB717C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 04:37:54 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o91IT6An022737
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 12:29:06 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o91Ibq7s211728
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 12:37:52 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o91Ibonh025178
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 12:37:51 -0600
Message-ID: <4CA62A7D.8030905@austin.ibm.com>
Date: Fri, 01 Oct 2010 13:37:49 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 9/9] v3 Update memory hotplug documentation
References: <4CA62700.7010809@austin.ibm.com>
In-Reply-To: <4CA62700.7010809@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, Robin Holt <holt@sgi.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the memory hotplug documentation to reflect the new behaviors of
memory blocks reflected in sysfs.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---
 Documentation/memory-hotplug.txt |   47 +++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 16 deletions(-)

Index: linux-next/Documentation/memory-hotplug.txt
===================================================================
--- linux-next.orig/Documentation/memory-hotplug.txt	2010-09-29 14:56:24.000000000 -0500
+++ linux-next/Documentation/memory-hotplug.txt	2010-09-30 14:59:47.000000000 -0500
@@ -126,36 +126,51 @@
 --------------------------------
 4 sysfs files for memory hotplug
 --------------------------------
-All sections have their device information under /sys/devices/system/memory as
+All sections have their device information in sysfs.  Each section is part of
+a memory block under /sys/devices/system/memory as
 
 /sys/devices/system/memory/memoryXXX
-(XXX is section id.)
+(XXX is the section id.)
 
-Now, XXX is defined as start_address_of_section / section_size.
+Now, XXX is defined as (start_address_of_section / section_size) of the first
+section contained in the memory block.  The files 'phys_index' and
+'end_phys_index' under each directory report the beginning and end section id's
+for the memory block covered by the sysfs directory.  It is expected that all
+memory sections in this range are present and no memory holes exist in the
+range. Currently there is no way to determine if there is a memory hole, but
+the existence of one should not affect the hotplug capabilities of the memory
+block.
 
 For example, assume 1GiB section size. A device for a memory starting at
 0x100000000 is /sys/device/system/memory/memory4
 (0x100000000 / 1Gib = 4)
 This device covers address range [0x100000000 ... 0x140000000)
 
-Under each section, you can see 4 files.
+Under each section, you can see 4 or 5 files, the end_phys_index file being
+a recent addition and not present on older kernels.
 
-/sys/devices/system/memory/memoryXXX/phys_index
+/sys/devices/system/memory/memoryXXX/start_phys_index
+/sys/devices/system/memory/memoryXXX/end_phys_index
 /sys/devices/system/memory/memoryXXX/phys_device
 /sys/devices/system/memory/memoryXXX/state
 /sys/devices/system/memory/memoryXXX/removable
 
-'phys_index' : read-only and contains section id, same as XXX.
-'state'      : read-write
-               at read:  contains online/offline state of memory.
-               at write: user can specify "online", "offline" command
-'phys_device': read-only: designed to show the name of physical memory device.
-               This is not well implemented now.
-'removable'  : read-only: contains an integer value indicating
-               whether the memory section is removable or not
-               removable.  A value of 1 indicates that the memory
-               section is removable and a value of 0 indicates that
-               it is not removable.
+'phys_index'      : read-only and contains section id of the first section
+		    in the memory block, same as XXX.
+'end_phys_index'  : read-only and contains section id of the last section
+		    in the memory block.
+'state'           : read-write
+                    at read:  contains online/offline state of memory.
+                    at write: user can specify "online", "offline" command
+                    which will be performed on al sections in the block.
+'phys_device'     : read-only: designed to show the name of physical memory
+                    device.  This is not well implemented now.
+'removable'       : read-only: contains an integer value indicating
+                    whether the memory block is removable or not
+                    removable.  A value of 1 indicates that the memory
+                    block is removable and a value of 0 indicates that
+                    it is not removable. A memory block is removable only if
+                    every section in the block is removable.
 
 NOTE:
   These directories/files appear after physical memory hotplug phase.

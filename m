Return-Path: <nfont@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EFC2D1007DC
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 14:00:12 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6K3mv3i008121
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 21:48:57 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6K402Ow164836
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 22:00:02 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6K401rE024559
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 22:00:02 -0600
Message-ID: <4C451F3F.8000207@austin.ibm.com>
Date: Mon, 19 Jul 2010 22:59:59 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 8/8] v3 Update memory-hotplug documentation
References: <4C451BF5.50304@austin.ibm.com>
In-Reply-To: <4C451BF5.50304@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
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

Signed-off-by: Nathan Fontent <nfont@austin.ibm.com>
---
 Documentation/memory-hotplug.txt |   40 +++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

Index: linux-2.6/Documentation/memory-hotplug.txt
===================================================================
--- linux-2.6.orig/Documentation/memory-hotplug.txt	2010-06-23 15:06:53.000000000 -0500
+++ linux-2.6/Documentation/memory-hotplug.txt	2010-07-19 21:00:11.000000000 -0500
@@ -126,36 +126,44 @@ config options.
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
+section conatined in the memory block.
 
 For example, assume 1GiB section size. A device for a memory starting at
 0x100000000 is /sys/device/system/memory/memory4
 (0x100000000 / 1Gib = 4)
 This device covers address range [0x100000000 ... 0x140000000)
 
-Under each section, you can see 4 files.
+Under each section, you can see 5 files.
 
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
+'start_phys_index' : read-only and contains section id of the first section
+		     in the memory block, same as XXX.
+'end_phys_index'   : read-only and contains section id of the last section
+		     in the memory block.
+'state'            : read-write
+                     at read:  contains online/offline state of memory.
+                     at write: user can specify "online", "offline" command
+                     which will be performed on al sections in the block.
+'phys_device'      : read-only: designed to show the name of physical memory
+                     device.  This is not well implemented now.
+'removable'        : read-only: contains an integer value indicating
+                     whether the memory block is removable or not
+                     removable.  A value of 1 indicates that the memory
+                     block is removable and a value of 0 indicates that
+                     it is not removable. A memory block is removable only if
+                     every section in the block is removable.
 
 NOTE:
   These directories/files appear after physical memory hotplug phase.

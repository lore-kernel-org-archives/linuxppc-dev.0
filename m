Return-Path: <nfont@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2977B70E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 04:23:08 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o91INJiZ002014
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 14:23:19 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o91IN0mK1986666
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 14:23:00 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o91IMwxS001907
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 15:23:00 -0300
Message-ID: <4CA62700.7010809@austin.ibm.com>
Date: Fri, 01 Oct 2010 13:22:56 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/9] v3 De-couple sysfs memory directories from memory sections
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

This set of patches decouples the concept that a single memory
section corresponds to a single directory in 
/sys/devices/system/memory/.  On systems
with large amounts of memory (1+ TB) there are performance issues
related to creating the large number of sysfs directories.  For
a powerpc machine with 1 TB of memory we are creating 63,000+
directories.  This is resulting in boot times of around 45-50
minutes for systems with 1 TB of memory and 8 hours for systems
with 2 TB of memory.  With this patch set applied I am now seeing
boot times of 5 minutes or less.

The root of this issue is in sysfs directory creation. Every time
a directory is created a string compare is done against all sibling
directories to ensure we do not create duplicates.  The list of
directory nodes in sysfs is kept as an unsorted list which results
in this being an exponentially longer operation as the number of
directories are created.

The solution solved by this patch set is to allow a single
directory in sysfs to span multiple memory sections.  This is
controlled by an optional architecturally defined function
memory_block_size_bytes().  The default definition of this
routine returns a memory block size equal to the memory section
size. This maintains the current layout of sysfs memory
directories as it appears to userspace to remain the same as it
is today.

For architectures that define their own version of this routine,
as is done for powerpc and x86_64 in this patchset, the view in userspace
would change such that each memoryXXX directory would span
multiple memory sections.  The number of sections spanned would
depend on the value reported by memory_block_size_bytes.

In both cases a new file 'end_phys_index' is created in each
memoryXXX directory.  This file will contain the physical id
of the last memory section covered by the sysfs directory.  For
the default case, the value in 'end_phys_index' will be the same
as in the existng 'phys_index' file.

Updates for this version of the patch:

- Patches 2 and 3 have been swapped which has alleviated the need for the
  section count in the memory_block struct to be an atomic.

- The get_memory_block_size and memory_block_size_bytes routines now return
  an unsigned long instead of a u32.  This affects patches 4, 7, and 8.

- [Patch 5/9] The phys_index member of the memory block struct is changed to
  start_section_nr and the new end_phys_index is now named end_section_nr.

- [Patch 8/9] A new patch added to the set to define a version of
  memory_block_size_bytes() for x86_64 when CONFIG_X86_UV is set.

- [Patch 9/9] Correct the updates to hotplug documentation to indicate that
  4 or 5 files may be seen for each memory directory in sysfs.

-Nathan Fontenot

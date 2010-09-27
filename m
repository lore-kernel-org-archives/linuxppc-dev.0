Return-Path: <nfont@austin.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 997C2B70A8
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 05:10:17 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8RIsu2T018023
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Sep 2010 14:54:56 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8RJ9fgh1556716
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Sep 2010 15:09:41 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8RJ9d74028948
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Sep 2010 16:09:40 -0300
Message-ID: <4CA0EBEB.1030204@austin.ibm.com>
Date: Mon, 27 Sep 2010 14:09:31 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 0/8] v2 De-Couple sysfs memory directories from memory sections
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <greg@kroah.com>,
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
with large amounts of memory (1+ TB) there are perfomance issues
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
as is done for powerpc in this patchset, the view in userspace
would change such that each memoryXXX directory would span
multiple memory sections.  The number of sections spanned would
depend on the value reported by memory_block_size_bytes.

In both cases a new file 'end_phys_index' is created in each
memoryXXX directory.  This file will contain the physical id
of the last memory section covered by the sysfs directory.  For
the default case, the value in 'end_phys_index' will be the same
as in the existing 'phys_index' file.

This version of the patch set includes an update to to properly
report block_size_bytes, phys_index, and end_phys_index.  Additionally,
the patch that adds the end_phys_index sysfs file is now patch 5/8
instead of being patch 2/8 as in the previous version of the patches.

-Nathan Fontenot

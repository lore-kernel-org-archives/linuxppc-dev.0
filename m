Return-Path: <nfont@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B55F8B6F06
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 01:27:16 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6CFCsDn003123
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 11:12:54 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6CFRARQ124642
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 11:27:10 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6CFR3It014055
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 09:27:03 -0600
Message-ID: <4C3B3446.5090302@austin.ibm.com>
Date: Mon, 12 Jul 2010 10:27:02 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] De-couple sysfs memory directories from memory sections
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set of patches de-couples the idea that there is a single
directory in sysfs for each memory section.  The intent of the
patches is to reduce the number of sysfs directories created to
resolve a boot-time performance issue.  On very large systems
boot time are getting very long (as seen on powerpc hardware)
due to the enormous number of sysfs directories being created.
On a system with 1 TB of memory we create ~63,000 directories.
For even larger systems boot times are being measured in hours.

This set of patches allows for each directory created in sysfs
to cover more than one memory section.  The default behavior for
sysfs directory creation is the same, in that each directory
represents a single memory section.  This update also adds to
new files to each sysfs memory directory.  The file 'end_phys_index'
contains the physical id of the last memory section covered by
the directory.  The file 'split' allows for splitting the 
directory in two, with each new directory covering half as many
memory sections as the previous directory.

Thanks,

Nathan Fontenot

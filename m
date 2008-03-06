Return-Path: <pbadari@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 06DDADE045
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 05:51:16 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m26IpD9M027730
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 13:51:13 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m26IpDY4194034
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 11:51:13 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m26IpC65024860
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 11:51:13 -0700
Subject: [PATCH 0/5] 2.6.25-rc3-mm1 hotplug memory remove updates
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org
Content-Type: text/plain
Date: Thu, 06 Mar 2008 10:54:33 -0800
Message-Id: <1204829673.7939.59.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>,
	Andrew Morton <akpm@linux-foundation.org>, pbadari@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew & Paul,

Here are the updates for hotplug memory remove. Most changes are
PPC specific, but I would like these to be included in next -mm 
for easy testing and review, before including in Paul's tree.

eHEA driver folks are verifying if the exported interface
walk_memory_resource() is good enough for their needs. And also,
we are verifying the code on x86_64. Once that is done, we may
be able to cleanup some of the code (make remove_memory() arch
generic).

We still have an issue with not being able to free up the allocations
that came from bootmem. Yasunori Goto wants to clean up that code.

[PATCH 1/5] generic __remove_pages() support
[PATCH 2/5] [PPC] htab_remove_mapping() error handling
[PATCH 3/5] [PPC] hotplug memory notifications for ppc
[PATCH 4/5] [PPC] update lmb for hotplug memory add/remove
[PATCH 5/5] [PPC] provide walk_memory_resource() for ppc

Testing: All the patches are tested on p-series LPAR configuration,
writing to /sysfs & /proc, through DLPAR tools and through HMC. 
Testing on x86_64 needs more work.

Thanks,
Badari

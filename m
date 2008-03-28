Return-Path: <pbadari@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB1C5DE126
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 10:33:18 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2RNVe67024870
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 19:31:40 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2RNX9PM201680
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 17:33:09 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2RNX81t005476
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 17:33:09 -0600
Subject: [PATCH 0/5] 2.6.25-rc5-mm1 hotplug memory remove updates
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 27 Mar 2008 16:33:26 -0800
Message-Id: <1206664406.19368.2.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, Yasunori Goto <y-goto@jp.fujitsu.com>
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

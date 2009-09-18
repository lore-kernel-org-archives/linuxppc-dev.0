Return-Path: <nfont@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EBE96B7B77
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Sep 2009 00:57:02 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8IEt2iN002030
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 08:55:02 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8IEus1X261258
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 08:56:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8IEus7Q026771
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 08:56:54 -0600
Message-ID: <4AB39FB3.1020608@austin.ibm.com>
Date: Fri, 18 Sep 2009 09:56:51 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5 v2] kernel handling of dynamic logical partitioning
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Dynamic Logical Partitioning (DLPAR) capabilities of the powerpc pseries
platform allows for the addition and removal of resources (i.e. cpus,
memory, pci devices) from a partition. The removal of a resource involves
removing the resource's node from the device tree and then returning the
resource to firmware via the rtas set-indicator call.  To add a resource, it
is first obtained from firmware via the rtas set-indicator call and then a
new device tree node is created using the ibm,configure-connector rtas call
and added to the device tree.

The following set of patches implements the needed infrastructure to have the
kernel handle the DLPAR addition and removal of memory and cpus (other
DLPAR'able items to follow in future patches).  The framework for this is
to create a set of probe/release sysfs files in pseries that will add or
remove the cpu or memory to the system.

The majority of the code is powerpc/pseries specific except for PATCH 3/5, so
I am cc'ing lkml.

Patches include in this set:
1/5 - DLPAR infracstructure for powerpc/pseries platform.
2/5 - Move the of_drconf_cell struct to prom.h
3/5 - Export the memory sysdev class
4/5 - Memory DLPAR handling
5/5 - CPU DLPAR handling

This also includes the following suggested fixes from the first version of the
patches sent out.
- Correct initialization of workarea_lock and reconfig notifier chain.
- Add cc_workarea struct to help understand the work buffer layout.
- Fix memory leak in cpu_probe_store()
- Use strict_strtoul
- Correct checkpatch failures.

-Nathan Fontenot

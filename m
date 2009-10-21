Return-Path: <nfont@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 48FBFB7BAE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 01:36:23 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9LEVI55000877
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 08:31:18 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n9LEaDnQ259040
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 08:36:15 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9LEbbPr029584
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 08:37:37 -0600
Message-ID: <4ADF1C49.2030201@austin.ibm.com>
Date: Wed, 21 Oct 2009 09:35:53 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5 v4] Kernel Handling of Dynamic Logical Partitioning
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: lkml@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a re-send of the entire patch set with updates made from the comments
I have received, namely patches 1,3 and 5.  I am re-sending the entire patch
set for clarity.

The Dynamic Logical Partitioning (DLPAR) capabilities of the powerpc pseries
platform allows for the addition and removal of resources (i.e. cpus,
memory, pci devices) from a partition. The removal of a resource involves
removing the resource's node from the device tree and then returning the
resource to firmware via the rtas set-indicator call.  To add a resource, it
is first obtained from firmware via the rtas set-indicator call and then a
new device tree node is created using the ibm,configure-coinnector rtas call
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

-Nathan Fontenot

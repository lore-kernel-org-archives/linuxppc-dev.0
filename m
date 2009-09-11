Return-Path: <nfont@austin.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1D725B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 06:57:11 +1000 (EST)
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8FD45DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 06:57:10 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8BKuUlO002342
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 16:56:30 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8BKv6Ac209836
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 16:57:06 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8BKv5Eb028770
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 16:57:05 -0400
Message-ID: <4AAAB99B.2080503@austin.ibm.com>
Date: Fri, 11 Sep 2009 15:56:59 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5] kernel handling of dynamic logical partitioning
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

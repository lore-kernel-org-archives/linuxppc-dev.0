Return-Path: <rcjenn@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71568DDFB4
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 06:09:02 +1000 (EST)
Received: from e3.ny.us.ibm.com ([192.168.1.103])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m7FJ2tWj030527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:02:56 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7FJ2bf0030337
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:02:37 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7FJ2VK0203220
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:02:31 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7FJ2VhC032205
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:02:31 -0400
Date: Fri, 15 Aug 2008 14:02:30 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/3] powerpc: cmo fix page loaning and add info to lparcfg
Message-ID: <20080815190230.GA20629@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to correct a problem found where the kernel is using 64k pages
but the firmware pages size is 4k.  In this case we were not properly
marking pages as 'loaned' to firmware.

To fix this I exposed some data pulled from rtas during early setup.  I
also made these values available via /proc/ppc64/lparcfg in the second
patch.

The first patch makes the data available and the other two patches
(unrelated to each other) depend on the first.

Regards,
Robert Jennings

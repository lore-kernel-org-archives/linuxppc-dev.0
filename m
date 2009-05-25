Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [59.145.155.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E52BDE09D
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 11:14:07 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp09.in.ibm.com (8.13.1/8.13.1) with ESMTP id n4P0XZbg010182
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 06:03:35 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4P1E3E72707556
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 06:44:03 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n4P1E2o7017279
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 06:44:03 +0530
Date: Mon, 25 May 2009 06:43:58 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [Patch 0/6] PPC64: Hardware Breakpoint interfaces - ver IV
Message-ID: <20090525011357.GA11078@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,
	Please find a new patchset that implements Hardware Breakpoint interfaces
for PPC64 architecture, the previous version of which was posted here:
http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072387.html and the changes over
it are mentioned in the changelog below.

Changelog - ver IV
------------------
(Ver I: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/071942.html)
(Ver II: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072106.html)
(Ver III: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072387.html

- While DABR register requires double-word (8 bytes) aligned addresses, i.e.
the breakpoint is active over a range of 8 bytes, PPC64 allows byte-level
addressability. This may lead to stray exceptions which have to be ignored in
hw_breakpoint_handler(), when DAR != (Breakpoint request address). However DABR
will be populated with the requested breakpoint address aligned to the previous
double-word address. The code is now modified to store user-requested address
in 'bp->info.address' but update the DABR with a double-word aligned address.

- Please note that the Data Breakpoint facility in Xmon is broken as of 2.6.29
and the same has not been integrated into this facility as described in Ver I.

Kindly review the patches and let me know if they're in a form that is ready for
upstream inclusion.

Thanks,
K.Prasad

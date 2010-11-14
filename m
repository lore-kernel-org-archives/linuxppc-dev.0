Return-Path: <jkenisto@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1ECFBB70FB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Nov 2010 15:15:43 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAE3wHx7012939
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 22:58:17 -0500
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAE4FBHL458776
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 23:15:15 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAE4FAOB014070
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:15:10 -0700
Received: from localhost.localdomain (w-jimk.beaverton.ibm.com [9.47.28.66])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAE4FAkX014055
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:15:10 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [RFC PATCH 0/6] nvram: Capture oops/panic reports in NVRAM
To: linuxppc-dev@lists.ozlabs.org
Date: Sat, 13 Nov 2010 20:15:10 -0800
Message-ID: <20101114041510.9457.92921.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series enables p Series systems to capture oops and panic
reports from the printk buffer into NVRAM, where they can be examined
after reboot using the nvram command.

Patches 1-2 implement the basic feature, and patch 4 adds compression,
so we can capture more of the printk buffer.  Patches 3 and 5-6 add
refinements.  Patch 5 is not powerpc-specific, and I plan to pursue that
independently on LKML.

This series applies atop the little bug-fix series I posted two days
ago --

"More ppc64 nvram code cleanup"
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-November/087009.html

-- which in turn applies atop Ben Herrenschmidt's Aug. 2 patch set --

"[RFC] Clean up ppc64 nvram code"
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-August/084601.html

My patches have been tested against 2.6.37-rc1.
---

Jim Keniston (6):
      Shrink our zlib_deflate workspace from 268K to 24K
      Slim down zlib_deflate workspace when possible
      Add compression to fit more printk output into NVRAM
      Always capture start of oops report to NVRAM
      Capture oops/panic reports in ibm,oops-log partition
      Generalize code for OS partitions in NVRAM


 arch/powerpc/include/asm/nvram.h       |    3 
 arch/powerpc/include/asm/rtas.h        |    6 
 arch/powerpc/kernel/nvram_64.c         |   31 ++
 arch/powerpc/platforms/pseries/nvram.c |  470 ++++++++++++++++++++++++++++----
 include/linux/zlib.h                   |   14 +
 lib/zlib_deflate/deflate.c             |   33 ++
 lib/zlib_deflate/deflate_syms.c        |    1 
 lib/zlib_deflate/defutil.h             |   17 +
 8 files changed, 504 insertions(+), 71 deletions(-)

--
Jim Keniston
IBM Linux Technology Center
Beaverton, OR

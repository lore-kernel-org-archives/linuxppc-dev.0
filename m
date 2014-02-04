Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F10C2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 22:31:34 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 4 Feb 2014 17:01:30 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D75C93940058
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 17:01:27 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s14BVGPO7077970
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 17:01:16 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s14BVEvo032695
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 17:01:14 +0530
Received: from deepthi.in.ibm.com (deepthi.in.ibm.com [9.124.35.236] (may be
 forged))
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s14BVElq032692
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 17:01:14 +0530
Subject: [PATCH V5 0/3] powerpc/powernv: Error logging interfaces 
To: linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 04 Feb 2014 17:01:35 +0530
Message-ID: <20140204113127.19141.21493.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series defines generic interfaces for error logging to
push down critical errors from powernv platform to FSP.

Also, it contains few minor fixes for the exisiting error logging
framework that retrieves error logs from FSP.

Changes from V4:
* Reverted OPAL token for ELOG_OPAL_SEND to 92
* Use __pa() to obtain the physical address of the error log
  buffer. 

Changes from V3:
* Change memory allocation to GFP_ATOMIC, to generate
  errors in bad context
* Move all error log generation related code to arch/powernv
  rename it from opal_* to pnv_* .

Changes from V2:
* Review comments from V2 have been addressed
  includes comment formats, changing naming
  conventions and incorporated error handling
  of the buffers.
* Minor typo fix and use of pr_err/pr_fmt to
  log errors.

 Deepthi Dharwar (3):
      powernv: Push critical error logs to FSP
      powernv: Correct spell error in opal-elog.c
      powernv: Have uniform logging of errors in opal-elog.c


 arch/powerpc/include/asm/opal.h                |   36 +++++++++
 arch/powerpc/platforms/powernv/opal-elog.c     |   92 +++++++++++++++++++++---
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
 arch/powerpc/platforms/powernv/powernv.h       |   84 ++++++++++++++++++++++
 4 files changed, 203 insertions(+), 10 deletions(-)


-- Deepthi
